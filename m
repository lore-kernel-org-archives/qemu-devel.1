Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C0C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DC5208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="AZfCa6Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DC5208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtzz-0002iw-6f
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39077)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hhtzT-0002KG-E6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hhtzS-0004sb-ER
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:56:55 -0400
Received: from mail-eopbgr680100.outbound.protection.outlook.com
 ([40.107.68.100]:45417 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hhtzS-0004ob-4F
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDYgxB/Z83V3St1lRHMfNfBLZRHULmkCx0u7iBpHAfM=;
 b=AZfCa6QnLAhT8I4e4O0DzgaO3B5HTKUNkZa/6uRkw/OVuvkuoGTXHbf38lt3vlT1ZMN+lRuW/QOi4WPyit7G48ayz5e2jnqen2nCQsnDJ1Cr+aB4xQK1DekbHipWbeK/q+lG2L7YHAl6zcDHHjN/jRdjfGhpv1kxRkbt730tImw=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1700.namprd22.prod.outlook.com (10.161.152.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 10:56:52 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7%10]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 10:56:52 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar
 Markovic <aleksandar.m.mail@gmail.com>
Thread-Topic: [Qemu-devel] [PATCH v3 0/7] Kconfig dependencies for MIPS
 machines (but Malta)
Thread-Index: AQHU16VG/MdBSy5wtkCBDghuaTXhiaa0dwuAgAHJqACAAAY2nw==
Date: Mon, 1 Jul 2019 10:56:51 +0000
Message-ID: <BN6PR2201MB1251B0D61EEE430BA44A3821C6F90@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190311005618.19007-1-philmd@redhat.com>
 <CAL1e-=gqqd4EogYQqb74zLkS+a=8yhfNS5tnFhG6GWSRw5vdkQ@mail.gmail.com>,
 <63fd1b6a-3e35-747f-0dca-c7f1c0f38aea@redhat.com>
In-Reply-To: <63fd1b6a-3e35-747f-0dca-c7f1c0f38aea@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc8f60c8-1263-4708-de45-08d6fe12d2e5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1700; 
x-ms-traffictypediagnostic: BN6PR2201MB1700:
x-microsoft-antispam-prvs: <BN6PR2201MB1700A0B03DEF8D38B584EF6EC6F90@BN6PR2201MB1700.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(376002)(366004)(346002)(396003)(189003)(199004)(66066001)(33656002)(14454004)(6116002)(476003)(11346002)(446003)(486006)(2906002)(81166006)(81156014)(74316002)(305945005)(7736002)(4326008)(4744005)(8676002)(256004)(86362001)(71190400001)(186003)(14444005)(55016002)(53936002)(66574012)(8936002)(71200400001)(3846002)(6246003)(55236004)(9686003)(5660300002)(66476007)(316002)(478600001)(76176011)(110136005)(102836004)(99286004)(25786009)(26005)(54906003)(7696005)(6506007)(66946007)(6436002)(76116006)(66446008)(64756008)(91956017)(66556008)(68736007)(229853002)(52536014)(73956011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1700;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zTb6Cxko5+Zeta6mB5kh+VbPrqpb624Z/mDhzdMUoZt5lHq9ZhTaHaBj9kG39GfHUG2aFP9AdKI+USwemssQG9oC9w5lC5pVX4hbxaDDmwsH9Bi7Maw7mRIEWSIcY/syKFjHDKtgso5B2jFIljcZ6WsOw+eq8ORmQpCadaOxulm3L+Vaqt5Mwvk6abSewK+njq1CE9iDXwIF6jynN7jl47XJ9j0VI530+sAgVzwpATHQt8l6KKOXRnm90TUWAAnKCUq9/QGO7A5c2Ccxrvi8ayVJKokMM7ZlRNIEA41cBCk7TqR2GtYgLZt0WQHztpb9l5QTs0uUA9vEL+GDlyMoBVZE6m1nQPM6VolMK3edaghvB9FQ9w4Ovkl8PEvN8ZIqQ6CWDdUc02Ci+3cgldq74xnAMY+/kkyjGd2/OflyMiQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8f60c8-1263-4708-de45-08d6fe12d2e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 10:56:51.9499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1700
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.100
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Kconfig dependencies for MIPS
 machines (but Malta)
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
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>,
 Thomas Huth <thuth@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 James Hogan <jhogan@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Since I doubt we can fix easily the design flow when (coproc)
> instructions access optional device before 4.1, I'll also take out the
> Boston patches, and see what's left I can respin.

No problem, what can we do.

Or you can tell me just what patches I should apply from this series now.

I plan a MIPS pull request tomorrow evening.

Bon apr=E9s midi,
Aleksandar

> Regards,
>Phil.

