Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E22C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C74206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aI94VjV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C74206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUwL6-0001R8-AS
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 12:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1iUwKP-0000yo-3C
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1iUwKN-00005H-LR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:21:12 -0500
Received: from mail-eopbgr720116.outbound.protection.outlook.com
 ([40.107.72.116]:26656 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1iUwKN-0008WO-G2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:21:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXdnvZHGwLVrLemvWrww4/ikAPJPImcEAIHEOodTfR+WvS59LKEP2hBAjOMFmz1Q9bbnQgGcFbjsU+zQYooroEpIjBBg+QcyirhZuFIb8sW0xjaSgNBrWWiMfHOETSD/iKdZJZxUkI5h+bHRhtMdVV7VjRlUL5/kuH7NSAMaH9JdRkdPzIn1pFLaz98MkOCVLAk3CzuvFDrx+vhPnHaUOC0ETWRbxdDn88vT5YkXd1cii2SwAMV+n1YEXgh4Ul09gVnrHKXA7Fnq/LpENx47urdrG21aRrG++lFamyOQDaC8YT1hNn8bnIRbrfqdmL3HLLEr5t26/Wu2VQQPZgflWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJgbk87KGNjLXWQzZ2YKiogp92r41ufKE5Q7OlR8A/4=;
 b=Zg194B9gfdZrBW7JhE/PiWT5fni3NB/qoVX0PyIKs2DEoRu4V3V8WMgBL8Q6rE7DyrIEBTq4LDEdA5B720oRQyFvprRbEMM4msoLo0zy5aVJhx1XwOWHV8GsgvFDsnPSHxUXcbBpxShxAWONU6otFP/NwffCCHAQHhr6wHQ6/kpWFuGrLLGCMBsfgNHXg0VdT+cPaSw5SM2tdy+EktAtXN3IDm5NWoHokkjlTv1SarzfWh/QQSrrdz1mXMuV6iJfi4xuALXLnJ/kCN6IlPt+kIui0DELTZnM4vV3RJcZlbWDcVhjALUPAuaqCOZ3I1Tnt61sfiYwEMwRBYg0DoWSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJgbk87KGNjLXWQzZ2YKiogp92r41ufKE5Q7OlR8A/4=;
 b=aI94VjV8d7eBk1GzJo7J2EwjNsay1HNjPE1lwgZU4kAoqfCFgSDzSOMmtKpYTsGO/rpjIx0kJ8gAHUISp5A8d86ksJC1femXKK73HxHp+BuwgqsPS9fKR3RcJVgSc47RtgU29OWCZnC16ZHH/Ym0oi0E0X0shfWtmKEdVOr4Pts=
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) by
 MW2PR2101MB1132.namprd21.prod.outlook.com (52.132.146.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15; Wed, 13 Nov 2019 17:21:08 +0000
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9]) by MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9%6]) with mapi id 15.20.2474.008; Wed, 13 Nov 2019
 17:21:08 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, "Justin
 Terry (VM)" <juterry@microsoft.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Subject: RE: [PATCH] WHPX: refactor load library
Thread-Topic: [PATCH] WHPX: refactor load library
Thread-Index: AdWWczxfa/0gc1vPTEu6TOvflPR6ngDFYVqAAAJR6gAAK5kfgAAAd6gAAADf6PA=
Date: Wed, 13 Nov 2019 17:21:08 +0000
Message-ID: <MW2PR2101MB11169063EA5EEB4014000C81C0760@MW2PR2101MB1116.namprd21.prod.outlook.com>
References: <MW2PR2101MB1116386CFE4628B6767D6CDBC07B0@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <MW2PR2101MB1116C3DF422DB5E301B74AEEC0770@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <20191112194738.GF3812@habkost.net>
 <017bdcd1-4058-c717-619a-d8362ac089b7@redhat.com>
 <20191113164922.GI3812@habkost.net>
In-Reply-To: <20191113164922.GI3812@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:1cef:6b41:87e5:6afe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 362cabc8-eac7-4f73-f866-08d7685ddf54
x-ms-traffictypediagnostic: MW2PR2101MB1132:|MW2PR2101MB1132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1132011E391171D46D602F17C0760@MW2PR2101MB1132.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(136003)(376002)(366004)(396003)(189003)(199004)(71200400001)(74316002)(52536014)(81156014)(71190400001)(186003)(316002)(7696005)(33656002)(86362001)(76176011)(11346002)(10090500001)(54906003)(81166006)(446003)(2906002)(25786009)(6436002)(22452003)(110136005)(4326008)(6116002)(99286004)(8676002)(6246003)(478600001)(8936002)(256004)(4744005)(46003)(6506007)(9686003)(229853002)(10290500003)(14454004)(5660300002)(66476007)(476003)(66446008)(64756008)(66556008)(102836004)(305945005)(55016002)(66946007)(8990500004)(76116006)(7736002)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1132;
 H:MW2PR2101MB1116.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ZY0IbPqRy43g1TOlNyWIZA31s7e3EGNFWrOkgMWJHgDO191AT0FpsHJNnKnl/CeghCkvdJFf+8So4Ty1XR9PvW8B4zh69jxzbx0AcNSNUP5dmv38NFq1axYBOFkE4kt9CfKMCAOgyR3ZDQfPCKfYfdekuSYgIlu3iGsLpHtO3jtgGiHwJyZ9pm1c8GjwY7iTd2W0rKxZw5+gteSg4Uy41y+Jme2xj0keRRUsgYwJ2325s+YMEVsoQQ4Uxl3TAMw6JnEcqaG6H854tFBaXXQMCeap/eL/EHlr3khK90iF5Gra+q+6z52YX1W9TMgMCcNjNUZeydu+CaYeExwHwxT10uyvBfW7+bhl6Ijl8VRxDYTGD+SMEIB1V1fqyUGYPJB355Qb0W/GxmYj0KDdOx9hZDLg8huZcJ2yn3GGUE9NmMxNvkjFy+ff5FC+YSDmmMs
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362cabc8-eac7-4f73-f866-08d7685ddf54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 17:21:08.2430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUdMsmy8weNXALvIOzKuULieM9I0SfNR2hETJXRdVy6uY6wpehX1uEpN2osCe+XrOVNTHeF9gP67teT4xR26WzYiTgLsvPh4Pdg8eoDmAh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1132
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.116
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


> Making it easier for other people to test WHPX would be nice.

Yes, we understand the concerns and I generally agree here. I am
trying to connect the different teams involved here (legal, SDK here)
and connect the dots for them, to see what can be done here.

> But in case this is not sorted out soon, I don't see a reason to
> not merge WHPX changes if they are reviewed and approved by the
> main author of that code (Justin).
>=20

Justin is ready to review it, but is out for another week. Will have him
review once he is back.


