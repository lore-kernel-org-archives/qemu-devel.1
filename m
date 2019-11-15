Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4490C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70ECF20674
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fnYWOsUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ECF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVd50-00048J-J9
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVd4C-0003Uf-Th
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVd4B-0002t1-Uw
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:59:20 -0500
Received: from mail-eopbgr20118.outbound.protection.outlook.com
 ([40.107.2.118]:2720 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVd48-0002hc-Cp; Fri, 15 Nov 2019 09:59:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIjJMqoXxcPL/rPRayKsybvUo5cC9EngS207fYomgrmDoPteDXkjLpwvLVv5XOoQG0itjQ/fBk6WSYy6s1fWpSbYTAe1SwWP2V0IVHi3m85Ia4BtJfKW4CSFFVjXe/LuVOZEJAf2QuK/RAYWUvIQxmjeArvyOBfAbAbhGtv56WguhuAO0WQHAaXATCvGCycctdQMf/YrtsdeFQrg12mAp9IYTjytI215bbenQXvd1p8QfGN77EDq9gZ4/THdL3QlXfLcLLPV0HtzfpKhQ/JYrDuOwj2NGHab2GOivthPtay6ODhhQ/DfZ7++8Ue2qwN5F26A4MnsdOSr0p9Xw0NVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUcpcPdbmdeLRiwbP6ish2m220mn2xSCL042qEBjHXo=;
 b=jNWfMfdtExDqwuwJWQZv7AO89svkbMQhdWvFMJJl03mH+C04zdQo9kbtx/eXyGYeFZZqoVoCnYNMOW3kdsp9/qVB/iZ0zi4mSZlh+Uu8CpOHyx5rxVQ5c+vHwXeGMDXw2nlB8wyCYR7gBHbTSpLuInGTsAjeoUTZMe97ia66mKXnQO7k+s6MgL+/aPpy13d58hRxoJIX+Jx+gFszUjCLDF5Hwo46x91wXZMM1PqwL8wlDkGrj8dXXMj/0HjKnalpp61D8p31LwWfkNmse2KnmG3AqbOCTiUsePXn5Cs+LKj41tmrDNKe3t57glqRMd2w7z6ND301eM+Blsqfe7uYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUcpcPdbmdeLRiwbP6ish2m220mn2xSCL042qEBjHXo=;
 b=fnYWOsUuBgf6faLtmXfDo70jruEmsd+2cSJTM1V85vC9rC8Ubl4gHS6DlnLCKKGjJvMlrIQ1LkwM2B3K9iZ7IQbAbmHchkYZzka8by12uPV7I5KsCNKxnzKixRYOCCm9DMUW++ObwtPinBqWUPr1fDexRWYmiTZfV4RfUoRNUo0=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4616.eurprd08.prod.outlook.com (20.177.199.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Fri, 15 Nov 2019 14:59:14 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 14:59:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 1/4] nbd/server: Prefer heap over stack for parsing
 client names
Thread-Topic: [PATCH v3 1/4] nbd/server: Prefer heap over stack for parsing
 client names
Thread-Index: AQHVmpXDnTPdexq4FkePTxEQWD0we6eMVU8A
Date: Fri, 15 Nov 2019 14:59:13 +0000
Message-ID: <f0f0d956-1066-2f1f-e6e2-7d7ec11f97d7@virtuozzo.com>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-2-eblake@redhat.com>
In-Reply-To: <20191114024635.11363-2-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0048.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191115175912160
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43f373c7-5e61-45b1-d9e6-08d769dc60fb
x-ms-traffictypediagnostic: AM6PR08MB4616:
x-microsoft-antispam-prvs: <AM6PR08MB461600EFBB8984AD4B1B569BC1700@AM6PR08MB4616.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39840400004)(396003)(136003)(366004)(189003)(199004)(66066001)(6512007)(81166006)(6246003)(8676002)(81156014)(4326008)(229853002)(6486002)(7736002)(305945005)(6436002)(71200400001)(99286004)(71190400001)(316002)(8936002)(110136005)(54906003)(386003)(26005)(14454004)(102836004)(31686004)(31696002)(86362001)(486006)(36756003)(11346002)(25786009)(476003)(76176011)(52116002)(2616005)(446003)(66946007)(3846002)(6116002)(2906002)(256004)(14444005)(186003)(66556008)(66476007)(64756008)(66446008)(5660300002)(4744005)(2501003)(6506007)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4616;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCSDxmxlWU+x/RlEp2Rl+bVI5oB3rsCUvcYGAxX99Ke9GcoDHrIc4Mhvsua/xOfGTj/36HGg1v0qvL2FlZmLzeGBPqH01DvtaSEa5omqIHeZ59z2Zjxjcd2WlsZGY/BxJx1ss9IHardA3W9kypzsaWbguxqRVJBW1kVJ9z11fPf5nylv8NVBwYq+dgvOW95miFO6z8WWrCMiZoZMkyikElkNtrSnn8FXNDcCMzrSijgtkxn5rg7Y37TPzDaEio78bAE9XIj4X2Vq4cSntw4DWrZuCOoG0Tfz37L9ShV7zW/hvADen0lfTSxQhiTXHRLjiOzEfu+FnEiBKYX/ouwH8MgWUnpEMPZnCnjpBoVWlGBygiKZcefeqyCshwTmJ2EbYGccHi6RK+wnELpWjDzgV20TLwdCwX58wF9cgnjgF5Ob+S6jWmHYW7N22wUARVj/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <24C744A828E88446A6E660F682A8E62A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f373c7-5e61-45b1-d9e6-08d769dc60fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 14:59:14.0272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K51dQ5skwTWGvOj4Ydi/4wXW1hUb/ZutaTQMgnSfeK9SwMR5a99C6hcsPd33A+caK1RJi/L0kW63jDhVPpWY853JDZE4/dl2avzCtchgi0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4616
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.118
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.11.2019 5:46, Eric Blake wrote:
> As long as we limit NBD names to 256 bytes (the bare minimum permitted
> by the standard), stack-allocation works for parsing a name received
> from the client.  But as mentioned in a comment, we eventually want to
> permit up to the 4k maximum of the NBD standard, which is too large
> for stack allocation; so switch everything in the server to use heap
> allocation.  For now, there is no change in actually supported name
> length.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

with mentioned fix:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

PS: Great, how using g_autofree simplifies reviewing! I don't need to check
that something is leaked at some return point.


--=20
Best regards,
Vladimir

