Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1FBC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6D62087E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="BYQpad/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6D62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i07Xz-0007OP-Lo
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 13:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1i07X1-0006cR-Dg
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1i07X0-0001NS-46
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:02:51 -0400
Received: from mail-eopbgr740094.outbound.protection.outlook.com
 ([40.107.74.94]:50096 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1i07Wz-0001Jj-R8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:02:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKmVl0oI7EBa4HbYdjpjrWblDIynVqzmAoCb8sPPA67DLxU5n3IzxwBFMfX8ZB2idyu2bl3LLjn25AFqxpi9QxPXMS3wbeXyoD8KbbvyyJXMuveM0Q+LHfS+lInXeVYwfzcR8H8Ti0RQpXjUR3rvBui9Occ1bfYr0iUj+8C7VowWpPnwbLJjB3k+SvlSkEo668qokDs9pzV+ARSPlMDHQwFfKjLszXifltUIv8uUDawnyBH7CX4aloDPBJonBFR9rMrW5+xYsMtQAp6MXETkRtkkv4irNihpihssgFRewEHPosIfpxLS7iFamy82Omg1pMuacCjyf5fPfqiZTGFE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8FFjIu4hCbqH+JmmG6g46OvvBHUFdYS1FEoIzusttY=;
 b=cWSSvV07cyn5DsuYoV9135Y4nJMv3Q7NvNO4JJn4VTlt/NyA0/GgbQxNj/gDVXtSL6vIj2mNJHATpIZzndQnYPd/u5OSIGmtDCIJYzXGSv0gAlFanfjohxAiUByiS/joL4j4CamseoazqRlFwwaDx3HYnIUZSdYgOgRxCjNAKHbfAu+XZPwsXYs3GVTNXnmh628zJh8gKEpLAGi/gl16IcsMAvCjA17fiwe/Nm4KN5cGm7xaeqXJ8Xvn+XL4MSwHz01xAPrphA37vbvwylr1l4V1l4LOElp9Fo1sLTgIEiTst3nu69F46WTo9hlqQdUudih5vps+gifHiguDdrNWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8FFjIu4hCbqH+JmmG6g46OvvBHUFdYS1FEoIzusttY=;
 b=BYQpad/FJ3BE4hb4K43yV/7Xn9vZaFlpJJQXqBC7aDb/wELWhn+CIrBLLX4chhj5DG15fV89jp5u+bo1BqMcXCAtUv4krN5svQlOX5jwiJLyPmOBXlBATaPsWVe3xnOOX8NhPhfd7+D9xDD2xJAW1GFB9lQGYM82J7CiF8e6GUA=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1730.namprd22.prod.outlook.com (10.161.152.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 17:02:45 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::709c:ea73:df85:b135%12]) with mapi id 15.20.2178.018; Tue, 20 Aug
 2019 17:02:45 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: David Hildenbrand <david@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Richard Henderson <richard.henderson@linaro.org>
Thread-Topic: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
Thread-Index: AQHVV1XFWW/0Wa1HQESTSd2lS0WjRqcEBcwAgAAGa4mAAB9pAIAADDyAgAABwzqAAATagIAABErR
Date: Tue, 20 Aug 2019 17:02:45 +0000
Message-ID: <BN6PR2201MB125185E01847A313D7699EA4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
 <alpine.LMD.2.03.1908201811150.2980@eik.bme.hu>
 <BN6PR2201MB12512C4D20F05C8F21E5945DC6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
 <00b3cf35-d879-60d6-048a-fe757a461938@redhat.com>
In-Reply-To: <00b3cf35-d879-60d6-048a-fe757a461938@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ea80110-6eb9-462a-0402-08d725903914
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1730; 
x-ms-traffictypediagnostic: BN6PR2201MB1730:
x-microsoft-antispam-prvs: <BN6PR2201MB17303885EAE5AD25CEB4456CC6AB0@BN6PR2201MB1730.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(396003)(39850400004)(366004)(199004)(189003)(14454004)(102836004)(6506007)(4326008)(55236004)(25786009)(558084003)(186003)(6436002)(55016002)(6246003)(9686003)(26005)(478600001)(53936002)(446003)(11346002)(76176011)(7696005)(8936002)(64756008)(476003)(66946007)(486006)(66446008)(66556008)(66476007)(7416002)(8676002)(81156014)(81166006)(229853002)(99286004)(76116006)(71190400001)(54906003)(316002)(74316002)(6116002)(110136005)(305945005)(7736002)(5660300002)(3846002)(71200400001)(256004)(52536014)(66066001)(33656002)(2906002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1730;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oYsy9iVbF4kAYzIiVnfE8XDUUuuCRQo2+iYZ9dkRNaXPHdVXp/thmAILFQfkBB9K+uUT1vi3SwqAAiEJhIBfgnpqZN0wSmUlJhk2YSKR1W1Khq0bYIt+UyKPDyiWPRLZf4cZbDfWhwT4BZriUl612yh8nWWeHCW1JGx/ADjqH7H5au3nR4i7191/aM6ZbGTkEVWNT3fAVSK+GK64/md5uajrSfK7nYeKz4roRrNkatm95diyumru1FCZflfjgNbfjhrYpnGcBij456IXaBwg55GrkBueqdr/DVgHF/T3Rw5FNG80Eg6GgUPzWnApNdR3CPeGI0GoFhc7XsWLrttcAX1KGvxlw7Doj+Ipij/qmVvCIgaW/pNEHpxdVnDjhyiH5rOGzAPHCwX3ElLBBPAT6l93993d4ZHgLWdEA6X5uyw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea80110-6eb9-462a-0402-08d725903914
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 17:02:45.7007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HHsFz+/d8CxYjkreyqtTw66xY2xu2Q8LFtO/PZzMaXsAYzM5Eqcko/+a3CbekF/9o6yxEQ41CaC1LoScDi3+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1730
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.94
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
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: David Hildenbrand <david@redhat.com>
>=20
> I just got familiar with the terminology and everything I read so far
> confuses me even more (gather/pick/extend/extl/shrd). No, I don't like th=
at.

David,

How often did you use the functions in question? Thinks about that,
and about reasons for that.

Yours,
Aleksandar=

