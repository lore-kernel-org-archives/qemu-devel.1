Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F6FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9AF20748
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NJdlN/MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9AF20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJAmY-0007JV-Ej
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 02:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJAlO-0006ok-Tb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJAlM-0006pf-KC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:52:42 -0400
Received: from mail-eopbgr60115.outbound.protection.outlook.com
 ([40.107.6.115]:55383 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJAlL-0006p2-QQ; Tue, 31 Mar 2020 02:52:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp+E0Goviz2PvNNt1UtlKKPBvaJTraCqQPNCDhEPWM/QlJC4eqUrKv/CIsgj2WWorYEYjOKJ+ASBoH3Qc96jwItWe9anmFm120GUD0g4pH6C6mbs+Dqx/JJmGwllLoXfT0qpLapqR4N2qbHdbDVKxss7BYZm8PCOnTGuACC8oaQLvYG0K7Lhpwh/PcsXkzvMN12JpDfGC0CGPN2a57rOXqGQr3BGqVeMk+KVauZe1GgOWm59kE2oMiK4fU6J5IluwZ3B00GUWQpT8jIJEvpmQwt5TVc/yP9q2J2RceiPu5c0AYV96ufqPuH0ZYzWSV7GsuV0r3S4hA6ziQhELwIrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkHKH3/jOGTUN0Cp/kRoNISuD2NOp5cY32M30K5xCyQ=;
 b=n96iI9cfZe+8pu9+eEih2gz5o5rTO3Dbb7qp54rDpJeok71emN5eFLAVrGpMGNrylNtbIiXb89OOJyzmaR6mjhMMZd/B38CVkl00z1fBn67qlc8Ex6JV3b2iIUatTzfPMn6wJzaMo0k93D9CkIpIFnYzYmcYWh2iwhu+I+RIopbwby+UbW34faNcqfDOwPKGvl/TvayyL3watvzM2ZcpY33DCNPuJxpb1DviFPxEG1yzvGMCc48ZdBFhcakODkoKFdueCa4nYn+3EHreJdkpEXxt0las6mmFf4keD3MjUBeDUnMVkjvu923xqwcXRD/M73xZeo2s9escGm6sqWVSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkHKH3/jOGTUN0Cp/kRoNISuD2NOp5cY32M30K5xCyQ=;
 b=NJdlN/MOyKm/JQx7ZqPHqzJJD6ToJGqYjRKVpJziwy1MViCuYLW2TQJxEdGkBsXWyXEDmr0edepphR4wRXrXwhxBBk9cyFLnaO1hHXamGxy3EaE4GO4Q3pSAtytO0/eQOMDiTilVNz/TsCMuxGK4Qj70kOURJnrQ0wvoGIo81xo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5478.eurprd08.prod.outlook.com (10.141.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Tue, 31 Mar 2020 06:52:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 06:52:37 +0000
Subject: Re: [PATCH 3/5] block: add max_pwrite_zeroes_no_fallback to
 BlockLimits
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-4-vsementsov@virtuozzo.com>
 <422e0c60-4423-b474-0836-3ea8997c90da@redhat.com>
 <7c2161f9-d902-97dc-cb43-d6a10f573996@virtuozzo.com>
X-Tagtoolbar-Keys: D20200331095235543
Message-ID: <d541f110-574e-36fe-a69a-8c5c55ac7e08@virtuozzo.com>
Date: Tue, 31 Mar 2020 09:52:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <7c2161f9-d902-97dc-cb43-d6a10f573996@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.2) by
 AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Tue, 31 Mar 2020 06:52:36 +0000
X-Tagtoolbar-Keys: D20200331095235543
X-Originating-IP: [185.215.60.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b38dafe-a99d-4c1f-cf82-08d7d54018fc
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478D9BC0820D09AD1A1F610C1C80@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(396003)(366004)(136003)(376002)(346002)(26005)(66476007)(316002)(2616005)(956004)(5660300002)(53546011)(8676002)(107886003)(8936002)(31696002)(4326008)(86362001)(66556008)(2906002)(6486002)(16576012)(478600001)(66946007)(52116002)(81156014)(36756003)(31686004)(16526019)(186003)(81166006);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8leK0TZxn1LG+qGnHX3+eauMTRL8NNzEsu6gRMPoDoeOMQB7Io+/5j8fpSJ4vj/r9nkGxHlm5BrqDJuNqAFduUkIhuRBM/+td2AT57Beh0mZXuAghejeXJoDQv+4WxOzp7NIZyU0xWvJQ3ohDEjO9LDKaI1mrZDFICRK+9PwzyGV6xmW5VTHiCGHaeZ9JJCzwIVG8LuuFAO2u/J2KzoK228gUL3omxsVKQbZzVY5AqJAYaGSgqrWjB9HJafw29xp6Kvx4Cn9GrWg0wVJfDOIudFLLBu26fg7MpUkY/VKnfG+LzsfGEfxDOS/7s0EwG7pqy+A3FpVIYEpCSWBNeV4qMeBgnBYeUHxAT3XwOTO5iPhEVdBQwtFwhVNJ6PWf1hQYYg4D3byvgXwn1zWDO7jyy4VbrpsTLaHnw93l2Gh9OMAcTafLlUv6YtDtFTOWX8
X-MS-Exchange-AntiSpam-MessageData: vLB+nRfEDHxtbKusJsNX1+/LxDtkSG4YKni2kFmJ75k23EskBOzKpsGzk4giDQ2zMb3xacZS24cweA9hFlmjtUhQ0v0rT7vUsqg+7lmFszNU+a+bx+l04EZ4Jry77enrkwroarhe67yKi50gK783Og==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b38dafe-a99d-4c1f-cf82-08d7d54018fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 06:52:37.1901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Alcwv4pZ80LxWSkn1zUXEwbXgqCjw8cGgpfkgeNgRcA1kgJ5gAMKUMTT9DY+oGKJW6p20KBOiXtuFHQ6zqsgRrH78cAFwPTv9YNN+F/L+7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.115
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

24.03.2020 11:32, Vladimir Sementsov-Ogievskiy wrote:
> 14.03.2020 0:07, Eric Blake wrote:
>> On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> NBD spec is updated, so that max_block doesn't relate to
>>
>> Maybe: The NBD spec was recently updated to clarify that max_block...
>>
>>> NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which mirrors Qemu
>>> flag BDRV_REQ_NO_FALLBACK). To drop the restriction we need new
>>> max_pwrite_zeroes_no_fallback.
>>
>> It feels odd to have two different pwrite_zeroes limits in the block lay=
er, but I can live with it if other block layer gurus are also okay with it=
.
>>
>>>
>>> Default value of new max_pwrite_zeroes_no_fallback is zero and it means
>>> no-restriction, so we are automatically done by this commit. Note that
>>
>> Why not have the default value be set to the existing value of the norma=
l pwrite_zeroes limit, rather than 0?
>>
>>> nbd and blkdebug are the only drivers which in the same time define
>>> max_pwrite_zeroes limit and support BDRV_REQ_NO_FALLBACK, so we need to
>>> update only blkdebug.
>>
>> Grammar:
>>
>> The default value for the new max_pwrite_zeroes_no_fallback is zero, mea=
ning no restriction, which covers all drivers not touched by this commit.=
=A0 Note that nbd and blkdebug are the only drivers which have a max_pwrite=
_zeroes limit while supporting BDRV_REQ_NO_FALLBACK, so we only need to upd=
ate blkdebug.
>>
>> Except that I think there IS still a limit in current NBD: you can't req=
uest anything larger than 32 bits (whereas some other drivers may allow a f=
ull 63-bit request, as well as future NBD usage when we finally add 64-bit =
extensions to the protocol).=A0 So I think this patch is incomplete; it sho=
uld be updating the nbd code to set the proper limit.
>>
>> (I still need to post v2 of my patches for bdrv_co_make_zero support, wh=
ich is a case where knowing if there is a 32-bit limit when using BDRV_REQ_=
NO_FALLBACK for fast zeroing is important).
>>
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =A0 include/block/block_int.h | 8 ++++++++
>>> =A0 block/blkdebug.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 7 ++++++-
>>> =A0 block/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 4 +++-
>>> =A0 3 files changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index 6f9fd5e20e..c167e887c6 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -618,6 +618,14 @@ typedef struct BlockLimits {
>>> =A0=A0=A0=A0=A0=A0 * pwrite_zeroes_alignment. May be 0 if no inherent 3=
2-bit limit */
>>> =A0=A0=A0=A0=A0 int32_t max_pwrite_zeroes;
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * Maximum number of bytes that can zeroized at once if fl=
ag
>>
>> zeroed
>>
>>> +=A0=A0=A0=A0 * BDRV_REQ_NO_FALLBACK specified (since it is signed, it =
must be < 2G, if
>>> +=A0=A0=A0=A0 * set).
>>
>> Why must it be a signed 32-bit number?=A0 Why not let it be a 64-bit num=
ber?
>>
>>> Must be multiple of pwrite_zeroes_alignment. May be 0 if no
>>> +=A0=A0=A0=A0 * inherent 32-bit limit.
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 int32_t max_pwrite_zeroes_no_fallback;
>>> +
>>> =A0=A0=A0=A0=A0 /* Optimal alignment for write zeroes requests in bytes=
. A power
>>> =A0=A0=A0=A0=A0=A0 * of 2 is best but not mandatory.=A0 Must be a multi=
ple of
>>> =A0=A0=A0=A0=A0=A0 * bl.request_alignment, and must be less than max_pw=
rite_zeroes
>>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>>> index af44aa973f..7627fbcb3b 100644
>>> --- a/block/blkdebug.c
>>> +++ b/block/blkdebug.c
>>> @@ -692,7 +692,11 @@ static int coroutine_fn blkdebug_co_pwrite_zeroes(=
BlockDriverState *bs,
>>> =A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0 assert(QEMU_IS_ALIGNED(offset, align));
>>> =A0=A0=A0=A0=A0 assert(QEMU_IS_ALIGNED(bytes, align));
>>> -=A0=A0=A0 if (bs->bl.max_pwrite_zeroes) {
>>> +=A0=A0=A0 if ((flags & BDRV_REQ_NO_FALLBACK) &&
>>> +=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_no_fallback)
>>> +=A0=A0=A0 {
>>> +=A0=A0=A0=A0=A0=A0=A0 assert(bytes <=3D bs->bl.max_pwrite_zeroes_no_fa=
llback);
>>> +=A0=A0=A0 } else if (bs->bl.max_pwrite_zeroes) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 assert(bytes <=3D bs->bl.max_pwrite_zeroes)=
;
>>> =A0=A0=A0=A0=A0 }
>>> @@ -977,6 +981,7 @@ static void blkdebug_refresh_limits(BlockDriverStat=
e *bs, Error **errp)
>>> =A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0 if (s->max_write_zero) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes =3D s->max_write_z=
ero;
>>> +=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_no_fallback =3D s->max_=
write_zero;
>>
>> Ah, so you DO default it to max_pwwrite_zeroes instead of to 0; the comm=
it message does not quite match the code.
>>
>>> =A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0 if (s->opt_discard) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.pdiscard_alignment =3D s->opt_discar=
d;
>>> diff --git a/block/io.c b/block/io.c
>>> index 7e4cb74cf4..75fd5600c2 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -1752,7 +1752,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(=
BlockDriverState *bs,
>>> =A0=A0=A0=A0=A0 int head =3D 0;
>>> =A0=A0=A0=A0=A0 int tail =3D 0;
>>> -=A0=A0=A0 int max_write_zeroes =3D MIN_NON_ZERO(bs->bl.max_pwrite_zero=
es, INT_MAX);
>>> +=A0=A0=A0 int max_write_zeroes =3D MIN_NON_ZERO((flags & BDRV_REQ_NO_F=
ALLBACK) ?
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_n=
o_fallback :
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes, =
INT_MAX);
>>
>> I'd still like to get rid of this INT_MAX clamping.=A0 If we can blank t=
he entire image in one call, even when it is larger than 4G, then it is wor=
th making that exposed to the user.=A0 (Even in NBD, we might decide to add=
 an extension that allows NBD_CMD_WRITE_ZEROES with a new flag and with off=
set/length =3D=3D 0/0, as an official way to make the entire image zero, wh=
ereas it is now currently unspecified to pass a length of 0).
>>
>=20
> Hmm. This series is kind of hacking. Now, 5.0 is missed anyway, I think, =
I'll prepare something more complete. It would be good to prepare generic b=
lock layer for 64bit commands.

I've started: "[RFC 0/3] 64bit block-layer part I". But I now see that it's=
 not simple thing to convert the block-layer, so it probably will not be fa=
st, and better not force the dependency between the series. So, I'll handle=
 your comments and resend this series in separate and will try to keep it p=
arallel.

>=20
>>> =A0=A0=A0=A0=A0 int alignment =3D MAX(bs->bl.pwrite_zeroes_alignment,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 bs->bl.request_alignment);
>>> =A0=A0=A0=A0=A0 int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer, =
MAX_BOUNCE_BUFFER);
>>>
>>
>=20
>=20


--=20
Best regards,
Vladimir

