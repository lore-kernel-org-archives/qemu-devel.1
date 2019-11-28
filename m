Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283E7C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EC22176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=livekentac.onmicrosoft.com header.i=@livekentac.onmicrosoft.com header.b="uEQMi643"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EC22176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaGUk-0007V0-4G
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 04:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iaGKT-0007RF-3k
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iaGBo-0000Ld-Qx
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:34:22 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com
 ([40.107.8.70]:13700 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1iaGBo-0000AL-F3
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:34:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ4GrYvU1HEA55UGntsVOuwSKZzL1dPeincA5VeL4yUv/o+lC6eywQYgHS70VF+cDf6tsUwnkXqPAogOzTkPWQn/POO2yhOkI+vGqrn6oWkSVSdu0ZbZNHvqZhjyBR0u0qdwLBa2fGq3IKPnrdCoeik8BJuhO5GjOtyH6pJzIRoFNdNREQpTPDxu46SZyWCQRhqgt7HpC0dEMdbj+TFJXGMnGkqi23L8Mw7H0Pc+RbErG3vpNdaDuiG0i6WVvwS2sa6cBfSowewYOO1jDAyLdD0FQJEnUBma4tqcC8TiOgwB/QtHqhAwcrNlskFh9u6B3v/rUYr1IffhKo9+Qr2eWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5wlwv6WeC8RUMlpUbOuaSSM+hHwVIQ9FTO8goxmDfs=;
 b=aoWebiOiMRNwQD+zoHknX10fHGhyPw5TL4b7xjc3/Uisv+G44Y12C2UO1L7b6+3zY+MvM52tIQr8yx5M6hsme7eEStg6znj4BpfAd+eTiDS9r364ieUm3CQ1q7Asg14NMzSuIyOmJAlku1T/y/SoP5yobpvGaXbZ0Zfg4p9p4PQQk9u/yFOP0OdWW+oUuUhdIK6k8LbTNy2CMC30gp68l4I4YTkWvUDfNiAA6nUha52wYDaz8W+7wO6EOSFbYun6kMEFG/ePdBZArJv8yM6yMVXPbuhXEpeGgE4cGLrc7083J7OF62VaYHwWX7DN1LDNXXyTiLwq7eqUWjCRTjW3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kent.ac.uk; dmarc=pass action=none header.from=kent.ac.uk;
 dkim=pass header.d=kent.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livekentac.onmicrosoft.com; s=selector2-livekentac-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5wlwv6WeC8RUMlpUbOuaSSM+hHwVIQ9FTO8goxmDfs=;
 b=uEQMi6433vbo6KH3y2uDV3k5w9wFBHiOWG/Rx5Z6TO/+h0FyuARNGXAPiGkU01vj1Xc6FFVxltZUw5TbPDuz3qVeIJ1I1ClvwPlSWzqvR/GWVizaCMAz7onJUhLKfizoAlxkibzfDsV5OyGHW8MP+Nyo1qQy1a+PwoAATb/pivo=
Received: from DB7PR01MB4348.eurprd01.prod.exchangelabs.com (52.135.135.22) by
 DB7PR01MB4137.eurprd01.prod.exchangelabs.com (52.135.133.150) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Thu, 28 Nov 2019 09:34:17 +0000
Received: from DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 ([fe80::c426:70fc:26fe:b0e3]) by DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 ([fe80::c426:70fc:26fe:b0e3%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 09:34:17 +0000
From: Sarah Harris <seh53@kent.ac.uk>
To: Michael Rolnik <mrolnik@gmail.com>
Subject: Re: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
Thread-Topic: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
Thread-Index: AQHVpJFAqIx7RMARPkuZugcTadPMZaed6qMAgAJqN4A=
Date: Thu, 28 Nov 2019 09:34:17 +0000
Message-ID: <20191128093413.95a5fc9d58315da1bf257a53@kent.ac.uk>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-18-mrolnik@gmail.com>
 <CAL1e-=gBBFRxAsDnRyQqiZSLWhMmfyp2YXge4E12VaEmEG=a9g@mail.gmail.com>
 <CAK4993jvnA+rkBQzyp7jCY5Vo6TLzL8A7uN+ah8hmJa3-d4YFg@mail.gmail.com>
 <CAL1e-=hzDtugeN37fPsck9ZsOBS1EbWW4YExz8TeMm+S305nAQ@mail.gmail.com>
 <CAK4993hFYyw43JZaWBBX4r--jxyNBYWkfURoj+nZRSEn7E5rvw@mail.gmail.com>
In-Reply-To: <CAK4993hFYyw43JZaWBBX4r--jxyNBYWkfURoj+nZRSEn7E5rvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::35) To DB7PR01MB4348.eurprd01.prod.exchangelabs.com
 (2603:10a6:5:2f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=S.E.Harris@kent.ac.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
x-originating-ip: [80.189.49.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad12f88b-60e7-49d1-3824-08d773e62356
x-ms-traffictypediagnostic: DB7PR01MB4137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR01MB4137E5A5CB9CB95C3B5AA89DF7470@DB7PR01MB4137.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(66946007)(71200400001)(5660300002)(66556008)(54906003)(66476007)(66446008)(64756008)(8676002)(71190400001)(6916009)(305945005)(50226002)(7736002)(6246003)(786003)(81156014)(81166006)(76176011)(1411001)(256004)(36756003)(14454004)(316002)(14444005)(52116002)(6486002)(6436002)(478600001)(26005)(55236004)(186003)(102836004)(53546011)(6506007)(386003)(2906002)(966005)(4326008)(66066001)(3846002)(6116002)(1076003)(6512007)(25786009)(99286004)(11346002)(446003)(229853002)(2616005)(8936002)(6306002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR01MB4137;
 H:DB7PR01MB4348.eurprd01.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: kent.ac.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUAJ3W8/mxMVI5auNLERoV5RPgmXl5vAlCfiOh1rVWuGfy0dgQmjzgO3CAf3MNdqf9oSzuesDP3RYpH6a7JISRqD7dPUl7h44eERNlPEJlr1uh7FnMHK35UeX51xzDD9qfMekNTKWLuDYqJi96aQl/bZSwmirOrNZBHca/7KWi+I0iRjA9InuwFk0Vgbska31OrT3GAY/gm7im843naIGuFPD1BLmJOc6VveMsQXLqHxJEfAD2RjaPXxDaLcuC6XzDQwcbTF8Kmr8OAsUOKF2J8nIzuGDL4IqpxmKPwNxQ4xO6BJhj2QDAlhhuzXYkH+JhVgbW8we2RGEuH83RBsgG4l2wu/PPUw5Zbv+1wKpK0AnYc3X5gpCQZWxyXL3KYhfrBu2TaJ61x0b4Cy9vT5FSxSaurY6yNlTMBaHEyGe2Nxd6wQdfaPCBkkXfvqRyNcCgHwdnMTAuNq75wFykZLSbf8bBYe9nPLyWkZaeUQC9U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2AE4D8F2C50A3A419DCEAC7D960167D4@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kent.ac.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: ad12f88b-60e7-49d1-3824-08d773e62356
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 09:34:17.0728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 51a9fa56-3f32-449a-a721-3e3f49aa5e9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTgKlWa5c61uu13JYed+Mu1gxsvf/62+QA1Vz+i84UkyG/Yz7yHj76yMhxG7XpnU3fGT1UcyZu8WbWYF3wgx1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB4137
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.70
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "S.Harris" <S.E.Harris@kent.ac.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, I don't have time to do maintenance, but I can manage reviewing.

Kind regards,
Sarah Harris


On Tue, 26 Nov 2019 22:41:32 +0200
Michael Rolnik <mrolnik@gmail.com> wrote:

> Ah. I think Sarah was ok with reviewer role.
>=20
> On Tue, Nov 26, 2019 at 9:39 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>=20
> > On Tue, Nov 26, 2019 at 8:06 PM Michael Rolnik <mrolnik@gmail.com> wrot=
e:
> > >
> > > Aleksandar,
> > >
> > > there was an email from Sarah, stating that she does not want to be a
> > maintainer.
> > >
> >
> > But this is for "reviewer" role, not "maintainer".
> >
> > Sarah?
> >
> > > On Tue, Nov 26, 2019 at 5:17 AM Aleksandar Markovic <
> > aleksandar.m.mail@gmail.com> wrote:
> > >>
> > >>
> > >>
> > >> On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wro=
te:
> > >>>
> > >>> Include AVR maintaners in MAINTAINERS file
> > >>>
> > >>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > >>> ---
> > >>>  MAINTAINERS | 9 +++++++++
> > >>>  1 file changed, 9 insertions(+)
> > >>>
> > >>> diff --git a/MAINTAINERS b/MAINTAINERS
> > >>> index 5e5e3e52d6..ad2d9dd04a 100644
> > >>> --- a/MAINTAINERS
> > >>> +++ b/MAINTAINERS
> > >>> @@ -163,6 +163,15 @@ S: Maintained
> > >>>  F: hw/arm/smmu*
> > >>>  F: include/hw/arm/smmu*
> > >>>
> > >>> +AVR TCG CPUs
> > >>> +M: Michael Rolnik <mrolnik@gmail.com>
> > >>> +S: Maintained
> > >>> +F: target/avr/
> > >>> +F: hw/misc/avr_mask.c
> > >>> +F: hw/char/avr_usart.c
> > >>> +F: hw/timer/avr_timer16.c
> > >>> +F: hw/avr/
> > >>> +
> > >>
> > >>
> > >> I had a strange feeling that something is missing here, and I finall=
y
> > realized what that was:
> > >>
> > >> R: Sarah Harris <S.E.Harris@kent.ac.uk>
> > >>
> > >> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04225.html
> > >>
> > >>
> > >>
> > >>>  CRIS TCG CPUs
> > >>>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> > >>>  S: Maintained
> > >>> --
> > >>> 2.17.2 (Apple Git-113)
> > >>>
> > >
> > >
> > > --
> > > Best Regards,
> > > Michael Rolnik
> >
>=20
>=20
> --=20
> Best Regards,
> Michael Rolnik

