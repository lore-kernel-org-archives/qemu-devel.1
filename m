Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE77C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 01:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25A42225E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 01:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD4aoGVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25A42225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWrWH-0007oE-Od
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 21:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWrVc-0007JX-Qd; Sun, 25 Oct 2020 21:41:16 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:40346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWrVX-0002YE-RT; Sun, 25 Oct 2020 21:41:16 -0400
Received: by mail-yb1-xb42.google.com with SMTP id n142so6346421ybf.7;
 Sun, 25 Oct 2020 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q3cPl29zKnqybr70jkv6rl7R1OTzhpJ8x1NVQwDLhD8=;
 b=cD4aoGVCKSSxU0UZLAZzpFoMIb0dFYBRkM1oDfqrp/x0DqHM+2lGtJydWlZM+Ecf2v
 x3Vkzd79Tlo615n6cZpGWcBDZ5rui45QCCuSVvnkUHm5QDvgxOe7QRdjuntXmdWvvWw7
 udQ5NWxABayALqRF5SIQAOuMQHZVHok4KBz6s4tHkDYKi0DUmHZDxjZu9McM9G+awwSS
 qrPQgcejMB1rzG8rod+Tsl8Aen2ihDUXX8zLR8I05Wf688YTdKckZkloRGxNSDWKTpFw
 t69tFL1HL/vVDJTsiyLA32fZ2mceXwxn5NIEAG2LBReUuVXBuspR5NEeuk+fmOb3e+B6
 bY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q3cPl29zKnqybr70jkv6rl7R1OTzhpJ8x1NVQwDLhD8=;
 b=M0Um3KV2q7dH/9Ls38psXK5uO3tfGRHNpRPxpHYnYlQjWREjb5Mgji5iaeTEcmAEf6
 40YFrxi6FVrOIuyklxMcnbG1dSgMRCLKjbaTVR8/TlkD8K8al1KyW0HtreU/wZeLGLdF
 RAJshBrcXDfnofAlkJ+wlecqId0GDfXcEojXyJsqc8T0OcoSCIfDm3B394D+dDObpFhm
 yS+Z0biNs48saTz+wBnzCzba2pw6AnZ+7mRK4FZAb2qPGXFRPBdibJaxTe03Cpj60uu2
 jUbJoOF5TTBG2BQLb4kiXMtaatf+3yGtelHg74lerN6vqOrLvD9qcpu93JC6ZUBglyDL
 zRZA==
X-Gm-Message-State: AOAM533vx0bDw580juWD3gV1b4qTq0TeDv02dYMGeJoSBAxXYAtWK1A6
 5P0i0ze8FlEnK81i4GEs6Qh1vxIjOw2arRGjNBQ=
X-Google-Smtp-Source: ABdhPJyP2vZ3t4Pe7K0FmpGu8dt9cBMtWDyCKyBAW4xR79NB4nl7oiJwbawT7QK+4hBQoSw+X5eb4+EI3MtXREXC0wY=
X-Received: by 2002:a25:4113:: with SMTP id o19mr17395486yba.314.1603676470494; 
 Sun, 25 Oct 2020 18:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201025152357.11865-1-bmeng.cn@gmail.com>
 <10ba2a1c-4e8d-a860-2e8d-99dd32e61c9e@amsat.org>
In-Reply-To: <10ba2a1c-4e8d-a860-2e8d-99dd32e61c9e@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 09:40:59 +0800
Message-ID: <CAEUhbmUSYd4gz0Egs8zSCUhk9Y0CqP4c6cBePmT08zfYxxQ_DA@mail.gmail.com>
Subject: Re: [PATCH] hw/sd: Fix 2 GiB card CSD register values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Mon, Oct 26, 2020 at 2:56 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 10/25/20 4:23 PM, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > Per the SD spec, to indicate a 2 GiB card, BLOCK_LEN shall be 1024
> > bytes, hence the READ_BL_LEN field in the CSD register shall be 10
> > instead of 9.
> >
> > This fixes the acceptance test error for the NetBSD 9.0 test of the
> > Orange Pi PC that has an expanded SD card image of 2 GiB size.
> >
> > Fixes: 6d2d4069c47e ("hw/sd: Correct the maximum size of a Standard Cap=
acity SD Memory Card")
> > Reported-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >
> >   hw/sd/sd.c | 15 +++++++++++----
> >   1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index bd10ec8fc4..732fcb5ff0 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -386,10 +386,17 @@ static const uint8_t sd_csd_rw_mask[16] =3D {
> >
> >   static void sd_set_csd(SDState *sd, uint64_t size)
> >   {
> > -    uint32_t csize =3D (size >> (CMULT_SHIFT + HWBLOCK_SHIFT)) - 1;
> > +    int hwblock_shift =3D HWBLOCK_SHIFT;
> > +    uint32_t csize;
> >       uint32_t sectsize =3D (1 << (SECTOR_SHIFT + 1)) - 1;
> >       uint32_t wpsize =3D (1 << (WPGROUP_SHIFT + 1)) - 1;
> >
> > +    /* To indicate 2 GiB card, BLOCK_LEN shall be 1024 bytes */
> > +    if (size =3D=3D SDSC_MAX_CAPACITY) {
> > +        hwblock_shift +=3D 1;
>
> This is going in the good direction, however now we have an huge
> security hole, as SDState::data[] is 512 bytes, and you announce the
> guest it can use 1024 bytes. See sd_blk_read() and sd_blk_write().

Currently sd_normal_command() ensures that the maximum block length is
512 bytes as the response to cmd 16.

The spec also says in chapter4.3.2 2 GByte Card:

"However, the Block Length, set by CMD16, shall be up to 512 bytes to
keep consistency with 512 bytes Maximum Block Length cards (Less than
or equal 2GBytes cards).

I don't see any issue here. Am I missing anything?

>
> Now SDState::data[] is migrated, so this isn't an easy field to
> modify without breaking compatibility again :(
>
> I've been working on a more robust approach today, doing some cleanup
> first. I'll send it during the next days hopefully.

Regards,
Bin

