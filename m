Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63012C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A85C2087E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="ACWbiLwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A85C2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i07Oc-00039h-93
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1i07NP-0002EN-8g
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1i07NO-0007PY-7A
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:52:55 -0400
Received: from mail-eopbgr780127.outbound.protection.outlook.com
 ([40.107.78.127]:2784 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1i07NN-0007NQ-Rv
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jISZS1rAf95aToWdEq/2xAjwGFIR3qnt1nbXkUtk9gm9ccjxlDKk+WC9Qs10inreEkK0oOo2pzygmuqM2xom73CisG3qmH/bYNZl9bpiak6bstb9eO866YiJJ6piNTUvs2gMofP9F/OzdtIEAGWj0eldkSAbnyK1Ewy+jhxb5OQv9xQOHSt/T6jgOqNOhfmcqMuKZGowGAq/ZUOMZEXIk+eh+9bvlEejyXqZaW8Hg7cdCh+GFkkbin1S/pN/muWxY7g6+CEfTdPBntVtDv7rR73mUwzTFn5OR/tt3pXwKQuWnjWbfNi9MgdiwmoLfFHWHTbgt86QkqP/O5NZ12V4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm2oVzgBg+qu8mN7o/KeSc2Zx2sIcbERVqI0wFHTV84=;
 b=m0v+82lTlCZZQNydStc2VkYz4WtA3JYTEdUQ83WA9R0sqXIjYxp3rQZOE6QJRB6VD7FGsy2MkMeoF7TTSHhWEcBvYVZJaKZsuiyJvESWYPXHp2SWS9xasPgBNuvid0eShUEi5cLFlBhRoeT64RVT9BCCyChaFD3g8UWtUjCsOs1+tEu2QKMjmnfcI78IMJ41PDMd4wUK/k44K5bHIS+VZi87a4ZjdHyExT82zK91Ck5hSLqmLvWOD0S3yXJrokWOfCjHAvybu+nH6C4571z8r1/7dhmCX+PdFaToEhmPt/VRyW2ai+V2eQ7nxHrEniZnPV2YLwaydYKf/HnJmuAALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm2oVzgBg+qu8mN7o/KeSc2Zx2sIcbERVqI0wFHTV84=;
 b=ACWbiLwHWRWCYcZL47kiTKh63lXrI2Jn7d2nudPlzWvHiCmpGSNlj5oIpunz+UgA7hTK1xKiiM3tiYSBOaJ1RVUT3PD5tEKmjGjVkN4leapzr55UNELLSrQjYuQDmuzLnHIV9KQmnnaEcUDtHwi8IogaEOg91vFE2/PpRdMJAhE=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1746.namprd22.prod.outlook.com (10.161.152.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Tue, 20 Aug 2019 16:52:50 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135%12]) with mapi id 15.20.2178.018; Tue, 20 Aug
 2019 16:52:50 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Richard Henderson
 <richard.henderson@linaro.org>
Thread-Topic: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
Thread-Index: AQHVV1XFWW/0Wa1HQESTSd2lS0WjRqcEBcwAgAAGa4mAAB9pAIAADDyAgAABwzqAAATagIAAAQ2AgAAAMik=
Date: Tue, 20 Aug 2019 16:52:50 +0000
Message-ID: <BN6PR2201MB1251B435983F1DCCA16A9B48C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
 <alpine.LMD.2.03.1908201811150.2980@eik.bme.hu>
 <BN6PR2201MB12512C4D20F05C8F21E5945DC6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <00b3cf35-d879-60d6-048a-fe757a461938@redhat.com>,
 <d66f02f7-22a4-b586-3580-e1cd0ba48d9c@vivier.eu>
In-Reply-To: <d66f02f7-22a4-b586-3580-e1cd0ba48d9c@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dc43432-dc5c-40db-fb15-08d7258ed62e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1746; 
x-ms-traffictypediagnostic: BN6PR2201MB1746:
x-microsoft-antispam-prvs: <BN6PR2201MB174601FB39396B0C3FFBDE5BC6AB0@BN6PR2201MB1746.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39840400004)(199004)(189003)(486006)(316002)(2906002)(3846002)(14454004)(478600001)(4744005)(66066001)(33656002)(52536014)(86362001)(66556008)(64756008)(66476007)(76116006)(66946007)(66446008)(5660300002)(81156014)(6436002)(81166006)(7416002)(25786009)(11346002)(7736002)(6116002)(305945005)(8676002)(74316002)(110136005)(7696005)(76176011)(446003)(55236004)(186003)(53936002)(54906003)(476003)(256004)(4326008)(102836004)(99286004)(229853002)(55016002)(6506007)(71190400001)(71200400001)(6246003)(26005)(9686003)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1746;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YMDMc6gyJil+z8XeVdbBFslsijVUUg9lpsDsALIkmqtxel77Wq5l7/RdjtbPc/Xn0B5gmOFOuQC4BZPy5x+V0Kmd0HpuQMMYxxRgZM3ByV9kha0H9saY/iHpr+XCvV9UKlmI2pvCWAYdqGsB6j5MhG/LG+fZGAWq6LvMhZ9FNkjCfNY8iT4jJ5SpHpUZr/BftNxS3Zq/r70j1kUBkwRJdoYnTFvMIoIQ5bX/NC9yBEO5saPUNLLR/nPhyWoaUflR1xj0D3+BN/VBGV5rFCmgaMWllwRgBEEkQcrcYkKqC+APv0335KgRm+IMOfGkXcbqoG+AoqJ7ATPbsbEmY++vAKq4a6G8zBcJBbjZK+Bk8E2y1E/v31WDMh6fLxU1rtyyObBj9Nrj1ce3FHJqs7HDTxDlNXsK95s4JN6oiqVvU0w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc43432-dc5c-40db-fb15-08d7258ed62e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 16:52:50.2332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwmQlyylZugrjgOU3zBwEVbU0WPD6y/twnCXHXBX6n35g1ol0UqlykOSsnuReQQ5G8vIZDoiRp9fc+meTp3I9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1746
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.127
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
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Laurent Vivier <laurent@vivier.eu>
>=20
> Personally I agree with David, proposed terminology is not more obvious
> to me and changing things just for matter of taste is not a good idea.

Thanks, Laurent for your input, but this in not a matter of taste, there
are exact metrics here - different things should be called differently,
not almost the same. Also, the API names should describe something,
they are not mnemonics.

Aleksandar

