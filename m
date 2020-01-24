Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D4BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14E02072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="dlGKvlRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14E02072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3sA-0004FB-5R
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1iv3rR-0003iE-0s
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1iv3rP-0000s7-Lr
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:39:16 -0500
Received: from mail-mw2nam10on2137.outbound.protection.outlook.com
 ([40.107.94.137]:11969 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1iv3rO-0000pq-4J
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:39:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/KVaPQ5AO3EJKNMcLtl86Ep6L2V7GckhXhl8rlK8pJ9u+55Ksfbpkl7vBx0m0APr3sqSKLPMkRe/xEazhsDDkp6lpujB7UxJM6SljfqBQ8wTE3krYwb/Rf/fndNKVa1xjE6rNeePCNSaF1Qe/6JVW9OBfeHNDLqibj3GeLj5ZWGFsMVx4MZzHdMwiF2UTC+zCOfsfZ+ctix3mv5IMbPq8AVNlkAw4NRnV1WxRLDFRehEbEMDrfefV+cgs3bGhRRnAkN/X1qYM3qzO7IWIdXksD3hylFeEQglWzTGphTLPEKppClTL48ofKmTwWFsA7MReeAqWG35lR/4UCth8jF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7edXDUI6XNTMwvejo7ueTdhRCqol9iOM1OtByJJ0GqE=;
 b=QKY/31URnd+rfrldG7sEzMqNaA/4TfpbL+bYYMWRPDCeX+idjYrvDGVCMocPUrGKCjvqH3iY02NfYULIE8olUwPkhFp8iBc9uCiCt/UfI/ddMbr/OsJpCwddKencFy1Ur9JqLe92H4H0onvDFtIQy0m64L7xUwXugUavwlvSkT/q6nvMnOdDA+L2Hc2FTTSoFrO0N6W+5YzRVwIGlwtFc0/KSRiSFUOm7feUBxMRzK7CpsNc0tfpEGDiKLpZXIOo3iiN3fE47rOtgQo6g15HrFach9z0Gph1qRXjq3HLXYevZd2bh3CqBYe/9gFmfv24UGi0zfZnVwg495dtgfxxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7edXDUI6XNTMwvejo7ueTdhRCqol9iOM1OtByJJ0GqE=;
 b=dlGKvlRh6qWhY12aPseI0AzNntlBJhXMVsg1d0EDZEarFcHuvB8KQ9a+9CPV5YtOH0iYVhl+WtkQzFuOA8KWQAlnECf3PFyBnHxWGcyNLiDO+Z5Exes52H5boO0CyzwB2iDpba0qKWdI6zaZU1Tq9Ff7/Z87miVDcGiurdXYCnQ=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1203.namprd22.prod.outlook.com (10.174.81.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.19; Fri, 24 Jan 2020 18:39:11 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::1594:9447:698:8486]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::1594:9447:698:8486%6]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 18:39:11 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic
 <aleksandar.markovic@rt-rk.com>
Subject: Re: [EXTERNAL]Re: [PULL v2 0/7] MIPS queue for Jan 24th, 2020
Thread-Topic: [EXTERNAL]Re: [PULL v2 0/7] MIPS queue for Jan 24th, 2020
Thread-Index: AQHV0uTNtohQbuxg3k6/l7b1mgCkZ6f6JMoT
Date: Fri, 24 Jan 2020 18:39:10 +0000
Message-ID: <BN6PR2201MB1251B1A4CDE9D9A2E6B006B4C60E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1579889269-8122-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <CAFEAcA96divoYVZcxeWVNPNHh8+0Px69Q+PuTc6j8HJ+6-XhKQ@mail.gmail.com>
In-Reply-To: <CAFEAcA96divoYVZcxeWVNPNHh8+0Px69Q+PuTc6j8HJ+6-XhKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c90b0289-bd58-4888-0af3-08d7a0fcb41f
x-ms-traffictypediagnostic: BN6PR2201MB1203:
x-microsoft-antispam-prvs: <BN6PR2201MB1203DD42C6A414F062B9C40AC60E0@BN6PR2201MB1203.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39840400004)(189003)(199004)(76116006)(91956017)(66476007)(33656002)(64756008)(66446008)(66556008)(66946007)(55016002)(81156014)(52536014)(9686003)(71200400001)(2906002)(4326008)(81166006)(86362001)(8936002)(4744005)(508600001)(8676002)(55236004)(6506007)(26005)(110136005)(5660300002)(7696005)(316002)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1203;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ewc7WMeCiOHUNFuTfQSvNEsbKeW9knvtlx2CakEU1M7S3wtLpOiq2ScHl/2PsaMFLliHUsX6CtAEdInSf/ULgwI3ixikU37uaBe+wnN3EfXJ3TbYtvnHyHRvWB1Eq1lRk8ANAkQI2t3v+u9ndpwxn7RapUQ/4SJoNDDcEG5/1SzLcOTHqxqA2lvYG5+n7idafqt4rMGKs7Bz5EkYaHqM4DnXJFF1HD3UiYalOSBRif4zHNxzot8J9Uvbt8+pICPDnyTOynv5dQbqdlyuAr3pnE1MXxgX1A0gPHkg17SQ/dGZ8TwM/1J9237058w8MqjgwM8dhzdtnktqfY0JCKL8jgGv2RTtHxkkAT6ubicyWNbEp0RKTZakwlnfiqaZdWmH8ooHKeaPTLDQfdxquxDXDDorEem5VBx6vKpFVGkn1Mvi90lvElSryofNFLSSwHgx
x-ms-exchange-antispam-messagedata: hJbWmXXxzYscLpmXyGoSTCDbXtVZ7saBy2SI5I+NMO/0j9XQVUF9Y+lE128mU+l0YS5tL8eGx6eiloNukci5Z18bwpTmW46P6OOV5UodOrg/NLrcam6CQG5lMGMmNobX3c0nNAmR8yiSsFXGDj9Gdw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90b0289-bd58-4888-0af3-08d7a0fcb41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 18:39:10.8901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhP5OsTOMx18++55jtsOjH4Xe3rGyqRQiz7Xqj2c5UM/VdXR9EI4xfZl55S6YRLy72/Qpu7G5IP4dQyMDuT/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1203
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.137
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> I don't think the patches from Igor are suitable for cherry-picking=0A=
> into your tree, because they depend on earlier patches from the=0A=
> start of his series which haven't yet gone into master.=0A=
=0A=
Auch. Sorry. In that case, please ignore this pull request. I will send a n=
ew=0A=
one hopefully next week.=0A=
=0A=
> thanks=0A=
> -- PMM=0A=

