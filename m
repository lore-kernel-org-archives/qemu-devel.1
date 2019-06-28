Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A51C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FC520645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lFcXB41B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FC520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgr53-0004KF-K0
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45516)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hgqPo-0006K2-Ih
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hgqPm-0007nq-I9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:55:44 -0400
Received: from mail-eopbgr770122.outbound.protection.outlook.com
 ([40.107.77.122]:52965 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hgqPi-0007dT-KU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:55:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=K+GKJP7E1nbgqacXdvLoONRqlGiLuTbGyPO1RgJymJ6PaWq3DRz8y84JL4eTQh5R4IRhY0DbTSXS+8pFPoB7sKz/j6PfwTUjXr5UYQ1NcOvVCy0UMAzMS2SOqjQ5s17hFwTI7jZj6HxTAkTK+w4pkoymoquD/u32cOVHmZZyXP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugX3G7NrQSU2i1OUMG8nXcaD+JG9naKJ/i7tI68B7cQ=;
 b=wsl4Bbz6Rhn5dIgY1DO1ppSWE8gJyr6YInBBRcO6O9sR6lQ1A8u7jrv8TaCOZhGU+pw3lCCtN6i4XuMwbUbLo8o6ETfCdN/7bSHtwzxL9f40ADQb5uwLacOS3dGETd1A2qvodFhR2VmCjLUtTDTpo6qWHWkweqebaHghebCnbHA=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugX3G7NrQSU2i1OUMG8nXcaD+JG9naKJ/i7tI68B7cQ=;
 b=lFcXB41BPQC7dzcBBMgjpjgtkJnIYK053huEOGPzf3kwjczExV/BUtMlKG/UltmwhvY9JnKaak4th43qp1BPQR1mgmkbSb36ZcUu949DtL0mB0ngXV3flV5z6QmZyXJs6ekdI2okoH3WyRW4pP6YT8G15q0lID6Mjksn0hccotk=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1729.namprd22.prod.outlook.com (10.161.158.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 12:55:30 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::b0c5:c059:f809:fc07]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::b0c5:c059:f809:fc07%2]) with mapi id 15.20.2008.018; Fri, 28 Jun 2019
 12:55:30 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Laurent Vivier <laurent@vivier.eu>, Fam Zheng <fam@euphon.net>
Thread-Topic: [Patchew-devel] [Qemu-devel] [PATCH v15 0/5] linux-user: A set
 of miscellaneous patches
Thread-Index: AQHVLY8puA1jfdE0PE6ot7AC0RBAX6aw0o+AgAAozgCAAAcTgIAAAbuAgAABs6c=
Date: Fri, 28 Jun 2019 12:55:29 +0000
Message-ID: <BN6PR2201MB12512151463CD300D0EC1887C6FC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <156171539473.6332.3788894025347542150@c4a48874b076>
 <f1ff093c-cb64-a54e-778e-eb18a0fdddb2@vivier.eu>
 <20190628124117.2lltlf7yiwlwy4j4@debian>,
 <4d6b26bf-6f20-f809-9e9c-f706dfd21e35@vivier.eu>
In-Reply-To: <4d6b26bf-6f20-f809-9e9c-f706dfd21e35@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a08b850-b8b1-404b-b594-08d6fbc7e65e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1729; 
x-ms-traffictypediagnostic: BN6PR2201MB1729:
x-microsoft-antispam-prvs: <BN6PR2201MB1729B5CD68C6FD8D00F3A236C6FC0@BN6PR2201MB1729.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(39840400004)(376002)(136003)(199004)(189003)(53936002)(64756008)(66476007)(66446008)(73956011)(66556008)(66946007)(91956017)(4326008)(186003)(71190400001)(71200400001)(76116006)(4744005)(52536014)(8936002)(6506007)(110136005)(76176011)(68736007)(102836004)(229853002)(26005)(86362001)(5660300002)(6246003)(55236004)(256004)(54906003)(25786009)(2906002)(8676002)(476003)(6436002)(55016002)(11346002)(446003)(7696005)(99286004)(486006)(14454004)(81156014)(3846002)(74316002)(478600001)(6116002)(33656002)(9686003)(305945005)(7736002)(66066001)(81166006)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1729;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8xhdOi55+oflsIvKzVHAM6/XxkRujVZn3CymsFMLz+TIdY1McpjoKq+0R7B4HVM0Igo6vYyf4Q6uj7rNeuosoS0slzTjNOpNNRzD/wLX4HD1epcw29QKgcZI6VyNGAasOP9DAsusKsyLasnzR55NmpBcearVF5UmwdI5TCV+lpTEAwtBDhvVoWzx33D0PNbjEIXxripOjRQtPDARBKY6VvTvytNpne0nm5gtVJzdC3mm/09cHofAgfiO3660jPE5NGFPC9eyMk3Zgrbir8BIqyv/6k0t2Eg85+kLnmmEIAg6Xgz+5m+JQnTFbLqhkv3odDQK5gcj3V8Xxy7L3DZ/xeQ2IJIPS4DeCP05n4AClQdyx5dXGaolN+38q8aEwJNRq0PG2T3M9J0SxMtADMkLx9EPO7W4zjDYhrShLG8dhZw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a08b850-b8b1-404b-b594-08d6fbc7e65e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 12:55:29.9712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1729
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.122
Subject: Re: [Qemu-devel] [Patchew-devel] [PATCH v15 0/5] linux-user: A set
 of miscellaneous patches
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
Cc: "patchew-devel@redhat.com" <patchew-devel@redhat.com>,
 "aleksandar.markovic@rt-rk.com" <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> I've moved the env/rpm/uname commands before the actual testing commands,=
 so
> the information can be collected even upon failures.

Would it be hard for you to capture output of the command "ldd --version" a=
nd include it early in the log?

That would be sufficient for us to deduce "glibc version".

Thanks,
Aleksandar=

