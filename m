Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD96DC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDB22075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="MnnNzdQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDB22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdusm-0003hz-M4
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hduff-0003JU-SN
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hduF9-0006np-Ch
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:24:52 -0400
Received: from mail-eopbgr680091.outbound.protection.outlook.com
 ([40.107.68.91]:56964 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hduF8-0006lh-VC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEfTt9UZVCY5POd87p70mSVHcqXgPSlsh6h4VviLAD4=;
 b=MnnNzdQ47F9hyQyw5sBo3+fRtbCfVZ0CeqsMhF8Q6rTU+GH+4Qdkt63kIXAJTHPVlXGb3wPScjneyh8Wq0Y3SCclQCcb1oP6Ks5wwKTgq4H/x6tWLFdoA0pnPjvYGsa0ecfeIQlzy8letkxyjmaoROr8loFS6xiATYEfpZq0QZY=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0795.namprd22.prod.outlook.com (10.171.158.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 20 Jun 2019 10:24:30 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 10:24:30 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 0/4] target/mips: Misc fixes and maintenance for 4.1
Thread-Index: AQHVJ09CpTQdAwILcUmqxV0XMbM+JaakVYiI
Date: Thu, 20 Jun 2019 10:24:30 +0000
Message-ID: <DM5PR22MB1658FD6148E93CFAA6676F02D2E40@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1561024929-26004-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1561024929-26004-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09259aa6-e53a-488b-7c88-08d6f5697af3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0795; 
x-ms-traffictypediagnostic: DM5PR22MB0795:
x-microsoft-antispam-prvs: <DM5PR22MB07953F54A08829E0ABC196A9D2E40@DM5PR22MB0795.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(376002)(39840400004)(396003)(189003)(199004)(6246003)(52536014)(71190400001)(71200400001)(107886003)(4326008)(66066001)(53546011)(53936002)(2906002)(6506007)(5660300002)(229853002)(478600001)(66446008)(64756008)(66556008)(66476007)(8936002)(91956017)(76116006)(66946007)(73956011)(2501003)(68736007)(256004)(14444005)(316002)(110136005)(14454004)(86362001)(6606003)(99286004)(74316002)(486006)(76176011)(7696005)(476003)(19627405001)(55016002)(7736002)(54896002)(26005)(3846002)(6116002)(102836004)(446003)(55236004)(186003)(25786009)(33656002)(81156014)(81166006)(11346002)(8676002)(9686003)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0795;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MGHOt1m5SLZRDPQKVyDNU+dJ9Fodc+0POIEB/5Nxk0TUXA1pFbbjyQ90QqN5p2FMvFj4GdnICMp17P6EmVRD67TPg3/7CA/GBKX8YVuoVJg+/0BBQ0dqIdmGWN01IWARh0sv2Z+qZw0KQhhQVKXf5a/QyWWfLD9ZU/wolq/feke44Pd4xhUeL62dkMzM3GkGCuRAGbJD6OT2mQ5dYvkvaeIClgM0iI774zLwRkK27ah2u2yvws0SIBw0v5p8XSb3gNnNQvuXeKvoGF0zGIJUZDOE9Bbbclj2W/vNPRXb/JOpmZuVVEBrf4H/VaD6wJ6B4gZc4zanWdLt2lbCDmTY8KjpC2WxP8eIufR90tNFgvFS6QuBYU0bLDrtsuwAATXwDmX9W+ibmSk5TW7PWlh+Kvzuj1rH5Oasv2R0LZXqIqQ=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09259aa6-e53a-488b-7c88-08d6f5697af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 10:24:30.0423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0795
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.91
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 0/4] target/mips: Misc fixes and
 maintenance for 4.1
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Thursday, June 20, 2019 12:02 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v3 0/4] target/mips: Misc fixes and maintenance for 4.1
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This series contains miscelaneous fixes, improvements, and
> maintainance items intended to be integrated into QEMU 4.1.
> I will gradually add patches by the end of June 2019.
>
> v2->v3:
>
>   - amendeded two patches on cleaning checkpatch warnings
>
> v1->v2:
>
>   - added two patches on cleaning checkpatch warnings
>
> Aleksandar Markovic (4):
>   MAINTAINERS: Update file items for MIPS Malta board
>   MAINTAINERS: Consolidate MIPS disassembler-related items
>   target/mips: Fix some space checkpatch errors in translate.c
>   target/mips: Fix if-else-switch-case arms checkpatch errors in
>     translate.c
>
>  MAINTAINERS             |   6 +-
>  target/mips/translate.c | 445 +++++++++++++++++++++++++++---------------=
------
>  2 files changed, 257 insertions(+), 194 deletions(-)
>
> --
> 2.7.4

For the whole series.
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>


