Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE0BC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AB92072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L2gdTf21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AB92072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkKD-0005y3-BY
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTkJ3-0005RN-6n
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTkJ1-0006d1-Bh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:51:08 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com
 ([40.107.8.114]:53128 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTkIq-0006aO-TA; Wed, 29 Apr 2020 06:50:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRAceRw/Jov6ugG4Mc4xustBNus9fvjhMy+vsx2WK+W6SysqOhBy4OlznuhzuKudX5hanEu+NYPX7x7z1mLenGzXS8OGPcCz/CZTLpZCr1nt60hCXKYa3+hprfiVpz3T3KOgUIWyeHKQQDKBUxrM6V7APJPYBgc3pM6ih4+ZVFQklfaBhJHYCZ9uFJwWV2knCM4ps8DCHPSLAmKu9kAPLmuuI0N5s0lJPHAM6YqZB85SNs/P2N/6rEfSYMgeyl3OakOHHzywH84M1Caum/av5262GkUhTdwAWK6NdEjMaWJB3Rfo5AH06StDMfxcdyeRZpMCg0Lon/0MILvgV5spBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HppZ898wVQhJttBtx8Tupg420bP9Huz+XF96cZ3e+A=;
 b=Fs+MQU8Hx1ilo7dNrl1RgfjMncKS22ZtlH6QmLa+hkB5KNj3u0TB89uE6Soh9QFlFLqP0TovkDOcre3hkJsO1Z0PbR1alK7EYi0oyNk43ELQtp47OBxpaP5PFd+DkjnswNQI+klew3QT84Pdm0LRCGQ4RxT26GKuWMlfY9u4NwOX7xNq7cfqdGd1g+c3axcFZgXjEiww9yUmMfIW8Lm6BpYpZvdtf7VCmfslURD1SQVdN/K4ZoxeQc27pNVXoZKa8uNiXCczUlV/H4u0uFrJHzABWMthEf8qpRK3xinjbyF+o6s0PdiKvGmpILyRBNf1XMz0RFvSHDIGH7NMOLac1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HppZ898wVQhJttBtx8Tupg420bP9Huz+XF96cZ3e+A=;
 b=L2gdTf21GPPUUnwvW3HxnSqvCatX+qJhK0KkOtE85fgk3jcQsYrKNLrSfvtVFwzSeWWsIkK9Wd5F6dclgi1GIzmT1qLba0LasLO4+UE2AG8uVTqcQ2YLpLlnaDR7l3ZuRTt7b0kQ2y4ozPbG9ywn0PjsJqHRaCJh+50SC+JgEvA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5384.eurprd08.prod.outlook.com (2603:10a6:20b:10c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 10:50:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 10:50:53 +0000
Subject: Re: backing chain & block status & filters
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <20200428112853.GC5789@linux.fritz.box>
 <2e3eab55-4a1d-f1a9-ab28-3f9399c57bfe@virtuozzo.com>
 <25f6278c-466d-c663-73e0-ef2d256b326d@redhat.com>
 <04dd8365-7077-766a-6d42-1aac26abbdeb@virtuozzo.com>
 <91b741ac-248c-2065-17b9-7fe31eafee40@virtuozzo.com>
 <7b1d4246-e59b-0fdb-3c44-6810eea6e5b8@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429135051399
Message-ID: <a91f4d6c-efaa-d76f-3959-d0b607c0ed51@virtuozzo.com>
Date: Wed, 29 Apr 2020 13:50:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <7b1d4246-e59b-0fdb-3c44-6810eea6e5b8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0142.eurprd05.prod.outlook.com
 (2603:10a6:207:3::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM3PR05CA0142.eurprd05.prod.outlook.com (2603:10a6:207:3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Wed, 29 Apr 2020 10:50:52 +0000
X-Tagtoolbar-Keys: D20200429135051399
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b0ac76-7835-4e37-9b92-08d7ec2b3004
X-MS-TrafficTypeDiagnostic: AM7PR08MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53846410BBC78C76D68D5B55C1AD0@AM7PR08MB5384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39830400003)(346002)(366004)(396003)(6486002)(16526019)(36756003)(66476007)(186003)(8936002)(2906002)(66556008)(66946007)(86362001)(8676002)(478600001)(31696002)(26005)(16576012)(31686004)(316002)(110136005)(52116002)(5660300002)(54906003)(2616005)(4326008)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFK6Eegbcu/bXO8Nn9NepNzP5+ox2mXWAT+FRMi54x/N2hONtDtfSOq5/Z+hvx6yiyDquFOviZawKLo3yxV0i3r7CJU2/fAD0N9j+6lUwuVCrPb8DPePpBMC5LeYF64mm/AEvN/PBmrlSWJYv0Ajp1Bp3wvRZUqiI16JGi14Vp00Tf+eOJHjA07XtwlwOpPnzzKVEBLMipwL+k2fJ+dsGyel8kweizEuwNCh0IQY+UCspiCP1zvbUAfRQg3mZA04sP/BnqUpP+GFfbdgdxMP7UUSr+hj/COS6smjIfQjZAxn2uq2kMUujFQhmsuOuciaNQWI/EYAxvqiDOr3EPnDn8blPdVrqXGKSRYeOJCFNdrT0Y/l+ku8s1TRMpqLsF/LBvwLwmmhBmh1ZdPt7GIuIEsCvBArnsBQPzsH1n1OWfmI6vKLWq5HxjtXgJYw6XXU
X-MS-Exchange-AntiSpam-MessageData: yLMiYIDHvASQPFrhQbG1sFIpo830Hcp/WTAsdNqjqi4TurP6u0PEcW9KNADGNTM73gck05iIsH6h6pNaL4dJkAIuaiAIs35Om9tHEvLSP3nJbYk4hRUEwNqf1uhBYVdAMD/9JU47csTvh/NdXQf5kfejqcb6kRV0jUWNQ73a9v7FuKGPkDEvsVixMmB5WVIy22TElrSo2E4bpGRqIvgTzHCK8RzkTOvoGy2HfG3Sp/cfseJKLJXkc+Nr9A8+UbxL4Xpnc7IU8jTROoXKzGi4fN9t1EHANm7Jy1ClpKf8ml/sDw/HSNQEfXqOE4gnmYCD3IbpIGofMhC0m6j2Xq7V2BBNz1Z9DtTM+l4djBY5A6JNMyZ54RjHJya7DBHOaT8BX7W3xbDXfJx7ScgmgVO+OAr1f2j8T+My3wevbli+yLQgk8wm/ULX3Cf726wiHVYqNDUkb9BTD49mNhtk2/Ju6CcFG6iRW2eD9oaZDOgffNen2Xw+p9vwLNXGbjlQovvE++0rXvr4Yzr+7kk6UoDXftv8d+rFwUxNh80aC7V/gJUOtpZ2XROAmtUnxlwUozC4eSRG+HswREPMwSphPU9CWrUaTpUMhuyiqdGhCSc3fBKYCRCeaKORwj3ZzbfAG5FoPgmU5FTnRoW11JOEpihTKJ6g/EynuA6UR+VpBpMPZYkF5jDOjnasHmnjNW5SFqHXvgnnHuNY2RoBjvjP8zVK9rJOljIc/cRx6WbqcLvDWA1i/ugdTc3HlXvpOKATInS4ylUhNnZ7YMxVKc3wOTOvuhIA5kW9kCGWtvV/vseuZBM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b0ac76-7835-4e37-9b92-08d7ec2b3004
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 10:50:53.1085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNpjK/xXAZcZkQDstdpx5Ft1IuJH3Ux1r2qbN4dxkKT4ZCEa+blmFWyT8BDF+d3aiWOIn6+Kst0fgZHbNm6QO57eDFc2SvZV3iUoDvGY6FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5384
Received-SPF: pass client-ip=40.107.8.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 06:50:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.114
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Full summary

What drivers returns?

Filters and raw are just broken together with their BDRV_BLOCK_RAW.


Format drivers behaves as follows (except for backing-not-supporting, which should be fixed):

0 - go to backing (not-backing supporting will never return it, backing-supporting will return it even if there is not backing file, but read is guaranteed to return zeroes, if there is no backing file at the moment)
ZERO - zero at this level
DATA - data at this level
DATA | ZERO actually never returned.

Protocol drivers

0 - fs-unallocated, read may return any garbage (null-co, iscsi)

from SCSI:
Logical Block Provisioning Read Zeros (LBPRZ) bit
1     If the logical block provisioning read zeros (LBPRZ) bit is set to one, then, for an unmapped LBA specified by a read operation, the deviceserver shall send user data with all bits set to zero to the data-in buffer.
0     If the TPRZ bit is set to zero, then, for an unmapped LBA specified by a read operation, the device server may send user data with all bitsset to any value to the data-in buffer.

so, yes, this 0 actually have significant meaning. And null-co matches it too. And nbd should be fixed to match it, I think.

ZERO - fs-unallocated, reads as zero
DATA - fs-allocated data or safe default
ZERO | DATA - only nbd may return it, and it seems wrong. let's fix it.

So, seems, we may can with it as is. The only thing to be documented is meaning of zero status returned by driver:

for backing-supporting it means go-to-backing, with a guarantee to read zeroes if there is no backing file, for backing-not-supporting it means most probably not occupy disk space, read returns garbage. And format drivers without backing support should never return 0.

===================

How it is used? And here we definitely fail. As there are a lot of places where 0 return of drivers is misused: we consider it fs-unallocated, but it may be just go-to-backing, we consider it go-to-backing, but it may be fs-unallocated.

let's go again through our public API

= bdrv_block_status =

img-convert and bdrv_make_zero wants only zero and go-to-backing information
img-map is better to distinguish fs-unallocated and go-to-backing and report them in different way.

= bdrv_block_status_above =

most callers needs only zero and go-to-backing information, others are doing wrong things and should be rewritten anyway

= bdrv_is_allocated =

most callers need only go-to-backing information.

io-alloc io-map - are reporting utilities, and they probably want to show fs-unallocated as well... but we never documented, how actually img-map, io-map and io-alloc should work and what they are trying to say :). Anyway, they may use same interface as img-map

= bdrv_is_allocated_above =

callers only need go-to-backing information

OK, sounds good. So, for most things we only need zero/data/go-to-backing information. fs-unallocated should be treated as DATA, it's garbage, but on read we will directly read this garbage, so we should consider it DATA.

And only for reporting through img-map, io-alloc and io-map we may want fs-unallocated information.
Do we actually need it?

Basing on this, I think that there should be four block-status types:

ZERO: unrelated to backing, reads as zero from this layer
DATA: unrelated to backing, reads from this layer, may be non-zero
BACKING: go to backing for information, reads from backing as well
RAW: I'm a filter or 'raw' driver, I don't know what to do. I give you my child and offset in it, take care of it. Be careful: it may be backing child or not, don't break your backing-chain loop on me!

So we may require that at most one of DATA, ZERO, RAW is set. And if nothing is set it means BACKING. And if we want to report fs-unallocated things, we just need additional flag for it, like BDRV_FS_UNALLOCATED_GARBAGE, which may be combined with DATA type chunks.

Or, may be even better, to split type from flags: block_status will return type, which is one of these four types, and other things (RECURSE, EOF, OFFSET_VALID, FS_UNALLOCATED_GARBAGE) goes to additional flags out-argument.

Note also, that the only user of @map and @file parameters is img-map. And all other callers have to pass NULL, NULL. I think, this definitely should be refactored.


-- 
Best regards,
Vladimir

