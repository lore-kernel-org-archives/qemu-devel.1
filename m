Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2631BC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF92C2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF92C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NY7-0004MN-5v
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3NWq-0003dR-Fl
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3NWp-00041N-2F
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:44:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3NWo-00040z-Ri
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:44:07 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE76683F3B
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 16:44:05 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k14so2401493wrv.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e37qThlOf/YoQQgqRUcwATXkKcLi/cFpq9a5Q+V6lxM=;
 b=loqTjSw3kqxI2B1JJ2lgAG4av1c/H0wCUfXZM9YRGYUbr5eys/1Ap/ASwow1/Ezln5
 V4tjBOr0Oygl/5bgtb/12SpZwlRsBQtqyqEq83j97wAmeyRRHjviWR5nrEYOPXy1hD0f
 6sLWaGaLYzTbR+D40/vGElr8KkbQpPFkx0rHItgHT7rRkChPzN34jMhl0D6mwgy9kUqz
 c10Yk3BmtXWz7UzUMrawk0eoNAw57+idACRRluxkFgTWUKuag2FNgYbW7Chysjfyyfid
 SjSy3ywNPKanE/iKU0mBHZEnCcdVv3hpx50e4Mbi5n6iXXXFDWYwqeWrPHnMeMcaaumP
 4HIg==
X-Gm-Message-State: APjAAAWtyX3B5Fkmu8sEXcAuKLdRErOZklyJW6U2RsckvVasY6Hfhtqw
 q6L2u+UuKiXAgIvCzGSUuEgpsVAyBvejHAp8eFspY4o0kgdg6WNv23yBwnPXV/f3RzL2lAtVuZ2
 EBr4sjH/rcyG2gS4=
X-Received: by 2002:adf:de8a:: with SMTP id w10mr2073695wrl.276.1567097044215; 
 Thu, 29 Aug 2019 09:44:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz5FCNP5Wv1OKq/lKWK0FC1/DP2QeG4bLN/pW3o2zj3JlalH9TW3wQ+pH0mF1j4Od8YJyFS/g==
X-Received: by 2002:adf:de8a:: with SMTP id w10mr2073669wrl.276.1567097044037; 
 Thu, 29 Aug 2019 09:44:04 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id n8sm6874343wma.7.2019.08.29.09.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 09:44:03 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828190456.30315-1-richard.henderson@linaro.org>
 <20190828190456.30315-65-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <de42445d-aec2-4ea8-bfe5-7f6bc062300c@redhat.com>
Date: Thu, 29 Aug 2019 18:44:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828190456.30315-65-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 64/69] target/arm: Convert T16,
 shift immediate
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/19 9:04 PM, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/arm/translate.c | 26 ++------------------------
>  target/arm/t16.decode  |  8 ++++++++
>  2 files changed, 10 insertions(+), 24 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 5fb0e2066b..dd292b3042 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10731,7 +10731,7 @@ static void disas_thumb2_insn(DisasContext *s, =
uint32_t insn)
> =20
>  static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>  {
> -    uint32_t val, op, rm, rd, shift;
> +    uint32_t val, rd;
>      int32_t offset;
>      TCGv_i32 tmp;
>      TCGv_i32 tmp2;
> @@ -10743,29 +10743,7 @@ static void disas_thumb_insn(DisasContext *s, =
uint32_t insn)
>      /* fall back to legacy decoder */
> =20
>      switch (insn >> 12) {
> -    case 0: case 1:
> -
> -        rd =3D insn & 7;
> -        op =3D (insn >> 11) & 3;
> -        if (op =3D=3D 3) {
> -            /*
> -             * 0b0001_1xxx_xxxx_xxxx
> -             *  - Add, subtract (three low registers)
> -             *  - Add, subtract (two low registers and immediate)
> -             * In decodetree.
> -             */
> -            goto illegal_op;
> -        } else {
> -            /* shift immediate */
> -            rm =3D (insn >> 3) & 7;
> -            shift =3D (insn >> 6) & 0x1f;
> -            tmp =3D load_reg(s, rm);
> -            gen_arm_shift_im(tmp, op, shift, s->condexec_mask =3D=3D 0=
);
> -            if (!s->condexec_mask)
> -                gen_logic_CC(tmp);
> -            store_reg(s, rd, tmp);
> -        }
> -        break;
> +    case 0: case 1: /* add/sub (3reg, 2reg imm), shift imm; in decodet=
ree */
>      case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
>          goto illegal_op;
>      case 4:
> diff --git a/target/arm/t16.decode b/target/arm/t16.decode
> index f128110dee..79a1d66d6c 100644
> --- a/target/arm/t16.decode
> +++ b/target/arm/t16.decode
> @@ -126,6 +126,14 @@ ADD_rri         10101 rd:3 ........ \
>  STM             11000 ... ........              @ldstm
>  LDM_t16         11001 ... ........              @ldstm
> =20
> +# Shift (immediate)
> +
> +@shift_i        ..... shim:5 rm:3 rd:3          &s_rrr_shi %s rn=3D%re=
g_0
> +
> +MOV_rxri        000 00 ..... ... ...            @shift_i shty=3D0  # L=
SL
> +MOV_rxri        000 01 ..... ... ...            @shift_i shty=3D1  # L=
SR
> +MOV_rxri        000 10 ..... ... ...            @shift_i shty=3D2  # A=
SR
> +
>  # Add/subtract (three low registers)
> =20
>  @addsub_3       ....... rm:3 rn:3 rd:3 \
>=20

