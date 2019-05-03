Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE94C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334462070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRl9Sf7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334462070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38871 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWh9-0001rh-FX
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:49:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMWfr-0001DO-R6
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMWfq-0003T5-O1
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:48:19 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMWfq-0003ST-IK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:48:18 -0400
Received: by mail-oi1-x243.google.com with SMTP id l1so4197393oib.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 04:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=O82fIvuZqB1O7WRG76JEef08kMS7GixKqp8MrDrJFWQ=;
	b=DRl9Sf7pkL3VQP6ruKsw+YiGJawe2PHYhjtf6542PGiN/CuH4bBMLtcvk49o7QaXrk
	6OzAF/8yz/+Y1Ewk2ovSnjd0/w+I1v104zThfHj25SWZFCGa8t4VFz6T7Y3QhCJ9Cc6z
	j3ozlHdB8B12k8v7w7Ejwn4N5gWFQM3ZYiHs8ondVwlzZzpIMfDc0I7zYLS7BTadRQ4u
	s68Qk54fr0tgMaCYYKD3rKdNd8bsM3Oxz0M++VaLtc787klyXDqS6292Xn9CwLw/fie+
	/Aor+GwywvQNIBbR2QINA0IwUTJbgi1JMe68y0B7t1mOz/+egA+RtAK4W1JB948wMfFj
	mThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=O82fIvuZqB1O7WRG76JEef08kMS7GixKqp8MrDrJFWQ=;
	b=dXuNI3MBQ7FFQ5w+B5oCFnih/bQCOOsvH6+tsQ9rImiuSBGsuGCldJfHGeY/q1Tu/n
	8p/PRjVtQk96tDSuLA27qCPaxTJqGPwfbWfaEVyLC1Vw0kHAja4d2PG91GD9GcqZH5P0
	dj3+UF5aArp0mi2OMO4ls4aVhgzMqScyRktdoiquzed67uoljw31JbR4v7XMtQhfs5pV
	rBzAGy+ipSiO+JUrFMwra2564yzIklyHa4cMx3J/TCJswS7fyxKk3hse1gzIv4UT5J1W
	i/hmtnx5n07f+Ql5YTc70SSFBQyYM8Yo0d2HuwuT4GmYPxi4hOtiWCPu9AjdznGSRGLr
	8d5w==
X-Gm-Message-State: APjAAAX/ixY8q6vQe4iP5VdbEfsnyuhNZerWQF0hxGY3hYA6ieG0LzRN
	GFdaYywJo7jgy6gsjoJY5mNWh6gclIxwhygAbeKaOw==
X-Google-Smtp-Source: APXvYqytqFQxnJeSmta5HM7a79FwMxqEhxchW8+CBaG4FnAQffkocaUf0soBBTDpQsemovKLzw3YyzghK8izdyd+z1w=
X-Received: by 2002:aca:ed17:: with SMTP id l23mr5452595oih.146.1556884097422; 
	Fri, 03 May 2019 04:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190418153631.rl3lgadzrqqof72p@debian>
In-Reply-To: <20190418153631.rl3lgadzrqqof72p@debian>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 12:48:06 +0100
Message-ID:
 <CAFEAcA_MfK0i0QUq0V_e8hz+gHQv5Fx8yq7_OtWg0_ZE+tdV1Q@mail.gmail.com>
To: Giuseppe Musacchio <thatlemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] linux-user: elf: Map empty PT_LOAD sections
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503114806.p1WuRH6euFkKx5LnqsvVSlqAXWxEBtoq0Zr8KDd9fcg@z>

On Thu, 18 Apr 2019 at 17:46, Giuseppe Musacchio <thatlemon@gmail.com> wrote:
>
> Some PT_LOAD sections may be completely zeroed out and their p_filesize
> is zero, in that case the loader should just allocate a page that's at
> least p_memsz bytes large (plus eventual alignment padding).

Thanks for this patch -- codewise it looks good, so I just have
a couple of minor tweaks I think we should make to the comment
and commit message:

The things we're iterating through here are segments, not
sections (an ELF section is a different sort of data structure):
could you fix the text in your commit message and comment, please?

> Calling zero_bss does this job for us, all we have to do is make sure we
> don't try to mmap a zero-length page.
>
> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> ---
>  linux-user/elfload.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a2602..e9a0951 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2366,11 +2366,17 @@ static void load_elf_image(const char *image_name, int image_fd,
>              vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
>              vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
>
> -            error = target_mmap(vaddr_ps, vaddr_len,
> -                                elf_prot, MAP_PRIVATE | MAP_FIXED,
> -                                image_fd, eppnt->p_offset - vaddr_po);
> -            if (error == -1) {
> -                goto exit_perror;
> +            /* Some sections may be completely empty without any backing file
> +             * segment, in that case just let zero_bss allocate an empty buffer
> +             * for it. */

Our coding style says that multi-line comments should be
 /*
  * like this, with the start and
  * end markers on lines of their own
  */

(if you run your patch through scripts/checkpatch.pl it ought
to detect this sort of minor coding style nit).

> +            if (eppnt->p_filesz != 0) {
> +                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
> +                                    MAP_PRIVATE | MAP_FIXED,
> +                                    image_fd, eppnt->p_offset - vaddr_po);
> +
> +                if (error == -1) {
> +                    goto exit_perror;
> +                }
>              }
>
>              vaddr_ef = vaddr + eppnt->p_filesz;

Other than those minor things:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

so if you fix them and send out a v2 patch you can include
my Reviewed-by: tag in the commit message (under your
signed-off-by) in that patch email.

thanks
-- PMM

