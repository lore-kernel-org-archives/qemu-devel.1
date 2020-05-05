Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EEEC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB28206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qENpLMHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB28206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuym-0002u7-Ty
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVuxu-0002M0-0d
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:38:18 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVuxs-0003XW-Sj
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:38:17 -0400
Received: by mail-ot1-x344.google.com with SMTP id g14so1193675otg.10
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6Wf2JDkyu1epQNIJRFfISHKG+COWmGo22KN/bX6e+n8=;
 b=qENpLMHLa+WJNx7P5SrxGrb/HCYKWCHiTnSxOVUlRJepAkAZrjy4USZdpvElXsK011
 mSCKHALFvTJsmC21V0Dovb/zxNdO9IGw6dv2R+dI7RmIrx65AfYe/R2ZMrG6D0VYuBgn
 iTftdd4iRVevOhq1YP+e/G4ECrx4a1Lt/6KyQN8bL3UvcAGFhr147wuG8nJUxOygyfKy
 AVaSsdyqfneCNpxfq2duM0chtcgeKqLrB8DYXwHDa1dt7z56yL3nCfogNKStpTMQIffP
 sAYcp8L1pFagIFULWs5dtSX8Q9asClT8edNBY8onMT85lyTbvsGLu8PDrXRzok3yhAeG
 iKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6Wf2JDkyu1epQNIJRFfISHKG+COWmGo22KN/bX6e+n8=;
 b=tEOVTrkGjGb7p861LTRkM6K6fgGSdDFROF1lElC7YMzCaq8nerB+GfkMewOgYKaOeI
 wpKW3EBjWWbuUdWL96DKPY6LsiYfsozxITiCrQlS/T2ka55NqtDHA8lAMDNTKJ3QfDHj
 VsI67xJ9gp8Aycn1bUwzyV/LImgRhPc545AkMETdythRLj453hmbsbXMgkLvk2Xgg/5F
 MrgsVZ8dflDXwfYe+udAdhQTty4RiBIt1H488K+srlkQzugKg2lxQR9jLkSfsEr+OZzw
 6eAOheEBe5hAzrrb4PaWSA6ZfY15H0ScP/x6V+HxGkHhoQavXrtlSgF+gnoneDihxcfD
 w9WQ==
X-Gm-Message-State: AGi0PublR62bmhwN2a/H9hsgREPpUrUBnvgWiH102IMIzyjgqR0+Ek5A
 4lM2L+Jwrd9On9S+4RmPkpJ2OQrtCduUsr1NCzxfNA==
X-Google-Smtp-Source: APiQypLySE8IvXRCRE3SSeJ6uGDlOzEOj5Wa9G8vCpc3k61jWPBgCZm8uIOf6bxC9IbpV0moxRU+7pDwfv284PQ20ak=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr1611838otj.91.1588675094805; 
 Tue, 05 May 2020 03:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200502224503.2282-1-richard.henderson@linaro.org>
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2020 11:38:03 +0100
Message-ID: <CAFEAcA-fbQwjU3_UuorV3q-k9exr9f_uqO_YSP7aggsm=oP=wg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] target/arm: partial vector cleanup
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 2 May 2020 at 23:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is not complete, but shows the direction I'd like to go.
>
> It may well help what Peter is doing with the neon decodetree
> conversion.  It may be helpful to apply before the conversion
> in order to reduce the number of special cases.  As may
> continuing with the cleanup; I'll probably work on that more
> next week.
>
> Version 2 extracts more bits from my sve2 branch.  There's
> still more to pull back, especially for crypto_helper.c, where
> there are also tail clearing bugs to fix.

This doesn't apply on master any more as a result of the
first lump of decodetree stuff going in. Also patch 2
doesn't seem to compile:

/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c: In
function =E2=80=98gen_gvec_srshr=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:4107:9:
error: implicit declaration of function =E2=80=98tcg_gen_gvec_dup_imm=E2=80=
=99; did
you mean =E2=80=98tcg_gen_gvec_dup_i64=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
         tcg_gen_gvec_dup_imm(vece, rd_ofs, opr_sz, max_sz, 0);
         ^~~~~~~~~~~~~~~~~~~~
         tcg_gen_gvec_dup_i64
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:4107:9:
error: nested extern declaration of =E2=80=98tcg_gen_gvec_dup_imm=E2=80=99
[-Werror=3Dnested-externs]

Any chance you could do a rebase and resend?

thanks
-- PMM

