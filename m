Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7669DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5B6206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nI7op8qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5B6206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqYC-0001tz-7a
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Andrew.Baumann@microsoft.com>) id 1hsqWn-0000vv-Ch
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Andrew.Baumann@microsoft.com>) id 1hsqWl-0006Hj-VS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:28:33 -0400
Received: from mail-eopbgr760120.outbound.protection.outlook.com
 ([40.107.76.120]:23149 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
 id 1hsqWl-0006GZ-L2; Wed, 31 Jul 2019 11:28:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORjaQFDd1WFaDMuGIsByHB9ztCfXoftoBEZI8DmrhNKRsSfkwn9sZgn3zMSYqRgDKOaJfZp662v7BilVPpxlqcLFrcGZTd7BEYT3ZSRVr63w4fiFZWTDpFZZFMIB8IUST+CVP7XcCFiFDANZ8d/VFmdB4f1QY7J1r4WsfNPJ7fPnBltFPLChAXil3FEJY1QEumkacDPKZAmm5Kh5q6rKK7jJeqlUmDXqrrbmO3mzmtH5RyOvu6RNWm7ci6yKJdnd7rlAcRhugytJkkn/s32aqA+BxqfK2xpuL2lhFJgqtcc7r2BUwJDYjTeNC24Stt2aR4o/uVAjk3G2EbbsCB15Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH7GSOA2q9wXkYgrTOunEFF6rvhlZ8xhsFC2Ti6OsHI=;
 b=W5a8/F8JDkPkIz1Y+evQye2MogkLCrXeBqX2wuOTVxQFKeWJXj1GnAbFKzG9XrUSoRXe3MpFTf7u16pTNEewpKEW6PtnF7RZgJCQ3WQ9D/RyIlGlRtI73xpCHOW7e64hr5WkaYVXwsrWRoNYau2l3rnM7IvhDTN9wdIgTyOzg5l79zAckWnNtv7l33z2Qjz9fmPMM6zbdueGK+tcreryMDqtNiPsaOtmVysDXjLeJ940HDk316mmQ4khzq0SQmCvc0WCp83+lUDL0NHvQZmQS7NnJiFzfL2GT/vWTfba75YNjX0x0bjLXak0jCi+kiDXpjI66cG808c26cUgRYGAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH7GSOA2q9wXkYgrTOunEFF6rvhlZ8xhsFC2Ti6OsHI=;
 b=nI7op8qan0NfOgnkATBvmABOs0G0WjkV9S0SOeR6ozVjdm8HmrhWYIuI2KRvPAFxkr/ScmJea2qubIN/eaHJWC0QLaBf+BIsFtZ4M12UfigLkm+PkYITzX+ZcBFaO60KL0QY0bN63AwJGxyWof4mh4XKUto8vzruDyrHad4MF5Y=
Received: from CY4PR21MB0278.namprd21.prod.outlook.com (10.173.193.144) by
 CY4PR21MB0151.namprd21.prod.outlook.com (10.173.189.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 15:28:29 +0000
Received: from CY4PR21MB0278.namprd21.prod.outlook.com
 ([fe80::e44b:de9d:ef3d:a46d]) by CY4PR21MB0278.namprd21.prod.outlook.com
 ([fe80::e44b:de9d:ef3d:a46d%4]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 15:28:29 +0000
To: Damien Hedde <damien.hedde@greensocs.com>, QEMU Developers
 <qemu-devel@nongnu.org>, "clement.deschamps@antfield.fr"
 <clement.deschamps@antfield.fr>
Thread-Topic: RFC raspberry pi sd-card reset
Thread-Index: AQHVR6syQqCyH6u8gkCOvSjGlFYBkqbk11ZS
Date: Wed, 31 Jul 2019 15:28:29 +0000
Message-ID: <CY4PR21MB0278B2C6EDDA39E6F85DD15C9EDF0@CY4PR21MB0278.namprd21.prod.outlook.com>
References: <6ea54e80-63cd-5759-337b-1eb1686453f5@greensocs.com>
In-Reply-To: <6ea54e80-63cd-5759-337b-1eb1686453f5@greensocs.com>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrew.Baumann@microsoft.com; 
x-originating-ip: [131.107.160.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62c1727e-e2f5-47f9-02a6-08d715cbbd3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:CY4PR21MB0151; 
x-ms-traffictypediagnostic: CY4PR21MB0151:
x-microsoft-antispam-prvs: <CY4PR21MB0151A373BC990BA62291E39B9EDF0@CY4PR21MB0151.namprd21.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(6116002)(99286004)(3846002)(14454004)(7736002)(66066001)(22452003)(10290500003)(68736007)(81166006)(81156014)(8676002)(478600001)(86362001)(8936002)(71190400001)(25786009)(52536014)(5660300002)(19627235002)(74316002)(10090500001)(71200400001)(8990500004)(4326008)(7696005)(14444005)(2906002)(54896002)(76176011)(9686003)(316002)(26005)(256004)(186003)(6246003)(91956017)(76116006)(53546011)(66476007)(102836004)(66946007)(66446008)(6506007)(64756008)(66556008)(486006)(53936002)(11346002)(446003)(33656002)(476003)(229853002)(2501003)(55016002)(6436002)(110136005)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0151;
 H:CY4PR21MB0278.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aYVQ0AQppYX6NvV803CE/jtvhQJcBQ1uN9vOLWGN0HElyIBbU8TFRjiXv42C0Aj49g/kg+hdfIcG/Xj/xYrhL9cxwwAW0GeyisKSxjIgTrC7LC16BpoAoRfb/9g4+EsTI/BY0c9mY4Zy+psVY7zogml1KTmR3+x5m30PhLpWD8h+k+ro5ZbLeZC+6D3LP5u26E2cbpKc7GYlWarLs7pKU64jJZ8Vv103ntsN4LgQCDz3ClNjCINuwTlY+RG863ZC3kYKeDbJQD/QSrjzSR1x+bQXLQB7XHCmshLayjocpaRU+M9e6VRTFUXVPj66n93dc60OOl4f81CJqRu9Ht7dvw9Oj8AOqbn8RwktR8jKX5E8bM5KhyAD09rNwl/XjomrJUxUDwCFFuEWW4cUZPlMOkVaGBtcgL0pGWEpX+Rbhpg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c1727e-e2f5-47f9-02a6-08d715cbbd3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 15:28:29.0792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhMb3j5F707ghkWQQdQKALniRHVaEbL0zNiad2cR6UVrInxOOl1y16g0taGpuKFPNzBl75CFsnPcbB70GMJgwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0151
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.76.120
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
From: Andrew Baumann via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,



(Sorry for top-posting, just wanted to give you some quick context.)



The Pi-specific quirk here is that there are two different SD controllers o=
n the board, both accessing the same card, where only one can be used at a =
time. IIRC Clement Deschamps added this reparenting logic to accomplish tha=
t when he implemented the second SD controller. I can=92t give you a concre=
te suggestion, but =93initialize the platform with the sd-card at the right=
 initial place=94 is not really viable given that the right place changes d=
epending on GPIO programming by the guest.



Andrew



________________________________
From: Damien Hedde <damien.hedde@greensocs.com>
Sent: Wednesday, July 31, 2019 7:21:02 AM
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>; Andrew Baumann <Andrew.Bauman=
n@microsoft.com>; f4bug@amsat.org <f4bug@amsat.org>; qemu-arm <qemu-arm@non=
gnu.org>
Subject: RFC raspberry pi sd-card reset

Hi,

Concerning the reset on the raspi2/3 machine, I ran into an issue with
the sd-card.

Here follows a subset of the qbus/qdev tree of the raspi2&3 machine as
it is initialized:
 + System
   * bcm2835_gpio
     + sd-bus
       * sd-card
   * bcm2835-sdhost
     + bcm2835-sdhost-bus
   * generic-sdhci
     + sdhci-bus

raspi_init does 2 things:
 + it creates the soc
 + then it explicitly creates the sd-card on the bcm2835_gpio's sd-bus

As it happens, the reset moves the sd-card on another bus: the
sdhci-bus. More precisely the bcm2835_gpio reset method does it (the
sd-card can be mapped on bcm2835-sdhost-bus or sdhci-bus depending on
bcm2835_gpio registers, reset configuration corresponds to the sdhci-bus).

Reset call order is the following (it follows children-before-parent order)=
:
 1 sd-card
 2 sd-bus
 3 bcm2835_gpio -> move the sd-card
 4 bcm2835-sdhost-bus
 5 bcm2835-sdhost
 6 sd-card  (again)
 7 sdhci-bus
 8 generic-sdhci

In the end, the sd-card is reset twice, which is no big-deal in itself.
But it only depends on the bcm2835_gpio tree being reset before the
generic-sdhci (probably depends on the machine creation code).

I checked and it seems this is the only platform where such things
happen during master reset.

IMO this is a bit hazardous because reset is based on the qdev/qbus
tree (and with the multi-phase I'm working on, even if it still works,
it's worse).
I'm not sure what we should do to avoid this (and if there's is
something to be done).

The easiest solution would be to initialize the platform with the
sd-card at the right initial place (I do not really understand why it is
created in the bcm2835_gpio in the first place since we move it just
after). But it won't solve the issue if a reset is done afterwards.

Or maybe we could move the sd-card on the proper bus in a machine
reset code so that it's on the right place when we do the sysbus tree
reset just after.

What do you think ?

--
Damien
