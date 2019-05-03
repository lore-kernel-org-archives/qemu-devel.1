Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8F9C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9682075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9682075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMVIV-00072R-LJ
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 06:20:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMVHb-0006Rx-Gv
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMVHa-0005wl-Ek
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:19:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMVHa-0005uE-8j
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:19:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id o4so7178738wra.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 03:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fY8BWeHXpkt5DyiBVBFJHZ+Is0RB8VR9SD+x5JOsuxg=;
	b=XBN3AZE3omqBeXHdM/Rc9gSXcUu4Boyxe9Cg14jGVp1L86LuCObDNTmQkYQvlzJZAn
	Us/aoPPOkmPcqQxRwPzraz1ARH8pL6aR5q8ALM/DYhYfyweBnMAkD1ycq3veoy7kbN6Z
	aQw/KVF8WgI4yEr0z+P4v6Tv2I9XK5eYurNYOGQ+4f2Kh9qEQ8/7mdzow+eztKDgk3i6
	qMiIv6d7ZCA9Ha4UQh1yD6BCU3MElQX2/9rHqZkFNkLPWgkWjVJ63fBfKTAR3417JveP
	+12pX5tVGeh8csdHAdLo6B+7mggyI1SbNOInFJs1QHulgmC1xCanXDPMFs0vOmFLIbMS
	4tgA==
X-Gm-Message-State: APjAAAUyUiytysRXoxlvbMF4qPnZV1Wct5f/+aEHZNGZenK9Jhw3TS90
	5KrQCzcq5eJBErMdZz+VVwp9ysBzm40=
X-Google-Smtp-Source: APXvYqyjEyKdTfjGxobTdtwx6JcztfO7qRuY20qR1ot5n5UfXKPjLxNmX9IgdJpHi3NTEap/OKfvDw==
X-Received: by 2002:adf:eb03:: with SMTP id s3mr5469506wrn.170.1556878749158; 
	Fri, 03 May 2019 03:19:09 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	130sm2155667wmd.15.2019.05.03.03.19.08
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 03:19:08 -0700 (PDT)
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
References: <20190503002206.9751-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <39b71c2a-9630-5a56-17c7-d74625f97d55@redhat.com>
Date: Fri, 3 May 2019 12:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503002206.9751-1-driver1998@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Initial Windows on ARM (AArch64
 64-Bit) host support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503101907.Id33pqO-GYJM0-ME9lIAn-jvwJyqFSUc9ubgsbx1VHw@z>

On 5/3/19 2:22 AM, Cao Jiaxi wrote:
> Initial Windows on ARM (AArch64 64-Bit) host support
> 
> This series of patches is for initial support of Windows 10 on ARM as a QEMU host.
> Currently only TCG intepreter is working correctly, it crashes when TCG JIT is enabled.
> 
> For now we assume it is built using the clang aarch64-w64-mingw32 toolchain,
> you can get a prebuilt toolchain at https://github.com/mstorsjo/llvm-mingw.
> 

I'm a bit confused since those patches appear 2 times in my mailbox.
Assuming this is a git send-email setup mistake, please consider adding
my Reviewed-by/Tested-by here too.

These are:

> Cao Jiaxi (4):
>   QEMU_PACKED: Remove gcc_struct attribute in Windows non x86 targets

No tag.

>   qga: Fix mingw compilation warnings on enum conversion

Suggested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   util/cacheinfo: Use uint64_t on LLP64 model to satisfy Windows ARM64

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   osdep: Fix mingw compilation regarding stdio formats

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.

