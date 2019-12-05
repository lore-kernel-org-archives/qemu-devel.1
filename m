Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4DFC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C129206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IDzNS0+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C129206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icv7e-0004hh-D5
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icv6B-00045b-Uw
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icv6A-0001vZ-Hd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:39:31 -0500
Received: from mail-eopbgr130095.outbound.protection.outlook.com
 ([40.107.13.95]:22127 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icv65-0001Yv-CO; Thu, 05 Dec 2019 12:39:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncZAeq5oNsgVPU04Cf9Y3uhFymf+hfovk+toHx6fxKczTvlbDzre4+ZRU6oL0f06cMA2LAMDih/nmhURPDWFyTn7FUG5J3Who6xqT9FLU66dTor7StEbxcIdN3Ljxenh2fwhnCzkFDK/yikR729A/vp2Iva/TG5WQEHFmAw3FS/GtsE9cnDG/dThT9Fzaev5fVwOFFl2VlaB9Z67l1psHVUBNIy1tmmnfkpxztkGXlgZzo8UpdsKpmQ/K/Ys8kNK35N3IOAtRdy3ArCW3JxImA2xd8TyJG5WjV6ZBdU4++GNkwPzSxpXgyXwl/aYtS3h2xZLlIqbU0CoQSP9oq0euQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHVTnPZ4cAOt6dj7VZhOFTrufyLpTFOTFsLoVvTrtGo=;
 b=I/qaFkA8kDQWu3NpXTwbK7DO0jzL9nrdj6fgsHwhEB1olyxma220ix/QaLUrC7NeYTL6Evm1n187pLzpjEQG/nbhQzgxDs79AreAbWFrwSuxBJcJwpcAM3JR6ti+MyFPb9SEjzoFap9xm4RI2+drfv1fwPMidUOfPQECKG3teWtl8ktLmJmUWSycjAwmna7+itZ6WsU0hAtTXiqnxTILrnDNZDo9XHvpkty1IQSELnz5zC5QnsHk1Dowx//beG162XuvYy0l77qHALJkaGMAe5L1WWVcE/M6XLW9eqX3R5v9rjjU93APgh2bro6bY3Gb2cjf4X6F6/25WReA0GTKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHVTnPZ4cAOt6dj7VZhOFTrufyLpTFOTFsLoVvTrtGo=;
 b=IDzNS0+sygg8EKlNf/aZa0rDU5uy6Z2SmZW2HMPZF3dxNWmEmldgIxnZQfS51AXpPu4ahLEvpRZlg7lRXBXmh9hp0E7visYtNbfmIE8irrh63d+Cu2QhoiAuBIwUlVRfAxOkdogGQngyiVPt96tgTAjfTleQqHJt0B72je1yAn4=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3462.eurprd08.prod.outlook.com (20.177.113.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 17:39:21 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 17:39:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
Thread-Topic: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
Thread-Index: AQHVq3+LSA8OoYLZZUia0++YbcEGYaerx+kAgAAG74A=
Date: Thu, 5 Dec 2019 17:39:21 +0000
Message-ID: <93046486-1580-14a1-520d-08abdf74da0e@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-22-vsementsov@virtuozzo.com>
 <c4ff448d-e756-9d95-b07e-4ae5f2d5b9b0@redhat.com>
In-Reply-To: <c4ff448d-e756-9d95-b07e-4ae5f2d5b9b0@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205203919271
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 815c5471-8891-4c90-e424-08d779aa0fe6
x-ms-traffictypediagnostic: AM6PR08MB3462:
x-microsoft-antispam-prvs: <AM6PR08MB346206B130A2F3E5C2248C7AC15C0@AM6PR08MB3462.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(346002)(376002)(136003)(189003)(199004)(186003)(31686004)(26005)(86362001)(6512007)(6506007)(229853002)(102836004)(71200400001)(71190400001)(36756003)(31696002)(64756008)(99286004)(8676002)(14454004)(81166006)(2616005)(25786009)(81156014)(53546011)(6486002)(76176011)(4326008)(66556008)(66446008)(66476007)(305945005)(8936002)(5660300002)(11346002)(14444005)(52116002)(478600001)(54906003)(66946007)(110136005)(2906002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3462;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymAvGOXT3Ifepn7kruzDzoB2rW5qRKddIkZ0ttYMWc3SbYT5AjIJW1jvq21R2uczUAIpItG3djPobjhtihktBXWJiCGeZaETjHDJOHb5hKZKQ8rSd4j9orpJw3WcsH1SNsCv4uY/AiEQOcFILPOEg5z+y1yS/ulTo7f5aAGfzWF8FEh8UA2EKausGCKUBnlgbIIAmqpU+12ssmAtBSkvlbdAFA7IVfEs3dY/e6+AH4TmopoxkhnoSDzuyfRFzAW2aeRK1hh4UUlHAEx1V0lqVCmAj0/j9m/t/63bqRRnCWj04kN0GtjHpnKZGNczmcVtFymzb793iyFQZfW+uVqutA3o5fHkQQFLZ4ZMvCe4oco8PYctwzHBw010BOBhlboAQihjwhLq/Wx94pDULlWaokP5hzpCRnFQhFyFmCjYQxE+5m7yyLFo2E4VIWQ4NTru
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0EAC9A060F7CBC47921895F64750BF37@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815c5471-8891-4c90-e424-08d779aa0fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 17:39:21.5654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KRRCGvfhU/mGSPnZLP8o8M6rHTJulo13yWIf7RwOZ2xW5suj9cBTftyGqh6sCL4BJHSD5NBQwsK/RLprvoNopCTH3M3I77+mSZTO6bR1Ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3462
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.95
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
Cc: Kevin Wolf <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.12.2019 20:14, Eric Blake wrote:
> On 12/5/19 9:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The local_err parameter is not here to return information about
>> nbd_iter_channel_error failure. Instead it's assumed to be filled when
>> passed to the function. This is already stressed by its name
>> (local_err, instead of classic errp). Stress it additionally by
>> assertion.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 block/nbd.c | 1 +
>> =A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 5f18f78a94..d085554f21 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -866,6 +866,7 @@ typedef struct NBDReplyChunkIter {
>> =A0 static void nbd_iter_channel_error(NBDReplyChunkIter *iter,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret, Error **local_err)
>> =A0 {
>> +=A0=A0=A0 assert(local_err && *local_err);
>=20
> Why are we forbidding grandparent callers from passing NULL when they wan=
t to ignore an error?=A0 We are called by several parent functions that get=
 an errp from the grandparent, and use this function to do some common grun=
t work.=A0 Let's look at the possibilities:
>=20
> 1. grandparent passes address of a local error: we want to append to the =
error message, parent will then deal with the error how it wants (report it=
, ignore it, propagate it, whatever)
>=20
> 2. grandparent passes &error_fatal: we want to append a hint, but before =
ERRP_AUTO_PROPAGATE, the parent has already exited.=A0 After ERRP_AUTO_PROP=
AGATE, this looks like case 1.
>=20
> 3. grandparent passes &error_abort: we should never be reached (failure e=
arlier in the parent should have already aborted) - true whether or not ERR=
P_AUTO_PROPAGATE is applied
>=20
> 4. grandparent passes NULL to ignore the error. Does not currently happen=
 in any of the grandparent callers, because if it did, your assertion in th=
is patch would now fire.=A0 After ERRP_AUTO_PROPAGATE, this would look like=
 case 1.
>=20
> Would it be better to assert(!local_err || *local_err)?=A0 The assertion =
as written is too strict without ERRP_AUTO_PROPAGATE, but you get away with=
 it because none of the grandparents pass NULL; but is appropriate as writt=
en for after after the macro conversion so then we wonder if churn on the m=
acro is worth it.

We don't have any grandparents, this function is always called on local_err=
. And it's argument named local_err to stress it.
The function is an API to report error, and it wants filled local_err objec=
t.

It will crash anyway if local_err is NULL, as it dereferences it.

I just want to place an assertion at start of functions like this,
which will be easily recognizable by coccinelle.

---

We can improve the API, to support local_err=3D=3DNULL, for the case when o=
riginal request was called with
errp=3D=3DNULL, but for this we'll need more changes, like, pass errp to NB=
D_FOREACH_REPLY_CHUNK and save
it into iter object...

But how to detect it in code? Something like


--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1059,8 +1059,10 @@ static int nbd_co_receive_blockstatus_reply(BDRVNBDS=
tate *s,
          case NBD_REPLY_TYPE_BLOCK_STATUS:
              if (received) {
                  nbd_channel_error(s, -EINVAL);
-                error_setg(&local_err, "Several BLOCK_STATUS chunks in rep=
ly");
-                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
+                if (errp) {
+                    error_setg(&local_err, "Several BLOCK_STATUS chunks in=
 reply");
+                }
+                nbd_iter_channel_error(&iter, -EINVAL, errp ? &local_err :=
 NULL);
              }
              received =3D true;


is ugly..


So, to support original errp=3DNULL the whole thing should be refactored.. =
Not worth it, I think.


>=20
>> =A0=A0=A0=A0=A0 assert(ret < 0);
>> =A0=A0=A0=A0=A0 if (!iter->ret) {
>>
>=20


--=20
Best regards,
Vladimir

