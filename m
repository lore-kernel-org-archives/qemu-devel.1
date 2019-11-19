Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E7AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCA0222CD
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JZucuXVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCA0222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2T0-0002Lm-Rz
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2S9-0001OE-Em
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2S8-000175-2U
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:17:53 -0500
Received: from mail-eopbgr40114.outbound.protection.outlook.com
 ([40.107.4.114]:62020 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iX2S7-00016L-S7; Tue, 19 Nov 2019 07:17:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDQzkHiUd0lQFyRZJ87g1GPYzCVhKykcXP0seJscGiW/yxc48t1jjejXNNtaA8utNEDP6ledcmP7F9ZM5+jv2y+4+MuM2LyVEdOS9XlX4yF8TXQsC24rgNjvzf96/d3b+n6IvpZgp9Dm8oX+0i/me7Qx5rW7iIZKg+CGn3TSmw/HVNprsMCzrQuT5CswJ4gdG3hI6DMkfHL3QJASXuhyTb+yp9b9ZTbiJWixZky0fK6mFOS+R+fJZBRyLmBjb6ZPc4yOBaaWQlAfTgQfNVhivPxDD1my3weyH6L02CfTrs4QAofGvAXOl7vq4OjLyKfs3iBuDY5WBEEmCcyXJDLacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGCP4fEZSBT557aNx+HIvPwvAMxzco2cMMAeFdLSAC8=;
 b=XAZWnVeo3HLKGLRV432F15Kc0xWblkpS/rWzwsXJ/C3uXmMlTE+TWuTS+uVbBKenGV5+M4xs5KxgNzkrBDR3PHRxp7ZU/1H3Tv+0+lM7Oa6Rt0737rqwO4D+86N4jYQy/DKV/Dvvcf84YIs39hZUF6Z5epJ3rxO4pRrqQnfm3UwHVOko7HBhphZpEaw2VZwEES3ESQRlcZCOuaplWT/cz3Zz+XD4rFLxKJGKIH4tEX5GVqYCY0MyBRLufKR43bBaYHL0UE7Jot1hKSwOenhLcYXXEGjhkQ5XLcCT19BCBk6QzFOkVIZtpadStiHJbFP1nDzy9kgdaGQwCEzbub91dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGCP4fEZSBT557aNx+HIvPwvAMxzco2cMMAeFdLSAC8=;
 b=JZucuXVZf8g3VOm10KPEoIHypTsdGewXb1VMVIr4/09q/Xpd3lYBOmpIwtJ+6D8wlGR1/BFukdcLK2VE6BOe/grg2jqBMbsFSof0FWmoz5Kx8SnhbjbFZgVmgPfPqrQl1tbmnJ92aEpM/LdggEcb0UtDeC6wbmj2feNVQc/qxHM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3094.eurprd08.prod.outlook.com (52.135.165.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 12:17:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 12:17:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeSaikAgAADVIA=
Date: Tue, 19 Nov 2019 12:17:49 +0000
Message-ID: <3b5a71bd-b247-fabe-824a-f0cde32deb13@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <20191119120552.GB5910@linux.fritz.box>
In-Reply-To: <20191119120552.GB5910@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::27) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191119151747608
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9f8434a-39c2-4aea-d4e7-08d76cea7e42
x-ms-traffictypediagnostic: AM6PR08MB3094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB30942BA2D99A203C964FDEE8C14C0@AM6PR08MB3094.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(396003)(39840400004)(136003)(53754006)(189003)(199004)(66946007)(476003)(2616005)(52116002)(6916009)(486006)(6246003)(14454004)(14444005)(256004)(76176011)(478600001)(446003)(36756003)(8676002)(107886003)(71200400001)(71190400001)(25786009)(6506007)(386003)(102836004)(4326008)(11346002)(26005)(305945005)(186003)(81166006)(81156014)(8936002)(7736002)(229853002)(6486002)(66066001)(3846002)(2906002)(6436002)(6116002)(6512007)(86362001)(5660300002)(66446008)(31696002)(31686004)(99286004)(316002)(54906003)(66476007)(64756008)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3094;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IkDwzXELPTrO6qaSoOVbT6alNoC1swkyxBh6shf+VxVtXFH8PWqS+FWfR018Cg3lbzHerExrFmAGPL4s45NOrp8wC9diQSPfGXxFl1Qko+JM/Suf8b3QU2n+zWRbeC+k5dg3zDJ2LybfhWZcIDpndlbgPiQl1kIBi6ZXuiTPKz4V1M7nFu4xJjPjj8qMHIRNTCU/0GewzYhN3fGpfraP/kJiZoIule7TdgRt/+jqPe204HqJ5urMHc11UTOWAzcFlxoLY//VxORZNlWO2hSFCm2E7HMtPS1f7lAjgWovkoxaDWp1udbrj6yhVidX3swHch5HDHjepoN7BwDZO8SqLouAI6EPyu2uZNlN3k+7ELKz5K/J/tFhMY4YePox4N2Z9vmBIdN3AOrQNpQxn/39t3IoAD8p3b9tfmax85KpOWMkQ9hZhFgRqUfUi7mJl8H2
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <27979DF48874CF48960380F41F6B9DAB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f8434a-39c2-4aea-d4e7-08d76cea7e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 12:17:49.4269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3a6nSnNN9zdZHWWP/IElEnpmV059U9zbz9rRsXhMeUVDCgBQIUWuNN0+F+/x/f+3Hmi6VNhuXMMjqtB0uR41+CsjBh1LiUDrYjUK3p5x8qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3094
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.114
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.11.2019 15:05, Kevin Wolf wrote:
> Am 16.11.2019 um 17:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Hi all!
>>
>> I wanted to understand, what is the real difference between
>> bdrv_block_status_above and bdrv_is_allocated_above, IMHO
>> bdrv_is_allocated_above should work through bdrv_block_status_above..
>>
>> And I found the problem: bdrv_is_allocated_above considers space after
>> EOF as UNALLOCATED for intermediate nodes..
>>
>> UNALLOCATED is not about allocation at fs level, but about should we
>> go to backing or not.. And it seems incorrect for me, as in case of
>> short backing file, we'll read zeroes after EOF, instead of going
>> further by backing chain.
>=20
> We actually have documentation what it means:
>=20
>   * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
>   *                       layer rather than any backing, set by block lay=
er
>=20
> Say we have a short overlay, like this:
>=20
> base.qcow2:     AAAAAAAA
> overlay.qcow2:  BBBB
>=20
> Then of course the content of block 5 (the one after EOF of
> overlay.qcow2) is still determined by overlay.qcow2, which can be easily
> verified by reading it from overlay.qcow2 (produces zeros) and from
> base.qcow2 (produces As).
>=20
> So the correct result when querying the block status of block 5 on
> overlay.qcow2 is BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO.
>=20
> Interestingly, we already fixed the opposite case (large overlay over
> short backing file) in commit e88ae2264d9 from May 2014 according to the
> same logic.
>=20
>> This leads to the following effect:
>>
>> ./qemu-img create -f qcow2 base.qcow2 2M
>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>>
>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>>
>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
>> read 1048576/1048576 bytes at offset 1048576
>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>>
>> But after commit guest visible state is changed, which seems wrong for m=
e:
>> ./qemu-img commit top.qcow2 -b mid.qcow2
>>
>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
>> Pattern verification failed at offset 1048576, 1048576 bytes
>> read 1048576/1048576 bytes at offset 1048576
>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>>
>> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
>> read 1048576/1048576 bytes at offset 1048576
>> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>>
>>
>> I don't know, is it a real bug, as I don't know, do we support backing
>> file larger than its parent. Still, I'm not sure that this behavior of
>> bdrv_is_allocated_above don't lead to other problems.
>=20
> I agree it's a bug.
>=20
> Your fix doesn't look right to me, though. You leave the buggy behaviour
> of bdrv_co_block_status() as it is and then add four patches to work
> around it in some (but not all) callers of it.
>=20
> All that it should take to fix this is making the bs->backing check
> independent from want_zero and let it set ALLOCATED. What I expected
> would be something like the below patch.
>=20
> But it doesn't seem to fully fix the problem (though 'alloc 1M 1M' in
> qemu-io shows that the range is now considered allocated), so probably
> there is still a separate bug in bdrv_is_allocated_above().
>=20
> And I think we'll want an iotests case for both cases (short overlay,
> short backing file).
>=20
> Kevin
>=20
>=20
> diff --git a/block/io.c b/block/io.c
> index f75777f5ea..5eafcff01a 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2359,16 +2359,17 @@ static int coroutine_fn bdrv_co_block_status(Bloc=
kDriverState *bs,
>  =20
>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>           ret |=3D BDRV_BLOCK_ALLOCATED;
> -    } else if (want_zero) {
> -        if (bdrv_unallocated_blocks_are_zero(bs)) {
> -            ret |=3D BDRV_BLOCK_ZERO;
> -        } else if (bs->backing) {
> -            BlockDriverState *bs2 =3D bs->backing->bs;
> -            int64_t size2 =3D bdrv_getlength(bs2);
> -
> -            if (size2 >=3D 0 && offset >=3D size2) {
> +    } else if (want_zero && bdrv_unallocated_blocks_are_zero(bs)) {
> +        ret |=3D BDRV_BLOCK_ZERO;
> +    } else if (bs->backing) {
> +        BlockDriverState *bs2 =3D bs->backing->bs;
> +        int64_t size2 =3D bdrv_getlength(bs2);
> +
> +        if (size2 >=3D 0 && offset >=3D size2) {
> +            if (want_zero) {
>                   ret |=3D BDRV_BLOCK_ZERO;
>               }
> +            ret |=3D BDRV_BLOCK_ALLOCATED;

No, I think it's wrong, as it's not allocated at bs, but at bs->backing->bs=
.


So, bdrv_co_block_status works correct, what we can change about it, is not
to return pnum=3D0 if requested range after eof, but return pnum=3Dbytes, t=
ogether
with BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO | BDRV_BLOCK_EOF.

And actual problem is in bdrv_block_status_above and bdrv_is_allocated_abov=
e, which
I'm fixing.



--=20
Best regards,
Vladimir

