Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A752C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D949F20657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs4HTi3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D949F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7huo-0002E4-1b
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7hqG-0001JB-Kn; Mon, 17 Aug 2020 12:18:36 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7hqE-00050I-R4; Mon, 17 Aug 2020 12:18:36 -0400
Received: by mail-io1-xd43.google.com with SMTP id u126so18085772iod.12;
 Mon, 17 Aug 2020 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p9XCntgwV4W2FDTPpu1YQgq63ARJn3VQZsFMwFACLI0=;
 b=bs4HTi3c1VSr3QBvajFKLXejfMxsMqR6knecjzwkeiEkfxA91VzONAAleXY9B/tdv7
 DCmD+MBjfmQTqb4RKHjYrUOlx0EhmfjXSaL/ozMGuZWhgn8TcxvHCfq1H15sCXnpgjHD
 /QuTmln589j3rfBXximJz7hPwz8ONvVfRxVPbkq8+8kSBzhuXpHD5MFXE/s8xZSEvwel
 XJN9A9CagnrenyLGtltfrBdmIIAo7KExQzimLiWKdX9I+2RxQba9jorzK6n1XSNhops1
 hGhB9tAiufUB9WxmF0T3hNYybpGVEU8bcTcnjPhj0WIRg3wIh7rniQ/MLFP/P4MoIvH1
 ieCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p9XCntgwV4W2FDTPpu1YQgq63ARJn3VQZsFMwFACLI0=;
 b=dhjMWABabmH/SvH15EA8TR1ktXwRNZYmfLhtSjXJ/EHtOyInhnxsRIW04pirV/S+mI
 sZzUMZfXWyVfRC5pwKB2X6++xhLfuMc0slVZUatCN2wP5tg3EE7yaVaZNyWVz+DnGsj+
 blvKDkkgbPf4/3dxBZttc1UvOOaW8Cmbss6gdyBl+Zla3D3T3q0QEQ+YnvAO91XKqTEW
 qKIVFTverb/u8eEy+vVea2kr2bHRXpAt4LSsCEaCtxjLlneXnzZzMQ+XBuHP9H7w6eky
 8occLStyZbvXXu2DKAOfwHJsinrj8xilFUyKbcpc+vA7l3F+AKc5JUM8mADsSO4FQ/JH
 IKug==
X-Gm-Message-State: AOAM531GnMVhvjjHO8akcT56swMpDSXM4wYZzKitka83jdNuff2NRtfK
 cMc6xeFqzUM3HbC/okqcuqall/wyqdBkFxxbutU=
X-Google-Smtp-Source: ABdhPJxtpAqo9IBscBr9q2dbQpzK88Gn7vUnSGYwOo0AG3Lm+DUnw1boPes7yth9VVKmgRhXDQl/mDcexrlO3x0tNwM=
X-Received: by 2002:a02:84c1:: with SMTP id f59mr15357394jai.106.1597681113382; 
 Mon, 17 Aug 2020 09:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
 <20200817140144.373403-2-edgar.iglesias@gmail.com>
In-Reply-To: <20200817140144.373403-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 09:08:02 -0700
Message-ID: <CAKmqyKNoWVxf0DPnNv0xOmhffGYmkVwqTwuvSKy0H5xvgotj_Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] target/microblaze: mbar: Transfer dc->rd to
 mbar_imm
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 7:04 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Transfer dc->rd to mbar_imm to improve the readability when
> comparing to the specs.
>
> No functional change.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/translate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index f6ff2591c3..47637f152b 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1229,8 +1229,10 @@ static void dec_br(DisasContext *dc)
>      /* Memory barrier.  */
>      mbar = (dc->ir >> 16) & 31;
>      if (mbar == 2 && dc->imm == 4) {
> +        uint16_t mbar_imm = dc->rd;
> +
>          /* mbar IMM & 16 decodes to sleep.  */
> -        if (dc->rd & 16) {
> +        if (mbar_imm & 16) {
>              TCGv_i32 tmp_hlt = tcg_const_i32(EXCP_HLT);
>              TCGv_i32 tmp_1 = tcg_const_i32(1);
>
> @@ -1246,7 +1248,7 @@ static void dec_br(DisasContext *dc)
>              tcg_temp_free_i32(tmp_1);
>              return;
>          }
> -        LOG_DIS("mbar %d\n", dc->rd);
> +        LOG_DIS("mbar %d\n", mbar_imm);
>          /* Break the TB.  */
>          dc->cpustate_changed = 1;
>          return;
> --
> 2.25.1
>
>

