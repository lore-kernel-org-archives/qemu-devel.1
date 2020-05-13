Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79340C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0E2205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cLFfrEmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0E2205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYw2T-00013S-Fg
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvr4-0006mW-AW
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:11:42 -0400
Received: from mail-eopbgr680082.outbound.protection.outlook.com
 ([40.107.68.82]:3429 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvr2-0000nk-MD
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDR0BHLWX+N963BN9l3pDUma0k134VxA1KZm2KfoCfGWSLQo39sl2AuYaG8cM5gN5RNE+igmG3nEyBMdriXF1FKJSgNVnMIPjHl4Tn0TweB1ldjPV4IFK39FOdFA5U/cHJ0e9nkIJk8nxwbSYuHHHJxEqo7qXlb43BPxtVsM9dNpLKV2jYGkmEbLQzZjh4gxRUMGi3cSjowA0tmsq5YqeKseaEnS/mhnsBVDywGTZ/7ug/pbhSriyRmAi0jgVrbzUP4IfJtVtykO6xVBeN7ZNFj+bZ+byhK8/B18I3h8cYPgmotxiQ1uUB6qLF1rYsahEk0zf5gn9/GRKdY0y1XPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPXSKqUHub+d7gUzRWKyYEQLoTGpM5vfsXITvIjxvCc=;
 b=SDhe9LxW3A78SovqAXm1i32HLFyXz+7JvU5pWq/ZIq9p46DaFpKmkJL7vAZ3Fhrqff9syKKvK+4a6yeP3lNyDWWBwuZ24TsPor6muE5aZDZBhkHP0Lu3d+8ZfUt83lQ0DBMrRd6IQoatBZrTs8DiBh7OuNph4x1hdTnixsaE0M5Ye4wsUeBPcKIPRZAK3HMyuL8DzU4kmCBgsPse/WFiWjYoUJ6nbtEL71COA/LuZKgyVpGK+LT1Xs7tVD8cLJ9kVFRknVbr5ppr5C599RRasfPHwENF1Kww6Op4fokp9Dt/lZ/AWWmLCCTDnT6u79dxfWZB9tekYFsIiUzPfc7QOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPXSKqUHub+d7gUzRWKyYEQLoTGpM5vfsXITvIjxvCc=;
 b=cLFfrEmJKE5CMGR6pn1YEoQS384R9yO2nSQYEbS3XH93bkt7qvEpoAKJDtax0CsSUdFZypEhGwvUP+5QDymjaNY6fKX3x1yq4nJn9oLgoqJ5RGIAWVkkxiumGIpRjPYYpeEB+HyN9RqgNjLsKddezfEtdOlh4E1NQXBov3g70rY=
Received: from BY5PR02MB6033.namprd02.prod.outlook.com (2603:10b6:a03:1ff::10)
 by BY5PR02MB6866.namprd02.prod.outlook.com (2603:10b6:a03:237::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Wed, 13 May
 2020 17:56:37 +0000
Received: from BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f824:4502:4930:8144]) by BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f824:4502:4930:8144%5]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 17:56:37 +0000
From: Joe Komlodi <komlodi@xilinx.com>
To: Edgar Iglesias <edgari@xilinx.com>
Subject: RE: [PATCH v1 0/4] target/microblaze: Add dynamic GDB XML and correct
 SReg reporting
Thread-Topic: [PATCH v1 0/4] target/microblaze: Add dynamic GDB XML and
 correct SReg reporting
Thread-Index: AQHWJ7c2C6tNs7z8hUWjQjeVEgsbUKimSIkAgAAFbgA=
Date: Wed, 13 May 2020 17:56:36 +0000
Message-ID: <BY5PR02MB6033EA92D22B76522643E0B0D0BF0@BY5PR02MB6033.namprd02.prod.outlook.com>
References: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
 <20200513172858.GN2945@toto>
In-Reply-To: <20200513172858.GN2945@toto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8e8f6cf-997f-4bde-5391-08d7f766fb6a
x-ms-traffictypediagnostic: BY5PR02MB6866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6866A2FA75BACAE740E7E1D6D0BF0@BY5PR02MB6866.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kh5/sGzJWVxFQm7teUoai2d98smzOpFJKERiH1IyTW4NZwmU2Uh/xOfRot7g05ZkyL1Ix4I1d/x77tQlieOZFOZjIH1LH+0+QSXeFAAVGrrz2L5T2TgJXk9z124gZSKKUohmt5j6P1yoyPbZOFkhx+OnJsn60rEMfXjiPMWIB8M2/78BP3O9UmNqIC0IC+HvKohGUEflDKCuRJMfJTQ5+n2GoHkJIvCZwIewQcOZMrZAUYfa0yQB4MZyf41l3o+8qd9rQDNqlqSMMlUKI5Z2l6rgMPp3fuAh15EElp8N0aNP3sDrw8f2LvxEn5RK9bgpGXR66OM4BsQqYM+ynlRXFJ5vR/qIixE5eY8xJqcX0dOVnDUruVCzh09mybB1/8d5+dEDknVxdJYf17hiLEMlaYCZvYsispTb06DWKiCSl7gfSVxi3E6kpgDtXOsbWtbn2xjtR75d2PeyMn7oh586yZyqe1l3DoSz7o7UezrF+NuHo3laizy5dix2tP00p1TKoHTEh2OSZ7ytMgw8fcIJlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6033.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(39860400002)(396003)(346002)(366004)(376002)(33430700001)(71200400001)(2906002)(4326008)(5660300002)(316002)(33440700001)(6636002)(6862004)(52536014)(8676002)(7696005)(53546011)(6506007)(33656002)(76116006)(86362001)(64756008)(478600001)(8936002)(66556008)(66476007)(9686003)(55016002)(26005)(186003)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kvL7NhvuYZ+hHLADpvBMyfACUEgbjB/JJiam4Xm5r75wtvJXRrun/2EThtf1w0NEtwUcXZY4JlrPEKmv2BMsI8PyR9GIXC4SCv+9mQk1PkC+zfDFAbQkIsVO6KzF1ND2OXt0lcmMToq7hppFnHSPUW0cOezfL1MhzP2hBstr8u3uLLeXn2dSb58yH7NfdeFvx1JYOx/wbM5U/JbEZ8sCS5HVZS6LU3sRBQSq3LsNZLXIP1eHDHBcG89Nn/I02R4VU0ZOlQhjHF4SombLOrTW2NDkggFGR5Qo/yVj6V4YHmFTlRimy5KjlZW7YUHUn6KMjOVDAyftMyZHNnAWA50JTfCuMhQQNJPyDKlKW4mw8cTA6oM2Tt2fi7qGDScG3iOtZPuD7o+67Nlio6l1N8kwvr58TniJgQ6uutf483SKHI/WLIARsFi7ZpONDjsrWLtBLZHTp5DS6UMsLuJlQqBed8WElHD/QLlbBKZvELwgqIOHGxmQc/vHsfdSA1BcJCLi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e8f6cf-997f-4bde-5391-08d7f766fb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 17:56:37.1439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJ3nj5GGBOs88qyyKFtZ2Bpech8Bt4X3Wbkwy8p5bo3sW57qMvUYnVALpARC0oaNx0Z6opZQKKssdx5b93a4kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6866
Received-SPF: pass client-ip=40.107.68.82; envelope-from=komlodi@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 14:11:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Edgar,

Ah, I did.  It was in my directory but didn't get added to git.
It should have been part of the first patch.

I'll add it to the first patch and send up a v2.

Thanks!
Joe

-----Original Message-----=09
From: Edgar E. Iglesias <edgar.iglesias@xilinx.com>=20
Sent: Wednesday, May 13, 2020 10:29 AM
To: Joe Komlodi <komlodi@xilinx.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 0/4] target/microblaze: Add dynamic GDB XML and corr=
ect SReg reporting

On Mon, May 11, 2020 at 10:05:47AM -0700, Joe Komlodi wrote:
> Hi all,
>=20
> This series adds dynamic GDB XML support for Micraoblaze CPUs, and=20
> fixes an issue when reporting Microblaze SRegs through GDB.
>=20
> The SRegs used to be printed out by iterating over the SReg array, but=20
> the SReg array isn't laid out in memory in the same order that GDB expect=
s them.
>=20
> When reporting register to GDB, note that even though 32-bit=20
> Microblaze supports having certain registers wider than 32-bits, we're=20
> repoting all of them as being 32-bits wide right now to maintain compatib=
ility with GDB.
>=20
> Thanks!
> Joe

Hi Joe,

Looks like you forgot the patch that adds the xml file?

Thanks,
Edgar



>=20
> Joe Komlodi (4):
>   target/microblaze: gdb: Add dynamic GDB XML register support
>   target/microblaze: gdb: Extend the number of registers presented to
>     GDB
>   target/microblaze: gdb: Fix incorrect SReg reporting
>   target/microblaze: monitor: Increase the number of registers=20
> reported
>=20
>  configure                     |   1 +
>  target/microblaze/cpu.c       |   6 +-
>  target/microblaze/cpu.h       |   9 ++
>  target/microblaze/gdbstub.c   | 214 ++++++++++++++++++++++++++++++++++++=
+++++-
>  target/microblaze/translate.c |  16 +++-
>  5 files changed, 240 insertions(+), 6 deletions(-)
>=20
> --
> 2.7.4
>=20

