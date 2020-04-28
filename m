Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8491CC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394B7206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FUYOdJ/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394B7206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMnr-0007oT-BC
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTMXG-0005DO-LP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTMU6-0005wO-WC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:28:13 -0400
Received: from mail-vi1eur05on2133.outbound.protection.outlook.com
 ([40.107.21.133]:40320 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTM1o-0008Vv-02; Tue, 28 Apr 2020 04:55:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWIDCSDFj2RAjtHtv2B8vXC81IE+vwYb52kI6Q9+TVngDZRg/amndpApsGJKhQYybwXhuWhoF+SdAyTPIwuWOcAuj34sAbU5NXhjDY6C7DQtI7MYJLTi+LG3yrD0IohCoazmpf+/sKeTv5SPZI6CVj7DYh9cDq+EDjcgVYE3oZOVGK0F3ZB4uhnjsuv7fMAtaz5KCjJ7PbIacFFqjamudv0KCHn3sEtgnYx4j2TcMNdef2SIQDkunDoQyC095IWTUyL7fjOpLZMAxdf5iYuPnw+QV/5j/ZEONNGFYKXAGkN8AfVoOhbSUyT1IJGXu6os4WPxjvICnhRY/gSMgROChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXROdLAE+ybEt/RjCV1QzqpD37vS3gYZWuvhowhXe5s=;
 b=Zo6PbU4VAiu7xB0LZ0iFFJ6YEiKqFNt9nfprGyBPdIJuIAF5e8CsDQJEPJNiXMdobF0Rk27FnnxniMSC+8EYMyfCDMSa6Ip83AMg6g1cdEiuEAzkM8ulTG8FZmzeymxpgM8TfbUDoeeKkPCgaC0qCfObvEuKwH9CIRtjpsE/A/bthugntEOxLoHrWRfuzLJz65GjoO+IY8DTwIdi8hPrBCy98DC6EPmNjXdz390reglxOMU742OPFkFSyYhCQsnGwY1FKzphUK+Y4CzWd2MEgTg7VYAdn4TNSVdGoG/OErg05WYHh2u0NNWMYMLvGD5Es+copMdojDCAzUZT/i1lyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXROdLAE+ybEt/RjCV1QzqpD37vS3gYZWuvhowhXe5s=;
 b=FUYOdJ/7s1UKDNqQG87NINNUCpF7pleg5cpzD9ebRxM3fsEQKr4erjw4EvuOvPxyeWYFDYaKATeDGLpq3MJtZqOpsqWQ3JjaqJbZXHh1jgQCap9M7Bj/P4EgOeokSIfLAeeaNp0IyWq//M1lAVuCTGnW1fCrOGmBmMnKbm5gIkQ=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5304.eurprd08.prod.outlook.com (2603:10a6:20b:10e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 08:55:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 08:55:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: backing chain & block status & filters
To: qemu block <qemu-block@nongnu.org>
X-Tagtoolbar-Keys: D20200428115535240
Message-ID: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
Date: Tue, 28 Apr 2020 11:55:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.155) by
 AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 08:55:36 +0000
X-Tagtoolbar-Keys: D20200428115535240
X-Originating-IP: [185.215.60.155]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71d2267b-cb63-4394-b2c8-08d7eb51eb1b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5304916873197B4D41F2BE0EC1AC0@AM7PR08MB5304.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(66946007)(5660300002)(66476007)(66556008)(31686004)(36756003)(86362001)(31696002)(52116002)(478600001)(16526019)(4326008)(81156014)(2906002)(6916009)(8936002)(8676002)(107886003)(26005)(54906003)(956004)(2616005)(186003)(6486002)(316002)(16576012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCxlCjSOdHdUpfo3+FmLVhQpyf53t2MTE8Qe6rIFXK4yUSvY0bAcvAwYQKMLB0UySFJrWLRKfrb2B/6/kIVw4efUTh/kbvE0B1LzIjMnIpBa0t4u9gS1/6YczPVzEwshKX1ErEV9A9iXbHZbBIca5vB2VaclWC45xVJpE9SsNuKx9WzIxK6GBtDh9AFzr5vzlIKgsaXXWgixigFSrv3fQZMuRtDFE9CvC5HFPzhMu1G9wiewcaUEX6imbCb5eSaiLLQwYqRT9fWdbWOx1vJRsRT9HKqpbNh8JetsPtfRWC9CYzFuRckNzDgX5U8BBlTVWR7EEBTYjA6H4uURbB7ZZPog7ckg6vhnVGQImbQJWz1HazQkkDOQk6Bd5vq2IHXKsdE+ZPMfA/KQ2GpV9nX7Kj77LMl3nUsR36jECa8q31sMc6p4S1MOMvhkikz8QDJh
X-MS-Exchange-AntiSpam-MessageData: Ko3ga3dAM+nxVcBVnPS1puY96CWPZYNW9/omOtbUoq7mXpuWhTuOW5dF6O9mS9Goa4CRiH74qutnndeh8gjC3Gf80d0UctMpLKcGBmwGBdoIf1sr/KltilQOeBPTT6BzsWNurYK3otYfhMMrGGg11QqYXveupNPdQHPNOL8MqqlK4bRwJdzgsSij9SMCyMiZJlTnIRbs5YQFHgCImNsT17+9ZvO5ZfMUIMmJmrBA6BgaMxYCw91/ghyKDDQ6IoxBiWPscJQdML+UtiGZsQLt9q8sNBqawocpsIeIqp+gHA6oGVRzMVdj9z9B4uI20V4Ln5qsHx7srL+NvGnzUrGDZHV/tXMPhnVJvsR1sPB1qTpJtPfUoOXY0g+3BmEvz6/36MVmb0lLJSftj/7+51hlzGzSyz5OOVEwz2fkLQbtrvwtSiCnUf7l7XxWNUIb9VqKq1+j1WEoeU+oHdOUgHUgOQvIyRJgfaxdqCyWM3Udcdr+4nmSsk3uNn9tZz8HYYYIrUPhgjCVqN4Qpf2V2Ot91CrIw1tKkqS/Yqr348191wRSX5Fmc2zzjJiZegGpvtdUbsUF9Nk4a7M4K8+xdigo7YvdJbK0IRul+HVh1EtQuG1alrIukH3qU+d5j6Fiai6544yKU5hvDq5O4mcF7mN0z41dwLc3ciOGveanw4U7RT/auDdu2K/Aqw567zInWZyi8GByDt21zZrY4GKvsplauhYEOadhi8a+cZQR5RiURn0y9U27xpyXIw1dRgTgSmFy/BWtfRa3psPZZQMqNLFcXG1eZinouaASiJfx4PGRNkY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d2267b-cb63-4394-b2c8-08d7eb51eb1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 08:55:37.4554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olZ5GpFW/ltvwvAQMwCcriGCy2hFf9N0Fa4TgjcVRKIdriuZizN7VfA85MH4q9EpxdJTpB6DdXrsg1fUhijQ3ZYL9gsk0wgNmJmQAGgGO8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5304
Received-SPF: pass client-ip=40.107.21.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:55:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.133
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

I wanted to resend my "[PATCH 0/4] fix & merge block_status_above and is_allocated_above", and returned to all the inconsistencies about block-status. I keep in mind Max's series about child-access functions, and Andrey's work about using COR filter in block-stream, which depends on Max's series (because, without them COR fitler with file child breaks backing chains).. And, it seems that it's better to discuss some questions before resending.

First, problems about block-status:

1. We consider ALLOCATED = ZERO | DATA, and documented as follows:

    * BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
    * BDRV_BLOCK_ZERO: offset reads as zero
    * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing raw data
    * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
    *                       layer rather than any backing, set by block layer

This actually means, that we should always have BDRV_BLOCK_ALLOCATED for formats which doesn't support backing. So, all such format drivers must return ZERO or DATA (or both?), yes?. Seems file-posix does so, but, for example, iscsi - doesn't.

2. ZERO. The meaning differs a bit for generic block_status and for drivers.. I think, we at least should document it like this:

BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
BDRV_BLOCK_ZERO: if driver return ZERO, than the region is allocated at this layer and read as ZERO. If generic block_status returns ZERO, it only mean that it reads as zero, but the region may be allocated on underlying level.

3. bdi.unallocated_blocks_are_zero

I think it's very bad, that we have formats, that supports backing, but doesn't report bdi.unallocated_blocks_are_zero as true. It means that UNALLOCATED region reads as zero if we have short backing file, and not as zero if we remove this short backing file. I can live with it but this is weird logic. These bad drivers are qcow (not qcow2), parallels and vmdk. I hope, they actually just forget to set unallocated_blocks_are_zero to true.

Next. But what about drivers which doesn't support backing? As we considered above, they should always return ZERO or DATA, as everything is allocated in this backing-chain level (last level, of course).. So again unallocated_blocks_are_zero is meaningless. So, I think, that driver which doesn't support backings, should be fixed to return always ZERO or DATA, than we don't need this unallocated_blocks_are_zero at all.

3. Short backing files in allocated_above: we must consider space after EOF as ALLOCATED, if short backing file is inside requested backing-chain part, as it produced exactly because of this short file (and we never go to backing). (current realization of allocated_above is buggy, see my outdated series "[PATCH 0/4] fix & merge block_status_above and is_allocated_above")

4. Long ago we've discussed problems about BDRV_BLOCK_RAW, when we have a backing chain of non-backing child.. I just remember that we didn't reach the consensus.

5. Filters.. OK we have two functions for them: bdrv_co_block_status_from_file and bdrv_co_block_status_from_backing. I think both are wrong:

bdrv_co_block_status_from_file leads to problem [4], when we can report UNALLOCATED, which refers not to the current backing chain, but to sub backing chain of file child, which is inconsistent with block_status_above and is_allocated_above iteration.

bdrv_co_block_status_from_backing is also is not consistent with block_status_above iteration.. At least at leads to querying the same node twice.

=================

So, about filters and backing chains. Keeping (OK, just, trying to keep) all these things in mind, I think that it's better to keep backing chains exactly *backing* chains, so that "backing" child is the only "not own" child of the node. So, its close to current behavior and we don't need child-access functions. Then how filters should work:

Filter with backing child, should always return UNALLOCATED (i.e. no DATA, no ZERO), it is honest: everything is on the other level of backing chain.

Filter with file child should always return BDRV_BLOCK_DATA | BDRV_BLOCK_RECURSE, to show that:
1. everything is allocated in *this* level of backing chain
2. filter is too lazy to dig in it's file child (and, maybe the whole sub-tree of it) and asks generic layer to do it by itself, if it wants zeroes.

Then, of course, if we want some filter to be inside backing chain, it should have not "file" child but "backing". For this, we may support in current public filter both variants: backing or file, as user prefer. I.e., filter is opened either with file option or with backing and operate correspondingly. And newer filters (like backup-top) may support only backing variants.

=================

So, I propose to complicate a bit code of old file-based filters, to support backing child (which may be done on demand, when needed. For example, Virtuozzo now need only COR filter (and only to satisfy iotests, actually)), and keep generic code about block-status and handling backing-chains simpler (and simpler to document).

Another benefit is that block-graph is already visible through QAPI, and it would be good to keep backing link meaning, not adding the thing that for filters "file" link behaves as "backing".

So again, I'm for limiting backing-behavior to bs->backing child only (as it currently behaves). What do you think?

-- 
Best regards,
Vladimir

