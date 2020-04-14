Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74207C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AC320678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AC320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOus-0004aK-9a
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jOOtg-00032O-KO
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jOOtf-0000jd-D6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:58:52 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jOLjN-0001eQ-P1; Tue, 14 Apr 2020 09:36:01 -0400
Received: by mail-yb1-f193.google.com with SMTP id f13so5459125ybk.7;
 Tue, 14 Apr 2020 06:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1NutwCTYV7GLRuvHlCy5xsed3qRvUhgaTVGeCnPArTk=;
 b=SpICs4bd1ki1KdFh1NDjSBK+l62Fdivb5nVKLkVVbWcxjC9qB/sLEwLXKRFTNukbjd
 VmA0Ixd1wYtuXZWnTQo4Br1TZSJ0cQV7aOJAVk+PT6d/6Ea2C+wsd58benuJkwZol7E7
 c3e+TTbfzLrnyldgLJwvc/5o7/y4k8bO8vIc+tidmE62QQVB1H74lTiFGvp+crebpdo2
 J//O5SfSJ7enrS+p4S4+CF9fgeUHioJ/4/vGQC76Ny5zgkIfo3wP+edX5rszhsgcpbpg
 R4SekxYH1JbLpFSTU46PUyS9BBZ5u/w1uUX93MYUXXMEhfR0sSFJIU6ntjH1yj+8RuA8
 DrAQ==
X-Gm-Message-State: AGi0PuYrPDn2hf0hr29ybK6vOvthVIdBOD8V/MpSiYDjKbWCsBluIPDx
 8PtvCaboAiXMfUFx9Cj9ms3AsUbqU3g5kA+Ci/E=
X-Google-Smtp-Source: APiQypIJ+HC2pKttust+ddqIdMi+grpwPEnN0c06his9mOC/GAB6uA3yXK/YmA/lIxZC9SLhWMu2dHc8FSs5AeAFDdE=
X-Received: by 2002:a25:8491:: with SMTP id v17mr54493ybk.316.1586871361190;
 Tue, 14 Apr 2020 06:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <1586529926-11441-1-git-send-email-sundeep.lkml@gmail.com>
 <1586529926-11441-2-git-send-email-sundeep.lkml@gmail.com>
 <999b20d0-4933-046d-f014-a885073b1740@amsat.org>
 <CALHRZup_St5oJqB3gDm+RiVUo2-xwh_RUJKscMmGh=roQAa0gQ@mail.gmail.com>
In-Reply-To: <CALHRZup_St5oJqB3gDm+RiVUo2-xwh_RUJKscMmGh=roQAa0gQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 14 Apr 2020 15:35:49 +0200
Message-ID: <CAAdtpL4QUTXWHLG0M+fGvR0iTbx_qdVSyQSKrvoJWTQ=CTZTag@mail.gmail.com>
Subject: Re: [Qemu devel PATCH v4 1/3] hw/net: Add Smartfusion2 emac block
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.193
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 3:05 PM sundeep subbaraya
<sundeep.lkml@gmail.com> wrote:
>
> Hi Philippe,
>
> On Mon, Apr 13, 2020 at 2:16 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> > Hi Sundeep,
> >
> > On 4/10/20 4:45 PM, sundeep.lkml@gmail.com wrote:
> > > From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > >
> > > Modelled Ethernet MAC of Smartfusion2 SoC.
> > > Micrel KSZ8051 PHY is present on Emcraft's
> > > SOM kit hence same PHY is emulated.
> > >
> > > Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> > > ---
[...]
> > > +static const VMStateDescription vmstate_msf2_emac =3D {
> > > +    .name =3D TYPE_MSS_EMAC,
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_UINT32(rx_desc, MSF2EmacState),
> > > +        VMSTATE_UINT16_ARRAY(phy_regs, MSF2EmacState, PHY_MAX_REGS),
> >
> > Later we'll move the PHY registers out of the EMAC. Not now...
> >
> Cool but how? Like SSI and I2C, mdio bus?

Don't worry about it now, it was more as a comment to myself. I have
some series doing it, I'll cc you when it is ready.

>
> > > +        VMSTATE_UINT32_ARRAY(regs, MSF2EmacState, R_MAX),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
[...]

