Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDCBC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4222F206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HNQ1aeml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4222F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJe4e-0006q9-B7
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJe3o-0005ru-LI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJe3m-0005E9-I0
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:09:39 -0400
Received: from mail-db8eur05on2131.outbound.protection.outlook.com
 ([40.107.20.131]:15156 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJe3l-0005C2-RI; Wed, 01 Apr 2020 10:09:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y20cG3NJ5C7MHVEVhTzKJw/o9rutaMqOC9TTTghUv347NHhv69R8CxKTs/vqghB3M6+XmHlP/fCHCE5TfFLJA3U09rEIB9Hnr9H325D2xQD4tK7K2uhBHZB/JU8jXU6ESsxwWgL+p+vrplnm9L+VfmRKzjraEapLA6cU8/+eWUnGywM9EUcCe8WXdqEBi/mdK0gQe3r8e5SWoMDaCR1jTxEV/KIJpjclXZVeI3wqNfzSDkliUEB35s1MJuT4YT/ecRhbayppC39fFpqVm/HqkNg0qtreuF0ag2i6Z2DO4bfgYGwariJv7MRlaMG/B/S+fbZdsXCztxS6CboiNe+LHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F3hue5a8ZseXn4D891+UL5oQNLi5tT8bn1SRXQgsxQ=;
 b=nv0iL85JJzfl4gqsdaCMFZ2G3PvLUwNpTGfQskbgPX3IozITO/pHBRsSuh9+kmSZ7OQoIrSLVDTG/CAmPlL6gBPzFs3AK8+km1Egiu4jkCx0ATpwu9suzeUHLf+86Wj1DcMHcYQggHOiKjH1rujuoE6rUPGLs/AJO3Uw2IDm+JfyahOB0ukQgz3Vl8en4x57kAp5i1gldPsp9fAyWR3+dtt43JPQQ6qArdrhoBPUxxkTJNMTBhygQXifsgHYRrN1ns9xc2h/shz4w5vQutwgCfeCQIBnsd9rjo8Pq45r63Q02qL7xFDjLOjkPpo8DRnrJNfFMJPWWiaz984T40IgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F3hue5a8ZseXn4D891+UL5oQNLi5tT8bn1SRXQgsxQ=;
 b=HNQ1aemlBswGhKmAAe7TYo1rdlrjGz02S2/783Oz2EVNmilrbKc2O0UlZQuwSKohUa86mpWb45AnN1zu+7LfBCKukv9j88nVhre2TTIN0pFSnEmXk7O59s8l6hPB9hMPBI2HB/XcLZiyeh1FaSDwVkaktiw7PRYTOlYArktl30U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Wed, 1 Apr 2020 14:09:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 14:09:34 +0000
Subject: Re: [PATCH 3/5] block: add max_pwrite_zeroes_no_fallback to
 BlockLimits
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-4-vsementsov@virtuozzo.com>
 <422e0c60-4423-b474-0836-3ea8997c90da@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401170933216
Message-ID: <802b242a-d368-214f-a00b-2b240bafa801@virtuozzo.com>
Date: Wed, 1 Apr 2020 17:09:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <422e0c60-4423-b474-0836-3ea8997c90da@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR06CA0027.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR06CA0027.eurprd06.prod.outlook.com (2603:10a6:208:ab::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 14:09:34 +0000
X-Tagtoolbar-Keys: D20200401170933216
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6876ca4-9519-4ade-c78a-08d7d6464e59
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5494F300C2C5C1859374BD0DC1C90@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(366004)(39840400004)(346002)(396003)(136003)(66476007)(31686004)(16576012)(316002)(81156014)(8676002)(8936002)(2616005)(81166006)(36756003)(956004)(52116002)(6486002)(86362001)(31696002)(66946007)(2906002)(66556008)(16526019)(5660300002)(26005)(107886003)(186003)(478600001)(4326008)(53546011);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRuIqsRMfJK4q7kjSxUOxXJ9cOeR7zi9qCDko1mwbWfuPx2LhqSiWvl0r74mCzaD2TE1GSEr2OLijwNuoinxHH+wJtGVJG4BpR8AG8GZA4dSUVgH+7BMUS9cXxFWg69V435fGgXZzSGsWyJ+eMc6pZwKBoPJ4ZoY6WVwAdKXqLReH6/k1oMyocpOrPfb56oRts4iX6s9Anqrt7yo4vpsVnxHSl0uT0V7VISHIlkkWEAl0FUP8ncSWtH9qSMDnngHhBWYbvHsCn5dhra8lsOxL+62FuL4AQPnRoZWSH2DxIG1EJ6ofEXkpaTINJvfMaJOsDlGIE7mSb7X63QqD0gOJyR7IR5N6fYeIa1hnOXcJMvRfgqbEVouyXQQ5rzQA/OE8AXA60c0LREEwdOrgWKlOuqj3SkAyqz3m+LFJ3BsTbSC1LZX7FURAEcCRdbZxRR0
X-MS-Exchange-AntiSpam-MessageData: sL/x9sB6zJIEDSS9DfBBzYCm4f2U5/kKUL5io7HBYYndx5rnbGCxH1mBGeSZMbveT9wcFbH3CzXrLHqe90OJ+0uUftDJeaudpfz6nmJwEFl0mPR9hUEVGr1mkGnykJE0oGcE20ILZXDrx8kZFOkAgQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6876ca4-9519-4ade-c78a-08d7d6464e59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 14:09:34.8816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9XbGOAuwUeRl8ZkwNs9wQHAWr+J+dwLYYnwd0k5di6j+XBQDLaSpcLCK6tq52v5FzeaYTjaX/L7dve8vdJ8ZpcY7gvvj+2XjvWmbc4pR94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.131
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.03.2020 0:07, Eric Blake wrote:
> On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>> NBD spec is updated, so that max_block doesn't relate to
>=20
> Maybe: The NBD spec was recently updated to clarify that max_block...
>=20
>> NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which mirrors Qemu
>> flag BDRV_REQ_NO_FALLBACK). To drop the restriction we need new
>> max_pwrite_zeroes_no_fallback.
>=20
> It feels odd to have two different pwrite_zeroes limits in the block laye=
r, but I can live with it if other block layer gurus are also okay with it.
>=20
>>
>> Default value of new max_pwrite_zeroes_no_fallback is zero and it means
>> no-restriction, so we are automatically done by this commit. Note that
>=20
> Why not have the default value be set to the existing value of the normal=
 pwrite_zeroes limit, rather than 0?

Hm I agree, that it's better to keep safer default.

>=20
>> nbd and blkdebug are the only drivers which in the same time define
>> max_pwrite_zeroes limit and support BDRV_REQ_NO_FALLBACK, so we need to
>> update only blkdebug.
>=20
> Grammar:
>=20
> The default value for the new max_pwrite_zeroes_no_fallback is zero, mean=
ing no restriction, which covers all drivers not touched by this commit.=A0=
 Note that nbd and blkdebug are the only drivers which have a max_pwrite_ze=
roes limit while supporting BDRV_REQ_NO_FALLBACK, so we only need to update=
 blkdebug.
>=20
> Except that I think there IS still a limit in current NBD: you can't requ=
est anything larger than 32 bits (whereas some other drivers may allow a fu=
ll 63-bit request, as well as future NBD usage when we finally add 64-bit e=
xtensions to the protocol).=A0 So I think this patch is incomplete; it shou=
ld be updating the nbd code to set the proper limit.
>=20
> (I still need to post v2 of my patches for bdrv_co_make_zero support, whi=
ch is a case where knowing if there is a 32-bit limit when using BDRV_REQ_N=
O_FALLBACK for fast zeroing is important).
>=20
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 include/block/block_int.h | 8 ++++++++
>> =A0 block/blkdebug.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 7 ++++++-
>> =A0 block/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 4 +++-
>> =A0 3 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 6f9fd5e20e..c167e887c6 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -618,6 +618,14 @@ typedef struct BlockLimits {
>> =A0=A0=A0=A0=A0=A0 * pwrite_zeroes_alignment. May be 0 if no inherent 32=
-bit limit */
>> =A0=A0=A0=A0=A0 int32_t max_pwrite_zeroes;
>> +=A0=A0=A0 /*
>> +=A0=A0=A0=A0 * Maximum number of bytes that can zeroized at once if fla=
g
>=20
> zeroed
>=20
>> +=A0=A0=A0=A0 * BDRV_REQ_NO_FALLBACK specified (since it is signed, it m=
ust be < 2G, if
>> +=A0=A0=A0=A0 * set).
>=20
> Why must it be a signed 32-bit number?=A0 Why not let it be a 64-bit numb=
er?
>=20
>> Must be multiple of pwrite_zeroes_alignment. May be 0 if no
>> +=A0=A0=A0=A0 * inherent 32-bit limit.
>> +=A0=A0=A0=A0 */
>> +=A0=A0=A0 int32_t max_pwrite_zeroes_no_fallback;
>> +
>> =A0=A0=A0=A0=A0 /* Optimal alignment for write zeroes requests in bytes.=
 A power
>> =A0=A0=A0=A0=A0=A0 * of 2 is best but not mandatory.=A0 Must be a multip=
le of
>> =A0=A0=A0=A0=A0=A0 * bl.request_alignment, and must be less than max_pwr=
ite_zeroes
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index af44aa973f..7627fbcb3b 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -692,7 +692,11 @@ static int coroutine_fn blkdebug_co_pwrite_zeroes(B=
lockDriverState *bs,
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 assert(QEMU_IS_ALIGNED(offset, align));
>> =A0=A0=A0=A0=A0 assert(QEMU_IS_ALIGNED(bytes, align));
>> -=A0=A0=A0 if (bs->bl.max_pwrite_zeroes) {
>> +=A0=A0=A0 if ((flags & BDRV_REQ_NO_FALLBACK) &&
>> +=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_no_fallback)
>> +=A0=A0=A0 {
>> +=A0=A0=A0=A0=A0=A0=A0 assert(bytes <=3D bs->bl.max_pwrite_zeroes_no_fal=
lback);
>> +=A0=A0=A0 } else if (bs->bl.max_pwrite_zeroes) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 assert(bytes <=3D bs->bl.max_pwrite_zeroes);
>> =A0=A0=A0=A0=A0 }
>> @@ -977,6 +981,7 @@ static void blkdebug_refresh_limits(BlockDriverState=
 *bs, Error **errp)
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 if (s->max_write_zero) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes =3D s->max_write_ze=
ro;
>> +=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_no_fallback =3D s->max_w=
rite_zero;
>=20
> Ah, so you DO default it to max_pwwrite_zeroes instead of to 0; the commi=
t message does not quite match the code.

In this patch it's only for blkdebug. But I'm going to change the default a=
s you proposed.

>=20
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 if (s->opt_discard) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.pdiscard_alignment =3D s->opt_discard=
;
>> diff --git a/block/io.c b/block/io.c
>> index 7e4cb74cf4..75fd5600c2 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1752,7 +1752,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(B=
lockDriverState *bs,
>> =A0=A0=A0=A0=A0 int head =3D 0;
>> =A0=A0=A0=A0=A0 int tail =3D 0;
>> -=A0=A0=A0 int max_write_zeroes =3D MIN_NON_ZERO(bs->bl.max_pwrite_zeroe=
s, INT_MAX);
>> +=A0=A0=A0 int max_write_zeroes =3D MIN_NON_ZERO((flags & BDRV_REQ_NO_FA=
LLBACK) ?
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_n=
o_fallback :
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes, =
INT_MAX);
>=20
> I'd still like to get rid of this INT_MAX clamping.=A0 If we can blank th=
e entire image in one call, even when it is larger than 4G, then it is wort=
h making that exposed to the user.=A0 (Even in NBD, we might decide to add =
an extension that allows NBD_CMD_WRITE_ZEROES with a new flag and with offs=
et/length =3D=3D 0/0, as an official way to make the entire image zero, whe=
reas it is now currently unspecified to pass a length of 0).

We can't get rid of it now, just because write_zero driver handler has int =
argument. So, I'm going to convert block-layer to int64_t-everywhere, but d=
o it in separate series.

>=20
>> =A0=A0=A0=A0=A0 int alignment =3D MAX(bs->bl.pwrite_zeroes_alignment,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 bs->bl.request_alignment);
>> =A0=A0=A0=A0=A0 int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer, M=
AX_BOUNCE_BUFFER);
>>
>=20


--=20
Best regards,
Vladimir

