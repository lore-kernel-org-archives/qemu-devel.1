Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C994C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1B2206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="s1zAFMen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1B2206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqqa-00039E-MU
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hsqpQ-0002Ct-3A
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hsqpO-0007Vj-8W
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:47:47 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hsqpH-0007PV-83; Wed, 31 Jul 2019 11:47:41 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id BA64596F50;
 Wed, 31 Jul 2019 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564588057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xy1Vqqb/TirIRHsUvqfEQoGyLB8ofKKfiXA/+KzkHFg=;
 b=s1zAFMenPdtrCdLzr7ftOzsvln4tD+gi+zfHpIXTjC+Aac5amDVhMTzfKgkzS+KyMMK0QV
 yKyHQAzffg5i3qn+LxIS++1RSWcVI4VZ+ewIis1jC6+KF4umJSSsxrpQ8hcLXZw+c5gpuF
 NEraKNLUVMR8hSCyuIeef8bkdLMOMh4=
To: Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "clement.deschamps@antfield.fr" <clement.deschamps@antfield.fr>
References: <6ea54e80-63cd-5759-337b-1eb1686453f5@greensocs.com>
 <CY4PR21MB0278B2C6EDDA39E6F85DD15C9EDF0@CY4PR21MB0278.namprd21.prod.outlook.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <fa22d456-0662-800a-fa24-b4ddc6d3bd0d@greensocs.com>
Date: Wed, 31 Jul 2019 17:47:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CY4PR21MB0278B2C6EDDA39E6F85DD15C9EDF0@CY4PR21MB0278.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564588057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xy1Vqqb/TirIRHsUvqfEQoGyLB8ofKKfiXA/+KzkHFg=;
 b=ic9l1QUA18vQLU4gCAHqQ+i14hFX4S+aa5O1VndIHq5QH7l58A4uvQsMa42muRW0YBENFG
 FiBFITbJD2rPJhYopywD1jkmXNZgEH8qxQBToAEbjWQO4h/LZg7NnfEZnxhuYlOrdoN2D+
 wfOGLYeHEKGxw9Es1St0RNFzV0oSzxg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564588057; a=rsa-sha256; cv=none;
 b=n+4USx+dwiWWjUci1ydT5r/VyY55ElSolZnLq9QlvnhPxOkqpwTZrG0TrHjP2gHbZwIwFv
 7B/tr6bf1lzvQcnGK6vs55b1Ct6OQwohk9HrEQPGMdaRmIo3qoaC5nDdWl8pahWNDm+xan
 KAWuIWeL68O6yc4nFZaJvObQi7X29fU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] RFC raspberry pi sd-card reset
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/31/19 5:28 PM, Andrew Baumann wrote:
> Hi,
>=20
> =A0
>=20
> (Sorry for top-posting, just wanted to give you some quick context.)
>=20
> =A0
>=20
> The Pi-specific quirk here is that there are two different SD
> controllers on the board, both accessing the same card, where only one
> can be used at a time. IIRC Clement Deschamps added this reparenting
> logic to accomplish that when he implemented the second SD controller. =
I
> can=92t give you a concrete suggestion, but =93initialize the platform =
with
> the sd-card at the right initial place=94 is not really viable given th=
at
> the right place changes depending on GPIO programming by the guest.

I understand that there is different sd controllers the guest can choose.
My concern is only about the reset, before any guest kicked in. During
reset the sd-card will always ends up at the same place (the sdhci-bus)
Right-now machine init put the sd-card at some place, and reset moves it.

>=20
> =A0
>=20
> Andrew
>=20
> =A0
>=20
> -----------------------------------------------------------------------=
-
> *From:* Damien Hedde <damien.hedde@greensocs.com>
> *Sent:* Wednesday, July 31, 2019 7:21:02 AM
> *To:* QEMU Developers <qemu-devel@nongnu.org>
> *Cc:* Peter Maydell <peter.maydell@linaro.org>; Andrew Baumann
> <Andrew.Baumann@microsoft.com>; f4bug@amsat.org <f4bug@amsat.org>;
> qemu-arm <qemu-arm@nongnu.org>
> *Subject:* RFC raspberry pi sd-card reset
> =A0
> Hi,
>=20
> Concerning the reset on the raspi2/3 machine, I ran into an issue with
> the sd-card.
>=20
> Here follows a subset of the qbus/qdev tree of the raspi2&3 machine as
> it is initialized:
> =A0+ System
> =A0=A0 * bcm2835_gpio
> =A0=A0=A0=A0 + sd-bus
> =A0=A0=A0=A0=A0=A0 * sd-card
> =A0=A0 * bcm2835-sdhost
> =A0=A0=A0=A0 + bcm2835-sdhost-bus
> =A0=A0 * generic-sdhci
> =A0=A0=A0=A0 + sdhci-bus
>=20
> raspi_init does 2 things:
> =A0+ it creates the soc
> =A0+ then it explicitly creates the sd-card on the bcm2835_gpio's sd-bu=
s
>=20
> As it happens, the reset moves the sd-card on another bus: the
> sdhci-bus. More precisely the bcm2835_gpio reset method does it (the
> sd-card can be mapped on bcm2835-sdhost-bus or sdhci-bus depending on
> bcm2835_gpio registers, reset configuration corresponds to the sdhci-bu=
s).
>=20
> Reset call order is the following (it follows children-before-parent or=
der):
> =A01 sd-card
> =A02 sd-bus
> =A03 bcm2835_gpio -> move the sd-card
> =A04 bcm2835-sdhost-bus
> =A05 bcm2835-sdhost
> =A06 sd-card=A0 (again)
> =A07 sdhci-bus
> =A08 generic-sdhci
>=20
> In the end, the sd-card is reset twice, which is no big-deal in itself.
> But it only depends on the bcm2835_gpio tree being reset before the
> generic-sdhci (probably depends on the machine creation code).
>=20
> I checked and it seems this is the only platform where such things
> happen during master reset.
>=20
> IMO this is a bit hazardous because reset is based on the qdev/qbus
> tree (and with the multi-phase I'm working on, even if it still works,
> it's worse).
> I'm not sure what we should do to avoid this (and if there's is
> something to be done).
>=20
> The easiest solution would be to initialize the platform with the
> sd-card at the right initial place (I do not really understand why it i=
s
> created in the bcm2835_gpio in the first place since we move it just
> after). But it won't solve the issue if a reset is done afterwards.
>=20
> Or maybe we could move the sd-card on the proper bus in a machine
> reset code so that it's on the right place when we do the sysbus tree
> reset just after.
>=20
> What do you think ?
>=20
> --
> Damien

