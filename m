Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498F9C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019D024695
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QjX78a+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019D024695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GpL-0002Qk-8N
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7GoZ-0001OV-UT
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7GoX-00058t-S3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:54:47 -0500
Received: from mail-eopbgr60115.outbound.protection.outlook.com
 ([40.107.6.115]:34636 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7GoT-0004zK-Ba; Thu, 27 Feb 2020 05:54:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI0eQBzC5Byo3oy0kzpf4poKxBLyF0ofQYfO5U3PR4EhQE8t/eZPbIl6Ogp5JjngYGgDya7tAm57j1qcK5zBLQnOPycYSzzackkkvg9AfXSBVpwoLj7Wt4l1QD+xxU2zXBFAcU5/RJIYMAyRoD/KOrkrULSpNBqIl50AdbuSPZBl97mzOd+bKg9f51zhW/NZbIMGubTY8/8xr/tGqfzbbsf4Rj6Ig2wUtAaKR5cKYHNotO3B6Xt1DK7LLjwCrJ4WnxbjNZOJZi75hhb9ErT8LxQQk/bYIQvi9p3ApIHeej4Z2mq609e/Ub3Szo5VUj2TM1XFI93RpeJwIkkJFdGi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbGpjM1B9bs01JZOjelyJG1pIslhN8MECDm0ToJgStw=;
 b=avSyNkLqre271MVbl83Lgt3AC/874h4/GsmRouzrOCNLIALGf93hm8VfzFf8s7sLR8olGMk2XqDGFpMSbJRoT0/Czk5NpjBLttpFcyOPZ9i1RSAa6K7765/S1GcDtoHL/gM0ZVDUpj8k3zVPvm4EfkU2TGxSuE4M1yphbt7tiPuP3iv4oA0R4SnaALyCumsSj6cbXUa65GD20PMCPSz08tzwcbHCY0sDDPnWP+80GvHN9eE3wNKrYOaNWbxV0CNOLjDLwTEcTMgK7EsQIknCSh/xk3h/286zPfh6c9DQCruNuzBeVB9BR7eA4eK/aqfqrKxvyKjEIcjYyf7qAE4Bsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbGpjM1B9bs01JZOjelyJG1pIslhN8MECDm0ToJgStw=;
 b=QjX78a+a5NZVZIF7GX6N8dDCJkx4aI9QrTiJAfqe+GCy7Bw4ei8Vmh3YT710ENqAhf7IBqSKZ7gMPippZ7FuKQTEnSk3TmWo1VF19HUBmVdL9KIH/Cc5Ah0U789u79eyIbC5W/Y3wpKLtN4+pvIDKtmf36Eq0zMayU3vmi0Q3J4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3933.eurprd08.prod.outlook.com (20.178.125.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:54:38 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 10:54:38 +0000
Subject: Re: [PATCH 3/6] iotests: move bitmap helpers into their own file
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200225005641.5478-1-jsnow@redhat.com>
 <20200225005641.5478-4-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227135435574
Message-ID: <9870b153-f2a9-44dd-9967-228d158dabcb@virtuozzo.com>
Date: Thu, 27 Feb 2020 13:54:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200225005641.5478-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR02CA0093.eurprd02.prod.outlook.com
 (2603:10a6:7:29::22) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR02CA0093.eurprd02.prod.outlook.com (2603:10a6:7:29::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 10:54:37 +0000
X-Tagtoolbar-Keys: D20200227135435574
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05cf58bc-4587-47eb-a118-08d7bb7370a2
X-MS-TrafficTypeDiagnostic: VI1PR08MB3933:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3933BDAC20F100495469D068C1EB0@VI1PR08MB3933.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39840400004)(136003)(346002)(366004)(199004)(189003)(2616005)(8676002)(31686004)(956004)(86362001)(52116002)(2906002)(6486002)(16576012)(36756003)(31696002)(81166006)(81156014)(66946007)(4326008)(8936002)(186003)(16526019)(5660300002)(66476007)(66556008)(316002)(26005)(7416002)(478600001)(54906003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3933;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHvh68/P/uNN5arbsGfSgXOG5nlVc8evbxHTz/JJ+uJ5pqexNA155CD2+gQ+jRZWMZvWinE09b8top3GMw82/xP3bc/NRtsVHc07EBUz505q5N+Nbn4p6re1zsrH0Fu0T9G6hFxjyvkKLUVpziW3SC6JXiVMC4hltaY4ffjYS3zJIamIOM3G8O2F4zlPm6AUxupe4PxYFnFLJU0X+1E/UEFGOwyfxZjK7sc/Wf9E7BK0OROsuYWid3j5eq8KAuWJ3ldHAP/VAuzhnMtcwGM6jSNy3ekUnUhmaQHoiayvoqXNRTuBFFFnxQtJKHpQ2YwRH7FjoB6EK0i+6dHlJxWeKsrIrMhi2xZuYrqV6w6i1fOt4Bswa2iJea98MEZx+/NYuXt2TYrIEEre8YTtPAncsWTEtxIdFp3WAlkggN1jnkDiwLuw31SthhwInEo5ooWNwzzBIJE06Xz5wua9BCPIeneCpw9a2gier0sLj0JOAMOGna/V7mIz1TczibTL2gscI2cuT3TmhcgzBcL+ljcxdCuLhkq5AsHDdQHG9lW6Hjf06vsN1VdJT1Mzc7PmKREV
X-MS-Exchange-AntiSpam-MessageData: ziDSz8//kNRHRkgqnto5NLvfFOXzjnDYT880+epXdGtklR6lISgaT28n1O1HQRCbG+ZARvwhhjMnXYkPkqX0LzQigLtraTjXhm9NBHbzmyqrIIsOfa7rQuczMxCSg8EtCQ41fihnjXmrlSUyO0xgvg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cf58bc-4587-47eb-a118-08d7bb7370a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:54:38.3352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/QlCPzjcPo7SnGC3ogfZtJ1fktazZQUxB1K9JSKLmewPK5PiYhDViHCZxM+uhToCbFn8xAipSC3KNAFfdrdUpulT7YkGlT7yPkiC/XJ5u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3933
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.02.2020 3:56, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/257        | 110 +---------------------------
>   tests/qemu-iotests/bitmaps.py | 131 ++++++++++++++++++++++++++++++++++
>   2 files changed, 132 insertions(+), 109 deletions(-)
>   create mode 100644 tests/qemu-iotests/bitmaps.py
> 
> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
> index 004a433b8b..2a81f9e30c 100755
> --- a/tests/qemu-iotests/257
> +++ b/tests/qemu-iotests/257
> @@ -24,120 +24,12 @@ import os
>   
>   import iotests
>   from iotests import log, qemu_img
> +from bitmaps import EmulatedBitmap, GROUPS

Clean code movement, no changes. If test passes, it should be correct :)

The only thing: I'd prefer not exporting global variables and use bitmaps.GROUPS instead (even then, it's not very good interface but..)

with or without it:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>   
>   SIZE = 64 * 1024 * 1024
>   GRANULARITY = 64 * 1024
>   
>   
> -class Pattern:
> -    def __init__(self, byte, offset, size=GRANULARITY):
> -        self.byte = byte
> -        self.offset = offset
> -        self.size = size
> -
> -    def bits(self, granularity):
> -        lower = self.offset // granularity
> -        upper = (self.offset + self.size - 1) // granularity
> -        return set(range(lower, upper + 1))
> -
> -
> -class PatternGroup:
> -    """Grouping of Pattern objects. Initialize with an iterable of Patterns."""
> -    def __init__(self, patterns):
> -        self.patterns = patterns
> -
> -    def bits(self, granularity):
> -        """Calculate the unique bits dirtied by this pattern grouping"""
> -        res = set()
> -        for pattern in self.patterns:
> -            res |= pattern.bits(granularity)
> -        return res
> -
> -
> -GROUPS = [
> -    PatternGroup([
> -        # Batch 0: 4 clusters
> -        Pattern('0x49', 0x0000000),
> -        Pattern('0x6c', 0x0100000),   # 1M
> -        Pattern('0x6f', 0x2000000),   # 32M
> -        Pattern('0x76', 0x3ff0000)]), # 64M - 64K
> -    PatternGroup([
> -        # Batch 1: 6 clusters (3 new)
> -        Pattern('0x65', 0x0000000),   # Full overwrite
> -        Pattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
> -        Pattern('0x72', 0x2008000),   # Partial-right (32M+32K)
> -        Pattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
> -    PatternGroup([
> -        # Batch 2: 7 clusters (3 new)
> -        Pattern('0x74', 0x0010000),   # Adjacent-right
> -        Pattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
> -        Pattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
> -        Pattern('0x67', 0x3fe0000,
> -                2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
> -    PatternGroup([
> -        # Batch 3: 8 clusters (5 new)
> -        # Carefully chosen such that nothing re-dirties the one cluster
> -        # that copies out successfully before failure in Group #1.
> -        Pattern('0xaa', 0x0010000,
> -                3*GRANULARITY),       # Overwrite and 2x Adjacent-right
> -        Pattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
> -        Pattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
> -        Pattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the right
> -]
> -
> -
> -class EmulatedBitmap:
> -    def __init__(self, granularity=GRANULARITY):
> -        self._bits = set()
> -        self.granularity = granularity
> -
> -    def dirty_bits(self, bits):
> -        self._bits |= set(bits)
> -
> -    def dirty_group(self, n):
> -        self.dirty_bits(GROUPS[n].bits(self.granularity))
> -
> -    def clear(self):
> -        self._bits = set()
> -
> -    def clear_bits(self, bits):
> -        self._bits -= set(bits)
> -
> -    def clear_bit(self, bit):
> -        self.clear_bits({bit})
> -
> -    def clear_group(self, n):
> -        self.clear_bits(GROUPS[n].bits(self.granularity))
> -
> -    @property
> -    def first_bit(self):
> -        return sorted(self.bits)[0]
> -
> -    @property
> -    def bits(self):
> -        return self._bits
> -
> -    @property
> -    def count(self):
> -        return len(self.bits)
> -
> -    def compare(self, qmp_bitmap):
> -        """
> -        Print a nice human-readable message checking that a bitmap as reported
> -        by the QMP interface has as many bits set as we expect it to.
> -        """
> -
> -        name = qmp_bitmap.get('name', '(anonymous)')
> -        log("= Checking Bitmap {:s} =".format(name))
> -
> -        want = self.count
> -        have = qmp_bitmap['count'] // qmp_bitmap['granularity']
> -
> -        log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
> -            want, have, "OK!" if want == have else "ERROR!"))
> -        log('')
> -
> -
>   class Drive:
>       """Represents, vaguely, a drive attached to a VM.
>       Includes format, graph, and device information."""
> diff --git a/tests/qemu-iotests/bitmaps.py b/tests/qemu-iotests/bitmaps.py
> new file mode 100644
> index 0000000000..522fc25171
> --- /dev/null
> +++ b/tests/qemu-iotests/bitmaps.py
> @@ -0,0 +1,131 @@
> +# Bitmap-related helper utilities
> +#
> +# Copyright (c) 2020 John Snow for Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +# owner=jsnow@redhat.com
> +
> +from iotests import log
> +
> +GRANULARITY = 64 * 1024
> +
> +
> +class Pattern:
> +    def __init__(self, byte, offset, size=GRANULARITY):
> +        self.byte = byte
> +        self.offset = offset
> +        self.size = size
> +
> +    def bits(self, granularity):
> +        lower = self.offset // granularity
> +        upper = (self.offset + self.size - 1) // granularity
> +        return set(range(lower, upper + 1))
> +
> +
> +class PatternGroup:
> +    """Grouping of Pattern objects. Initialize with an iterable of Patterns."""
> +    def __init__(self, patterns):
> +        self.patterns = patterns
> +
> +    def bits(self, granularity):
> +        """Calculate the unique bits dirtied by this pattern grouping"""
> +        res = set()
> +        for pattern in self.patterns:
> +            res |= pattern.bits(granularity)
> +        return res
> +
> +
> +GROUPS = [
> +    PatternGroup([
> +        # Batch 0: 4 clusters
> +        Pattern('0x49', 0x0000000),
> +        Pattern('0x6c', 0x0100000),   # 1M
> +        Pattern('0x6f', 0x2000000),   # 32M
> +        Pattern('0x76', 0x3ff0000)]), # 64M - 64K
> +    PatternGroup([
> +        # Batch 1: 6 clusters (3 new)
> +        Pattern('0x65', 0x0000000),   # Full overwrite
> +        Pattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
> +        Pattern('0x72', 0x2008000),   # Partial-right (32M+32K)
> +        Pattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
> +    PatternGroup([
> +        # Batch 2: 7 clusters (3 new)
> +        Pattern('0x74', 0x0010000),   # Adjacent-right
> +        Pattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
> +        Pattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
> +        Pattern('0x67', 0x3fe0000,
> +                2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
> +    PatternGroup([
> +        # Batch 3: 8 clusters (5 new)
> +        # Carefully chosen such that nothing re-dirties the one cluster
> +        # that copies out successfully before failure in Group #1.
> +        Pattern('0xaa', 0x0010000,
> +                3*GRANULARITY),       # Overwrite and 2x Adjacent-right
> +        Pattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
> +        Pattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
> +        Pattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the right
> +]
> +
> +
> +class EmulatedBitmap:
> +    def __init__(self, granularity=GRANULARITY):
> +        self._bits = set()
> +        self.granularity = granularity
> +
> +    def dirty_bits(self, bits):
> +        self._bits |= set(bits)
> +
> +    def dirty_group(self, n):
> +        self.dirty_bits(GROUPS[n].bits(self.granularity))
> +
> +    def clear(self):
> +        self._bits = set()
> +
> +    def clear_bits(self, bits):
> +        self._bits -= set(bits)
> +
> +    def clear_bit(self, bit):
> +        self.clear_bits({bit})
> +
> +    def clear_group(self, n):
> +        self.clear_bits(GROUPS[n].bits(self.granularity))
> +
> +    @property
> +    def first_bit(self):
> +        return sorted(self.bits)[0]
> +
> +    @property
> +    def bits(self):
> +        return self._bits
> +
> +    @property
> +    def count(self):
> +        return len(self.bits)
> +
> +    def compare(self, qmp_bitmap):
> +        """
> +        Print a nice human-readable message checking that a bitmap as reported
> +        by the QMP interface has as many bits set as we expect it to.
> +        """
> +
> +        name = qmp_bitmap.get('name', '(anonymous)')
> +        log("= Checking Bitmap {:s} =".format(name))
> +
> +        want = self.count
> +        have = qmp_bitmap['count'] // qmp_bitmap['granularity']
> +
> +        log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
> +            want, have, "OK!" if want == have else "ERROR!"))
> +        log('')
> 


-- 
Best regards,
Vladimir

