Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB0FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584762070B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584762070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NSV-0001nH-J9
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3NRr-0001Ny-Sl
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3NRp-0001e5-C1
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:38:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3NRp-0001dY-3d
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:38:57 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9411080F83
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 16:38:55 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id x12so2398520wrw.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9crfS2lwbbrTGY/PjsTXajWPfVJCekZ1yS3oFpV2Sj4=;
 b=GDDmP7j/6c1XEz8zajQ3CBOE4ounGbNp8u9zbHEsNzPDq8CABcNN5ZXKruR+uL8kDB
 9rZg5rN32KC22v8vhCc27F50tSRrs4fTj+Nvke3K/GVJRABNb0IZV6uaM7OxwlLQUleO
 LhYqUHbL7UOjqC3H6xmiOV16JKITzmu4OMyy5e1lmwXTOMEAzp2hEhE3DkFN7aX7hVuA
 otTWM9qiBhe40IRiJVX+f4JMXIW11fW+w3hK+upPKXDJtfdy65crNOay0btcAtYNz94D
 WfIu6EKgivkjvb7qYRyQYRx6ebAMd27/FH+HbEcaMiZK378liveFxKHvilrl4ya8N9ue
 AqyA==
X-Gm-Message-State: APjAAAV8scjRSMyg+vnaHWEP/vv2rGROflRQKQXJKyU9eDJg8dhpMsna
 zBao62435yHYhfs9XPOGs4uYcWCuM1gXQcX5tqryUJLGOhzBCjdMXexyCS4uGTsu8BkmiDd6EGV
 WpjxJEubb13WY+OQ=
X-Received: by 2002:a1c:eb13:: with SMTP id j19mr11073756wmh.18.1567096734220; 
 Thu, 29 Aug 2019 09:38:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwOeDyeF7ZcBB4GQvKNUwa6NrET6Ct6xdynxC2DlYSHq2vDISByz8w13X9NjBnuoB7qjbU51w==
X-Received: by 2002:a1c:eb13:: with SMTP id j19mr11073733wmh.18.1567096733884; 
 Thu, 29 Aug 2019 09:38:53 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id k9sm4411617wrq.15.2019.08.29.09.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 09:38:53 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828190456.30315-1-richard.henderson@linaro.org>
 <20190828190456.30315-36-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <468dc2b7-7d7b-2400-bd86-e6be7b3a3ae7@redhat.com>
Date: Thu, 29 Aug 2019 18:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828190456.30315-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 35/69] target/arm: Convert
 Clear-Exclusive, Barriers
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Check m-profile for all; fix missing isa check for ISB;
> fix thumb isa check for CLREX and DSB.
> ---
>  target/arm/translate.c       | 127 ++++++++++++++++-------------------
>  target/arm/a32-uncond.decode |  10 +++
>  target/arm/t32.decode        |  10 +++
>  3 files changed, 78 insertions(+), 69 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 46e3f946d5..003b8ac414 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10122,6 +10122,63 @@ static bool trans_SRS(DisasContext *s, arg_SRS=
 *a)
>      return true;
>  }
> =20
> +/*
> + * Clear-Exclusive, Barriers
> + */
> +
> +static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
> +{
> +    if (s->thumb
> +        ? !ENABLE_ARCH_7 && !arm_dc_feature(s, ARM_FEATURE_M)
> +        : !ENABLE_ARCH_6K) {
> +        return false;
> +    }
> +    gen_clrex(s);
> +    return true;
> +}
> +
> +static bool trans_DSB(DisasContext *s, arg_DSB *a)
> +{
> +    if (!ENABLE_ARCH_7 && !arm_dc_feature(s, ARM_FEATURE_M)) {
> +        return false;
> +    }
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +    return true;
> +}
> +
> +static bool trans_DMB(DisasContext *s, arg_DMB *a)
> +{
> +    return trans_DSB(s, NULL);
> +}
> +
> +static bool trans_ISB(DisasContext *s, arg_ISB *a)
> +{
> +    if (!ENABLE_ARCH_7 && !arm_dc_feature(s, ARM_FEATURE_M)) {
> +        return false;
> +    }
> +    /*
> +     * We need to break the TB after this insn to execute
> +     * self-modifying code correctly and also to take
> +     * any pending interrupts immediately.
> +     */
> +    gen_goto_tb(s, 0, s->base.pc_next);
> +    return true;
> +}
> +
> +static bool trans_SB(DisasContext *s, arg_SB *a)
> +{
> +    if (!dc_isar_feature(aa32_sb, s)) {
> +        return false;
> +    }
> +    /*
> +     * TODO: There is no speculation barrier opcode
> +     * for TCG; MB and end the TB instead.
> +     */
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +    gen_goto_tb(s, 0, s->base.pc_next);
> +    return true;
> +}
> +
>  /*
>   * Legacy decoder.
>   */
> @@ -10215,38 +10272,6 @@ static void disas_arm_insn(DisasContext *s, un=
signed int insn)
>                  s->base.is_jmp =3D DISAS_UPDATE;
>              }
>              return;
> -        } else if ((insn & 0x0fffff00) =3D=3D 0x057ff000) {
> -            switch ((insn >> 4) & 0xf) {
> -            case 1: /* clrex */
> -                ARCH(6K);
> -                gen_clrex(s);
> -                return;
> -            case 4: /* dsb */
> -            case 5: /* dmb */
> -                ARCH(7);
> -                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> -                return;
> -            case 6: /* isb */
> -                /* We need to break the TB after this insn to execute
> -                 * self-modifying code correctly and also to take
> -                 * any pending interrupts immediately.
> -                 */
> -                gen_goto_tb(s, 0, s->base.pc_next);
> -                return;
> -            case 7: /* sb */
> -                if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
> -                    goto illegal_op;
> -                }
> -                /*
> -                 * TODO: There is no speculation barrier opcode
> -                 * for TCG; MB and end the TB instead.
> -                 */
> -                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> -                gen_goto_tb(s, 0, s->base.pc_next);
> -                return;
> -            default:
> -                goto illegal_op;
> -            }
>          } else if ((insn & 0x0e000f00) =3D=3D 0x0c000100) {
>              if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
>                  /* iWMMXt register transfer.  */
> @@ -10707,43 +10732,7 @@ static void disas_thumb2_insn(DisasContext *s,=
 uint32_t insn)
>                              gen_set_psr_im(s, offset, 0, imm);
>                          }
>                          break;
> -                    case 3: /* Special control operations.  */
> -                        if (!arm_dc_feature(s, ARM_FEATURE_V7) &&
> -                            !arm_dc_feature(s, ARM_FEATURE_M)) {
> -                            goto illegal_op;
> -                        }
> -                        op =3D (insn >> 4) & 0xf;
> -                        switch (op) {
> -                        case 2: /* clrex */
> -                            gen_clrex(s);
> -                            break;
> -                        case 4: /* dsb */
> -                        case 5: /* dmb */
> -                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> -                            break;
> -                        case 6: /* isb */
> -                            /* We need to break the TB after this insn
> -                             * to execute self-modifying code correctl=
y
> -                             * and also to take any pending interrupts
> -                             * immediately.
> -                             */
> -                            gen_goto_tb(s, 0, s->base.pc_next);
> -                            break;
> -                        case 7: /* sb */
> -                            if ((insn & 0xf) || !dc_isar_feature(aa32_=
sb, s)) {
> -                                goto illegal_op;
> -                            }
> -                            /*
> -                             * TODO: There is no speculation barrier o=
pcode
> -                             * for TCG; MB and end the TB instead.
> -                             */
> -                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> -                            gen_goto_tb(s, 0, s->base.pc_next);
> -                            break;
> -                        default:
> -                            goto illegal_op;
> -                        }
> -                        break;
> +                    case 3: /* Special control operations, in decodetr=
ee */
>                      case 4: /* bxj, in decodetree */
>                          goto illegal_op;
>                      case 5: /* Exception return.  */
> diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decod=
e
> index 64548a93e2..c7e9df8030 100644
> --- a/target/arm/a32-uncond.decode
> +++ b/target/arm/a32-uncond.decode
> @@ -22,6 +22,7 @@
>  # All of those that have a COND field in insn[31:28] are in a32.decode
>  #
> =20
> +&empty           !extern
>  &i               !extern imm
> =20
>  # Branch with Link and Exchange
> @@ -37,3 +38,12 @@ BLX_i            1111 101 . ........................=
          &i imm=3D%imm24h
> =20
>  RFE              1111 100 pu:2 0 w:1 1 rn:4 0000 1010 0000 0000   &rfe
>  SRS              1111 100 pu:2 1 w:1 0 1101 0000 0101 000 mode:5  &srs
> +
> +# Clear-Exclusive, Barriers
> +
> +# QEMU does not require the option field for the barriers.
> +CLREX            1111 0101 0111 1111 1111 0000 0001 1111
> +DSB              1111 0101 0111 1111 1111 0000 0100 ----
> +DMB              1111 0101 0111 1111 1111 0000 0101 ----
> +ISB              1111 0101 0111 1111 1111 0000 0110 ----
> +SB               1111 0101 0111 1111 1111 0000 0111 0000
> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> index c8a8aeceee..18c268e712 100644
> --- a/target/arm/t32.decode
> +++ b/target/arm/t32.decode
> @@ -305,6 +305,16 @@ CLZ              1111 1010 1011 ---- 1111 .... 100=
0 ....      @rdm
>        # of the space is "reserved hint, behaves as nop".
>        NOP        1111 0011 1010 1111 1000 0000 ---- ----
>      }
> +
> +    # Miscelaneous control

"Miscellaneous"

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    {
> +      CLREX      1111 0011 1011 1111 1000 1111 0010 1111
> +      DSB        1111 0011 1011 1111 1000 1111 0100 ----
> +      DMB        1111 0011 1011 1111 1000 1111 0101 ----
> +      ISB        1111 0011 1011 1111 1000 1111 0110 ----
> +      SB         1111 0011 1011 1111 1000 1111 0111 0000
> +    }
> +
>      # Note that the v7m insn overlaps both the normal and banked insn.
>      {
>        MRS_bank   1111 0011 111 r:1 .... 1000 rd:4   001. 0000  \
>=20

