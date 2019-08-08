Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44282C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4482171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4482171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hviby-0004TL-Bh
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 09:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvibF-0003rB-Nw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvibE-0003aO-AE
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:37:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvibD-0003Zs-RX
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:37:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so2473437wmg.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 06:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qVqreFISWIc5dEvO1iG4Zx7SWOp9dssgY+ts6oO3m0o=;
 b=Y6byRGmjPv7Fes4IlkAMTKzE4K+d5BM8nniZoriZ4lDTNAlnvFEO15ACVm97wHoQPl
 qkNb3kfJD1dV+faYatmZK/X7VIl3VQJmIUotd/rx39L+LYSFwp0ftwHlQ2n7i8saLTMO
 6UKMEvJnIvaxssD90zn01zM3mAx86sZ4a5gZLXxnkh1S5q7YXX4D1Ba2qvo0H/LzOWJe
 0LZVVvwOse0CaDLV0BWFhrFkCi92yPy3CXA+lba+DEcdPsmr4kCUtTHiBeOaZnLa+gS+
 6DVEQ2SR8IRhXpgu6blU6RSazaZrQHVPEF+t6HbJoowK87D8D3v50Zoqb95P7Inp3Uji
 V/eA==
X-Gm-Message-State: APjAAAWfieAniN35Dgf+yab1RuZuC76ii7O3jXOAmNQVkiAY4RTdH8wg
 rrmEGoifwMzkHo1x7CpXMCBx2Q==
X-Google-Smtp-Source: APXvYqy3Pl1NCfVbau+7jvg3c8SI3u4oXIX6k8ofSINM7N/Uz8++iF9797BW5ORcuUKgwlJbg5GHqw==
X-Received: by 2002:a1c:56d7:: with SMTP id k206mr4437550wmb.56.1565271418733; 
 Thu, 08 Aug 2019 06:36:58 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id y16sm202411257wrg.85.2019.08.08.06.36.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 06:36:58 -0700 (PDT)
To: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <12dbfcd1-8d9d-f564-fb90-767943eca874@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2e660c06-8efe-5158-2ba6-ecd9563e879f@redhat.com>
Date: Thu, 8 Aug 2019 15:36:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <12dbfcd1-8d9d-f564-fb90-767943eca874@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping?
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 7:38 AM, Jason Wang wrote:
> 
> On 2019/8/8 下午12:48, Markus Armbruster wrote:
>> Please excuse the attention-grabbing subject.
>>
>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>
>>> On 8/7/19 10:16 PM, Markus Armbruster wrote:
>> [...]
>>>> Can you tell me offhand what I have to install so configure enables
>>>> CONFIG_NETMAP?
>>> The steps are listed in tests/docker/dockerfiles/debian-amd64.docker,
>>> but you can get to this point running:
>>>
>>>    $ make docker-image-debian-amd64 V=1 DEBUG=1
>>>
>>> This will build the docker image with netmap (so you don't have to mess
>>> with your workstation setup), then build QEMU within the image.
>> So, to make use of QEMU's netmap backend (CONFIG_NETMAP), you have to
>> build and install netmap software from sources.  Which pretty much
>> ensures nobody uses it.  It was added in commit 58952137b0b (Nov 2013).
>> The commit message points to <http://info.iet.unipi.it/~luigi/netmap/>,
>> which gives me "connection timed out" right now.
>>
>> On the other hand, it's covered in MAINTAINERS, and has seen
>> non-janitorial activity as late as Dec 2018 (commit c693fc748a).
>>
>> Luigi, Giuseppe, Vincenzo, what's the status of the netmap project?
>>
>> Why is the QEMU netmap backend worth keeping?
>>
>> Who is using the netmap backend?
> 
> 
> Netmap was supported by freebsd:
> https://www.freebsd.org/cgi/man.cgi?query=netmap&sektion=4. So I guess
> there should be real users.
> 
> 
>>
>> How do they obtain a netmap-enabled QEMU?  Compile it from sources
>> themselves?
> 
> 
> Yes.

Hmm at least on the FreeBSD setup by vmtest (12.0-RELEASE r341666) we
don't need to build it from source:

$ make vm-build-freebsd V=1 DEBUG=1
[...]
netmap support    yes
[...]

$ fgrep -r CONFIG_NETMAP .
./config-host.mak:CONFIG_NETMAP=y

