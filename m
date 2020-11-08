Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49564C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 01:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B529420704
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 01:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIijDdKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B529420704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbZcc-0005sr-Nn
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 20:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kbZbT-0005Lf-EQ
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 20:34:47 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kbZbP-0004Z9-4q
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 20:34:47 -0500
Received: by mail-io1-xd42.google.com with SMTP id u19so6236437ion.3
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 17:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sc4Jq0b1J94acdTQHF1QYVEWn5H5kYqyGvZdzqAhowk=;
 b=EIijDdKFxTGrZ3Gi4eXkS+r8z3lQdIuv/RCYka1I3UxccePMqc5oPYFSzk9F6fK+mc
 FC8uWlB82NSXSLvj+dhzcWP/rqME1zGTa+rVX6ZNIKny8IgMgucQv3n2gEtA8pYWv969
 QWk9qP7uibdLCGFkKyw8jvhgFc8ANuUnF9zMMZF8ilsV1GRw9EU/cTYymw5mmIPhwX4W
 KybW2WK8HO4gfSWDj6vHYaoMBhIzVFtDggGdc+dMaNguUfJ7W7R6bi7/+Te1KUqBhy74
 G+sESvD3YfQIE5Amjpt/dW3tGOXUCGB3uco/ZOzD3BGMOoFh55NMsS7pJaipdfRMoXXG
 bR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sc4Jq0b1J94acdTQHF1QYVEWn5H5kYqyGvZdzqAhowk=;
 b=TBcVcz8kz4YixvkV5gvvMc5iuo7h4ffb9yDTlQZsdV4TpVGXIfu3tob36F7t/Txjq+
 BFBmBiOyJUpn456XyVeQkQbxG+KgbecKfnHU7qVFiGEzfwD1bHXGVtaTOOTQJkA2syNv
 PEpeFUoSS1dShwvl36tvIhmh84gNKy3YKl6qOMXFa+P0fHMS/oy9bE77Q56RGMbZGSMQ
 GoTsPk/5C0TaCNAKGSiP5PN0cqlYBvavas1mXYq4ZasozVhH3umwrUgp5ZdXxoxq5vX4
 X6cpDnN/fyXgqkKAOV4LYTohXWe4av1IMXBD+aAMnnwRHmbD9wDCKuQxie2qwFjTiMTJ
 BaIQ==
X-Gm-Message-State: AOAM530C/W5GOba8i3Ka6uB5MxVWsqJKCrgyjGW5Iy/kiXWXz1x3gKtr
 QfvO2zaTPEYk63QK1H3SdxdKWkXzKenCHcEBFO4=
X-Google-Smtp-Source: ABdhPJxLcZqu6hYDOCscUjnB+zTFrzfwW+eUCEw0UA/ZCMT6nY1co/HZ9LfatIe8hy+rI7TJJytFWM5zvCcMUZLC8sM=
X-Received: by 2002:a6b:6810:: with SMTP id d16mr5857894ioc.135.1604799281699; 
 Sat, 07 Nov 2020 17:34:41 -0800 (PST)
MIME-Version: 1.0
References: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
 <1604636510-8347-2-git-send-email-chenhc@lemote.com>
 <9b081173-c4f6-28b8-178c-7137e911d2f6@amsat.org>
In-Reply-To: <9b081173-c4f6-28b8-178c-7137e911d2f6@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sun, 8 Nov 2020 09:34:30 +0800
Message-ID: <CAAhV-H6hoEH-jjarncMfDuzjviFK0xx+MC+rXmJZdUXsThntCw@mail.gmail.com>
Subject: Re: [PATCH V17 1/6] target/mips: Fix PageMask with variable page size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Sat, Nov 7, 2020 at 8:11 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Huacai,
>
> On 11/6/20 5:21 AM, Huacai Chen wrote:
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >
> > Our current code assumed the target page size is always 4k
> > when handling PageMask and VPN2, however, variable page size
> > was just added to mips target and that's no longer true.
> >
> > Fixes: ee3863b9d414 ("target/mips: Support variable page size")
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >  target/mips/cp0_helper.c | 27 +++++++++++++++++++++------
> >  target/mips/cpu.h        |  1 +
> >  2 files changed, 22 insertions(+), 6 deletions(-)
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> >
> > diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> > index 709cc9a..92bf14f 100644
> > --- a/target/mips/cp0_helper.c
> > +++ b/target/mips/cp0_helper.c
> > @@ -892,13 +892,28 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, t=
arget_ulong arg1)
> >
> >  void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pa=
gemask)
> >  {
> > -    uint64_t mask =3D arg1 >> (TARGET_PAGE_BITS + 1);
> > -    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 =3D=3D ~0) ||
> > -        (mask =3D=3D 0x0000 || mask =3D=3D 0x0003 || mask =3D=3D 0x000=
F ||
> > -         mask =3D=3D 0x003F || mask =3D=3D 0x00FF || mask =3D=3D 0x03F=
F ||
> > -         mask =3D=3D 0x0FFF || mask =3D=3D 0x3FFF || mask =3D=3D 0xFFF=
F)) {
> > -        env->CP0_PageMask =3D arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK <=
< 1));
> > +    unsigned long mask;
> > +    int maskbits;
> > +
> > +    /* Don't care MASKX as we don't support 1KB page */
> > +    mask =3D extract32((uint32_t)arg1, CP0PM_MASK, 16);
>
> I'd simply use extract64().
>
> > +    maskbits =3D find_first_zero_bit(&mask, 32);
> > +
> > +    /* Ensure no more set bit after first zero */
> > +    if (mask >> maskbits) {
> > +        goto invalid;
> > +    }
> > +    /* We don't support VTLB entry smaller than target page */
> > +    if ((maskbits + 12) < TARGET_PAGE_BITS) {
>
> I suppose the magic 12 is TARGET_PAGE_BITS_MIN, right?
>
> If you confirm I can do the change when applying (no need to
> repost the whole series).
Yes, 12 is TARGET_PAGE_BITS_MIN.

Huacai
>
> > +        goto invalid;
> >      }
> > +    env->CP0_PageMask =3D mask << CP0PM_MASK;
> > +
> > +    return;
> > +
> > +invalid:
> > +    /* When invalid, set to default target page size. */
> > +    env->CP0_PageMask =3D (~TARGET_PAGE_MASK >> 12) << CP0PM_MASK;
>
> Ditto.
>
> >  }
> >
> >  void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
> > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> > index d41579d..23f8c6f 100644
> > --- a/target/mips/cpu.h
> > +++ b/target/mips/cpu.h
> > @@ -619,6 +619,7 @@ struct CPUMIPSState {
> >   * CP0 Register 5
> >   */
> >      int32_t CP0_PageMask;
> > +#define CP0PM_MASK 13
> >      int32_t CP0_PageGrain_rw_bitmask;
> >      int32_t CP0_PageGrain;
> >  #define CP0PG_RIE 31
> >

