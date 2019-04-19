Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A705C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 18:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DAD205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 18:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="nqftBpqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DAD205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHYYv-0004gw-Cr
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 14:48:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hHYSq-0000OA-Pl
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hHYSp-0005jD-GV
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:42:20 -0400
Received: from mail-eopbgr810135.outbound.protection.outlook.com
	([40.107.81.135]:49408
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hHYSp-0005h0-3K
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=42LBseW4KjX49lw8ruzHUDGOiZDvOSHjay2Rr/kxnKU=;
	b=nqftBpqg5NPvnjVAvxXZxTW5fE75XRBGgD3U1CAL6zRHPxHur596C8binFJz29krM9hF9xvi1WjOZ3pXTUy7eq2Numl/pvV4/QGTThTOa7VGf27B4h9DmUTVWv1hzS9c9sLEGG13BbWY/G+rldivnxLdR9xpjQQ+7kFBYXsgVXM=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1700.namprd22.prod.outlook.com (10.161.152.144) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Fri, 19 Apr 2019 18:42:14 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81%2]) with mapi id 15.20.1813.013;
	Fri, 19 Apr 2019 18:42:13 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Jules Irenge <jbi.octave@gmail.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 1/2] target/mips: add or remove space to fix
	checkpatch errors
Thread-Index: AQHU8jeGT4sE0P9dT0ipzK/tVd7J+6ZD2p8H
Date: Fri, 19 Apr 2019 18:42:13 +0000
Message-ID:
 <BN6PR2201MB125169BA5494784ED0AFB208C6270@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190413202818.13622-1-jbi.octave@gmail.com>,
	<20190413202818.13622-2-jbi.octave@gmail.com>
In-Reply-To: <20190413202818.13622-2-jbi.octave@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc3a5499-d953-43be-8e00-08d6c4f6bd76
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1700; 
x-ms-traffictypediagnostic: BN6PR2201MB1700:
x-microsoft-antispam-prvs: <BN6PR2201MB1700BF84E392205D92F2779EC6270@BN6PR2201MB1700.namprd22.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(346002)(376002)(39840400004)(366004)(136003)(189003)(199004)(186003)(446003)(9686003)(14454004)(6436002)(33656002)(558084003)(6246003)(26005)(97736004)(66946007)(316002)(102836004)(229853002)(52536014)(53936002)(91956017)(73956011)(478600001)(6116002)(25786009)(110136005)(55236004)(3846002)(8936002)(6506007)(54906003)(68736007)(5660300002)(81156014)(11346002)(8676002)(55016002)(81166006)(256004)(476003)(486006)(7696005)(74316002)(4326008)(71190400001)(76176011)(305945005)(99286004)(86362001)(71200400001)(2906002)(7736002)(66446008)(64756008)(66476007)(66066001)(66556008)(2501003)(76116006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1700;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PqnbM6IZbRzHVpm3f7DPPua99J69olT8BKHrPwETslcc3IvZKq61FNwHE7MAO0A5EtKSCOpGF1iGVzxTFXX1UosbEbirmidPp4Ku5IpkT8P5Y0KVHbQYDOiXrkOuApANN1bDZPmdf4Ie2sJTPgkyNBitI8aUXqCyETGSSK43dXU/3gfOGP1RRIReMY4ikKPJJmkBTy8q/t8ltDRXlKOOkXuKgcwncSh+fKWBOaBzeS8YUd0uxvwhX0FKZsPC+wlZKMGDjR+SegUrQHCkZAIiw1yB56BtQ0lfHbgsV56y8LUCYORLorrwVQGQRVwXEsml1BsHeX2Umzp6JDJN0BJkxjn/vGzorPgPCf1ceTirqYhoxV6KJVUrCY0qTdIZW9T/ZGme9ryzeu+RZBVch46ypa4YsYZnNXBO2g9YjlLnqZ4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3a5499-d953-43be-8e00-08d6c4f6bd76
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 18:42:13.6764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1700
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.135
Subject: Re: [Qemu-devel] [PATCH v5 1/2] target/mips: add or remove space to
 fix checkpatch errors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419184213.-C7PflK-gvmQR0eOVD19-ZohWWBwOVDPzYeaLyP4CSk@z>

> From: Jules Irenge <jbi.octave@gmail.com>
> Subject: [PATCH v5 1/2] target/mips: add or remove space to fix checkpatc=
h errors

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=

