Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A49BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BEB214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="Zu/vG3bM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BEB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i07A3-0008Re-Hb
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1i079G-0007YB-U0
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1i079F-0002Fr-N3
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:38:18 -0400
Received: from mail-eopbgr740092.outbound.protection.outlook.com
 ([40.107.74.92]:20802 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1i079F-0002Ey-FW
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:38:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT1gMs5xDHcRTFjpvDUG1U0IPIIhct2vo7G/OTmGPvwILUQlDgfKZcuTh36p0eapqrx3DlnfNSpOoAoTPCxjZNQAuxzxddMDDR1FvChtemLaF6hSIB4W81WjOfdS+pSLXfFins+mZcZkEcCpaiM8+64atCpUm3h9ccz07HqwN/LSVmdZrVl3Lk3yDx+IcbFqFYRM5rKvzuD5xjHPGfYWbiy+NTlCP9S5npE9Cooi6LdveOrXdgnxce8ULW+dHvS37WX7KV/TI1smXs20591gPkLv3Bif6MFX8q1MNwn8Vfi2W7W0M4wipRxM2SsiZq6VrlgvE48+aCaPlqRd9Pdh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xloYEUuMTeVYjse6ucnvGUUd1o85c4ZKYlndmx5phGw=;
 b=JUTYzGYlrvnOfHErBvHJXs7oC4soypfv1EpdtPsd+lOOmgp5Gw9u0/uZJdhLqEAo29U9RxpNIt7mIsWL/2hfVtavyt+vAZGl2HVCjYGWkYBc4ZMVRHxTQYQsdt29IFuJgHtps6LqRwVgQDfFlZuGJCQ2kc+IqzCrH3zzKDKjYteVX13x0OHCiyBxQhbXc8hApvudXbm/Txz4LzgFqbu96OssKy19iU7ceaSk33jnMwftfFSv2qEgJ9IurvbXzgI4S+Zed9ZmZydCy++OrvIDZKCxGpoXe2wvDtPc+2/0ehQXUiwCJbvLsmVGoakbhrQBVRJBqYZYvXc3a7VnTaX+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xloYEUuMTeVYjse6ucnvGUUd1o85c4ZKYlndmx5phGw=;
 b=Zu/vG3bMd9WRgYeEM9CHfUNthxeFqBbAp+3C4SuEsfF0tuwva5uCWLCIbkdtkrIDzaBb4Ww9jEinoCtxDNulNCcgk02cJW0+Ycj/ZQojkVCfs6A/mvyXF2axe7Fu15QEu5fu/+HX8XQ3HhL3jzvtNJT3CYjmTkpy+y81azrCRBY=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1537.namprd22.prod.outlook.com (10.174.85.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 16:38:15 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135%12]) with mapi id 15.20.2178.018; Tue, 20 Aug
 2019 16:38:15 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, Richard Henderson
 <richard.henderson@linaro.org>
Thread-Topic: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
Thread-Index: AQHVV1XFWW/0Wa1HQESTSd2lS0WjRqcEBcwAgAAGa4mAAB9pAIAADDyAgAABwzo=
Date: Tue, 20 Aug 2019 16:38:15 +0000
Message-ID: <BN6PR2201MB12512C4D20F05C8F21E5945DC6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>,
 <alpine.LMD.2.03.1908201811150.2980@eik.bme.hu>
In-Reply-To: <alpine.LMD.2.03.1908201811150.2980@eik.bme.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e9ab856-36b9-4bb4-d6d5-08d7258cccba
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1537; 
x-ms-traffictypediagnostic: BN6PR2201MB1537:
x-microsoft-antispam-prvs: <BN6PR2201MB153718ABC9FF7D417C1C1DD4C6AB0@BN6PR2201MB1537.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(396003)(39850400004)(366004)(189003)(199004)(25786009)(14454004)(256004)(66556008)(54906003)(7416002)(66476007)(64756008)(66446008)(8936002)(478600001)(81166006)(110136005)(2906002)(229853002)(81156014)(316002)(26005)(446003)(186003)(6436002)(6506007)(11346002)(55236004)(9686003)(102836004)(4744005)(5660300002)(33656002)(4326008)(55016002)(8676002)(53936002)(476003)(486006)(52536014)(71190400001)(6246003)(66066001)(76176011)(7696005)(3846002)(6116002)(86362001)(7736002)(305945005)(99286004)(66946007)(74316002)(76116006)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1537;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s7tjNcz8YtinQ84cAPnjrcaPq34JgGMvcmWk8z+2w5O8PyTu5uxNagNN0oIyYRVA2f4JTRHD8A4LMDl6pc1TfJ6J78KhjmqzlTgkDiZINV2LhigdgKJcg44nYSMF5L0n1Vf9OPmf6FBIxuHUcof9GyqjhxC5hm8GO18wl0VTiGWKXYGQH+gdOjayaS4DP/Bdn1E2xJeM3JdGPLDHGa7hFSO8JeTu+FkVE1VFppVIHYBrjhkIPdcU89qzg8xGI3bkml87wVUu86DU0LExooILGbhdZ2EyH+rykoTwbat47UQchkOZ2+gW6YP2EG+0NqwEFNyE3Humt84In9FhNQDbTGgH7CAt3oPndB5E0x8bRXU04AWx0XaFbO3dCLXHcUXK0QKiVl2JAWiQr1e4CB55MNTRdsJ/amLYJSxRfOxR4l4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9ab856-36b9-4bb4-d6d5-08d7258cccba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 16:38:15.3861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hS0ZZd5uqxOvlJoUu55yDOohI0ASBgd/eJ9J9yxKxFVUtCNJhLdqcvq2PuDQ/5/oX8jZwxtCbTG90d6O5nqDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1537
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.92
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: BALATON Zoltan <balaton@eik.bme.hu>
>=20
> Sorry to comment on this without really knowing what is it about but mayb=
e
> my view is not completely useless if this is to be understood by people
> who don't know anything about it. If it is not useful just ignore.

No, Zoltan, to the contrary, you hit the nail - the good interface scheme
should look natural even for people not acquainted with the gory details
of the area.

I have a couple of students, and these names just don't stick to their
minds, they just want to run away from using them. There seems to be
an "entry barrier" that is self-imposed by us.

All those functions seem to me underused in QEMU code. Partially
because some of them are relatively new, but for sure partially because
of some kind of disorganization of the naming.

Aleksandar=

