Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052FFC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4FB206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="O6aS8FCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4FB206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnHu-0001wr-Ur
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1jCnH8-0001Wy-JH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1jCnH7-0006ie-Mr
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:35:06 -0400
Received: from mail-bn7nam10on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::70c]:45440
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1jCnH5-0006SD-DR; Fri, 13 Mar 2020 12:35:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ9ibvshb8fv4yi72A1J0Qg29hDkOSPyWcfc7/wIqYI0Uahxp4aVlD0ZJhHtDikOI/nC8oYYRxDlJnYhQ2dGfoh2Lod0DCYkWyu/fhtOTncuvXWFRY64MoWqlZy+JoWp8p3X2z5vZZ3XSAD/92AjzrYZ+x/eavdWCZSZcPNM4Gc63WxfwwCcgEyJxLs3WIFeRcEAWnU8YfyCCZIt/VL5oNfF6u/fUlGG5Ab2FQZ6TfYAW+fRUkASg+/LwKG/Eggr4xeI+BH4PGiDFxSL8LeeAzFas2g9Buzk834gFn+T3DNZKIbs/1CqQHkUiOnUzcxN0BKhlqg7sYMjbm3GhVOQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMMsiIAombAdcbTmHW4R6ELwXAKUYS03j4If0+mkhOM=;
 b=Ht4vTAHvaSFLlJMPAtKqecm/0fpqRuAmUJlwfpEqVeXj1nMKExfO7MVIutH10reuOYapW7xECQroNtU4Ms2LrUiX4LxSYaA46uxRVcZYyPnXwtpxfMzih7Io6zEOnHvj9XyuO6UjwcwoPmTF0b+85R41ByYRXLkFEU0tGZYwY3otur0LIaB69RRJD4txjqwUJuqosYq/gUol51y3WD62knhiCRtyIupNsQ+dAyx3guphSNzkNOvrRs/0baKERcNBcLIg8bi2lTukCQJTWvwnix0de2aM5WsQ8BBoR0u3BHIVKHss0km6u30XKl/li5NTeiOcoxrzeN7bfpU9ooP0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMMsiIAombAdcbTmHW4R6ELwXAKUYS03j4If0+mkhOM=;
 b=O6aS8FCFiyvdIjS2zWCuJJz0Tnr94sGAeJfUVFfAnjp+lR2UCy+kFSeaEIEju1CC1RxQlD2+m+pkRAdUU5Ri2cD8IQmcxA+XQIYwDAL/PItseXBH5jJaowvC39IEdLXHxCeN/MVUaNKFwY/vs2CvzbqN1Sibc5L6piOtKVkly9o=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 (2603:10b6:405:23::11) by BN6PR2201MB1313.namprd22.prod.outlook.com
 (2603:10b6:405:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 16:34:59 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::5104:3643:96fa:3c04]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::5104:3643:96fa:3c04%12]) with mapi id 15.20.2793.018; Fri, 13 Mar
 2020 16:34:59 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "balaton@eik.bme.hu"
 <balaton@eik.bme.hu>
Subject: Re: [EXTERNAL][PATCH 0/7] via-ide: fixes and improvements
Thread-Topic: [EXTERNAL][PATCH 0/7] via-ide: fixes and improvements
Thread-Index: AQHV+RDgjXWaZUGeH0uNfJ1VHJIEFahGttM9
Date: Fri, 13 Mar 2020 16:34:58 +0000
Message-ID: <BN6PR2201MB1251E13D9FB745DDE73DC74BC6FA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20200313082444.2439-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20200313082444.2439-1-mark.cave-ayland@ilande.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2011337-5045-4fe4-ab59-08d7c76c78da
x-ms-traffictypediagnostic: BN6PR2201MB1313:
x-microsoft-antispam-prvs: <BN6PR2201MB1313AA710BFF8C6650E56177C6FA0@BN6PR2201MB1313.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(396003)(376002)(136003)(366004)(199004)(316002)(110136005)(66446008)(76116006)(66556008)(64756008)(66476007)(33656002)(66946007)(186003)(91956017)(7696005)(26005)(52536014)(81166006)(6506007)(55236004)(508600001)(71200400001)(86362001)(4744005)(55016002)(8676002)(9686003)(81156014)(5660300002)(2906002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1313;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MQNMHK2eIumqtX2JSP7O8imoUs9Vd/tiVBSNilQXW4eou0IHYfLe65EZ041gfTxhaifggWCnaTyIV09/+alEATxAWI3zBosmrmhLAxuY9jEc+Mr76UgrmUzoDWRdNXpbVJueTIENfJusoHoaLhn38ncZu0lEMEPU1f8v6Iq7B+Kt5OjA8aiFqn0uwVIYN6pj+3yHRlie1OC+E9Rme8KNVoKsEXvvoV/11mo9skpzRcjCraZbkf28lR2CK8Sqq1dILTU3wylmswYQ+ACPxpSIFTXGx/S3oCaj/EiYr9m6db8em3SNPFwdDUteyM0jM3g7nRdsT616GAX5gOG5L7/WWWnA6f1UCzAwmv6AJAi4SZfvvXP7yxoorSLPRCqyTb+7z6J2lou3HtG9GkJQ9qqDpqU6eRCBAgifFL44RVQWfT2doY8+22hh1Rjt8npx+g0E
x-ms-exchange-antispam-messagedata: ZTkUG6j6dE/Cfs5c71LLVBSy4UhwTaydSwJZ16PaKZBj2FQFr4H2QM5f0hOysHrg9ZAZF+1HzvQGe/RPcqLk5KEnS0qNl6iWo1zOpAngXI70g6OmjKZkx1pcqSEMNqIlJfi4fce8Y0g0iLtmsqQgnw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2011337-5045-4fe4-ab59-08d7c76c78da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 16:34:58.9578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECZK2wZOfkbrPr4maxASrmLy51ZF68FhKmhOwckXcLFC2D8hpHflqsPSItMG2aJJekt67CsWqXsDFegiNgA0aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1313
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e8a::70c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>=0A=
> This patchset effectively updates the VIA IDE PCI device to follow the=0A=
> behaviour in the datasheet in two ways: fixing some PCI configuration=0A=
> space register defaults and behaviours, and always using legacy IRQ 14/15=
=0A=
> routing, and once applied allows all our known test images to boot=0A=
> correctly.=0A=
> =0A=
=0A=
Hi, Mark, could you just enumerate those test images, download=0A=
locations, etc. and whatever else is needed to reproduce the boot=0A=
processes in question - it would be useful not only for this patch=0A=
set, but for possible future work, wouldn't it?=0A=
=0A=
Sorry in advance if that info in possibly in another message, and=0A=
was missed by me.=0A=
=0A=
Many thanks,=0A=
Aleksandar=0A=

