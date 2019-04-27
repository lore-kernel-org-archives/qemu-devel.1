Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64FBC43218
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 15:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BB02077B
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 15:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BB02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33464 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKPal-00053g-H9
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 11:50:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hKPZt-0004cl-Sd
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hKPZs-0005TF-KM
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:49:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hKPZq-0005Ow-NC
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:49:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so2251794oig.9
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 08:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=LIr9v/5M6fO4CtXKlASHeE0FiimF1F6pBPcyNslDlv4=;
	b=czxFBswyVsoqLiH8qTSY5m8KhrcgIzeeshbXs+Q0lZ0ZcikzuuffCmgZ+GV0cVOtJg
	tyeC4o4Src6KEuuScBVJ6A2TS2T0/7YFeK6ghMzorK7LxnnvcWo+TnrRm8oOesZyzzIZ
	1uZxHEGy5ZUt1shjmgiKRqDLIB5TGCDYNrOE8Fz3+kwV2UBIMqqbg1GQznvrDFVCvznS
	izBD3+rPyGHgsBQucY1zkFmKKTsragwzLeTmI7GWzIHULj0Sa3RK/krFEf5K+cE1Wuu1
	v0o7wFHiCRWGAy4qZOEfmgeAGnByZT//Yx51aJjiqU+o1WSXkyh6t+VBUnRKjZTDWQaS
	sUqQ==
X-Gm-Message-State: APjAAAVYIhQzBQVjDCoxbJShaxFI25Xz/wkcN0Wq/RSB2Mfbhnl5uRmo
	1fuKBmPqffBPRQm994ob2gFv8eIiZrzVjEVYqqna8g==
X-Google-Smtp-Source: APXvYqzqgh6o+Ks8QkANWEnwOfQ3XRZW4wrhKpPypuaAAG9Pvt8awtSPBs1WngKmhpubzlo+3+2HW1uI4/f7PPXADPs=
X-Received: by 2002:aca:1106:: with SMTP id 6mr9726047oir.46.1556380158813;
	Sat, 27 Apr 2019 08:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190427131857.11600-1-philmd@redhat.com>
In-Reply-To: <20190427131857.11600-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 27 Apr 2019 17:49:07 +0200
Message-ID:
 <CAMxuvayZ-woUZPxnav8EXSVGGADxeJjhDs1bgzPAzNLMGFgTsA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.167.194
Subject: Re: [Qemu-devel] [PATCH] hw/tpm: Only build tpm_ppi.o if any of
 TPM_TIS/TPM_CRB is built
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427154907.J0c4epWWY8KNCi6OV779RTqwRlpxQMYJFIsVhIZOL7Y@z>

Hi

On Sat, Apr 27, 2019 at 3:19 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The TPM Physical Presence Interface routines are only used
> by the CRB/TIS interfaces. Do not compile this file if any
> of them is built.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Marc-Andr=C3=A9:
>   You might want to add yourself as reviewer/maintainer of TPM ;)

yes, I suppose Stefan wouldn't mind having me as R: :)

> ---
>  hw/tpm/Makefile.objs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 700c8786228..de0b85d02ae 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,5 +1,5 @@
> -common-obj-y +=3D tpm_util.o
> -obj-y +=3D tpm_ppi.o
> +common-obj-$(CONFIG_TPM) +=3D tpm_util.o
> +obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) +=3D tpm_ppi.o
>  common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>  common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>  common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
> --
> 2.20.1
>

