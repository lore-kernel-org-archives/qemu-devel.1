Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046E2C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C314821741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WhQqZpj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C314821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izMBd-00052x-W9
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izM90-0002M9-Bn
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izM8y-0006cd-OL
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:59:10 -0500
Received: from mail-vi1eur05on2070e.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::70e]:7648
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izM8s-0006ID-Ka; Wed, 05 Feb 2020 09:59:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNkkl9P6P0L8S6rbSis28OGF3srdi3uzjPKKECJLTBsbj5uaFED1dWyfTz3DsqcA7zchiomwUa9RqbqWpycx+CKERmqf2LpAtsFYaPsgQSLWSrRLbufIWVxrske2L0RPsroDysxlNhQfxlsUvg5vZoBBaxIjlsujS70BO7ureP3Fibyxuncqq84jkwwx2jo/nOIIpvshY25AtHGtdyPl7651V0qnz1jsMGyoToNo71gPeIHMYe6DRWpsdbt6JJxFFXeB1U4uB9sYY7k6Nwn7ACG+7f1YGjsKoQ86zIs3Ubfu7TqrD5hp1KY8rrr8Wt+syMlqKubFyn9Ckvzpg3UQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9r1rZsYJXrox6BhivjGzVbfhR7Ep83cYc1xQdEILaM=;
 b=ne3UWP7UxJ1n/jW2m7V/1ISrzJepkAY/CIa/2W2UMVp28zJ1k3E9pOB/LYrBDiLCNAqh78NrdnauKfU0wMPad7oFLt6glAFX8PCVR0QYMnH8PvrrVo1d++KzpSNiM/U6+U+D8jIYEE6qmwFezqpImKXUIO7KLM9pd6SZhtmWp4g4EKYdau53uKKYb7x7ngzG4w9dJ3maJjFMxt7YW6GKqKahakeRRuMqbzJ/64SAeeHGYChK4riJyNycjhnKVwEnbU2ndetw/cOIZJIvHjlgE53heFRqGgt13vJRjW4yZP4LZObRgolljfbZZlt60OxgvbRsLk76qjZc/MNVC2rgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9r1rZsYJXrox6BhivjGzVbfhR7Ep83cYc1xQdEILaM=;
 b=WhQqZpj3L1uWYUrFRUALUMOPly0/5vT1h2+upMiLpXD7+X26BxPn2d/l6GfpZXrWlvxD8WovPlrqQoJ1Ua7Un0lzRYV89AqlF8vVzyNaIjypniRd8PCNsjz8H7Q698i95W5t0K2omKV3r7l7q/qgWitI0ZGT9sRo9P69WAs0YsE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3584.eurprd08.prod.outlook.com (20.177.62.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 14:58:59 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 14:58:59 +0000
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
 <9f2d8730-23ca-f070-52dd-0cbcbb08913b@redhat.com>
 <c7ff64b0-2916-aa51-f655-44adccee40e2@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205175857111
Message-ID: <944de4cd-a279-17aa-16f4-bbd44e707ea4@virtuozzo.com>
Date: Wed, 5 Feb 2020 17:58:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <c7ff64b0-2916-aa51-f655-44adccee40e2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:7:67::30) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:7:67::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.12 via Frontend Transport; Wed, 5 Feb 2020 14:58:58 +0000
X-Tagtoolbar-Keys: D20200205175857111
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf66c582-c457-4223-38fd-08d7aa4bee46
X-MS-TrafficTypeDiagnostic: VI1PR08MB3584:
X-Microsoft-Antispam-PRVS: <VI1PR08MB358464DB75D1599775ABEE70C1020@VI1PR08MB3584.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(136003)(346002)(376002)(366004)(189003)(199004)(66476007)(53546011)(2906002)(5660300002)(31696002)(966005)(478600001)(31686004)(86362001)(66946007)(26005)(186003)(16526019)(66556008)(956004)(2616005)(316002)(16576012)(6486002)(52116002)(36756003)(8676002)(81156014)(81166006)(8936002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3584;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzCRYygsSXObmsDenUUYdmIY9vaJPI7/2vIM17v4jwo1vOmar5V+kSNiNcGl9sCpYyifJysio2pxrk3gDYbMlpjUD64IcdLtdTMeJ1otX25bEi6T3BcBS9B7Kvqjh4XRP735jikfRxvPS8h5a8w/hix+TAnSy8E0fBwBlsI19TZIXUCEU2BJt2MEhWB/uIDpGU6hiPk8j4qD2VFt0N5kjbr7FVlRs6FU11NUp4AMwASvK5VMvGkt97hOZB01amg65ARXMIKIJC7JOQBv2LUYvkVc7FQzKxldsuSNnCcpbaewOQNrQXrgtZkABt7QGSY3/66GefJcaqTogC7QBl3+kDeR6QV9tf70la3zkk1Zw9GJ32ZqBNLhUWYiQ29XkTEnAVHr2I8ZsPqcs3i/10Ic54OaQL8jAluUpw/CLbgD1v07cqWxCtf9aDJmY4LicU9+JuiICD6+5UCSj+h0Fm9MVvK6nl/aVN7QgIHfCf9sdN3++hv8EeGVX3pDL/OpxD/HGeQB2733u6plY/HbQyHSGA==
X-MS-Exchange-AntiSpam-MessageData: tPw5hZt3i2tDrb/9s+0codZk2bePIYKBOcJnMNiUAnz00P4BZr5MInFB3xuK8N1hPvtoaPhcw3iAGs1TPZmMpMg60mw0IChghlN7JSyOBOsm1Qupd/LHDjkyWg9nZFkbwUioLubG015eii4Xoh6gzg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf66c582-c457-4223-38fd-08d7aa4bee46
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 14:58:59.3942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0WyWuM6YGdYl4Nj7BnHXczZt1+qmRgWyyGtwhs960OtI50Rdk05hrLEhFK5Z1EvlragioReOQ/FEvxltoe+DlWKoy8e9j0buGCXvbyWpyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3584
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7d00::70e
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.02.2020 17:43, Vladimir Sementsov-Ogievskiy wrote:
> 05.02.2020 17:22, Eric Blake wrote:
>> On 2/5/20 3:04 AM, Vladimir Sementsov-Ogievskiy wrote:
>>
>>>> [repo.or.cz appears to be down as I type this; I'll post a link to a
>>>> repository later when it comes back up]
>>
>> Now up
>> https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qcow2-all-zero-v1
>>
>>>>
>>>
>>> I have several ideas around it.
>>>
>>> 1. For generic block layer.
>>> Did you consider as alternative to BDRV_ZEO_OPEN, to export the
>>> information through normal block_status? So, if we have the
>>> information, that disk is all-zero, we can always add _ZERO
>>> flag to block-status result.
>>
>> Makes sense.
>>
>>> And in generic bdrv_is_all_zeroes(),
>>> we can just call block_status(0, disk_size), which will return
>>> ZERO and n=3Ddisk_size if driver supports all-zero feature and is
>>> all-zero now.
>>
>> Less obvious.=C2=A0 block_status is not required to visit the entire dis=
k, even if the entire disk is all zero.=C2=A0 For example, qcow2 visits at =
most one L2 page in a call (if the request spans L1 entries, it will be tru=
ncated at the boundary, even if the region before and after the boundary ha=
ve the same status).=C2=A0 I'm also worried if we still have 32-bit limitat=
ions in block_status (ideally, we've fixed things to support 64-bit status =
where possible, but I'm not counting on it).
>=20
> Not required, but why not doing it? If we have information that all disk =
is of the same ZERO status, no reasons to not reply on block_status(0, disk=
_size) with smaller n.
>=20
>>
>>> I think block-status is a native way for such information, and I
>>> think that we anyway want to come to support of 64bit block-status
>>> for qcow2 and nbd.
>>
>> Block status requires an O(n) loop over the disk, where n is the number =
of distinct extents possible.=C2=A0 If you get lucky, and block_status(0,si=
ze) returns a single extent, then yes that can feed the 'is_zeroes' request=
.=C2=A0 Similarly, a single return of non-zero data can instantly tell you =
that 'is_zeroes' is false.=C2=A0 But given that drivers may break up their =
response on convenient boundaries, such as qcow2 on L1 entry granularity, y=
ou cannot blindly assume that a return of zero data for smaller than the re=
quested size implies non-zero data, only that there is insufficient informa=
tion to tell if the disk is all_zeroes without querying further block_statu=
s calls, and that's where you lose out on the speed compared to just being =
told up-front from an 'is_zero' call.
>=20
> Yes. But how is it worse than BDRV_ZERO_OPEN? With one block_status call =
we have the same information. If on block_status(0, disk_size) driver repli=
es with ZERO but smaller than disk_size, it means that either disk is not a=
ll-zero, or driver doesn't support 'fast whole-disk zero check' feature, wh=
ich is equal to not supporting BDRV_ZERO_OPEN.
>=20
>>
>>>
>>> 2. For NBD
>>> Again, possible alternative is BLOCK_STATUS, but we need 64bit
>>> commands for it. I plan to send a proposal anyway. Still, nothing
>>> bad in two possible path of receiving all-zero information.
>>> And even with your NBD extension, we can export this information
>>> through block-status [1.]
>>
>> Yes, having 64-bit BLOCK_STATUS in NBD is orthogonal to this, but both i=
deas are independently useful, and as the level of difficulty in implementi=
ng things may vary, it is conceivable to have both a server that provides '=
is_zero' but not BLOCK_STATUS, and a server that provides 64-bit BLOCK_STAT=
US but not 'is_zero'.
>>
>>>
>>> 3. For qcow2
>>> Hmm. Here, as I understand, than main case is freshly created qcow2,
>>> which is fully-unallocated. To understand that it is empty, we
>>> need only to check all L1 entries. And for empty L1 table it is fast.
>>> So we don't need any qcow2 format improvement to check it.
>>
>> The benefit of this patch series is that it detects preallocated qcow2 i=
mages as all_zero.=C2=A0 What's more, scanning all L1 entries is O(n), but =
detecting an autoclear all_zero bit is O(1).=C2=A0 Your proposed L1 scan is=
 accurate for fewer cases, and costs more time.
>=20
> Ah yes, somehow I thought that L1 is not allocated for fresh image..
>=20
> Hmm, than possibly we need two new top-level flags: "all-zero" and "all-u=
nallocated"..
>=20

It make sense only with incompatible semantics. With autoclean semantics it=
's better to have one 'all-allocated-are-zero' and don't care.


--=20
Best regards,
Vladimir

