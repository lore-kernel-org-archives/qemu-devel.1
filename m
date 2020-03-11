Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55ADC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416FE208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwm2RaNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416FE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvc3-0002db-Ca
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 03:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jBvan-0001qK-Es
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luoyonggang@gmail.com>) id 1jBvad-0004X3-2f
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:15:49 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:46469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <luoyonggang@gmail.com>)
 id 1jBvac-0004Tq-4D; Wed, 11 Mar 2020 03:15:39 -0400
Received: by mail-lj1-x231.google.com with SMTP id d23so1049056ljg.13;
 Wed, 11 Mar 2020 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=XiNNPVMxzYEXtZQ1CBVb27z+/QEQ4ZEKs02ZBn7YCYU=;
 b=Qwm2RaNC2gzmGkNext1jDMuE9kpw29WxB0iMKHe2nLFE7PvNxAOk82iL9O28dprvtp
 uJEEyEkch9XAW/xizdOeXccXgwPCS1WOHbMRXLmDgRhcqb1zbUqncoLUy9hkLy0ij/hj
 D63U5sFJUz2c93fwe7Z7a8Pm7ln1KAnnVvXkEXW4Uj12lP+t9V5Qb7M/Kb5Fxx/ZyzUx
 p2Q51f4B2260Sw6eFBhayqxd8hAt/xxJ4D4iaA1XVk6wlOidPGVR1lZmkTV54A6NdYvP
 7O3Q8cVk8wWzGyn8Kdl2rL0aQF22fQ/llAYnFbwOvZ9p3zogvi8f7gZtS3+R+g4F24xA
 m4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=XiNNPVMxzYEXtZQ1CBVb27z+/QEQ4ZEKs02ZBn7YCYU=;
 b=P9sqYsUVYkXV1dA0a8olzj/F5SESRKnBHmHDz0Ym3MWsv+cKgxj8/tZ402t20oXDGX
 YsEoZ3ZekUudjSeiovTcKCXnvx4IsnWuH8ICQF3FdBZ+mKpAHWWlWHt4H8CIeND4yXTI
 UKlVzaPhZaZuvHIosX9I7g/Rwerdg2kDpULbci9sqHc3SjyPgP8SBLyOXXA8HrS+aOvz
 xEtI2aNqXyqdTFB080bX5s+89nhL6DJ2ZisYqSTuF20SHcaI3U85uLUeCRzf/uCC/x3x
 QR2Zohx/R4JmfejbgiELfzO/YAk+I2d2nYG7EwqSLaEmt4yI+YKKDEC/cdfVQRuXP/x+
 lY9w==
X-Gm-Message-State: ANhLgQ2nRE/1bmNWX50QRWsyAYjjG7nc2dPEaUj5bCje5UjRPv5bR+Vl
 WWKpYaqHjU+M7TAVWMYuTDk4REC6qQ+9RcurEtXqWWYfrDE=
X-Google-Smtp-Source: ADFU+vud7nodNSg9jnwIy2e42ELOI7gCc0XbUqC7rTxfcc6/JwjlsY8ikBxJuEjUi7us9OtrQh2ZtK86190S1SHVGYQ=
X-Received: by 2002:a2e:2419:: with SMTP id k25mr1067739ljk.165.1583910934806; 
 Wed, 11 Mar 2020 00:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-XeFmmPHsy6KT-zHtRcZqZnuWzaXR+SkMP60cCL2jx0w@mail.gmail.com>
 <20200310100418.GE140737@stefanha-x1.localdomain>
 <CAE2XoE_aFDLGCFZvsxV+Q2nPqdOeUfQS8KJ+bUs3wwch1auzMw@mail.gmail.com>
 <20200311044721.GW660117@umbus.fritz.box>
In-Reply-To: <20200311044721.GW660117@umbus.fritz.box>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 11 Mar 2020 15:15:24 +0800
Message-ID: <CAE2XoE-16=HDkbiY1c0-SQc6VOmSrCCX82u-HP8cF=OJxfoRRg@mail.gmail.com>
Subject: Re: I am trying to fixes a issue with QEMU with VxWorks.
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: multipart/alternative; boundary="000000000000a006c105a08f006e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::231
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
Reply-To: luoyonggang@gmail.com
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a006c105a08f006e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I understand.  I have already found the cause of the problem, there is too
much IEVENT triggered,
I wanna know which is the exact place that the IRQ (IEVENT) triggered?
Would that triggered in QEMU, or can only triggered in guest OS?
static void etsec_write(void     *opaque,
                        hwaddr    addr,
                        uint64_t  value,
                        unsigned  size)
{
    eTSEC          *etsec     =3D opaque;
    uint32_t        reg_index =3D addr / 4;
    eTSEC_Register *reg       =3D NULL;
    uint32_t        before    =3D 0x0;

    assert(reg_index < ETSEC_REG_NUMBER);

    reg =3D &etsec->regs[reg_index];
    before =3D reg->value;

    switch (reg_index) {
    case IEVENT:
        /* Write 1 to clear */
        reg->value &=3D ~value;
        etsec_update_irq(etsec);

        break;

On Wed, Mar 11, 2020 at 12:55 PM David Gibson <david@gibson.dropbear.id.au>
wrote:

> On Tue, Mar 10, 2020 at 08:48:49PM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Yon=
ggang Luo) wrote:
> > I  have already debugging it. I have infinite interrupt after calling t=
o
> > motTsecGracefulStop,
>
> What interrupt is it, and what instruction is triggering it?
>
> > I am simulating wrSbc834x using etsec with PPC.
>
> Unfortunately the freescale and other embedded ppc chips are only
> barely maintained at present - there just aren't that many people with
> both the interest and skills to do so.
>
> So, I'll do what I can, but you'll probably have to do most of the
> debugging here yourself.
>
> > ```
> > Chain 0: 00000000088bad00 [00000000/00e0ccf0/0x2000] sysTimestamp64Set
> > Trace 0: 0000000008a90940 [00000000/00e06358/0x2000] motTsecGracefulSto=
p
> > 32-bits write 0x00001039 to register 0x00000
> > 32-bits write 0x00001002 to register 0x00000
> > 32-bits write 0x62110180 to register 0x00000
> > 32-bits write 0x00000935 to register 0x00000
> > 32-bits write 0x00000937 to register 0x00000
> > Chain 0: 00000000086f9c40 [00000000/00e2b51c/0x2000] intUnlock
> > Stopped execution of TB chain before 00000000086f9c40 [00e2b51c]
> intUnlock
> > Trace 0: 00000000086f9c40 [00000000/00e2b51c/0x2000] intUnlock
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Stopped execution of TB chain before 00000000087501c0 [00e7bb78] windEx=
it
> > Raise exception at 00e7bb78 =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Linking TBs 0000000008901480 [00e08168] index 0 -> 0000000008902600
> > [00e08278]
> > Trace 0: 0000000008902600 [00000000/00e08278/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Stopped execution of TB chain before 00000000087762c0 [00e00c74]
> > quiccIntrDeMux
> > Trace 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Stopped execution of TB chain before 00000000086b0c00 [00e2b52c]
> intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Stopped execution of TB chain before 00000000087762c0 [00e00c74]
> > quiccIntrDeMux
> > Trace 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Stopped execution of TB chain before 0000000008772bc0 [00e00f48]
> > quiccIvecToInum
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Stopped execution of TB chain before 0000000008752700 [00e050d8]
> > timeMonitorCtxSwitchToTask2
> > Trace 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Stopped execution of TB chain before 0000000008772200 [00e87294]
> > excConnectCode
> > Trace 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Stopped execution of TB chain before 0000000008748b00 [00e7c0b4] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Stopped execution of TB chain before 0000000008771f80 [00000500]
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Stopped execution of TB chain before 00000000086b0c00 [00e2b52c]
> intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt
> > Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock
> > Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce
> > Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce
> > Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance
> > Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce
> > Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired
> > Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce
> > Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce
> > Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit
> > Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit
> > Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit
> > Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit
> > Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit
> > Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit
> > Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce
> > Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock
> > Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt
> > Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock
> > Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux
> > Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt
> > Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux
> > Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock
> > Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock
> > Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock
> > Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux
> > Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Stopped execution of TB chain before 0000000008776800 [00e872ac]
> > excConnectCode
> > Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode
> > Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit
> > Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit
> > Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit
> > Chain 0: 0000000008752700 [00000000/00e050d8/0]
> timeMonitorCtxSwitchToTask2
> > Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit
> > Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit
> > Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit
> > Raise exception at 00e2b52c =3D> 00000004 (00)
> > Trace 0: 0000000008771f80 [00000000/00000500/0]
> > Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode
> > Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux
> > Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux
> > Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum
> > Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux
> > Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock
> > Stopped execution of TB chain before 00000000086b0c00 [00e2b52c]
> intUnlock
> > Raise exception at 00e2b52c =3D> 0000000a (00)
> > Trace 0: 0000000008747a40 [00000000/00000900/0]
> > Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode
> > Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt
> > Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt
> > Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt
> > Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt
> > Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchToI=
sr
> > Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt
> > Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode
> > Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt
> > Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet
> > Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get
> > Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt
> > Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock
> > ```
> >
> > On Tue, Mar 10, 2020 at 6:04 PM Stefan Hajnoczi <stefanha@gmail.com>
> wrote:
> >
> > > On Mon, Mar 09, 2020 at 11:26:07AM +0800, =E7=BD=97=E5=8B=87=E5=88=9A=
(Yonggang Luo) wrote:
> > > > When I am running QEMU to simulating PowerPC.
> > > > And after running the following powerpc code:
> > > > 00e2b5dc <intUnlock>:
> > > > intUnlock():
> > > >   e2b5dc: 54 63 04 20 rlwinm r3,r3,0,16,16
> > > >   e2b5e0: 7c 80 00 a6 mfmsr r4
> > > >   e2b5e4: 7c 83 1b 78 or r3,r4,r3
> > > >   e2b5e8: 7c 60 01 24 mtmsr r3
> > > >   e2b5ec: 4c 00 01 2c isync
> > > >   e2b5f0: 4e 80 00 20 blr
> > > >
> > > > The QEMU are getting stuck and can not running the following
> > > instructions,
> > > > What I need to do to inspect which instruction are getting stuck an=
d
> how
> > > to
> > > > fix it?
> > > > Any means to debugging that.
> > >
> > > CCing ppc maintainers.
> > >
> > > You could begin debugging this using QEMU's GDB stub (the -s
> > > command-line option), TCG debug output (the -d command-line option),
> and
> > > the HMP "info status" command to check that the CPU is running.
> > >
> > > Good luck!
> > >
> > > Stefan
> > >
> >
> >
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
> _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000a006c105a08f006e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I understand.=C2=A0 I have already found the cause of the =
problem, there is too much IEVENT triggered,<div>I wanna know which is the =
exact place that the IRQ (IEVENT) triggered?</div><div>Would that triggered=
 in QEMU, or can only triggered in guest OS?<br><div><div style=3D"color:rg=
b(212,212,212);background-color:rgb(30,30,30);font-family:Consolas,&quot;Co=
urier New&quot;,monospace;font-size:14px;line-height:19px;white-space:pre">=
<div><span style=3D"color:rgb(86,156,214)">static</span>=C2=A0<span style=
=3D"color:rgb(86,156,214)">void</span>=C2=A0<span style=3D"color:rgb(220,22=
0,170)">etsec_write</span>(<span style=3D"color:rgb(86,156,214)">void</span=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*<span style=3D"color:rgb(156,220,254)">opaq=
ue</span>,</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0hwaddr=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(156,2=
20,254)">addr</span>,</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(86,156,214)">uint64_t</=
span>=C2=A0=C2=A0<span style=3D"color:rgb(156,220,254)">value</span>,</div>=
<div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<span style=3D"color:rgb(86,156,214)">unsigned</span>=C2=A0=C2=A0<span styl=
e=3D"color:rgb(156,220,254)">size</span>)</div><div>{</div><div>=C2=A0=C2=
=A0=C2=A0=C2=A0eTSEC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0*etsec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=C2=A0opaque;</div><div>=C2=A0=
=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(86,156,214)">uint32_t</span>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg_index=C2=A0=3D=C2=A0addr=
=C2=A0/=C2=A0<span style=3D"color:rgb(181,206,168)">4</span>;</div><div>=C2=
=A0=C2=A0=C2=A0=C2=A0eTSEC_Register=C2=A0*reg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D=C2=A0<span style=3D"color:rgb(86,156,214)">NULL</span>;</di=
v><div>=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(86,156,214)">uint32=
_t</span>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0before=C2=A0=C2=A0=
=C2=A0=C2=A0=3D=C2=A0<span style=3D"color:rgb(181,206,168)">0x0</span>;</di=
v><br><div>=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(220,220,170)">a=
ssert</span>(reg_index=C2=A0&lt;=C2=A0ETSEC_REG_NUMBER);</div><br><div>=C2=
=A0=C2=A0=C2=A0=C2=A0reg=C2=A0=3D=C2=A0&amp;<span style=3D"color:rgb(156,22=
0,254)">etsec</span>-&gt;<span style=3D"color:rgb(156,220,254)">regs</span>=
[reg_index];</div><div>=C2=A0=C2=A0=C2=A0=C2=A0before=C2=A0=3D=C2=A0<span s=
tyle=3D"color:rgb(156,220,254)">reg</span>-&gt;<span style=3D"color:rgb(156=
,220,254)">value</span>;</div><br><div>=C2=A0=C2=A0=C2=A0=C2=A0<span style=
=3D"color:rgb(197,134,192)">switch</span>=C2=A0(reg_index)=C2=A0{</div><div=
>=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(197,134,192)">case</span>=
=C2=A0IEVENT:</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<sp=
an style=3D"color:rgb(106,153,85)">/*=C2=A0Write=C2=A01=C2=A0to=C2=A0clear=
=C2=A0*/</span></div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<=
span style=3D"color:rgb(156,220,254)">reg</span>-&gt;<span style=3D"color:r=
gb(156,220,254)">value</span>=C2=A0&amp;=3D=C2=A0~value;</div><div>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(220,220,=
170)">etsec_update_irq</span>(etsec);</div><br><div>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(197,134,192)">break</sp=
an>;</div></div></div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Mar 11, 2020 at 12:55 PM David Gibson=
 &lt;<a href=3D"mailto:david@gibson.dropbear.id.au">david@gibson.dropbear.i=
d.au</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Tue, Mar 10, 2020 at 08:48:49PM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Y=
onggang Luo) wrote:<br>
&gt; I=C2=A0 have already debugging it. I have infinite interrupt after cal=
ling to<br>
&gt; motTsecGracefulStop,<br>
<br>
What interrupt is it, and what instruction is triggering it?<br>
<br>
&gt; I am simulating wrSbc834x using etsec with PPC.<br>
<br>
Unfortunately the freescale and other embedded ppc chips are only<br>
barely maintained at present - there just aren&#39;t that many people with<=
br>
both the interest and skills to do so.<br>
<br>
So, I&#39;ll do what I can, but you&#39;ll probably have to do most of the<=
br>
debugging here yourself.<br>
<br>
&gt; ```<br>
&gt; Chain 0: 00000000088bad00 [00000000/00e0ccf0/0x2000] sysTimestamp64Set=
<br>
&gt; Trace 0: 0000000008a90940 [00000000/00e06358/0x2000] motTsecGracefulSt=
op<br>
&gt; 32-bits write 0x00001039 to register 0x00000<br>
&gt; 32-bits write 0x00001002 to register 0x00000<br>
&gt; 32-bits write 0x62110180 to register 0x00000<br>
&gt; 32-bits write 0x00000935 to register 0x00000<br>
&gt; 32-bits write 0x00000937 to register 0x00000<br>
&gt; Chain 0: 00000000086f9c40 [00000000/00e2b51c/0x2000] intUnlock<br>
&gt; Stopped execution of TB chain before 00000000086f9c40 [00e2b51c] intUn=
lock<br>
&gt; Trace 0: 00000000086f9c40 [00000000/00e2b51c/0x2000] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Stopped execution of TB chain before 00000000087501c0 [00e7bb78] windE=
xit<br>
&gt; Raise exception at 00e7bb78 =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Linking TBs 0000000008901480 [00e08168] index 0 -&gt; 0000000008902600=
<br>
&gt; [00e08278]<br>
&gt; Trace 0: 0000000008902600 [00000000/00e08278/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Stopped execution of TB chain before 00000000087762c0 [00e00c74]<br>
&gt; quiccIntrDeMux<br>
&gt; Trace 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Stopped execution of TB chain before 00000000086b0c00 [00e2b52c] intUn=
lock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Stopped execution of TB chain before 00000000087762c0 [00e00c74]<br>
&gt; quiccIntrDeMux<br>
&gt; Trace 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Stopped execution of TB chain before 0000000008772bc0 [00e00f48]<br>
&gt; quiccIvecToInum<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Stopped execution of TB chain before 0000000008752700 [00e050d8]<br>
&gt; timeMonitorCtxSwitchToTask2<br>
&gt; Trace 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008772200 [00e87294]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Stopped execution of TB chain before 0000000008748b00 [00e7c0b4] intEn=
t<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Stopped execution of TB chain before 0000000008771f80 [00000500]<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Stopped execution of TB chain before 00000000086b0c00 [00e2b52c] intUn=
lock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 000000000874bdc0 [00000000/00e0c848/0] sysClkInt<br>
&gt; Chain 0: 000000000874c180 [00000000/00e0d8d8/0] usrClock<br>
&gt; Chain 0: 000000000874c3c0 [00000000/00e6f110/0] tickAnnounce<br>
&gt; Chain 0: 000000000874c9c0 [00000000/00e7d0f8/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874d580 [00000000/00e54b80/0] qPriListAdvance<br>
&gt; Chain 0: 000000000874d700 [00000000/00e7d238/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874da40 [00000000/00e54b8c/0] qPriListGetExpired<br>
&gt; Chain 0: 000000000874de40 [00000000/00e7d4d4/0] windTickAnnounce<br>
&gt; Chain 0: 000000000874e640 [00000000/00e6f1d8/0] tickAnnounce<br>
&gt; Chain 0: 000000000874e740 [00000000/00e7bb20/0] windExit<br>
&gt; Trace 0: 000000000874eac0 [00000000/00e7bb44/0] windExit<br>
&gt; Trace 0: 000000000874ebc0 [00000000/00e7bb48/0] windExit<br>
&gt; Chain 0: 000000000874f340 [00000000/00e7bb54/0] windExit<br>
&gt; Trace 0: 00000000087500c0 [00000000/00e7bb70/0] windExit<br>
&gt; Trace 0: 00000000087501c0 [00000000/00e7bb78/0] windExit<br>
&gt; Chain 0: 0000000008750340 [00000000/00e6f1dc/0] tickAnnounce<br>
&gt; Chain 0: 0000000008750500 [00000000/00e0d8f0/0] usrClock<br>
&gt; Chain 0: 0000000008750700 [00000000/00e0c874/0] sysClkInt<br>
&gt; Chain 0: 0000000008750900 [00000000/00e874ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0d00 [00000000/00e2b530/0] intUnlock<br>
&gt; Chain 0: 0000000008773640 [00000000/00e00b64/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008901480 [00000000/00e08168/0] motTsecTxInt<br>
&gt; Chain 0: 0000000008775b00 [00000000/00e00ba4/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086aef00 [00000000/00e2b508/0] intLock<br>
&gt; Trace 0: 00000000086af040 [00000000/00e2b514/0] intLock<br>
&gt; Trace 0: 00000000086af140 [00000000/00e2b518/0] intLock<br>
&gt; Chain 0: 00000000087762c0 [00000000/00e00c74/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Stopped execution of TB chain before 0000000008776800 [00e872ac]<br>
&gt; excConnectCode<br>
&gt; Trace 0: 0000000008776800 [00000000/00e872ac/0] excConnectCode<br>
&gt; Chain 0: 0000000008750a40 [00000000/00e7c0e8/0] intExit<br>
&gt; Trace 0: 0000000008750b80 [00000000/00e7c0f8/0] intExit<br>
&gt; Trace 0: 0000000008750c80 [00000000/00e7c0fc/0] intExit<br>
&gt; Chain 0: 0000000008752700 [00000000/00e050d8/0] timeMonitorCtxSwitchTo=
Task2<br>
&gt; Chain 0: 0000000008752980 [00000000/00e7c2f4/0] intExit<br>
&gt; Trace 0: 00000000087516c0 [00000000/00e7c344/0] intExit<br>
&gt; Trace 0: 00000000087517c0 [00000000/00e7c34c/0] intExit<br>
&gt; Raise exception at 00e2b52c =3D&gt; 00000004 (00)<br>
&gt; Trace 0: 0000000008771f80 [00000000/00000500/0]<br>
&gt; Chain 0: 00000000087720c0 [00000000/00e87280/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008772200 [00000000/00e87294/0] excConnectCode<br>
&gt; Chain 0: 0000000008772380 [00000000/00e00a20/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772840 [00000000/00e00a6c/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008772ec0 [00000000/00e00abc/0] quiccIntrDeMux<br>
&gt; Trace 0: 0000000008772bc0 [00000000/00e00f48/0] quiccIvecToInum<br>
&gt; Chain 0: 0000000008773180 [00000000/00e00afc/0] quiccIntrDeMux<br>
&gt; Chain 0: 0000000008773400 [00000000/00e00b38/0] quiccIntrDeMux<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; Trace 0: 00000000086b0c00 [00000000/00e2b52c/0] intUnlock<br>
&gt; Stopped execution of TB chain before 00000000086b0c00 [00e2b52c] intUn=
lock<br>
&gt; Raise exception at 00e2b52c =3D&gt; 0000000a (00)<br>
&gt; Trace 0: 0000000008747a40 [00000000/00000900/0]<br>
&gt; Chain 0: 0000000008747b80 [00000000/00e87480/0] excConnectCode<br>
&gt; Chain 0: 0000000008747cc0 [00000000/00e7bf24/0] intEnt<br>
&gt; Chain 0: 0000000008748980 [00000000/00e7c09c/0] intEnt<br>
&gt; Trace 0: 0000000008748b00 [00000000/00e7c0b4/0] intEnt<br>
&gt; Trace 0: 0000000008748c00 [00000000/00e7c0bc/0] intEnt<br>
&gt; Chain 0: 0000000008748dc0 [00000000/00e050bc/0] timeMonitorCtxSwitchTo=
Isr<br>
&gt; Chain 0: 0000000008749040 [00000000/00e7c0cc/0] intEnt<br>
&gt; Chain 0: 0000000008749200 [00000000/00e87494/0] excConnectCode<br>
&gt; Chain 0: 0000000008749380 [00000000/00e0c654/0] sysClkInt<br>
&gt; Chain 0: 00000000086a0a00 [00000000/00e7ac78/0] vxTimeBaseGet<br>
&gt; Chain 0: 000000000874a180 [00000000/00e0cc44/0] sysTimestamp64Get<br>
&gt; Chain 0: 000000000874a5c0 [00000000/00e0c780/0] sysClkInt<br>
&gt; Chain 0: 00000000086b0ac0 [00000000/00e2b51c/0] intUnlock<br>
&gt; ```<br>
&gt; <br>
&gt; On Tue, Mar 10, 2020 at 6:04 PM Stefan Hajnoczi &lt;<a href=3D"mailto:=
stefanha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Mar 09, 2020 at 11:26:07AM +0800, =E7=BD=97=E5=8B=87=E5=
=88=9A(Yonggang Luo) wrote:<br>
&gt; &gt; &gt; When I am running QEMU to simulating PowerPC.<br>
&gt; &gt; &gt; And after running the following powerpc code:<br>
&gt; &gt; &gt; 00e2b5dc &lt;intUnlock&gt;:<br>
&gt; &gt; &gt; intUnlock():<br>
&gt; &gt; &gt;=C2=A0 =C2=A0e2b5dc: 54 63 04 20 rlwinm r3,r3,0,16,16<br>
&gt; &gt; &gt;=C2=A0 =C2=A0e2b5e0: 7c 80 00 a6 mfmsr r4<br>
&gt; &gt; &gt;=C2=A0 =C2=A0e2b5e4: 7c 83 1b 78 or r3,r4,r3<br>
&gt; &gt; &gt;=C2=A0 =C2=A0e2b5e8: 7c 60 01 24 mtmsr r3<br>
&gt; &gt; &gt;=C2=A0 =C2=A0e2b5ec: 4c 00 01 2c isync<br>
&gt; &gt; &gt;=C2=A0 =C2=A0e2b5f0: 4e 80 00 20 blr<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The QEMU are getting stuck and can not running the following=
<br>
&gt; &gt; instructions,<br>
&gt; &gt; &gt; What I need to do to inspect which instruction are getting s=
tuck and how<br>
&gt; &gt; to<br>
&gt; &gt; &gt; fix it?<br>
&gt; &gt; &gt; Any means to debugging that.<br>
&gt; &gt;<br>
&gt; &gt; CCing ppc maintainers.<br>
&gt; &gt;<br>
&gt; &gt; You could begin debugging this using QEMU&#39;s GDB stub (the -s<=
br>
&gt; &gt; command-line option), TCG debug output (the -d command-line optio=
n), and<br>
&gt; &gt; the HMP &quot;info status&quot; command to check that the CPU is =
running.<br>
&gt; &gt;<br>
&gt; &gt; Good luck!<br>
&gt; &gt;<br>
&gt; &gt; Stefan<br>
&gt; &gt;<br>
&gt; <br>
&gt; <br>
<br>
-- <br>
David Gibson=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | I&#39;ll have my music baroque, and my code<br>
david AT <a href=3D"http://gibson.dropbear.id.au" rel=3D"noreferrer" target=
=3D"_blank">gibson.dropbear.id.au</a>=C2=A0 | minimalist, thank you.=C2=A0 =
NOT _the_ _other_<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | _way_ _around_!<br>
<a href=3D"http://www.ozlabs.org/~dgibson" rel=3D"noreferrer" target=3D"_bl=
ank">http://www.ozlabs.org/~dgibson</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000a006c105a08f006e--

