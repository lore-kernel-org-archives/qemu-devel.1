Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A1C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD092082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EKd4zb96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD092082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33770 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdMGW-0002Ol-3A
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 18:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jimw@sifive.com>) id 1hdMFh-00020C-Ui
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1hdMFg-00080V-Si
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:06:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1hdMFg-0007zI-Io
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:06:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id s27so8430437pgl.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vlWX1CWOsPek4dlsI8amEqUsMNRMnpCQAxJbIjyqXeo=;
 b=EKd4zb96SbYr3o3RlbZNnrGK/Gv/cGDsRxjfZaxL6hixDD8fDF1v3ovZWcfrbe6n46
 HtMiK2p/ReBxD9rX4NbMJ2KmWbpG4YqzyDwKjJcQGLvwCEXMFrSYmhSJpWdW/ZWelViq
 PsOlcFVuopsm02PUWrkPWEe+EuGjVRx03DaWLPf5DFsCGp9U95juMg03q7JlQeGXCLc2
 kbxek5LfW04sEvgxmdnKUIF2GZaOFgeFgGDAlo7kV+CwD8b5lx3FAHXdMWyIatDL5++Z
 cGRPtvksF7JKqOl7B6VHeLs1JOGI/a2KS0FNv8TiLgnkGAjN3GC2Nh3BYtCoeybk6A+N
 CZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vlWX1CWOsPek4dlsI8amEqUsMNRMnpCQAxJbIjyqXeo=;
 b=TmrenJQKXebU/KbVybOFfQsd1viavO05GtqPL9MLZAxo/EDmqIGd8K5sn47ZiHuYqL
 WW14GiQ221kCGDSOGvEkWYQCSzIEBho7eO2GM9qq2lL6+vP6GZyl3OfP+CBBdSO5HkuN
 wlXi9JSzPmiIZYPPyhGib2yAX1p+PoMBSCq/y1ueVFwAeJJPmBGOrlM5kUEApAXu1R9r
 1RhLOi10+8d9n7tKPabihbSyiqaejoQiU9FdFiYgNuq9GaIvm0swtGjNNPAQeLhdP1rR
 x20YeQ0qQ0ngSpDQk15jo8LWu9B3zaB0qAx6WwWKyiBAXo+Od+2nNr+R9k9FBv8gKJ5r
 bqtA==
X-Gm-Message-State: APjAAAUOIBH2WzQhl9QottYkBTqOJQkozB52Mja/vC5cN9mtsf4aWLLF
 E8BIMDDgJzjH7ntiiWTWeAj8Mg==
X-Google-Smtp-Source: APXvYqz1NKDHO8o7kjTj23M45WWRSDkFIqxTMatDPo4QFNT4WR0nsZUxJL3cGfr/5EWDxJRdzzjtbw==
X-Received: by 2002:a17:90a:d587:: with SMTP id
 v7mr7742308pju.28.1560895611333; 
 Tue, 18 Jun 2019 15:06:51 -0700 (PDT)
Received: from [10.17.0.59] ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id j14sm16204313pfe.10.2019.06.18.15.06.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 15:06:50 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559903719-7162-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1559903719-7162-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Jim Wilson <jimw@sifive.com>
Message-ID: <121c4da9-bf13-0da3-39a9-22891dabcb5c@sifive.com>
Date: Tue, 18 Jun 2019 15:06:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559903719-7162-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v10 3/3] linux-user: Add support for
 statx() syscall
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
Cc: lvivier@redhat.com, Aleksandar Rikalo <arikalo@wavecomp.com>,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 3:35 AM, Aleksandar Markovic wrote:
> Implement support for translation of system call statx().

I also need these patches for 32-bit RISC-V linux user mode support.

glibc ld.so calls statx if fstatat is not supported.  Apparently new 
linux architecture ports aren't allowed to define __ARCH_WANT_NEW_STAT 
which enables fstatat because this is already obsolete.  64-bit RISC-V 
linux does have fstatat, but apparently this was a mistake which we 
can't fix now because the ABI is already frozen.  The 32-bit RISC-V ABI 
is not frozen yet, so it won't have fstatat.  Anyways, without statx, 
ld.so doesn't work, which makes user mode qemu pretty useless, so we do 
need this emulated in qemu to make the 32-bit RISC-V linux user mode 
support work properly.

I started with the August 2018 version of the patch a few weeks ago, and 
just noticed that it has been resubmitted.  I had to modify the patch 
slightly to apply to current sources, and had to fix one bug to make it 
work.  The line
+                if (ret != TARGET_ENOSYS) {
needs to instead be
+                if (ret != -TARGET_ENOSYS) {
I see that Laurent has already pointed that out.

Incidentally, I also have strace patches for statx that work on top of 
this patch, since I didn't see that in the nanomips patch set I started 
with.  That helped me debug the 32-bit RISC-V user mode support.

I've tested this on Ubuntu 16.04 (no host statx) and Ubuntu 19.10 (with 
host statx) and it worked well for me running the gcc testsuite for a 
riscv32-linux target.  I haven't tried testing the latest version of the 
patch yet.  I can do that if this is helpful.

Jim

