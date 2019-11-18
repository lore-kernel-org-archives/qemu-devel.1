Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F47C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E497021850
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3T4yF/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E497021850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkjY-0002pG-6P
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWki5-00023b-LA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWki4-0003Z8-AG
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:21:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22980
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWki4-0003Yp-6p
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574097667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdrWFLS8oDxDxLyvuwrHjxehzGp28U5WwLMCYXPWf1g=;
 b=E3T4yF/flQ+5W7h8ytOUIeTKTX2oIFWe/Ls9BzSoeSl3y/TTdlifQIyKdqttJeS+Ko/Fef
 Od8xc2RS1ZTkRhiHjjGsK/lP9PJo7u/RKxAnf2hCy78jN4yspJbZcfCOptl/O1T37Jc+mA
 ZoyqFb6KJAKru2YeybWRr4O+qHZluZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-OevSpoSdNx2FAOSQkg-nNA-1; Mon, 18 Nov 2019 12:21:04 -0500
Received: by mail-wr1-f72.google.com with SMTP id h7so15760614wrb.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7fA7zqvAuYwCaWvH30pKir+bxqlr9D6hBDtqJVyuGvA=;
 b=nrTS03pDPCHx+DMdC5cp4kaDw+BOU2K7Czp1i6MUcq9tkgNtB2SDsW2ZI5KXmA4vuw
 fERTuwlfRGYkqVs36JcU8WCPFfLkNUp3cLCPguV+bHdTL8hB1LhSac86HbagQ+nIXely
 oxhr4deoZkzYjNELdjQqnTkLoFZVZS/aQZDxUQZSvy/eR+sjqPMp4/T6H8sPchB52phr
 dS+FmFXPSNp/aM71Xs6CqpdbPSxhWATRxEib/Dedw21MdNLRFwnmxAE77HA6m7SVHOjd
 7dlpoCyIrdKyyhlobifxHuQq4V6fjD3kXqDC/i35vmjXLJZSGnEE0581bL6BKh7qsI6b
 +xCA==
X-Gm-Message-State: APjAAAWR+xLsNDn+W/xYL7mwsLubXjY2TXr8uRlefupuxGX8pHErFTG3
 fleh6I0Rdo9yUHscC3OTWqtEzJCWU0zBVAMI2EsdnA+ux0LF5Xc6Lf+jAVb019mUxjnm/VW1NqM
 k4R9aaOMLqaNYey4=
X-Received: by 2002:a1c:544e:: with SMTP id p14mr84068wmi.17.1574097662930;
 Mon, 18 Nov 2019 09:21:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxb+C//lgAMIdsQQwGlKQIAXI0/oYObmuhukanm+FmkMBSXwaOEdqf/q+VvJoiD+THS8rigAw==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr84032wmi.17.1574097662727;
 Mon, 18 Nov 2019 09:21:02 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id c15sm23777071wrx.78.2019.11.18.09.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 09:21:02 -0800 (PST)
Subject: Re: [PATCH] net/cadence_gem: Set PHY autonegotiation restart status
To: Linus Ziegert <linus.ziegert@holoplot.com>,
 Alistair Francis <alistair23@gmail.com>, Jason Wang <jasowang@redhat.com>
References: <20191104181604.21943-1-linus.ziegert+qemu@holoplot.com>
 <CAKmqyKMWS18ssBUhDgYSnGiFRwCkSJPBRui4Op50Tq_Z-OUakA@mail.gmail.com>
 <CAPm2bJ_mfVepKP9hj-PQBnESsCi6t+9zj-m_KWQYx6m-S5ddAg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3c063300-b107-b17b-3647-8489b856a038@redhat.com>
Date: Mon, 18 Nov 2019 18:21:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAPm2bJ_mfVepKP9hj-PQBnESsCi6t+9zj-m_KWQYx6m-S5ddAg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: OevSpoSdNx2FAOSQkg-nNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Linus Ziegert <linus.ziegert+qemu@holoplot.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/19 12:31 PM, Linus Ziegert wrote:
> Am Mo., 4. Nov. 2019 um 23:50 Uhr schrieb Alistair Francis=20
> <alistair23@gmail.com <mailto:alistair23@gmail.com>>:
>  >
>  > On Mon, Nov 4, 2019 at 2:02 PM <linus.ziegert@holoplot.com=20
> <mailto:linus.ziegert@holoplot.com>> wrote:
>  > >
>  > > From: Linus Ziegert <linus.ziegert+qemu@holoplot.com=20
> <mailto:linus.ziegert%2Bqemu@holoplot.com>>
>  > >
>  > > The Linux kernel PHY driver sets AN_RESTART in the BMCR of the
>  > > PHY when autonegotiation is started.
>  > > Recently the kernel started to read back the PHY's AN_RESTART
>  > > bit and now checks whether the autonegotiation is complete and
>  > > the bit was cleared [1]. Otherwise the link status is down.
>  > >
>  > > The emulated PHY needs to clear AN_RESTART immediately to inform
>  > > the kernel driver about the completion of autonegotiation phase.
>  > >
>  > > [1]=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc36757eb9dee
>  > >
>  > > Signed-off-by: Linus Ziegert <linus.ziegert+qemu@holoplot.com=20
> <mailto:linus.ziegert%2Bqemu@holoplot.com>>
>  >
>  > Reviewed-by: Alistair Francis <alistair.francis@wdc.com=20
> <mailto:alistair.francis@wdc.com>>
>=20
> I consider this stable material. Applies cleanly to all versions=20
> starting from v1.5.0.

Too bad this wasn't Cc'ed to qemu-stable@nongnu.org and missed 4.1.1=20
stable release.

Jason: ping?

>  > Alistair
>  >
>  > > ---
>  > > =C2=A0hw/net/cadence_gem.c | 9 +++++----
>  > > =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>  > >
>  > > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
>  > > index 7f9cb5ab95..b8be73dc55 100644
>  > > --- a/hw/net/cadence_gem.c
>  > > +++ b/hw/net/cadence_gem.c
>  > > @@ -271,9 +271,10 @@
>  > > =C2=A0#define PHY_REG_EXT_PHYSPCFC_ST =C2=A0 27
>  > > =C2=A0#define PHY_REG_CABLE_DIAG =C2=A0 28
>  > >
>  > > -#define PHY_REG_CONTROL_RST =C2=A00x8000
>  > > -#define PHY_REG_CONTROL_LOOP 0x4000
>  > > -#define PHY_REG_CONTROL_ANEG 0x1000
>  > > +#define PHY_REG_CONTROL_RST =C2=A0 =C2=A0 =C2=A0 0x8000
>  > > +#define PHY_REG_CONTROL_LOOP =C2=A0 =C2=A0 =C2=A00x4000
>  > > +#define PHY_REG_CONTROL_ANEG =C2=A0 =C2=A0 =C2=A00x1000
>  > > +#define PHY_REG_CONTROL_ANRESTART 0x0200
>  > >
>  > > =C2=A0#define PHY_REG_STATUS_LINK =C2=A0 =C2=A0 0x0004
>  > > =C2=A0#define PHY_REG_STATUS_ANEGCMPL 0x0020
>  > > @@ -1345,7 +1346,7 @@ static void gem_phy_write(CadenceGEMState *s,=
=20
> unsigned reg_num, uint16_t val)
>  > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val & PHY_REG_CONTROL_ANEG) {
>  > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Complete autonego=
tiation immediately */
>  > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val &=3D ~PHY_REG_CONTROL=
_ANEG;
>  > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val &=3D ~(PHY_REG_CONTRO=
L_ANEG |=20
> PHY_REG_CONTROL_ANRESTART);
>  > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->phy_regs[PHY_REG_=
STATUS] |=3D PHY_REG_STATUS_ANEGCMPL;
>  > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val & PHY_REG_CONTROL_LOOP) {
>  > > --
>  > > 2.21.0
>  > >
>  > >


