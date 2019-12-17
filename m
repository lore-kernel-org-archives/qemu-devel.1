Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1CEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC8420733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="lXDg7t/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC8420733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHpT-0004TE-QS
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1ihHoj-00042B-Cv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1ihHoh-0007iz-Mj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:43:32 -0500
Received: from mail-co1nam11on2098.outbound.protection.outlook.com
 ([40.107.220.98]:57248 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1ihHoh-0007i7-8E
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:43:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwT/A47a5jFb0ACtYEbxfk7yo/h2J+wkfER1gv8ZZqMSnULHMdfsOyRGHKyRxrxbT5kMUkI/bfl1ZSFGxek/iM6lChqFeU6ofJkYGTl4b8wizw1zO72KcBzfFi0IE+hXH1B9nxM+qsPqBbnzYxOHVv9PqwG99WVE26H6LaPQO3zv+IXYs2Ch4f/BWmwYNTnhSaWk8xvxIeIlp1anhlvfZ42Zyk+1U73UwqT8c33vpEWKS7O/3kSAsrg56RozJLB5+qBAeUtzvoSDdPH35e3uPh6C80c7KAXoEuLCPOZwQV9SdqgyegsvoNz1hjUBVXIaiHROfegI+1h6fmSfC2ntvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0sr2XzWo+k2zZ23WMeUwBZxTSFaCZ/oKRIBuEMYdpU=;
 b=dBZgJjIGA3WFejM6EywiIdl2OPkYcrRmnQJjHWUjw9lvl0lXt0zn/GPfTfHax20d1xdJpS9ZaHBY9EC3/tcIc/+c+EOM64cR/bRaveUSa24ewXq+rjLjbMSSUIOwy06h6ZrJzQRK2skOvOe8227XDvFgjUVQchpTglnw8HlAmHnNe5U+vXQNvxkfCJ9jppD9Ey34L8Lm+aNcmGGtB+AfKLhkgcWmTzIW/59Ov80RvCxUFjiZP5cZZaK2VIiZDdjfooXhoOCzE2Oo6fiKWlzcjIlgvDgybg8wTungFSD+iR4RUzDk8GOdZxI641sJJJOrpqJmv1IR6/SdpQcxfWfJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0sr2XzWo+k2zZ23WMeUwBZxTSFaCZ/oKRIBuEMYdpU=;
 b=lXDg7t/S9LRrHmn4rEI8OA2ivpaxD6VEGGmu5g2t1RtyVYW/Eaf1PS90qVetQCDtvzUr/wacOuocPzEa79Sl36QdUl5y6YXFEr4bScGf40O48R8ujGkMJSqDLIHtasyzW3gsZGtZvEdr+uoad7AHipkpkkTTedNHxJm1yahT048=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1202.namprd22.prod.outlook.com (10.174.80.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Tue, 17 Dec 2019 18:43:27 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::8d7a:f373:d18d:db1c]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::8d7a:f373:d18d:db1c%10]) with mapi id 15.20.2538.019; Tue, 17 Dec
 2019 18:43:27 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL]Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
Thread-Topic: [EXTERNAL]Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
Thread-Index: AQHVtQVdxqpnuV46RUSu9/QyBLijlKe+qQT5
Date: Tue, 17 Dec 2019 18:43:27 +0000
Message-ID: <BN6PR2201MB1251317E014311162EDA9507C6500@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20191125104103.28962-1-philmd@redhat.com>,
 <691a359f-f923-5e2d-6beb-2f9c0a0aca8c@redhat.com>
In-Reply-To: <691a359f-f923-5e2d-6beb-2f9c0a0aca8c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b14dcc4-4775-487a-dfc4-08d78321015a
x-ms-traffictypediagnostic: BN6PR2201MB1202:
x-microsoft-antispam-prvs: <BN6PR2201MB12022E56A7F45BC7634E84E9C6500@BN6PR2201MB1202.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39850400004)(366004)(376002)(136003)(189003)(199004)(5660300002)(508600001)(9686003)(86362001)(55016002)(2906002)(66446008)(66946007)(66556008)(64756008)(66476007)(71200400001)(110136005)(33656002)(81156014)(8676002)(91956017)(76116006)(54906003)(81166006)(8936002)(26005)(6506007)(53546011)(316002)(55236004)(4326008)(7696005)(186003)(52536014)(42413003)(586874002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1202;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHrOWRpeUwE1SE77Xk16HT9nB/4bAtpcFtTYh3dOB1q+f0W5HY+yeWwvFjZvZyNjgjtOgGP4ziBYGRE0wyrYqdCwC+WU23oFPkuVgMGxnrsdiUVINfOm3ycdgMRcf29W+CsW98WESeN2PJy1lr5UsGXo7Yta5usH0OhHkKZWi0oJ0YlDk8MdLmlGjIymxvctmHwZJEEGX+cgHaN/T8ME8H7IJmgkXF54KJvgL0WftwqutHlLhGoDMClFaF4fBzZm77QeKQsk6RJQpM3Gp067g8KNmtqaViw2E9RV/IZ3Oypcnw9VZmPLk91zWtkJiN181i+uudAywkCtUJSOZ0bDQdVAypRxcoc87XILZWox1KH47fuMpR+cooQN91QCIIdzWc96/niEVngeKZJq+rKcGTjTkIASAHNtQPnzneocQ2J83FT9LuTEiYCNTqf2eL2p2MydVxa2LwjGnfkVYWER7p6G7i26vP7EwVzE/bK4rnuqx7wMwysC9Vsd2lcvtz+hx6UMPb6F/6tok6lFEoUJYw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b14dcc4-4775-487a-dfc4-08d78321015a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 18:43:27.1378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0bxqCAp1zBXj63K+IhMhRIDH3jtqmszxR7wjPvE5PtuBh8g/Eb9MOtMSSoENIRYtjyKFZiwX7tZT6aKhoPe1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1202
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.220.98
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
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?iso-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
=0A=
________________________________________=0A=
From: Thomas Huth <thuth@redhat.com>=0A=
Sent: Tuesday, December 17, 2019 7:10 PM=0A=
To: Philippe Mathieu-Daud=E9; qemu-devel@nongnu.org=0A=
Cc: libvir-list@redhat.com; Herv=E9 Poussineau; Aleksandar Markovic; Aleksa=
ndar Rikalo; Aurelien Jarno=0A=
Subject: [EXTERNAL]Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine=
=0A=
=0A=
 Hi,=0A=
=0A=
On 25/11/2019 11.41, Philippe Mathieu-Daud=E9 wrote:=0A=
> > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi=0A=
> > index 4b4b7425ac..05265b43c8 100644=0A=
> > --- a/qemu-deprecated.texi=0A=
> > +++ b/qemu-deprecated.texi=0A=
> > @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should=
 use 'scsi-hd' or=0A=
> >=0A=
> >  @section System emulator machines=0A=
> >=0A=
> > +@subsection mips r4k platform (since 4.2)=0A=
> =0A=
> Since the patch has now been merged after the release of 4.2, the mips=0A=
> 4k platform will be deprecated in 5.0 instead. Could you send a patch to=
=0A=
> fix it up?=0A=
=0A=
OK, I'll send a patch that'll certainly be applied to the next MIPS queue.=
=0A=
=0A=
Thanks for spotting this, Thomas.=0A=
=0A=
Aleksandar=0A=
=0A=
>  Thanks,=0A=
>   Thomas=0A=
=0A=

