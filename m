Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB2CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CADD206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uAj6tMpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CADD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7GJ-0004MM-Fc
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ7FD-0003Ij-KO; Thu, 14 May 2020 02:21:23 -0400
Received: from mail-eopbgr30106.outbound.protection.outlook.com
 ([40.107.3.106]:7246 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ7FA-00082Q-KV; Thu, 14 May 2020 02:21:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWcTqUd89b+QQ8F90e136NROTerCuySpsUqgn/Eh8IRDu1xLyonY5h340wvkBj6UALV1P3wDE6mXElp69NBTYQHxUqT1tkxQcAT8zZVcE7O8fAh90WuC5oI5wwPBMA12h+eCv0HCjG/kgQzY0F59UykOvNDBpkWNEUIWdz+sAn+3RNogb1hTTvydOywVONK6IFLX4qHXvQ1M4FUuYRODh16lntF2f1BRRQT7wxysXxHP6kx6HoQ8meYWp18tMPV/ChjeVGMjx8WtepxumRRbJhcJhLEDX5BsEckbRLJ9fPl+xitUM25xvay5EPfWdMLetT/3sofYOpEoAQ/sXW+Ojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi4/BD+uuRJt8I5EWtxOW+1x/IZLmj5EjrKkDhZBUTc=;
 b=Jk8hm2BEU4RMTMh3Mgt+9BsuTljojFy/5Q3FULt2Q4+dbtFSi9AJVETX9gBdP2zwdNbs0p4OUW93/dQWo/Sjahkg6QQ35HTrdkMP2ExBYKYtzgl/hf5tyaMomzR7hULU4x4RUEVjMuLgSV3gKvi81szLwUTLnAkWUE+1+fMCaAfNxR1PixldFswVVE2CLSNdQzTmVyB4QlhBUs30WeCT69nfg9CWtA4Mk0ChnaMNvqqZHz17t7+zXCaf0FIJA6BQxy7fQPlMAcYnFibNxmt9Bt1601h1++mOQhd1KmkCo4bTHiV0qZCBDKcK0U0lbaa4IDCBl1+5ZqrdkO7vo4FNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi4/BD+uuRJt8I5EWtxOW+1x/IZLmj5EjrKkDhZBUTc=;
 b=uAj6tMpKsFJP2iAuG1ovlrkvDPs1bG112gHp+t88lxT+7J/XaXsNqj2OlODxO/9UJh44tfMGq61ElODN7MUuPQWSgAz8mSCUVLuQ+fYZ1OeRhcyM6l0NOIZNfE9fNLcW7YXVcf2DVMURXINGvJTOwthYobvCmj26tE+rIC/6WPo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 14 May
 2020 06:21:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 06:21:17 +0000
Subject: Re: [PATCH v4 5/9] blockdev: Split off basic bitmap operations for
 qemu-img
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-6-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <59288d06-6da0-0479-bfd9-7beaf8d3f35c@virtuozzo.com>
Date: Thu, 14 May 2020 09:21:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 06:21:16 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db08dc1-2a28-43e4-bee3-08d7f7cf02a8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512B4D0BB5F81C677F46EF4C1BC0@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Su5vdasHtmxRc4fAzXYwHSOpFnt6kPCJ8rM2gEzZgiSKBnooqnuyGPrk/08u0h3S2Ba0bfxcu320enuCRDU9iE2cwTPNeHD+4Oz8VWyVJJ62lxRzlgMltwLraKQNqIWadmTZzprYKGdOVb7SqueLkyl9XZV6Ywg8tONNaCRLiGgRcG6bOBh1t3juYLc43icvyL503ZSaj2eMPBfBxZ+LW071xTBrLsjkMU+iVLU8vS0OiRHcTNuwMK+kP3wvLGcaq1Hq09dJFMhsXjJNRDW0ARKZmVub29SRC2OFWRnNrXgIVj88Mw7MiipJ2ZgkLalJbAvqT4Bwk/Pise5g/KgWfZC0JgPvg0OPpEvuq9yT8MKagJqMeeSC7Wgu/NWDbRp9WNFb4oE6Vg0eatclR3uMxfUJ73ZiCfB63I94FLImrcyu+SmRqVMU73ayHlkMe5FpJ+9bmHri7r0/4b0u0DsLz/R+IlD05rMn+vlnmqSHQ1wfUSf2qNUf9mzrjOtS8590
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(136003)(396003)(31686004)(66476007)(316002)(66556008)(86362001)(66946007)(31696002)(52116002)(2616005)(956004)(16576012)(54906003)(478600001)(36756003)(8936002)(5660300002)(26005)(16526019)(6486002)(4326008)(186003)(8676002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ag1jTn8O9ZDkxqEeffORU6loeJjMNJUJIpHArQA0orGYXpso4EgX5o3sccq+Ewmz6klgmZHvjz1JDDGCPIppbv+DIlEB/60/0vsjC5C5+LkHlPxHRMInT5wfqMamZCRDQfMD0lGlyJ0tRY+btfssCnqJ9gt3eyKQhv8VZpnl93WUoNDXshGmkteDXuEVIBpTD/9JEeUEeRgmZO0YjhYL4f6ux0c1AiHHtu7Djk7zZVNTqNaIpv7QoVuR/sT/4iDGFQRGH6TGp5N1vhaUnsXJMILQyoB+0eomvlbErUdUMdB5yqbJRMD9WKDNVTQQnMzFtc8Re/sUehur1o2Kc3pTJRYsCBe+2hhRDueg7MPO2mqcxyqY+9grRBcpA6feh2HN2GbanRF27Q5gCAVf5GuX53WIBV86d6lQUW+W6WIvQVuWcRAmwhD3hl2vFeUyIWEYKhYK3oGVcTvyrYkVmEqlIyEJpqQE3yb+jeX9EC3JB3dpez7gfjxbjCmRAizj/A3F
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db08dc1-2a28-43e4-bee3-08d7f7cf02a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 06:21:17.2452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mkwJOI8bmODRfu6vcTlKz8VFhJohObVyAiz4elnRRLW7Z2zaSSd2t6FfZTXnhN9Pxnv03woifL0PaXzOteXTcqNktfun3yrCQM5GrPT7jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.3.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 02:21:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, mreitz@redhat.com, nsoffer@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 04:16, Eric Blake wrote:
> Upcoming patches want to add some basic bitmap manipulation abilities
> to qemu-img.  But blockdev.o is too heavyweight to link into qemu-img
> (among other things, it would drag in block jobs and transaction
> support - qemu-img does offline manipulation, where atomicity is less
> important because there are no concurrent modifications to compete
> with), so it's time to split off the bare bones of what we will need
> into a new file block/monitor/bitmap-qmp-cmds.o.
> 
> This is sufficient to expose 6 QMP commands for use by qemu-img (add,
> remove, clear, enable, disable, merge), as well as move the three
> helper functions touched in the previous patch.  Regarding
> MAINTAINERS, the new file is automatically part of block core, but
> also makes sense as related to other dirty bitmap files.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   Makefile.objs                   |   3 +-
>   block/monitor/bitmap-qmp-cmds.c | 323 ++++++++++++++++++++++++++++++++
>   blockdev.c                      | 284 ----------------------------
>   MAINTAINERS                     |   1 +
>   block/monitor/Makefile.objs     |   1 +
>   5 files changed, 326 insertions(+), 286 deletions(-)
>   create mode 100644 block/monitor/bitmap-qmp-cmds.c
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index a7c967633acf..99774cfd2545 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -13,9 +13,8 @@ chardev-obj-y = chardev/
> 
>   authz-obj-y = authz/
> 
> -block-obj-y = nbd/
> +block-obj-y = block/ block/monitor/ nbd/ scsi/
>   block-obj-y += block.o blockjob.o job.o
> -block-obj-y += block/ scsi/
>   block-obj-y += qemu-io-cmds.o
>   block-obj-$(CONFIG_REPLICATION) += replication.o
> 
> diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
> new file mode 100644
> index 000000000000..748e1e682483
> --- /dev/null
> +++ b/block/monitor/bitmap-qmp-cmds.c

Hmm, shouldn't transaction bitmap actions be moved here too? May be, not in these series..

> @@ -0,0 +1,323 @@
> +/*
> + * QEMU host block device bitmaps

A bit conflicts with tha fact that they are not of block-device level but of node-level.

May be just "Block dirty bitmap qmp commands" ?

> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard

Does it really apply here? block-dirty-bitmap-add was added in 2015.. May be Red Hat and Virtuozzo copyrights would be more appropriate.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + *
> + * This file incorporates work covered by the following copyright and
> + * permission notice:
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "sysemu/blockdev.h"
> +#include "block/block.h"
> +#include "block/block_int.h"
> +#include "qapi/qapi-commands-block.h"
> +#include "qapi/error.h"

compiles for with only four:

   #include "qemu/osdep.h"
                                                                                  
   #include "block/block_int.h"
   #include "qapi/qapi-commands-block.h"
   #include "qapi/error.h"

with at least extra includes dropped:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

