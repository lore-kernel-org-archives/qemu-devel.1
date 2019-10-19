Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D43CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 14:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50E121835
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 14:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50E121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLpJU-00071r-Tr
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 10:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iLpHa-0006Qd-Rk
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 10:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iLpHW-0007DS-Q0
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 10:00:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iLpHW-0007Bm-Gy
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 10:00:34 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14730368B1
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 14:00:32 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k9so4081416wmb.0
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 07:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KP3vwjUBEB84k8OE1O8olnCOg3vO9FYTOfM95m1nWOY=;
 b=WdgU1USiv866JNA6RLzVl6FldNGYo0KX5vc/nKRfDgiq6z8M8x3QAkv4Q4IsCamVLv
 +NuzlE2IzhUU6i2V8FGqlWkqj0esIPb9Q2hLh0c8h2hnCF6ozQr0YpXTIl61b9AGSEFk
 aYS3H9n1zOhyNYAPkBbZ4v6ETjVkfouoUY2zdg8fbhPip8RtS3n05EvUOBLRnYTns6P1
 cWGI5mZCcvapezUcazV8Ak7U4yjkGPHRjKA7eO7NDzAJ6bYW1r8JSOoRAAOeAIzXujO/
 UeEI2bbEt6MMeKb0vdSe8noqHVZCrUm1VEH9huZ04FTOx13ZdF42CoAOhERmN0eCqfd4
 /UKw==
X-Gm-Message-State: APjAAAUyMdEVLQvOBYZizTWjlfAzE2vfGGKLxPiXd/2jIhj//GwiIgLk
 9p94BEbu7YWIkJpTfAQcRfflMs/s0G2HQ1PcQHJcrdYS9y+qCHezcrBh4tcYqci4PtrU7NeW/pI
 2KhT2MPJUAZAdPCo=
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr12338756wmf.174.1571493630783; 
 Sat, 19 Oct 2019 07:00:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyV6qcwnkahEIWdsQ2Aqhq4hVfSdpKgV9ufvq3gfQC4GHf1PMG3zkzKP41gmyc3E9bkyT3n7w==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr12338734wmf.174.1571493630437; 
 Sat, 19 Oct 2019 07:00:30 -0700 (PDT)
Received: from steredhat (host93-199-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.199.93])
 by smtp.gmail.com with ESMTPSA id z13sm9500067wrm.64.2019.10.19.07.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 07:00:29 -0700 (PDT)
Date: Sat, 19 Oct 2019 16:00:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] Do not use %m in common code to print error messages
Message-ID: <20191019140027.yzr6ccalmu6nmz53@steredhat>
References: <20191018130716.25438-1-thuth@redhat.com>
 <20191018134215.u6psfffrrxlsa2ns@steredhat>
 <1f36c112-fabb-df41-e01d-476e4c86186e@gmx.com>
 <f8fc0de2-b4b0-a75a-a00f-c6bca6914159@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8fc0de2-b4b0-a75a-a00f-c6bca6914159@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: berrange@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Kamil Rytarowski <n54@gmx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 06:01:22PM +0200, Thomas Huth wrote:
> On 18/10/2019 15.49, Kamil Rytarowski wrote:
> > On 18.10.2019 15:42, Stefano Garzarella wrote:
> >> On Fri, Oct 18, 2019 at 03:07:16PM +0200, Thomas Huth wrote:
> >>> The %m format specifier is an extension from glibc - and when compiling
> >>> QEMU for NetBSD, the compiler correctly complains, e.g.:
> >>>
> >>> /home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c: In function 'sigfd_handler':
> >>> /home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c:64:13: warning: %m is only
> >>>  allowed in syslog(3) like functions [-Wformat=]
> >>>              printf("read from sigfd returned %zd: %m\n", len);
> >>>              ^
> >>> Let's use g_strerror() here instead, which is an easy-to-use wrapper
> >>> around the thread-safe strerror_r() function.
> >>>
> >>> While we're at it, also convert the "printf()" in main-loop.c into
> >>> the preferred "error_report()".
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>  v2: Do not try to g_free() the strings
> >>>
> >>>  hw/misc/tmp421.c | 4 ++--
> >>>  util/main-loop.c | 3 ++-
> >>>  util/systemd.c   | 4 ++--
> >>>  3 files changed, 6 insertions(+), 5 deletions(-)
> >>
> >> There are many uses of %m also in hw/vfio/ but that's Linux stuff.
> >> Should we change those too or it doesn't matter since it never really
> >> compiled on NetBSD?
> > 
> > It's a gnu (glibc) extension and linux can use alternative libc
> > implementations. Probably most of them capable to host qemu use %m.
> 
> I think I read somewhere that other libcs on Linux also support %m (like

Good to know!

> musl), but I just can't find that reference anymore. Anyway, we can
> still fix that later in case someone hits the issue.
> 

Yes, make sense to me.

Thanks,
Stefano

