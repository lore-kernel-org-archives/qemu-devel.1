Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193ECC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F65E21741
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwOpx1LF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F65E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVAtS-0004u2-CQ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 05:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kVAsO-0003w7-FM; Wed, 21 Oct 2020 05:57:48 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29]:46979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kVAsM-0006is-Ll; Wed, 21 Oct 2020 05:57:48 -0400
Received: by mail-yb1-xb29.google.com with SMTP id a4so1237575ybq.13;
 Wed, 21 Oct 2020 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YW79+lFpEFCqnEQQP8HwytXt4cTJ/sxB7WqwHgsmxdc=;
 b=GwOpx1LFv2J5T8fTWozSy9p4O9djDY9Ym+p6ohR44eHa3+WKWPGxR4FZ6SLepfQwg5
 11cGA6eEzMiFuibtIqdesEcl8oi2tJYa6dnR56RMjUSD45UfWQFo5DRcPlVZU84lUFQr
 pOIF9BHFWOb5FHLVAU7Ci8nJZ8/HhIJZSjU/tMRKEkxJLhQVzaokLdFb2ywUG31Lsx37
 SRX0RcyWc5d6yrhX+U4C2QfvxzWRHGLiHncebZSI1CXfx5lM+ylbycx/lNs5cDdpQ7uk
 SS2SH1Kh0kA0GyJf/YxFG0WoikSzmhoacBaqpBwFow1Qneb6rA2tAfVwhFj4vuF9R4JO
 wmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YW79+lFpEFCqnEQQP8HwytXt4cTJ/sxB7WqwHgsmxdc=;
 b=SCoro3kZtPS+vx/2LwJss3EjV48nvGbyDZfPxLYZsF1V5Ur+CL78+HtWnGvYV/kulX
 tATiAbX0IvQ3ISYxgbpczC/QfujWebWx8R7cw4emMTql31TkjwNpdcxvjwLmN68lo6vY
 5I3y/RjW8lbJtS8RHJyYUh2oiWPOTPOCc5komQN95P9zXIsyPo5odJ9B/LpBCw40HIkN
 7h1SUD+lvbD6OqI6vEhmjSjX12xfqtg5zD6z7eeSH1GU45343WomsaWYENT7DbYyFOJF
 nI/CN3NTqCOoUTeH9JzVCAoWBDXoMlTsZTXQv7aEpJA8QnMaRWWLbFmDekJaIVnlb8Zx
 O2WQ==
X-Gm-Message-State: AOAM5311jwVLgcVMl0+LWUyXNNFxquSvwSN/M4QU45DJOUr43nkzo8BB
 se+eXaggSAuPh1AqcyjQ9hhM/3KZOl7Yp4w01Rk=
X-Google-Smtp-Source: ABdhPJwj6YWuQbP25eDARMwRQ/5FHJSninTCbpOacf2GDu6Y7li1a5Ptf7EzVU6W0HS67MwOQHsSRyccvmq5xH1bD0E=
X-Received: by 2002:a25:bb01:: with SMTP id z1mr4139098ybg.387.1603274264623; 
 Wed, 21 Oct 2020 02:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200821172916.1260954-1-f4bug@amsat.org>
 <20200821172916.1260954-23-f4bug@amsat.org>
 <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
In-Reply-To: <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 21 Oct 2020 17:57:33 +0800
Message-ID: <CAEUhbmVFZ8aWdv48D8acdfFRp6WMYL6n=ENeo4hBZfmqE9TrDA@mail.gmail.com>
Subject: Re: [PULL 22/23] hw/sd: Fix incorrect populated function switch
 status data structure
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb29.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Michael Walle <michael@walle.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Tue, Oct 20, 2020 at 11:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Hi Bin,
>
> On 8/21/20 7:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > At present the function switch status data structure bit [399:376]
> > are wrongly pupulated. These 3 bytes encode function switch status
> > for the 6 function groups, with 4 bits per group, starting from
> > function group 6 at bit 399, then followed by function group 5 at
> > bit 395, and so on.
> >
> > However the codes mistakenly fills in the function group 1 status
> > at bit 399. This fixes the code logic.
> >
> > Fixes: a1bb27b1e9 ("SD card emulation (initial implementation)")
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Tested-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > Message-Id: <1598021136-49525-1-git-send-email-bmeng.cn@gmail.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >   hw/sd/sd.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index 7c9d956f113..805e21fc883 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -807,11 +807,12 @@ static void sd_function_switch(SDState *sd, uint3=
2_t arg)
> >       sd->data[11] =3D 0x43;
> >       sd->data[12] =3D 0x80;    /* Supported group 1 functions */
> >       sd->data[13] =3D 0x03;
> > +
> >       for (i =3D 0; i < 6; i ++) {
> >           new_func =3D (arg >> (i * 4)) & 0x0f;
> >           if (mode && new_func !=3D 0x0f)
> >               sd->function_group[i] =3D new_func;
> > -        sd->data[14 + (i >> 1)] =3D new_func << ((i * 4) & 4);
> > +        sd->data[16 - (i >> 1)] |=3D new_func << ((i % 2) * 4);
>
> This patch broke the orangepi machine, reproducible running
> test_arm_orangepi_bionic:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg739449.html
>
> Can you have a look?

Yes, I can take a look. Could you please send more details on how to
run "test_arm_orangepi_bionic"?

Regards,
Bin

