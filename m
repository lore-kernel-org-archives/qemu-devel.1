Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21953C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C02E217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpKciGAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C02E217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWWA-000385-RQ
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWV3-0002Pa-R5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:02:29 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWV0-0002aF-U9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:02:29 -0400
Received: by mail-ej1-x643.google.com with SMTP id u8so8304814ejg.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K9tBDfuop8j2E6u+TWsjamk6eN0eE07ZY8wkUtvmSZc=;
 b=cpKciGASCkLJE8WzsRHZCnIpzlQBkX+zz5bxGk+YChLDD+ewnadvGFWEs2CNF47/UQ
 8rCkti66OklQKw9M3HRRwSiZNfwO8vLThEhkeXUnetC+NFx7YzzgnOdFt4Ir8ptaQCbT
 HHXW2z3MTwxTKSr+BaNuPTeN1+uvSuaNfMeDWuiNiM0YSOtsNHEvrz9UaPRdxJw6A8vq
 Q8QDsBrNjANSvA1J79hUnef/QNNGyV7boIHHHp8TmXs9a+iMNQ8QG+F34avGtqi7mhhV
 9cWSWBXuP/I8u8JXud5y58wAQtcqnqg0hI042O0/QkRb4tYtUb44aAlQI2fiIyZ7xToV
 +ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K9tBDfuop8j2E6u+TWsjamk6eN0eE07ZY8wkUtvmSZc=;
 b=fONCySZ++vv1a2sjcu/k50rmd4gn2oyU1r7k9Zkyj4YFy5EyYbt9t7c3QhxOTvGI6t
 zimeyVU2Jye7j3MdOqe8/kqNXTq9uEom5rOBKfiXV3qm8l6PaOAtfm3PDQzGwaMhRCkP
 IOvtvXt+JZcYIry2IB9VYZFsE/V7lz/r82+O5ls28/PM99/EwDGF+gpOR38Cf/OmLLe5
 IpMWaSpvjaO8rfAFki6OD7enQkfkvgObApV3QpK8b2Wsy06pTriIYmMmo3sPkNAmNudo
 cE6IFBRoiOoMpV8fMTwHiaTdRlp6TZgIzaKIY76bcooEAHyvHPZ397ETw5ozUyKBVBOd
 sDhA==
X-Gm-Message-State: AOAM533yvcno70vjV86xsmimxrsiwRfUNjdVzUWlgJc9zfnCO2sUYvCe
 plWrOpdQ3av07D+bQlkWf1GQIo9QXE6U1XgjpxUtqQ==
X-Google-Smtp-Source: ABdhPJwS4/obQMPI37vi76IWf/JDsu9IHChDyPxdc3OUZXXa33DMOD2qCtEMCJWJI+uSBqOOfAol6XTf39hBMaBA+ic=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr8792238ejk.407.1602165745209; 
 Thu, 08 Oct 2020 07:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201002215955.254866-1-richard.henderson@linaro.org>
 <20201002215955.254866-8-richard.henderson@linaro.org>
In-Reply-To: <20201002215955.254866-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 15:02:13 +0100
Message-ID: <CAFEAcA8jBAKe_tWAKzAXq4LFO5vk1H8AZN+s+3oWsLfoRugQdQ@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0
 notes
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 23:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For aarch64, this includes the GNU_PROPERTY_AARCH64_FEATURE_1_BTI bit,
> which indicates that the image should be mapped with guarded pages.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v9: Only map the startup executable with BTI; anything else must be
>     handled by the interpreter.
> v10: Split out preparatory patches (pmm).

> @@ -2467,6 +2467,50 @@ static void load_elf_image(const char *image_name, int image_fd,
>                  goto exit_errmsg;
>              }
>              *pinterp_name = interp_name;
> +        } else if (eppnt->p_type == PT_GNU_PROPERTY) {
> +            /* Process NT_GNU_PROPERTY_TYPE_0. */
> +            const uint32_t gnu0_magic = const_le32('G' | 'N' << 8 | 'U' << 16);
> +            uint32_t note[7];
> +
> +            /*
> +             * The note contents are 7 words, but depending on LP64 vs ILP32
> +             * there may be an 8th padding word at the end.  Check for and
> +             * read the minimum size.  Further checks below will validate
> +             * that the sizes of everything involved are as we expect.
> +             */
> +            if (eppnt->p_filesz < sizeof(note)) {
> +                continue;
> +            }
> +            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
> +                memcpy(note, bprm_buf + eppnt->p_offset, sizeof(note));
> +            } else {
> +                retval = pread(image_fd, note, sizeof(note), eppnt->p_offset);
> +                if (retval != sizeof(note)) {
> +                    goto exit_perror;
> +                }
> +            }
> +#ifdef BSWAP_NEEDED
> +            for (i = 0; i < ARRAY_SIZE(note); ++i) {
> +                bswap32s(note + i);
> +            }
> +#endif
> +            /*
> +             * Check that this is a NT_GNU_PROPERTY_TYPE_0 note.
> +             * Again, descsz includes padding.  Full size validation
> +             * awaits checking the final payload.
> +             */
> +            if (note[0] != 4 ||                       /* namesz */
> +                note[1] < 12 ||                       /* descsz */
> +                note[2] != NT_GNU_PROPERTY_TYPE_0 ||  /* type */
> +                note[3] != gnu0_magic) {              /* name */

note[2] and note[3] are both basically magic numbers, AIUI.
Why do we have a #define for one but we assemble the other
with a const_le32() expression ?

> +                continue;
> +            }
> +#ifdef TARGET_AARCH64
> +            if (note[4] == GNU_PROPERTY_AARCH64_FEATURE_1_AND &&
> +                note[5] == 4) {
> +                info->note_flags = note[6];
> +            }

The spec for the .note.gnu.property section (which AIUI is
https://raw.githubusercontent.com/wiki/hjl-tools/linux-abi/linux-abi-draft.pdf
) says that the n_desc (words 4 and up) is an array of program
properties. There doesn't seem to be any guarantee that there
is only one entry or that the FEATURE_1_AND entry is the first
in the list. Don't we need to iterate through the array to find
matches? This seems to be how the kernel does it:
 https://elixir.bootlin.com/linux/latest/source/fs/binfmt_elf.c#L786

(Is it worth adding the infrastructure to parse notes generically
the way the kernel has? I dunno if we think it's likely we'll
want to do this for more note types and/or other architectures
in future, so it might just be pointless complexity.)

thanks
-- PMM

