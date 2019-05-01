Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7D1C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E941120866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVP0auOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E941120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37614 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLtAM-0004Qw-SK
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 13:37:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLt7X-0002xI-4m
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLt7V-0001Pi-54
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:34:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLt7S-0001F9-1z
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:34:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id e28so2303911wra.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:subject:in-reply-to:date:message-id
	:mime-version:content-transfer-encoding;
	bh=rE+ZclOYA+sTRRDN49DlyI/RNr+kudItrD/D0Qg1SWU=;
	b=yVP0auOL8ZJ+jzcxQge4ZzTQFmAJ2lilpRESb9P4FZ5pQJeXgI8Qh7h/Ce2q4nLaKr
	UYMoU9ynWp3hzY4yauntrnhvG7oU4S/0XuUs0Mq28WAbkAjVcxjqMzft+Ldmz3azXCSS
	Fkt4rmQDdDI7kCnvunATQMb/fvnoUYv/rKFp8T6qaNQzpF9GhnfhHcgCfhVIpgngWvC3
	EYN2nfJY46owA21KiGbx8LslkKzk7Ey2y5I5muNlxZACgGDwfS41PcSBgI1fvok64uCU
	gTFIKgXt3vuwhTCwxjl/+87DpP7e+Lb2gQPu/cSFu0GcHycYGRCvPPutWq9bOFD+Stkw
	zXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=rE+ZclOYA+sTRRDN49DlyI/RNr+kudItrD/D0Qg1SWU=;
	b=VGu+MYliNwrLZEx1H4Qnmro8R9IVxcW2BAFWEcKv2fhmwhy2moD8+GmP/1zdru2H3W
	X2Y9vuJ1Uxz7LcwKXHWsjGvMCUTyp8ofv5vDb+YO/BZ//VesjhGuGGKYMFv6SYUrRTYe
	ojkxAw2ZO+gdAqQvBK5KbEOQmhJQvM2MRmCdPViLYhf8PfIWr+aNsJXP24ZtwNKbMh9S
	UBHUOoyMt0YkKETEjJmK5gKMOq+sVYskURoPY/Xbn2/DW2Igi+8pb+wkH+iZSQgdUgIm
	8LAY1S4Eq5a65Rw0pMNi3Ef8WcOFRs2yW1SeGpTWv7wxgUty8hWPg06JvGYL3SX0EHxt
	jxVQ==
X-Gm-Message-State: APjAAAWZoKfk3Zw11lvs76b5uk2Au0weAFkIMtVANu83zHScg/XT1nIL
	MzUXAwq0OLt2puk2NMIjTBHpvxw2T+U=
X-Google-Smtp-Source: APXvYqy1tv+iHVgf201Mm3JORmdaDn9MqK8fPY1pP9Bm6XTOxFAEJ09Q5WbotQj7cs1VIeQh/Lu68Q==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr433687wrm.329.1556732044403;
	Wed, 01 May 2019 10:34:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 5sm4440300wmi.32.2019.05.01.10.34.03
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 10:34:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 02AEE1FF87
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 18:34:03 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-8-richard.henderson@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190501050536.15580-8-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 18:34:02 +0100
Message-ID: <87muk65bat.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 07/29] tcg: Support cross-class moves
 without instruction support
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
Message-ID: <20190501173402.HmrzlK2_4VF7RnX8AGXhIK5yErNWrcv6jNk6401xLfY@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> PowerPC Altivec does not support direct moves between vector registers
> and general registers.  So when tcg_out_mov fails, we can use the
> backing memory for the temporary to perform the move.

I couldn't see where tcg_out_mov fails in this way for ppc, it is still
abort or pass:

static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
{
    tcg_debug_assert(TCG_TARGET_REG_BITS =3D=3D 64 || type =3D=3D TCG_TYPE_=
I32);
    if (ret !=3D arg) {
        tcg_out32(s, OR | SAB(arg, ret, arg));
    }
    return true;
}

did a patch get missed somewhere?



>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 8ed7cb8654..68d86361e2 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3368,7 +3368,20 @@ static void tcg_reg_alloc_mov(TCGContext *s, const=
 TCGOp *op)
>                                           ots->indirect_base);
>              }
>              if (!tcg_out_mov(s, otype, ots->reg, ts->reg)) {
> -                abort();
> +                /*
> +                 * Cross register class move not supported.
> +                 * Store the source register into the destination slot
> +                 * and leave the destination temp as TEMP_VAL_MEM.
> +                 */
> +                assert(!ots->fixed_reg);
> +                if (!ts->mem_allocated) {
> +                    temp_allocate_frame(s, ots);
> +                }
> +                tcg_out_st(s, ts->type, ts->reg,
> +                           ots->mem_base->reg, ots->mem_offset);
> +                ots->mem_coherent =3D 1;
> +                temp_free_or_dead(s, ots, -1);
> +                return;
>              }
>          }
>          ots->val_type =3D TEMP_VAL_REG;
> @@ -3470,7 +3483,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const =
TCGOp *op)
>              reg =3D tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
>                                  o_preferred_regs, ts->indirect_base);
>              if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
> -                abort();
> +                /*
> +                 * Cross register class move not supported.  Sync the
> +                 * temp back to its slot and load from there.
> +                 */
> +                temp_sync(s, ts, i_allocated_regs, 0, 0);
> +                tcg_out_ld(s, ts->type, reg,
> +                           ts->mem_base->reg, ts->mem_offset);
>              }
>          }
>          new_args[i] =3D reg;
> @@ -3631,7 +3650,13 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGO=
p *op)
>                  if (ts->reg !=3D reg) {
>                      tcg_reg_free(s, reg, allocated_regs);
>                      if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
> -                        abort();
> +                        /*
> +                         * Cross register class move not supported.  Syn=
c the
> +                         * temp back to its slot and load from there.
> +                         */
> +                        temp_sync(s, ts, allocated_regs, 0, 0);
> +                        tcg_out_ld(s, ts->type, reg,
> +                                   ts->mem_base->reg, ts->mem_offset);
>                      }
>                  }
>              } else {


--
Alex Benn=C3=A9e

