Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8DC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E88621741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z/hX/BYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E88621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PCJ-0008RE-7E
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 07:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0PBb-0007vV-Rl
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0PBZ-0005Ui-C9
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:26:11 -0500
Received: from mail-eopbgr60112.outbound.protection.outlook.com
 ([40.107.6.112]:2694 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j0PBX-00051R-OC; Sat, 08 Feb 2020 07:26:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2r6LqrC4ypg9aR4lrwgiSqSKcUHrww0cGmyghFUYJoZBVqwrZTzX704FIxMKMF9x+r5P8oOwArRIM6TmL0jGJcbA2FZwqxuqqznZ5xPD/eOJk+aK3wP70Ck3z5xzVu3TDpl3omuBB4VejwZyI/EBPCzjF/61UdQN+WFgVtNsGSGEbg+KnR3jifPhamO6VeGRnhJF6tnlgD8SRcZBxL/vmkxaSJhRJ1iyOcmKN6FjGrzyMUlHaQB5Wcjx7we7F6ao+DJzfcGNzygJI5jGUcfsxAxtO0Y3Cq2QhfYB9vsWnAWYRWFs2/3wjWeRPeqQ7FvPioCbVIQHfbBRpWCVagilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMMrYNeIQFhM9oaa0Otdscsv7BM8dktmE0n5UCjBIDg=;
 b=jAMA7ugrt9mCLp2bJEaOtbX+haHjlBg+GVjZ8MUtd3nOXIct9tA0LpL+saahQXVaXtRLrnf0iLXMB/czAGQpN6XMqSiYFJxJis2lBYAMPaE8YP6ItlApbo5rUbrFBZ3JAFngGkDYQiPC+Umt9H4bQLGtLKVrijRm+2l4abJB4oY2ylLBAoX/ZzN/3iEG2FZoylUXsgqucYoN3MWbHUVPBRK2J1+eqMdViDAobO7wETwL+BR/74FBkGQsuqbYDWN/pEt0H7fwKyYI0VypP7YJmYJWdR/6Bq6rUEu5R6bNzLBHJZnKjpPO9AgiNm/HsqKwp5y2W68Vj15+wd5n0u/j6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMMrYNeIQFhM9oaa0Otdscsv7BM8dktmE0n5UCjBIDg=;
 b=Z/hX/BYX9KkdKVjHK22ruFNhEcts8cNhnTHolNxHbZ0hU4XwAMSQMT8Vy/4eOx5DF4ZzxDj8/6BhmpbvTwk+cFh0bRBrzpfqAj05QDqIEveTsOzZ2L0X1Gi5lAFuU88a0XeBhaOccEkuS8XmZDDjomNQPNsdmEqfh5eGl66R8ag=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4422.eurprd08.prod.outlook.com (20.179.7.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Sat, 8 Feb 2020 12:25:59 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.024; Sat, 8 Feb 2020
 12:25:59 +0000
Subject: Re: [PATCH v2 2/7] block/block-copy: use block_status
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-3-vsementsov@virtuozzo.com>
 <81ce033a-2ac9-21b6-4649-48df61d41797@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200208152556823
Message-ID: <e6a5a095-78f3-faf1-6eaa-68843b41c490@virtuozzo.com>
Date: Sat, 8 Feb 2020 15:25:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <81ce033a-2ac9-21b6-4649-48df61d41797@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::30)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34 via Frontend Transport; Sat, 8 Feb 2020 12:25:58 +0000
X-Tagtoolbar-Keys: D20200208152556823
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dec130f2-d4ed-4cdc-6ffc-08d7ac920dc9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4422:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44223B36637FC7845A8D5942C11F0@AM6PR08MB4422.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39850400004)(376002)(396003)(366004)(199004)(189003)(66946007)(66556008)(66476007)(36756003)(5660300002)(4326008)(107886003)(31686004)(6486002)(316002)(16576012)(478600001)(8936002)(81166006)(81156014)(8676002)(31696002)(26005)(53546011)(52116002)(186003)(86362001)(16526019)(956004)(2616005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4422;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIIUtmuU9v4Cj/OA5VY0h5lPhSvsSPNZIJfObfvnPHH4YUUmkIL7efMWWQwbN4oU54v0jKvIKxo5G1aa8KDHEQqfbQS7swreeDsDNFn+dVksd4y+cD/MZwk06TJL/Tf0KeyOPzedVfV9BdAPRXzS1oUH07NQXJ2nNCkeg42kI0ANoQ9XHgz5VMAuyWO3RMtJs8RqY6kcdUXkyDRqBDVZIrMPjBoBBZizwDjva/cH/CWUQi+lnlSUykGx9Kte+Sz9GketYk+qqqfbL/v45/kU2x4wlqkgKsXox5oTHPbTYNr9ZuaV72mb7rV8f/oiMZVBjEzJYfpe9ndifGxCb28N2qw55hm6EU0DxDD3I6QTrWYCW42pD/vMWNuPzlkmLHuZDsUU7gNU49Yix6yldq/AzzIxQnoMTG7BeInvpxh9sCPC385KKkK779aGfDBs6RGt
X-MS-Exchange-AntiSpam-MessageData: H2cjsMGJgJ7R5nctHtOwyEHCZzvGlQydTJzpQ3FyYPWDWUbu2n1099fFkd+wAbuEAscyW02YcZCW2NsMuawVLzxG6KZLV5xmze9+Hoz0PmCtKgfv0eAMRAqAbf3hFyeR0DjsTRvJdvLWBAbPucff0A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec130f2-d4ed-4cdc-6ffc-08d7ac920dc9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 12:25:59.4521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: az8c7gEvs6Yi4oBW5NJuzRHuFZ2ak1xfcxOzoTEnVbEOP3pt/hnyqsHO4vMGqVS/grlreSw6MMLombGo182A8RY2QH6H7mb8UKPFnmV7I+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4422
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.112
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.02.2020 20:46, Max Reitz wrote:
> On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
>> Use bdrv_block_status_above to chose effective chunk size and to handle
>> zeroes effectively.
>>
>> This substitutes checking for just being allocated or not, and drops
>> old code path for it. Assistance by backup job is dropped too, as
>> caching block-status information is more difficult than just caching
>> is-allocated information in our dirty bitmap, and backup job is not
>> good place for this caching anyway.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/block-copy.c | 67 +++++++++++++++++++++++++++++++++++++---------
>>   block/trace-events |  1 +
>>   2 files changed, 55 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 8602e2cae7..74295d93d5 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>=20
> [...]
>=20
>> @@ -336,23 +375,25 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>               chunk_end =3D next_zero;
>>           }
>>  =20
>> -        if (s->skip_unallocated) {
>> -            ret =3D block_copy_reset_unallocated(s, start, &status_byte=
s);
>> -            if (ret =3D=3D 0) {
>> -                trace_block_copy_skip_range(s, start, status_bytes);
>> -                start +=3D status_bytes;
>> -                continue;
>> -            }
>> -            /* Clamp to known allocated region */
>> -            chunk_end =3D MIN(chunk_end, start + status_bytes);
>> +        ret =3D block_copy_block_status(s, start, chunk_end - start,
>> +                                      &status_bytes);
>> +        if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
>> +            bdrv_reset_dirty_bitmap(s->copy_bitmap, start, status_bytes=
);
>> +            s->progress_reset_callback(s->progress_opaque);
>> +            trace_block_copy_skip_range(s, start, status_bytes);
>> +            start +=3D status_bytes;
>> +            continue;
>>           }
>>  =20
>> +        chunk_end =3D MIN(chunk_end, start + status_bytes);
>=20
> I=92m not sure how much the old =93Clamp to known allocated region=94 act=
ually
> helps, but I wouldn=92t drop it anyway.

But it may be not allocated now. We just clamp to status_bytes.
It's "known allocated" only if s->skip_unallocated is true.

>=20
> Apart from this nit, the patch looks good to me.
>=20
> Max
>=20


--=20
Best regards,
Vladimir

