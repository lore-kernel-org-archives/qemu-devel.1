Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E968CC54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BA52064C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NgjR7nAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BA52064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56095 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrGP-0000tL-R6
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 07:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQrFe-0000Ol-IU
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQrFc-0007vX-RA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:39:41 -0400
Received: from mail-vi1eur05on20710.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::710]:6520
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQrFc-0007pT-2A; Tue, 21 Apr 2020 07:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X95/fSwENeEe285veMa0sm1qVyK5Q/NqWhElrIXp0bU7V9bWWo7ys5lF1vCgH5VR3Rua+n1MOCRkTljuDaG+ap7Ukv5m+n9cIbifRnvL5wbz7SPaJI83BuGEIvRMTsxrrE0x7bBe+vpEk5IBu3C3CFVktQUe8+NYGy68x2kMIlmMUIElf1hp6aPkV/+52P3kX6+1qc8eZ5QIy1msof4VEUxyTKVLL5d2raud0hYFIUe1TS4iNOYRURCYtL6RDXX6OQXSetl9h2RJ3A/kF/6WaYf+CaSbn3fQMsmUjeem1zd96TAen2HAGWEspBaeap0a5h+vqZ8Nve156kSrg+/1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmnhpIBY7DF3ds5pHPvG7w5cJahJHzLrB1RNLzupS4A=;
 b=QClWbtAm45mn4Q2AHnTvWIOZL5cftyiQMxhRz1gNhWRHxiQP+0JgrGoheEKJwjy1GrTlhN6sTFZeQXLkHpMKweqaPBWMuxYLFvBrk9+fKLRVycqCqzHlkllc0aGTl4IMKinYdjpBkE8cwrZigEGIJxjKgKfANPkHtuXCNp+l1Jtne3Ook1OpZ/0nWz/ddIfvRbpfcJAufAuYyu3y14inyQ2F0A2jXNILZ0cPJoy5srn4Wu+9KDDM9PqTpbs+YJg8gmFS2KGuB9ZQGX294qB5ZaHattjXfuuVQf6yTkoShU6VBVFdvMZXAo2fT6PHqi5sEghYVzpQ2xxdyGf5EZR3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmnhpIBY7DF3ds5pHPvG7w5cJahJHzLrB1RNLzupS4A=;
 b=NgjR7nAhX6fZd1LwQG6ewSHNBwv0ArylZetzC25Sq8fR0EEr64ADrtgziTSQWHEITaFn+IyHO0jKMT+N5kcscwW17KXE+Q1QztYMAczbe3ggT3XQ1V3rl2MKo9njNIxT3+8gZG990nyHhuOlPIpZiXtPddhFc0DnTMJC50PFXaI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5320.eurprd08.prod.outlook.com (2603:10a6:20b:103::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 11:39:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 11:39:36 +0000
Subject: Re: [PATCH v4 9/9] iotests: Test committing to short backing file
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-10-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421143934467
Message-ID: <3cb44f78-93cd-b25b-9df1-72ded8e5fc8c@virtuozzo.com>
Date: Tue, 21 Apr 2020 14:39:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420133214.28921-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29 via Frontend Transport; Tue, 21 Apr 2020 11:39:35 +0000
X-Tagtoolbar-Keys: D20200421143934467
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d7dd104-6671-4bc6-8771-08d7e5e8ab0d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5320:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53203B50AF45B898210F9517C1D50@AM7PR08MB5320.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(346002)(366004)(136003)(39850400004)(396003)(478600001)(66946007)(66556008)(8676002)(8936002)(66476007)(4326008)(81156014)(86362001)(26005)(16576012)(316002)(31686004)(6486002)(52116002)(36756003)(2906002)(956004)(186003)(2616005)(31696002)(16526019)(5660300002)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1qPw8HLNdwXHVkto8vkc86FcxuMFnkreIRv/lXsLZuhIYWC6u/qWP+eNQ7WCtVrLC8UllbKYJNN5w//pBQdMGCxfJ81HnQtHL9spjrbi14nkIS9hiaQ79ulWeGzlvDR0Scvz02n+jGGDnpByYnNfwHKH7xm7PYi8eiX3kSWrM3nPXWXHOQUbZekyohE4yR3R2C/sp2KAYmO3BH4WJHQWvEAcS2kxrhB/7qB/vy5jHkAf6zs2uhTRucNVSJeAXWC5KTYDepFzzkgOLLXtTgxAf89FNjU8+RwTjvgQkwlcNT0vUpESeYRt3zop2qiT1a6UbZ1JC5BUGDgySl9o9vyH4GWnzVVmgQhPhNp1geHhIdFCZoFi2iILmFuJs39tjs6QwXTD2iqc2rryBmeQ9HUQbLmrga4UqgXulTv/CC3tFmIaMF/384mT1PnDerRTY6WDdA0p8RrWBF8NoFk1SPJNa0PCQ2P0+wwBxDA2vdJoV+L5+HHRmH51HAdmyp8hbOMDYN1tUi1NXM/+TPi4rhdq6QhT/G3HBxWX/Y4Sx1xVXbBQbFPKEUyLwLHkoyBU8yt
X-MS-Exchange-AntiSpam-MessageData: CjEIyInAX9aD2VbEJTrp+rq9YbSNujid/58vIULuzQc/cZBHTLjeMkioPJDVXu6iaGBd2Eyf1XXQtiUQ/Bb8gHTO0wc3N9eGn2ED/2SzuGnxCu4Z/KqZcMT+JMc6oX14dPAf2AexTSnxCYayxmTuHg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7dd104-6671-4bc6-8771-08d7e5e8ab0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 11:39:36.2363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qldZPvD429VyhBRi4QlEU+/imADz65CKP2iMcXfAVTrcCaPV4pUrr27xGEvdkYe7xcSY37kbneHBJVcJUw9azREETyIKKSO79kWQszdO+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320
Received-SPF: pass client-ip=2a01:111:f400:7d00::710;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a01:111:f400:7d00::710
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 16:32, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/274     | 152 ++++++++++++++++++++++++++++
>   tests/qemu-iotests/274.out | 202 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 355 insertions(+)
>   create mode 100755 tests/qemu-iotests/274
>   create mode 100644 tests/qemu-iotests/274.out
> 
> diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
> new file mode 100755
> index 0000000000..30463e54e7
> --- /dev/null
> +++ b/tests/qemu-iotests/274
> @@ -0,0 +1,152 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (C) 2019 Red Hat, Inc.
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
> +# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
> +#
> +# Some tests for short backing files and short overlays
> +
> +import iotests
> +import os
> +
> +iotests.verify_image_format(supported_fmts=['qcow2'])
> +iotests.verify_platform(['linux'])
> +
> +size_short = 1 * 1024 * 1024
> +size_long = 2 * 1024 * 1024
> +size_diff = size_long - size_short

Would be good to add unaligned-to-cluster testcase.


-- 
Best regards,
Vladimir

