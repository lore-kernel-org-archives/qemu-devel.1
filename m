Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA664C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B468B217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tVAJMuB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B468B217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwWH-0004rv-R8
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itwU9-0002oT-Ts
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itwU8-0007w6-K6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:34:37 -0500
Received: from mail-eopbgr60120.outbound.protection.outlook.com
 ([40.107.6.120]:50926 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itwU0-0007mU-6z; Tue, 21 Jan 2020 11:34:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaJKdK3N1D1wJH8IAZPGO2rNawtL5mTZz6k62HHTkJIspJbjl5JUQfwoGQXhKKvtogYID8lltM22bLWl90dL0geHsUv7kcCexAqKDoHSel7oJ/eEIA9q0u4zFld51zs+XW3/DsGqBYttEUPkZEKuEnC5o5a1TeDPPhQR5jL5YPukqw+AQugnC68gUsaK2odRs5B/nPzi73MvGxFc0dhMWh2nDvz16/8tTO45jwtPU38LeV2tWLosxPlfxi70rfRbY61g1nni7LgLgJpVITqNbHMPDNGj18i1QpEWT1rOaPnC9Ntjwy5z7cCXHSpsSxiPRPHXt01vHoG/hWMp/eYdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zEH+Rifh3NEShsjZP/2BJD9LjNFTBp5EJ9JFDYnDq0=;
 b=TzW+5nTfvFkXE5AcHCZMbZCb4q01Rrtr03c45no9B2+gSkF3JkEBPHLmLZNt2jdBn+5gFZEDTFbEj82c1RYnsrSj3wyKkoKRiwPcoOi0nul4mqYesAypdLDT7DwtYyj0VyINiZMJM6CQl2Ta1aOVDA2cOznBNK0e3IB5xkgaG/aWoKL3Lv8EVVUeDwGMgBBQn7jNTK8f/SgMDqt1bC/JS+8lA92pvFbQkycyMHX/k/elGM+bXjUE9QaIBnByTVj4HqEowXtRCxmTj4Qg2WY+NexsqX7i9BIvA5KaNGH7x4rLcb1/8/8WfqUKukdmVLC0nKJYCE7F0hGna/4ETbQiMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zEH+Rifh3NEShsjZP/2BJD9LjNFTBp5EJ9JFDYnDq0=;
 b=tVAJMuB+1ZO+EqSRqZRzTQbSTikxImXd94tZ+b915xFs815IOdY53W4XJ0YV7+/VFZ9wd8lFPPg4t0BdMMCqDCO/2UIPXg3EyKziKwocItUT8MUeKqcwGAcrDT6HznScVRZ7P3X1FLndc4+wsf55eMPVOaarA6EXzew65GW1SaY=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4376.eurprd08.prod.outlook.com (20.179.6.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Tue, 21 Jan 2020 16:34:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 16:34:26 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 16:34:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 0/2] backup-top failure path fix
Thread-Topic: [PATCH v2 0/2] backup-top failure path fix
Thread-Index: AQHV0GcHL/4L65XOb02QM7avovRIHKf1T9aAgAAAowA=
Date: Tue, 21 Jan 2020 16:34:26 +0000
Message-ID: <a1602315-92a4-53bb-74f6-8951d27bca09@virtuozzo.com>
References: <20200121142802.21467-1-vsementsov@virtuozzo.com>
 <c9b9ef96-3f1d-5d6d-f20c-971b4c39b774@redhat.com>
In-Reply-To: <c9b9ef96-3f1d-5d6d-f20c-971b4c39b774@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::39)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200121193424015
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8bf1600-5b95-4913-6d11-08d79e8fc77d
x-ms-traffictypediagnostic: AM6PR08MB4376:
x-microsoft-antispam-prvs: <AM6PR08MB43761FBCE77AC0550E27BB02C10D0@AM6PR08MB4376.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(39850400004)(366004)(136003)(199004)(189003)(316002)(54906003)(16576012)(110136005)(8676002)(81156014)(6486002)(558084003)(66946007)(66476007)(66556008)(71200400001)(64756008)(66446008)(31686004)(36756003)(186003)(53546011)(26005)(16526019)(966005)(4326008)(508600001)(81166006)(31696002)(2906002)(956004)(52116002)(86362001)(2616005)(8936002)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4376;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWP4EKkkU0nNmAXa/IM7iTBmX1PkUWY6CDp8STbEcyLC70UOmBzI014XT9LvHx8CRuVQC9A8JVnW/+c45RBCdt1h614+/kjIX282YQXFCB6i3HOrctS5spinPEY+Q/eLyLIKI6Rbh+VjNMj2GfaDxc/hVSE9/N8hqB1YukRHTSnO/vY2wkmtEsY2aMtBlMWWkJSl2UDgBNnQN5UjVy1umAXjaYRVlz0r41JNl8xU2ApOgFxlkOsXJJvr0p8n/+IqbQHIwQs05iR1F2n/CMAR0sK7hbNG1pD6J3+hU/PxrFaDnifYCUwz0bhBq2Q0eYpE0oVkbEvYv1p5xF8bN7litG8LOxkAgAChUAsbnM1zu5L8rvMZ3g/qJY+j9+k2Etlh5rIltJBEr4j0PoeXvBP3Lj0+wtwxjKP4tEsx8Oc/4DMoUuoIrnJ8q++ZFbGI9Xa45o8p4rBJ/G/r5kxMhLCdLPa/RQ1EFoHwM+dr/ugfS+CYo+pdtzcK/7/CTK6TEmfjok1oeOXAkBzl77/FTWWaeQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <54A8AA2E9DCC2040B8B6BE5785742C65@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bf1600-5b95-4913-6d11-08d79e8fc77d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 16:34:26.1811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xs5JhdSRgBAVnqQwaU0S7SWafcQiTSet92iAY7a2OwN6ZpJsgpFXjx3dN3OuAtRTFaF7qNlZy7j6qhLQtzy6adYwHsvOvrYke3SWNHh3/+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4376
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.120
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.01.2020 19:32, Max Reitz wrote:
> On 21.01.20 15:28, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Here is a small crash fix.
>=20
> Thanks, applied to my block branch:
>=20
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>=20

Thank you Max!


--=20
Best regards,
Vladimir

