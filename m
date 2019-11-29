Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8197EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCED2176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EeysIzjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCED2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaczl-0006qt-4M
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iacr2-0001Eo-1j
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iacqy-0005d8-53
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:46:21 -0500
Received: from mail-eopbgr40120.outbound.protection.outlook.com
 ([40.107.4.120]:3394 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iacqx-0005Vo-MF; Fri, 29 Nov 2019 04:46:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu4QgG0vbrkwg+h7dVIJbj6fnS7YP5uxHGvnDmrkPwK4ZOkktkKxcuNkIlr8zO6jI96ZBgVbh+fAaz/+YELq2enJzHa15QKeQK9QDID5X6dwnSlnHTKWabkwr3QMGLOlbQVsaqPZlmRrGbTCHSsNzbFRIOtOzZ0qSpRSPNoT6kS7zTZQx49wbmqwu/xlDoPuaJtdV0TE5IpsXZ041tnBSYre7cDaOD2oBRTg0WuVB+UQ1eKH7F/VunRKrWlKY1NXEqHvcmtIrjd0Pby9HPh00CGCJ1ZDctMN/1Mw+HGT3mkAncLfYjsrAB6OwzJT4nziX2Iiq19vHY1uh7+WScZolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi3DiJ3rFEJ+M40zJQpkRN9ItQelKQ21E0UsMG7/0Lo=;
 b=ipReS7pCA26NZ60oDznyDVZnKwlT44z0vJgXYV38L3DMeQ8YNaYKrb518QMN1pbvtPtDfCi93poKa4+DnT1R6ukJ69CwzsyPVGdmLZ/sQA775lT4L9JtQ0kOFpOzeaZ6AEE4Ky1h0xMD7iud4S/H32yymnkjpAgqfkW1YmZtszirK0Jpp4zKyyr7hJKFu2jbKQ09UMoiHPtoHX6TNrqrg8iZwdINKjMP60C61+qdtdCGyCAcUxocUmgyBbEFvyxf6XQnJk+JErOTmhVEdNrr+99Mfh73ygJAdEtX+6tVbNeuiYU7WoUYzDDMlvq953aiP3VL1iDL9+NLEIEMroUtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi3DiJ3rFEJ+M40zJQpkRN9ItQelKQ21E0UsMG7/0Lo=;
 b=EeysIzjHv7Wo4seh1kWrju5Kj5pgY+tRqKRi90yBKajAjotmLSGgalF76RmaJTeJYrkWBfcS7YG72RYqpgCamUEtejQ1vuLM0xQJHRt5FtyvoBT+mBTOCQ0Yy11yeSoRGUf9CCmOjPtR0iswJ91jC4Kz/LvaL+Nxizi36Mvph9M=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3720.eurprd08.prod.outlook.com (20.178.91.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 09:46:15 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 09:46:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 08/23] quorum: Store children in own structure
Thread-Topic: [PATCH for-5.0 v2 08/23] quorum: Store children in own structure
Thread-Index: AQHVmKl40OStCzeJgEm0QklkJhZCC6eiAlgA
Date: Fri, 29 Nov 2019 09:46:14 +0000
Message-ID: <a516b94f-e5e0-26b3-db2f-4963340c8c47@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-9-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-9-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0001.eurprd03.prod.outlook.com
 (2603:10a6:3:76::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129124612447
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ebd7187-1be2-4ca4-e20b-08d774b0f952
x-ms-traffictypediagnostic: AM6PR08MB3720:
x-microsoft-antispam-prvs: <AM6PR08MB37204615DD22417BC7EBDF45C1460@AM6PR08MB3720.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(136003)(39840400004)(346002)(396003)(189003)(199004)(2906002)(31696002)(52116002)(305945005)(66476007)(66946007)(316002)(86362001)(66556008)(386003)(6436002)(229853002)(558084003)(6486002)(64756008)(110136005)(54906003)(7736002)(66446008)(6506007)(36756003)(6512007)(2501003)(5660300002)(81166006)(8936002)(81156014)(31686004)(3846002)(71190400001)(71200400001)(6116002)(8676002)(25786009)(2616005)(4326008)(14454004)(256004)(26005)(76176011)(6246003)(446003)(11346002)(102836004)(99286004)(186003)(66066001)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3720;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C5JFfIG3GRNbUoOooCiJdU+PTvbf2U7LyPgfr94RncC8FY+8PDRuaL47cd7x2F9YVbzoXwMoHB96aMD5nEel2Tvq5qweJh+wy/HhM2uw3Uxyw5N2l1Cl0FGdW7jX2Rli/0WRLni4WgjuZYogggQV7ttA/DpmaAsW+0/k0Giyq5LvAjZg9AfYSqBa/YC4HIwBZAg6KUffC9di1bLb+Wbrf9KpEFq2IraJKVN/2PVzEb0dV8FA7m7A6ksdK3uLFYqkS15i1anTAqeB68NN2FrYk/7XwLypVGkZwCCi1gsI5RWnqRAOSZlHxwIgB2KCEOPztr0Lh4xog1c1DuKdmwCxz+Y7uYq2jsN+ByrMedL4b4nbuO/UL1aUJ9xVrHECtGrtAtoTRKhxrEc7k6d2v8Nr0J1J5fhwM1CwzOwQo+MhRaOf6jBbCBviI/VjGzYw9Nco
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <21C0816DA7987E4EAECA47D8A6F9FBD4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebd7187-1be2-4ca4-e20b-08d774b0f952
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:46:14.4388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BGpkdmNtuDqpZlsSWRJpqmdzra9pVrM+zzFP8IvWNccAhinqi3BZLwpxyqEKou0jMcdoVC1VGh+qB1+4GX4mgFAULYaDBstDvu0jJ8B/+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3720
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.11.2019 19:02, Max Reitz wrote:
> This will be useful when we want to store additional attributes for each
> child.
>=20
> Signed-off-by: Max Reitz<mreitz@redhat.com>

you forget my
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

