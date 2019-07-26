Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8FFC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04AFB216C8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="dlV6VS4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AFB216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqyKk-00019U-9a
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34054)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hqyKN-0008Lo-0R
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hqyKI-0003hM-LK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:23:57 -0400
Received: from mail-eopbgr810094.outbound.protection.outlook.com
 ([40.107.81.94]:53408 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hqyKH-00030J-92; Fri, 26 Jul 2019 07:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj7x41zz9ocrvBY1rHfStqj8OeAUuM3hKTwo+y1s6Qz5Nncy3J3OE70YL29KOYHPVs6PRLHT6ERir9EHS28vxEM3BM4lS2EBjg5YPLbYlaoDHgAOSP/IoIVRdebY7VLfzVHwToIfY/g/M+3m6cjErbLJr5MwYgsctBnyUy0RzxqX/MXG4Q0UvLA5R6Ynt1ZfmMc22Hq4DpYHRuUbjdzzxuhZRUUQxNCOc5x28pcYjeUzBKbzBtP4+qAy3iWtIGdnj0ppqlG3QnuYoFbs1XC23PL66YdczYu2A8YUepguebifWsJFWHd76PXhlJzWEny1RqK9FHf5MxwfNf73u4zKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gnf+9EOWzJupWhq0khuZl6jAZUQBoPrsdA9sKOB+qAo=;
 b=PpUpRoZTM/+u6fqHrWAJq0z86jw1G6wWZ/Kr3i+nLUZIiVsiFiQKeqM74xlgX3oPWvLFZn9Xk32ehHr7fuSiSuPjJagLnrciQKK+m7yEDPHomyikfJjpjylmVZja6fMqkUlCtJcsDY/5PAfCyiHvxEnuDFb0q/+nxNXN7gHaZdSehIARDyVtK9TBulFC5qK3vYM/LdwC+phLo6ouARwJ8999ZaStEvTx5bN3jA6VssDB3rspeDmpELLBRI+Zo8jzlTe8Q7xRt8IsEBzvLLQfrup/cNLdi1K8kFOLzdkF4BluNRq3diyUAPcEKTPDXqmeIg2vv8wlIDxSh0y13do2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gnf+9EOWzJupWhq0khuZl6jAZUQBoPrsdA9sKOB+qAo=;
 b=dlV6VS4dww1wWWv4sY/Xf4br3xmtHywK6gyvSnbEzCB4KknnSoHth/u+YzmQ+wouHz9Gn3k8vBZXIfh6yZIVWwQBE2Sf34ccrRd2RraFiL1UhRwbflhrEuPlDjoC2qx8iYUkQlxe2Von04D2C04aj1jgmrXYRh+wbDIqWzKoCL4=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1332.namprd22.prod.outlook.com (10.174.80.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 11:23:41 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2094.017; Fri, 26 Jul 2019
 11:23:41 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 "tony.nguyen@bt.com" <tony.nguyen@bt.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL]Re: [Qemu-devel] [PATCH v5 09/15] cputlb: Access
 MemoryRegion with MemOp
Thread-Index: AQHVQ6IbUaNvFRVr0EmGVWMLY+9noqbcwIS0
Date: Fri, 26 Jul 2019 11:23:41 +0000
Message-ID: <BN6PR2201MB1251DC94B60C40FE2F236375C6C00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123618147.19868@bt.com>, <55d4c7f3-633b-0005-f74c-53578dd1bee1@redhat.com>
In-Reply-To: <55d4c7f3-633b-0005-f74c-53578dd1bee1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04ebe8fd-797c-4002-fb83-08d711bbb676
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1332; 
x-ms-traffictypediagnostic: BN6PR2201MB1332:
x-microsoft-antispam-prvs: <BN6PR2201MB1332CB2AAB34A2759F6635E5C6C00@BN6PR2201MB1332.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39850400004)(396003)(376002)(346002)(199004)(189003)(478600001)(6246003)(6116002)(53936002)(3846002)(5660300002)(66066001)(2501003)(25786009)(305945005)(76116006)(9686003)(486006)(14454004)(54906003)(7416002)(110136005)(7696005)(76176011)(7736002)(68736007)(7406005)(8676002)(6506007)(71200400001)(6436002)(71190400001)(102836004)(52536014)(4326008)(53546011)(74316002)(26005)(8936002)(86362001)(256004)(14444005)(229853002)(81156014)(11346002)(55016002)(476003)(66946007)(81166006)(66446008)(2906002)(91956017)(99286004)(316002)(64756008)(66556008)(66476007)(446003)(2201001)(33656002)(186003)(55236004)(586874002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1332;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lHD6x6QX8drq8Xl97Uir5p13xllLZEWlBJQOx8UcfGvaB0aXuHJ823J55Tiq9ngbcMzj4bXFy3GsCmJ1zfVeI5Q4EV2HUnx2o0HU0QjYMCsd0Fh3A4V73xgZQ5qbpRreGlGr8vC2uCx7yVtjy0O2QmePSf36j+iCNjLIQToTffOENgTwegIwabWs1L+tGP3mcWs7nummXvrLIrXy+3XDM7Nd4QIxZvEV5G3RpOkDWeGKv7CU8V3+B+QS1vsdQ4hn8sWGfqzmDJ1EkquufjsqRuY9LtWYEVePLwSoNHrCM0iZUggqQhJhLwt5oIKqOG553Y1RrwyvHCbpV3ywAUpBnQqIhlrkKDgsvbLvysA1BUEbXwNR9pzJWXoFioMxYDwYQGO3VHh44W1uyPgaOwuDflgI4iuYqRs6WypKsVW+iQk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ebe8fd-797c-4002-fb83-08d711bbb676
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 11:23:41.0533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1332
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.94
Subject: Re: [Qemu-devel] [EXTERNAL]Re: [PATCH v5 09/15] cputlb: Access
 MemoryRegion with MemOp
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "walling@linux.ibm.com" <walling@linux.ibm.com>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>,
 "mst@redhat.com" <mst@redhat.com>, "palmer@sifive.com" <palmer@sifive.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 "david@redhat.com" <david@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "atar4qemu@gmail.com" <atar4qemu@gmail.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "shorne@gmail.com" <shorne@gmail.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
=0A=
________________________________________=0A=
From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
Sent: Friday, July 26, 2019 1:03 PM=0A=
To: tony.nguyen@bt.com; qemu-devel@nongnu.org=0A=
Cc: peter.maydell@linaro.org; walling@linux.ibm.com; sagark@eecs.berkeley.e=
du; mst@redhat.com; palmer@sifive.com; mark.cave-ayland@ilande.co.uk; laure=
nt@vivier.eu; Alistair.Francis@wdc.com; edgar.iglesias@gmail.com; Aleksanda=
r Rikalo; david@redhat.com; pasic@linux.ibm.com; borntraeger@de.ibm.com; rt=
h@twiddle.net; atar4qemu@gmail.com; ehabkost@redhat.com; qemu-s390x@nongnu.=
org; qemu-arm@nongnu.org; stefanha@redhat.com; shorne@gmail.com; david@gibs=
on.dropbear.id.au; qemu-riscv@nongnu.org; kbastian@mail.uni-paderborn.de; c=
ohuck@redhat.com; alex.williamson@redhat.com; qemu-ppc@nongnu.org; Aleksand=
ar Markovic; pbonzini@redhat.com; aurelien@aurel32.net=0A=
Subject: [EXTERNAL]Re: [Qemu-devel] [PATCH v5 09/15] cputlb: Access MemoryR=
egion with MemOp=0A=
=0A=
On 7/26/19 8:46 AM, tony.nguyen@bt.com wrote:=0A=
> No-op MEMOP_SIZE and SIZE_MEMOP macros allows us to later easily=0A=
> convert memory_region_dispatch_{read|write} paramter "unsigned size"=0A=
> into a size+sign+endianness encoded "MemOp op".=0A=
>=0A=
> Being a no-op macro, this patch does not introduce any logical change.=0A=
>=0A=
=0A=
The last sentence has a bad structure. Possible remedy:=0A=
=0A=
"Being a no-op macro," -> "Relying no-op macros,"=0A=
=0A=
I think this patch should be reogranized (possibly by splitting) so that=0A=
the hunks that introduce usage of macros are in a separate patch, which=0A=
would leave only changes that directly involve using "MemOp" in this=0A=
patch.=0A=
=0A=
Thanks,=0A=
Aleksandar=0A=

