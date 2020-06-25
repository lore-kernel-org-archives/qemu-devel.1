Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE76C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D8520706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QU7eNz2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D8520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPJf-0004lq-4O
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPIP-0003OR-7O
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:39:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPIM-0003xj-M5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:39:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id t6so4778901otk.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y0tl/LRYmxKEARCyKj8ORv9XyuR7fStN6OqdSH4iSXE=;
 b=QU7eNz2nPOTt/qp2wSppObKa90nGSzNeafrQrlhlunwEe67du3H4831Fss8a8G1uCn
 XRnaRCZmAtFcREyY+9lqbtwakX+Yc6lVmkCR1u6ptmNenCeiY6tfvr5bvA8xVxmuF87Z
 F7Hq3s5J2ezFLGJ7M2UiN+7xXRHQ5GdZPvfPdYMiF6qxZVw7998rcKRC0CN56Hn2R4uj
 YoOTEEFIGY6INHLuG45kZL1iYpal/A3H4/dPJa3+BvLAUgkE/H6GK+Nm7cVicZqATPt8
 6dyLDQ34PAK3Nbu+SfgQxstsApI5LFOXEMD5vNUT5rsIXObQ3Mll+Pz3UmBxkmpdxXGy
 NcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y0tl/LRYmxKEARCyKj8ORv9XyuR7fStN6OqdSH4iSXE=;
 b=WRyGBQ1tpnqdb0cpd/pre1uc2ckgEDvsSCnzLOUuUKmb+8gFhd8T0ySk5vaHlneP+a
 tBHTEtUz66dQ9o0Fw54CliZKTj1TIWBE4bO4XkR+rOKs6DlWj3knPJhsphoMf1YH+bZt
 stom/YWi+DfSzMfQAE7QGyBGSfx0Tukvi7e68/LBa55vDt/Da+IpnQYqSyhmUw/WSHM+
 TmSIEb5uBCO+biqDJ/MBMBCtzh/iG4X5bcwg9YDN4QjlubDACcpzpINcAevf4JL1OL5A
 WCL8HZ8JeO4Paukx5zlEKIQa2Vx2YVGmO5NRRLlOOWpxbF9VSHHhAtkqYrzn1xQdrfm5
 lkEQ==
X-Gm-Message-State: AOAM5300fUUcgfAK2Z6D3NXpCKsCYFDSNS0RumP/3mZ9qla6j8A6NKXv
 uXMZIMakX2/XcrcWBh4dQbSYs8Oy184b1+8swiEtVQ==
X-Google-Smtp-Source: ABdhPJxiUi3EiWToydRRGXtu6M12FfIRzh1DT0Yvj4YdcufUNvmnVdTDiIBavIBywPGcByJ2Zvp696sLXqKt+JNWmL8=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr15838587oop.20.1593081588979; 
 Thu, 25 Jun 2020 03:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-12-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 11:39:37 +0100
Message-ID: <CAFEAcA88cAAd0o9MON6ioyxy471GVzv4Y4y57=1-2NnENb=EaQ@mail.gmail.com>
Subject: Re: [PATCH v8 11/45] target/arm: Implement the ADDG, SUBG instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> +/*
> + * Add/subtract (immediate, with tags)
> + *
> + *  31 30 29 28         23 22 21     16 14      10 9   5 4   0
> + * +--+--+--+-------------+--+---------+--+-------+-----+-----+
> + * |sf|op| S| 1 0 0 0 1 0 |o2|  uimm6  |o3| uimm4 |  Rn | Rd  |
> + * +--+--+--+-------------+--+---------+--+-------+-----+-----+

Bit 23 should be '1'.

> + *
> + *    op: 0 -> add, 1 -> sub
> + */
> +static void disas_add_sub_imm_with_tags(DisasContext *s, uint32_t insn)
> +{
> +    int rd = extract32(insn, 0, 5);
> +    int rn = extract32(insn, 5, 5);
> +    int uimm4 = extract32(insn, 10, 4);
> +    int uimm6 = extract32(insn, 16, 6);
> +    bool sub_op = extract32(insn, 30, 1);
> +    TCGv_i64 tcg_rn, tcg_rd;
> +    int imm;
> +
> +    /* Test all of sf=1, S=0, o2=0, o3=0.  */
> +    if ((insn & 0xc040e000u) != 0x80000000u ||

This bit pattern doesn't seem to match the comment:
0xc is 0b1100 so that's sf and op, not sf and S;
0xe is 0b1110 so that's testing the top bit of uimm4
as well as op3. I think it should be 0xa040c000.
Though the existence of this bug suggests that it would
be clearer to test the individual fields :-)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


Interestingly clang (6.0.0) gets pretty close to optimizing
the field test version:

bool foo(uint32_t insn) {
   return (insn & 0xa040c000) != 0x80000000u;
}

bool bar(uint32_t insn) {
   bool sf = extract32(insn, 31, 1);
   bool s = extract32(insn, 29, 1);
   bool o2 = extract32(insn, 22, 1);
   int op2 = extract32(insn, 14, 2);

   return sf != 1 || s != 0 || o2 != 0 || op2 != 0;
}

gives
0000000000000000 <foo>:
   0:   81 e7 00 c0 40 a0       and    $0xa040c000,%edi
   6:   81 ff 00 00 00 80       cmp    $0x80000000,%edi
   c:   0f 95 c0                setne  %al
   f:   c3                      retq

0000000000000010 <bar>:
  10:   89 f8                   mov    %edi,%eax
  12:   25 00 00 00 a0          and    $0xa0000000,%eax
  17:   3d 00 00 00 80          cmp    $0x80000000,%eax
  1c:   75 0a                   jne    28 <bar+0x18>
  1e:   f7 c7 00 c0 40 00       test   $0x40c000,%edi
  24:   0f 95 c0                setne  %al
  27:   c3                      retq
  28:   b0 01                   mov    $0x1,%al
  2a:   c3                      retq

(I don't know why it's split it into two tests: it's
not that it's testing "must be 1" in one part and "must
be 0" in the other because it has checked both sf and s
in the first comparison.)

gcc (7.4.0) makes more of a hash of it though:

  10:   89 f8                   mov    %edi,%eax
  12:   89 fa                   mov    %edi,%edx
  14:   c1 e8 1f                shr    $0x1f,%eax
  17:   c1 ea 1d                shr    $0x1d,%edx
  1a:   83 f0 01                xor    $0x1,%eax
  1d:   09 d0                   or     %edx,%eax
  1f:   83 e0 01                and    $0x1,%eax
  22:   75 13                   jne    37 <bar+0x27>
  24:   89 f8                   mov    %edi,%eax
  26:   c1 ef 16                shr    $0x16,%edi
  29:   c1 e8 0e                shr    $0xe,%eax
  2c:   83 e7 01                and    $0x1,%edi
  2f:   83 e0 03                and    $0x3,%eax
  32:   09 f8                   or     %edi,%eax
  34:   0f 95 c0                setne  %al
  37:   f3 c3                   repz retq

thanks
-- PMM

