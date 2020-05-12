Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D66C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A70206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KavdgEOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A70206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVFX-0007MK-DS
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVEh-0006cz-Dc
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:46:19 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:46403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVEg-0002QQ-9k
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:46:18 -0400
Received: by mail-oo1-xc41.google.com with SMTP id x16so2711858oop.13
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nUJDNAQXQcaIWONQyykONY5kjqq//opk+gXJWcH43ys=;
 b=KavdgEOTyXDFnkQn/dT24zNPNSOoAZM04whbOUWQlNMPOqo6kWDfnZW9W82muSf4Nc
 2Ehq+NPLGDNh/U/TYHouBltKMcFoUfaYeINZRo/U8gxB/XV9pMSjJ0PuqEiqn6fjnXLV
 pGFnEZZWk+ZLZ25aDCbBvU9bSbc1KMXuT3oFZGeXnbpWwttmRGlpdazMEnoLctWqeqHm
 hM3Po2ZHMWhPBVqecugStFSBbqZlQVt4KY4j93oPqHmjBt1rPKWb1ObF8zjHQ1/q9OPM
 5+YQBfSkRK9wuSIVM2xYP+K2aZi/GDRzM7pJuPtDyj4bkof06HXmf2PqWWiBv4xFhrVf
 eVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nUJDNAQXQcaIWONQyykONY5kjqq//opk+gXJWcH43ys=;
 b=hDDxD4oZqH3zy+WtyvTvxliRQRS5GSEQcIIQ4ba8IPlu8iV1kESEdAbbL60RKSLmxB
 Gj5XNsEdrXoXPJqsSXhevM22OHeg73WgYqjx/+a3SC41gXMXY63r8nD4+T86sjcQoRqO
 ripVsIGyuEZcYZEl2nVTRMfSR8ssFtaX0/9Qr0BkcGPV89/wpBoymv647fpg4HM174jU
 NCyhiKHXPFeBLKxVxJF7N5WUP2ZFIVLVGFaWIvVG4uAPimYlztQJfGvAHowEHzQFVjpK
 1PKp/n9zGtaVpqK1tfn5UGG9QqWCHipreb6diR5D+zbL9otNIt7m7zQ7cbGo7DhLnV7P
 gC5g==
X-Gm-Message-State: AGi0PuaJy1h1cmBdHFcU7nNp+AoPQgOUZiOYQRAh9mTXC2cTgPhg1IIQ
 UpMxEOHucvOoro/sC9i9o5qlqDH/soKS2sEF615xfQ==
X-Google-Smtp-Source: APiQypI0pu/IrUCwNQStXj+6A3en+d+1fEXixgRK2vHypN3Ulcs2ybtDpIIaBB+kvI+Vsz+JjlNOHS7q/JkgtqSZZaE=
X-Received: by 2002:a4a:3556:: with SMTP id w22mr12203220oog.20.1589291176827; 
 Tue, 12 May 2020 06:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-3-richard.henderson@linaro.org>
 <CAFEAcA9q6ZJqEzgfSTgLiFp0a708yhGjrEGArqhCKUQDVp8XLg@mail.gmail.com>
In-Reply-To: <CAFEAcA9q6ZJqEzgfSTgLiFp0a708yhGjrEGArqhCKUQDVp8XLg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 14:46:05 +0100
Message-ID: <CAFEAcA9=yrvEZGRW0rj_1UyRQd0VFYCq7OWtN8ePGvsBajkaFQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] target/arm: Create gen_gvec_{u,s}{rshr,rsra}
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
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

On Tue, 12 May 2020 at 14:09, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Fri, 8 May 2020 at 16:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Create vectorized versions of handle_shri_with_rndacc
> > for shift+round and shift+round+accumulate.  Add out-of-line
> > helpers in preparation for longer vector lengths from SVE.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > +    /* tszimm encoding produces immediates in the range [1..esize] */
> > +    tcg_debug_assert(shift > 0);
>
> This assert can be triggered:

(well, not this assert, but the equivalent one in gen_gvec_ursra)

=EF=BB=BF=EF=BB=BF
> > +static void gen_srshr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64=
_t sh)
> > +{
> > +    TCGv_vec t =3D tcg_temp_new_vec_matching(d);
> > +    TCGv_vec ones =3D tcg_temp_new_vec_matching(d);
> > +
> > +    tcg_gen_shri_vec(vece, t, a, sh - 1);
> > +    tcg_gen_dupi_vec(vece, ones, 1);
> > +    tcg_gen_and_vec(vece, t, t, ones);
> > +    tcg_gen_sari_vec(vece, d, a, sh);
> > +    tcg_gen_add_vec(vece, d, d, t);
> > +
> > +    tcg_temp_free_vec(t);
> > +    tcg_temp_free_vec(ones);
> > +}

+void gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] =3D {
+        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
+    };
=EF=BB=BF=EF=BB=BF=EF=BB=BF
Is there documentation somewhere of which vector operations don't
need to be listed in the vecop list? Here gen_srshr_vec() also
uses 'dupi_vec' and 'and_vec', which aren't listed, presumably
because we guarantee them to be implemented? (Hopefully we don't
encounter a future host vector architecture which breaks that
assumption :-))

> > @@ -5269,6 +5685,28 @@ static int disas_neon_data_insn(DisasContext *s,=
 uint32_t insn)
> >                      }
> >                      return 0;
> >
> > +                case 2: /* VRSHR */
> > +                    /* Right shift comes here negative.  */
> > +                    shift =3D -shift;
> > +                    if (u) {
> > +                        gen_gvec_urshr(size, rd_ofs, rm_ofs, shift,
> > +                                       vec_size, vec_size);
> > +                    } else {
> > +                        gen_gvec_srshr(size, rd_ofs, rm_ofs, shift,
> > +                                       vec_size, vec_size);
> > +                    }
> > +                    return 0;
> > +
> > +                case 3: /* VRSRA */
> > +                    if (u) {
> > +                        gen_gvec_ursra(size, rd_ofs, rm_ofs, shift,
> > +                                       vec_size, vec_size);
> > +                    } else {
> > +                        gen_gvec_srsra(size, rd_ofs, rm_ofs, shift,
> > +                                       vec_size, vec_size);
> > +                    }
> > +                    return 0;
>
> I think the VRSRA case needs the same "shift =3D -shift" as VRSHR.

With this bug fixed,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

