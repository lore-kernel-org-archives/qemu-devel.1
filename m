Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BD8C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35681208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35681208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBOwf-0001DK-7s
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 15:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBOvW-00088Q-JM
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBOvT-00014i-Bt
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:50:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35723)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBOvR-00012o-Dy
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:50:42 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF9898553B
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 19:50:38 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k184so1696431wmk.1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 12:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OS8nGQXMin5R8+FmdQpp11KdCM+SoDPvVP5YFxrQlwo=;
 b=EpmqYSjkQAIljG27b4ZJlNz+GQdrTCFSz2LcUYgOLbKlFJF/FWar3VtOJAUOr0124Q
 K9MJrNOAplDGY7KOuQG6j+dRQtVbx2sD8tEaXrwXzUH3rxTKM3ZrsrA+xqlG+QRicCn2
 NuaeMeeallnnG2WGHt1L6H9qnKUtEl3wVlV0tytezvIqMDbCxwF4PPtlvaJv0BO+PpqQ
 hSfICaLHFz72DGVr4Mwl6UN2hbB7S3DVM/ToogBQw1KzOoFeb4tjQOjBoXRXE2CVrf84
 P1pncKljU1/ReW+SikpGXCdXi2K2Vn9oGzS2DmRlaAZAbEALO4L6SoejhVkOHKYYaxIH
 slbw==
X-Gm-Message-State: APjAAAWNuzGbVhPKcCKWJS6x9uxgv4zxnRufK6V3nwlXxHRAfjFMeU4/
 xT0aRuhcGt/d98EmqUJUtY3BtxqzSIdn0omLE/e3sdeiwcCXMGMC4ljYnTtoabpUUofmACNKeuN
 C1BljzrrGj9Egjj8=
X-Received: by 2002:a05:600c:2052:: with SMTP id
 p18mr4624340wmg.13.1569009037668; 
 Fri, 20 Sep 2019 12:50:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyY2GnCz9n6BK8TBWEAWDY2VLSXpLIzEC2Tj+pA2weUrFBmzU1WIRJ4fLKnHdV3hI6yW3i4w==
X-Received: by 2002:a05:600c:2052:: with SMTP id
 p18mr4624338wmg.13.1569009037469; 
 Fri, 20 Sep 2019 12:50:37 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id t6sm4258461wmf.8.2019.09.20.12.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 12:50:36 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 2/2] roms/Makefile.edk2: don't pull in
 submodules when building from tarball
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20190912231202.12327-1-mdroth@linux.vnet.ibm.com>
 <20190912231202.12327-3-mdroth@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9659eaf9-65f8-b717-271c-e5941debdb2f@redhat.com>
Date: Fri, 20 Sep 2019 21:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190912231202.12327-3-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: lersek@redhat.com, qemu-stable@nongnu.org, brogers@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 1:12 AM, Michael Roth wrote:
> Currently the `make efi` target pulls submodules nested under the
> roms/edk2 submodule as dependencies. However, when we attempt to build
> from a tarball this fails since we are no longer in a git tree.
> 
> A preceding patch will pre-populate these submodules in the tarball,
> so assume this build dependency is only needed when building from a
> git tree.
> 
> Reported-by: Bruce Rogers <brogers@suse.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Bruce Rogers <brogers@suse.com>
> Cc: qemu-stable@nongnu.org # v4.1.0
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  roms/Makefile.edk2 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
> index c2f2ff59d5..33a074d3a4 100644
> --- a/roms/Makefile.edk2
> +++ b/roms/Makefile.edk2
> @@ -46,8 +46,13 @@ all: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashdev).fd.bz2) \
>  # files.
>  .INTERMEDIATE: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashdev).fd)
>  
> +# Fetch edk2 submodule's submodules. If it is not in a git tree, assume
> +# we're building from a tarball and that they've already been fetched by
> +# make-release/tarball scripts.

Annoying, without using the make-release tool in a fresh clone, I get
qemu/roms/edk2/CryptoPkg/Library/OpensslLib/OpensslLibCrypto.inf(-1):
error 000E: File/directory not found in workspace

I vaguely remember there was a thread about not using 'git submodule
update --init --recursive' in the root directory but can't find it, any
idea?

>  submodules:
> -	cd edk2 && git submodule update --init --force
> +	if test -d edk2/.git; then \
> +		cd edk2 && git submodule update --init --force; \
> +	fi
>  
>  # See notes on the ".NOTPARALLEL" target and the "+" indicator in
>  # "tests/uefi-test-tools/Makefile".
> 

