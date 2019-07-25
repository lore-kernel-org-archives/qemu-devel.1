Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC78C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865E221734
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865E221734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqf9E-0001su-Qi
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40851)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqf93-0001Tc-Ti
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqf92-0007rd-Rr
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:55:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqf92-0007r7-LN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:55:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so45294542wmj.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:cc:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LXiCJZ4VWGNJsNUwukDV+ACV42olF+9sJgg1u0AJl4E=;
 b=NKlTtRbwb29qlkQIqpuTX7LjFcsk808ajdZn1/t17smqUx69wk0EXzg794w12pyh/z
 BGeZZqWhZJqx0BqdV0z0rBT8jizd+UyrEGhlZa7iJLh7ortTKy4NGc0U9xRMog4LXMz4
 JnBX3DOXamTcDNW5E1N1OhppSPWf68BLTHVaOo9j7W+WuG+KqExWkNVpUhKwiE68Uvot
 2z1/U9wTBjvplohYdN3V67CAjooChi2SsTFgQJO1+pKatXMp+Uc/WlvM4jIXOrwWs+Tg
 57PGxjXWx6OBljmmJMARgiXdwDi6YpiTNk2KA7k77wa9jCjEv4ET76TbJ1vRkareqcJX
 yhOQ==
X-Gm-Message-State: APjAAAWCgaU/7vtmvNOFaU/9igi11QEuKt9gPtgcLm24cUI4ZSNixjCn
 TP9FQNDgUDzSwQPgaspiJMLNd2SzIW8=
X-Google-Smtp-Source: APXvYqyYx2TXeyjw5E4SMh/BkHDUEH6U06OoediLHMdEWdayiOmp98ZE+hpww88BPva4ybJXvotmsw==
X-Received: by 2002:a05:600c:23d2:: with SMTP id
 p18mr75633019wmb.160.1564066498735; 
 Thu, 25 Jul 2019 07:54:58 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id g11sm50314338wru.24.2019.07.25.07.54.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 07:54:58 -0700 (PDT)
To: Bug 1837909 <1837909@bugs.launchpad.net>,
 Cole Robinson <crobinso@redhat.com>
References: <156406441263.18058.18411127090440261548.malonedeb@gac.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9674376a-61fa-c845-46ae-701d65fc174f@redhat.com>
Date: Thu, 25 Jul 2019 16:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156406441263.18058.18411127090440261548.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [Bug 1837909] [NEW] test-char fails if host has no
 network interfaces
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 4:20 PM, Cole Robinson wrote:
> Public bug reported:
> 
> # ./tests/test-char 
> # random seed: R02S8602535bf831a74bca571d8c416d8161
> 1..34
> # Start of char tests
> ...
> ok 12 /char/websocket
> # Start of stdio tests
> # End of stdio tests
> # Start of socket tests
> # Start of server tests
> # Start of mainloop tests
> Unexpected error in inet_parse_connect_saddr() at util/qemu-sockets.c:421:
> # 
> # address resolution failed for 127.0.0.1:42275: Name or service not known
> # 
> 
> Aborted (core dumped)
> 
> 
> # ip a
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host 
>        valid_lft forever preferred_lft forever
> 
> 
> This seems to be related to use of AI_ADDRCONFIG in qemu-sockets.c inet_parse_connect_saddr, dropping it fixes the test. 'man getaddrinfo' makes it sound like AI_ADDRCONFIG requires the host to have a non-loopback ipv4 or ipv6 address available

GETADDRINFO(3)

  If hints.ai_flags includes the AI_ADDRCONFIG flag, then IPv4
  addresses are returned in the list pointed to by res only if
  the local system has at least one IPv4 address configured, and
  IPv6 addresses are returned only if the local system has at
  least one IPv6 address configured.  The loopback address is not
  considered for this case as valid as a configured address.
  This flag is useful on, for example, IPv4-only systems, to
  ensure  that  getaddrinfo() does not return IPv6 socket addresses
  that would always fail in connect(2) or bind(2).

I'm a little confused, and I don't feel fluent enough with English to be
sure that "only if A and only if B" is equivalent to "requires (A or
B)". Maybe the man page should use 'or' instead of 'and' here...

> This host setup may seem niche, but it is what the 'mock' RPM build tool
> has by default. In Fedora we run the test suite during the RPM build, so
> the failing test causes a bit of pain for certain workflows

Would this diff snippet help?

-- >8 --
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index a5092dbd12..9ad775270d 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -417,7 +417,7 @@ static struct addrinfo
*inet_parse_connect_saddr(InetSocketAddress *saddr,
         ai.ai_flags &= ~AI_V4MAPPED;
         rc = getaddrinfo(saddr->host, saddr->port, &ai, &res);
     }
-    if (rc != 0) {
+    if (rc and rc != EAI_NONAME) {
         error_setg(errp, "address resolution failed for %s:%s: %s",
                    saddr->host, saddr->port, gai_strerror(rc));
         return NULL;
---

> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 

