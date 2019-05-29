Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2941C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABDD23C95
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABDD23C95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW0xX-0003iB-Vg
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 11:57:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hW0st-0000iJ-Em
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hW0ss-0000Xx-5q
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:52:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hW0sr-0000XN-W6
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:52:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so2041264wme.0
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 08:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fEI8N6lsKt6fZ6Iwbx+zoKLKaH50H4fdnNWHKRq8cGw=;
	b=ZUOCZEU+YuhESBS5D1CoOrf6xzBYXnfriwRNUwVn3sFCRYnAhomWpbwWNQ4XmMimjf
	kuaZ9WNFdmtxSv23aWYOPngSgRiYb2VAkkg5tihF0dPlxqP75Ntxc+xdEjYs2F50TLgB
	0AHbUqtuHfeOWdQcNjYOTkGYI181ZSKmiC9xOZ/jjOIaQUiDvR/o1sYQNJ2ib6//mi7P
	ExjS9MPhY2wNc6I+uDmZ6j1LM4g5b/ivxrYVmRlQOJj5BIfmoX7lGNA0yTgRV3aknAGk
	FLhDz4al8Px9pg4WDjAORMxd7zQzyhXi2yDUtwE0nNyA9j5KOsevnSNe6xejNgqv7cVX
	S/Bg==
X-Gm-Message-State: APjAAAXVpTmbcoais43hzz+AXmEt2VHi7XSB4WRG0cWOK4L5E39FMlck
	mGcLwNFIgSbehqqohVAobv8VmP2oMVc=
X-Google-Smtp-Source: APXvYqzIeH8yFRBnPL+MYrsTHDvpGazPyMPrb/CbDDMLhu1zBwA64+W8g9NP3isGE6H3yCzfzt9kTQ==
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr6767622wmc.60.1559145176456;
	Wed, 29 May 2019 08:52:56 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	w3sm15520005wrv.25.2019.05.29.08.52.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 08:52:55 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fe9bdf35-70bf-0adc-b096-21a891dfdbd4@redhat.com>
Date: Wed, 29 May 2019 17:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529150853.9772-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 1/3] MAINTAINERS: Drop redundant L:
 qemu-devel@nongnu.org
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

On 5/29/19 5:08 PM, Markus Armbruster wrote:
> Redundant since commit c9a19d5b95 "MAINTAINERS: add all-match entry
> for qemu-devel@".

https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05019.html

:(

> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f5f8b7a2c..edc260e503 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -109,7 +109,6 @@ L: qemu-s390x@nongnu.org
>  Guest CPU cores (TCG):
>  ----------------------
>  Overall
> -L: qemu-devel@nongnu.org
>  M: Richard Henderson <rth@twiddle.net>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> @@ -444,19 +443,16 @@ F: util/*posix*.c
>  F: include/qemu/*posix*.h
>  
>  NETBSD
> -L: qemu-devel@nongnu.org
>  M: Kamil Rytarowski <kamil@netbsd.org>
>  S: Maintained
>  K: ^Subject:.*(?i)NetBSD
>  
>  OPENBSD
> -L: qemu-devel@nongnu.org
>  M: Brad Smith <brad@comstyle.com>
>  S: Maintained
>  K: ^Subject:.*(?i)OpenBSD
>  
>  W32, W64
> -L: qemu-devel@nongnu.org
>  M: Stefan Weil <sw@weilnetz.de>
>  S: Maintained
>  F: *win32*
> @@ -565,7 +561,6 @@ F: include/hw/*/digic*
>  Gumstix
>  M: Peter Maydell <peter.maydell@linaro.org>
>  R: Philippe Mathieu-Daudé <f4bug@amsat.org>
> -L: qemu-devel@nongnu.org
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/gumstix.c
> @@ -1044,7 +1039,6 @@ F: pc-bios/qemu_vga.ndrv
>  
>  PReP
>  M: Hervé Poussineau <hpoussin@reactos.org>
> -L: qemu-devel@nongnu.org
>  L: qemu-ppc@nongnu.org
>  S: Maintained
>  F: hw/ppc/prep.c
> @@ -1831,7 +1825,6 @@ S: Supported
>  F: scripts/coverity-model.c
>  
>  CPU
> -L: qemu-devel@nongnu.org
>  S: Supported
>  F: qom/cpu.c
>  F: include/qom/cpu.h
> @@ -2566,7 +2559,6 @@ F: qapi/rdma.json
>  
>  Semihosting
>  M: Alex Bennée <alex.bennee@linaro.org>
> -L: qemu-devel@nongnu.org
>  S: Maintained
>  F: hw/semihosting/
>  F: include/hw/semihosting/
> @@ -2577,7 +2569,6 @@ Build and test automation
>  M: Alex Bennée <alex.bennee@linaro.org>
>  M: Fam Zheng <fam@euphon.net>
>  R: Philippe Mathieu-Daudé <philmd@redhat.com>
> -L: qemu-devel@nongnu.org
>  S: Maintained
>  F: .travis.yml
>  F: scripts/travis/
> @@ -2592,7 +2583,6 @@ W: http://patchew.org/QEMU/
>  FreeBSD Hosted Continuous Integration
>  M: Ed Maste <emaste@freebsd.org>
>  M: Li-Wen Hsu <lwhsu@freebsd.org>
> -L: qemu-devel@nongnu.org
>  S: Maintained
>  F: .cirrus.yml
>  W: https://cirrus-ci.com/github/qemu/qemu
> @@ -2608,7 +2598,6 @@ R: Philippe Mathieu-Daudé <f4bug@amsat.org>
>  S: Maintained
>  F: tests/tcg/Makefile
>  F: tests/tcg/Makefile.include
> -L: qemu-devel@nongnu.org
>  
>  Documentation
>  -------------
> 

