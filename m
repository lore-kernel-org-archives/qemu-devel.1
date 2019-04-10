Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41621C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E2E2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E2E2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE5Qb-0005rP-5x
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 01:05:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5Ph-0005Tw-AR
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5Pg-0006aA-6q
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:04:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hE5Pf-0006Vo-Tq
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:04:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so1029738wml.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 22:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=l7ujrbObxIBGdoqFxEMvPc55va4XDyGyLSzNQNbGWvQ=;
	b=WJJQTUMOKMAJoHpQIYv6a11uii1YWDvYACsg9nNAMcsR2u+LH8qvQphwc7FHa6XJ/o
	Kl+Nly5+fQ4M8pSziq1QaybFNbnHAPx1S9jRVZBH0WWDtGR1Xnd81oJSdqBrLlMtoiYI
	lDxDJm+4UoxWmW01xxAzb7mTEHAblUh1tulmXAtGzdREo+M1D6JaAQVZpMwdoqJ+iSoo
	zH6AzkBw13w4r5TD58HKOkkelynRb5iFqqmu3DpI5HZJPgFYzyl6zLdgCA4ndDpIkXln
	2OsjOiLnrdvvnmLluKTjTedPW0xSDRZwMv9ROdYtiGBHaYEy93G0ywfH9oBeylRVB7NX
	j6QQ==
X-Gm-Message-State: APjAAAWajFvaHnL8YakEBLO6iBrmYUOax99PYtXhyD9ZA6152Q2GvA4h
	KbbR+zro+yQd0ZjmIWF8aRzt//fBR3s=
X-Google-Smtp-Source: APXvYqyAi0fCkO7Hblcgj/A85I6R7tjrIyxDfJ41o/BaKxyFzFP2p6Xf9TLc1THSj7XSk8WD3y4ddg==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr1124406wmh.13.1554872680108; 
	Tue, 09 Apr 2019 22:04:40 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	y1sm100390452wrd.34.2019.04.09.22.04.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 22:04:39 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, eblake@redhat.com, 
	f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com,
	mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org,
	qemu-devel@nongnu.org
References: <20190409230022.6462-1-lersek@redhat.com>
	<20190409230022.6462-7-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d9ad152e-00b9-5a32-9df5-1005c88d954d@redhat.com>
Date: Wed, 10 Apr 2019 07:04:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409230022.6462-7-lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 06/12] roms/Makefile: replace
 the $(EDK2_EFIROM) target with "edk2-basetools"
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
Message-ID: <20190410050436.m7C1RV9GQG3_Pmb9GeOYgtbfiThIOcPqumO4JfXDMjg@z>

On 4/10/19 1:00 AM, Laszlo Ersek wrote:
> We don't (can't) have a recipe for building just $(EDK2_EFIROM);
> therefore, while we call the target $(EDK2_EFIROM), we actually build all
> of the edk2 BaseTools. Rename the target to edk2-basetools, and update the
> iPXE prerequisite accordingly. This will let other targets depend on
> "edk2-basetools", where an $(EDK2_EFIROM) pre-requisite would be
> misleading.
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Notes:
>     v4:
>     
>     - rebase: resolve conflicts with
>     
>       - commit d912e795e029 ("roms: Rename the EFIROM variable to avoid
>         clashing with iPXE", 2019-04-09)
>     
>       - commit 1cab464136b4 ("roms: Allow passing configure options to the
>         EDK2 build tools", 2019-04-09)
>     
>     - refresh commit message accordingly: replace EFIROM references with
>       EDK2_EFIROM references
>     
>     - drop all previous feedback tags, consequently :(
>     
>       - Phil's R-b / T-b
>       - Michal's R-b
>       - Michael's R-b
>       - Igor's T-b
>     
>     v3:
>     
>     - pick up Igor's T-b
>     
>     v2:
>     
>     - pick up Phil's R-b / T-b
>     
>     - pick up Michal's and Michael's R-b's
> 
>  roms/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index 1ff78b63bb3a..93c3d467be14 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -102,7 +102,7 @@ pxe-rom-%: build-pxe-roms
>  
>  efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
>  
> -efi-rom-%: build-pxe-roms build-efi-roms $(EDK2_EFIROM)
> +efi-rom-%: build-pxe-roms build-efi-roms edk2-basetools
>  	$(EDK2_EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
>  		-b ipxe/src/bin/$(VID)$(DID).rom \
>  		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
> @@ -131,7 +131,7 @@ build-efi-roms: build-pxe-roms
>  #    EDK2_BASETOOLS_LDFLAGS='...' \
>  #    efirom
>  #
> -$(EDK2_EFIROM):
> +edk2-basetools:
>  	$(MAKE) -C edk2/BaseTools \
>  		EXTRA_OPTFLAGS='$(EDK2_BASETOOLS_OPTFLAGS)' \
>  		EXTRA_LDFLAGS='$(EDK2_BASETOOLS_LDFLAGS)'
> 

