Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2969C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 11:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D47F2087D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 11:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qf89OIPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D47F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6YLE-0001pn-Qc
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 07:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k6YKd-0001Ll-Bu; Fri, 14 Aug 2020 07:57:11 -0400
Received: from mail-eopbgr50119.outbound.protection.outlook.com
 ([40.107.5.119]:50523 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k6YKZ-00071J-Oe; Fri, 14 Aug 2020 07:57:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaDhnF8t1MibcqSEUybGVqHvC1LIl+o8RPd0aZrKnsFXVAv3YTg6E3BVj1+nNtROaFJulBPbvO7kwE71g7IAy88xPfsyiPUCG0T38ynyVdPMDi7J1JO26I4cogUM4nvhJyiTr7NpDBIk6Xn+/G51tSBFZK0BH84jraOKVGPiTjjqK7A6h6pLINSd7G3XJQG16s37ycuwPjv7TIYetYGt33XtuscCTMHUGC5DqTb8rPHMl4tMc40wYvaHSgyh/yfhok37zG7Np5jXFA/6q0ieRQmc3Ztvv46ejkCc9QObOeqjBxGQUdh3XjzZNC4s/02e45yW3swpgBzWplm5Yt4WKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfQiJoCi2UAB5lcdjxsDTHbYIf15HuSeqWTcoPvDwdE=;
 b=fml86mrWdZTus2fsTAghntLjG2n+c1Akf37zpSXnn29N6IO7rHKdA7/J/5w6OxRUUDu6rdKMHQz49KwqJw2zJ+O0dC6cK9J4tWCGQI5j5YS/NdgtRLcIfxuhn9kMXw1q9anEOWzASP7lONQ3u8XpnAhUpQwIuAaULWT9zhWSLixlRdYAE8f5UuOB4A3WnRU8cBPe1YM+1ZgwCBjld3Ij1CxSw5vIqKfpXdED+2Kw71iZn6dVCEDm42K2BK9H/YUJDNXmrGgKgCD2NtRC8GlrXuFzDtmw+8KB7GhYjJSGJVRZv4wzHASeRDCe+kvQKDf0gCYM4OcEsxOR9UFKE5DHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfQiJoCi2UAB5lcdjxsDTHbYIf15HuSeqWTcoPvDwdE=;
 b=qf89OIPHfDK5Im1GW7mkUlPXj7rOTuEW+zUubpo2jmJp32R42cvhp9MMQ53oTTxJSq975F1bzgpqc/2dfWRrBG+iXb2TH0+NbsyamjgWkwnsmwCwRtIBi81SpWwgZu1sd/stwYQ3qeGDo32t0K9aAoBF46UYi0ASHRt+61PKJyA=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2412.eurprd08.prod.outlook.com (2603:10a6:3:de::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 14 Aug
 2020 11:57:01 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3283.016; Fri, 14 Aug 2020
 11:57:01 +0000
Subject: Re: [PATCH v13 00/11] iotests: Dump QCOW2 dirty bitmaps metadata
To: qemu-block@nongnu.org, eblake@redhat.com
References: <1596742557-320265-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <8c84c4ca-f0e5-b973-d508-e13dd0ebaa74@virtuozzo.com>
Date: Fri, 14 Aug 2020 14:56:58 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <1596742557-320265-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR06CA0096.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::37) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR06CA0096.eurprd06.prod.outlook.com (2603:10a6:208:fa::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 11:57:00 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051b34fa-c917-4a9e-b518-08d840492767
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB241299C39CDC146401600FAAF4400@HE1PR0802MB2412.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfWl9ZA6I/d4rPasqsfS6uacqqasxDE5rppxTRcqcvtnS8GqjIUXCRg8D4aUC54NlyUHeVT+Pq+dsOxJnhhWJsEElh99MlSQjg0bCJiWoS35JFNmY0rN7KGvT/UBBGVGPZCeEZELONoI+DSTjvkOm7YhcIqfN1OPzbA2mZ8WS8X+BCTUBuCaF6xbYEFjlHi+GJ6ze6Wo9oV4UBF/FBQQp7+syYw/XP7jYafCGH+nUSZzpaD2e4CSlTCkAQEZM/fS58KBYVN8hfwY+UwtdpTbm9finfU7wFWb/Xhw1S6lMtmn8rXxkp0doNqoLqtDn81GnPyXZBux8tx/5fLSh5QxQkoP3W3+yFK1uZj2LWPVAZ9/LXfbQ4neamY5fVSqPdpmIMHAAdUr6gTxrJwuBISELQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(39840400004)(366004)(396003)(2906002)(107886003)(478600001)(2616005)(956004)(4326008)(44832011)(5660300002)(186003)(6512007)(52116002)(83380400001)(8676002)(26005)(16526019)(6486002)(31696002)(66476007)(66556008)(6506007)(36756003)(8936002)(66946007)(316002)(31686004)(86362001)(53546011)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5cgr5Et8IVdILVm8UxCivO0MVJSyz09pkabkOLnMeitp6ZfxB0jBhRWvS2joR7urNtdTwOHEEHcycu/WeyDCNpfwzDVCKlT0NS0Iwq+lBJo5VnyyfZMULe532Vu9uETaKhOifgzCWcoJRNJ7poh28XfSaZbVlZOIONBLN1lLBZIPpW19wV7QSZBiJ6YdFgAn+sp781bI3ncwNS/SizgjgRm15y80aw+ExmPTqck39ZqBE10+Jv1YkKqastYBoQJRXFWg8H1gKUM3ZjfFaiEXKm/Psg3PekJsH/nhe9Ha3rRUvpAxFx6R6XlI+w6LEak+PzUBhmbWImto0+vy0hfw7DTCnD3PLaV4E5w0xZtADYYkyba8SJb/q5JDAK6GpN0Hv4mys+Xu8zLtZJhtXYpp+2nMeyH+PpGn64tveVwTJq/YjauE1KnQ+IzSNSBxNSXXzd0uUoue0jF6Seu0aOI9dWJe1fjBB5HCmLUqe49Zv9Iu3FjE9gfXhu1yCA71L9sxziVuOkP7uthf9jTeLC7uV/AshTG6ndwoTrvsZ6OvpmGly3474u/pHPzj1UQ+85pwxkbWWkbDSW07YjPh3n5eICLvLiXOCmCZau5alkzg7hBzvXvjLweyymdw67rKwjxmeU3cudj7GBH9wjd4AYf0Sw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051b34fa-c917-4a9e-b518-08d840492767
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 11:57:01.3482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTn06LmYqTR4CsAJcGuHphQPdR8fWQixZydOyziSCkJrB4C2mkc153lJ9OXhgTkGaL+MVRZqUjUCks4jaxThLYTP3bc9ORfdJ8dlKW0Zz3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2412
Received-SPF: pass client-ip=40.107.5.119;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 07:57:03
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear Eric!

Vladimir has compeated reviewing this series. I have not received any 
other responses to it so far.

So, is it good for pull request now? Would you please consider taking 
this series as you did it with the Vladimir's related one?

Kindly,
Andrey


On 06.08.2020 22:35, Andrey Shinkevich wrote:
> Add dirty bitmap information to QCOW2 metadata dump in the qcow2_format.py.
>
> v13:
>    01: Bitmaps are added without launching VM (suggested by Eric).
>        The code amendments suggested by Vladimir.
>    07: Bitmap table entry size zeroed up for all types but serialized.
>    09: The extra dict variables removed. to_dict() renamed to to_json().
>        The to_json() added to the class Qcow2BitmapTable. (By Vladimir).
>
>
> Andrey Shinkevich (11):
>    iotests: add test for QCOW2 header dump
>    qcow2_format.py: make printable data an extension class member
>    qcow2_format.py: change Qcow2BitmapExt initialization method
>    qcow2_format.py: dump bitmap flags in human readable way.
>    qcow2_format.py: Dump bitmap directory information
>    qcow2_format.py: pass cluster size to substructures
>    qcow2_format.py: Dump bitmap table serialized entries
>    qcow2.py: Introduce '-j' key to dump in JSON format
>    qcow2_format.py: collect fields to dump in JSON format
>    qcow2_format.py: support dumping metadata in JSON format
>    iotests: dump QCOW2 header in JSON in #303
>
>   tests/qemu-iotests/303             |  63 +++++++++++
>   tests/qemu-iotests/303.out         | 158 +++++++++++++++++++++++++++
>   tests/qemu-iotests/group           |   1 +
>   tests/qemu-iotests/qcow2.py        |  18 +++-
>   tests/qemu-iotests/qcow2_format.py | 215 ++++++++++++++++++++++++++++++++++---
>   5 files changed, 434 insertions(+), 21 deletions(-)
>   create mode 100755 tests/qemu-iotests/303
>   create mode 100644 tests/qemu-iotests/303.out
>

