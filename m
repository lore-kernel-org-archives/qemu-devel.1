Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F53C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 12:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AAE720732
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 12:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="To/Pl0Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAE720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNxwk-0004wQ-NE
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 08:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1jNxvO-0004PQ-Et
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1jNxv8-0008VC-VU
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:10:49 -0400
Received: from mail-vi1eur05on2094.outbound.protection.outlook.com
 ([40.107.21.94]:29537 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1jNxv8-0008SW-CN
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:10:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVL46JJYOBUxIilPKtc7Db5hq9YlmdoY9wmjWYHbFYYupq2QOzQFSVobbrwLUJICsqD5s4dbYphZz15RwugJXRgXBr4Qy4dojQJleux8fmz3Axf/fbjhW4gnrodlOMxj0BfUNpM3+Ij0HefVegkzRtfPFQwuD/AuMFNUJLmqPDJK+Mpd6eY5zYqgJVaTQlq3SdFTDBZw4suCRSlt1B11abpiPVUOvERQDlAdF790L00s4aeozn4fYlM/z197RuOeP8B4uvM1GmKS+xwgb8d+C4gxxvuaR29CllK+QlVT9LxY0bphpAcNCO3/4TnlPuoPrI4ykfI6pMNBkIAhWsBBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUuYYgMtgcqqVZ52qXImoxJ4JxEKfbm1u79olU5mPxc=;
 b=hxBtPw9ZyRC81Xs6GhFS6aqfp2H7KpJKv7Oo/PlV1nD33DgYXOC36bADD3cm+H1EY0k4d0A00zMLxAmh1dxtUo9U7z4RSdcjksfeVNK0/AEelrYEdYtT5lZepl3z+S4DDkxwIsfm5cFm4g0zFCiuykMWhYN4h6RbiXFWRoDHKhTR7dCzmeb5g2q5E4stYQj/6tNv6MoqkDLgp8trUzLXtJTZvFQKqf0Sp0tvbdqNylDjgnY12QPXGmQi3WrVGGe2z0XF33qhmFWQaadSIFRmrdLw1Td3rqkf9XVlqMDHHZgK8Uty9XssbPsFF/6hhrL+CAO+0dGBuc121p+IKi4I6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUuYYgMtgcqqVZ52qXImoxJ4JxEKfbm1u79olU5mPxc=;
 b=To/Pl0LhF8RngXakU1BXaNjW78+5RYBVYnjkiCWXENk1jOzYzUax43PEUIY4g3HqGI7dhjokYqKzzc62RN0VnK/ERQRvaComsvQYVFhEf7oK+6qoLZgjvekgZdHHEi+OOlGAwuj1k/eCcLnH8D4nSLZePjy8Jl32CMhB2suMb18=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
Received: from AM0PR08MB5268.eurprd08.prod.outlook.com (2603:10a6:208:155::29)
 by AM0PR08MB3379.eurprd08.prod.outlook.com (2603:10a6:208:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 12:10:30 +0000
Received: from AM0PR08MB5268.eurprd08.prod.outlook.com
 ([fe80::20c6:8b78:b40c:283e]) by AM0PR08MB5268.eurprd08.prod.outlook.com
 ([fe80::20c6:8b78:b40c:283e%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 12:10:30 +0000
Subject: Re: [RFC patch v1 0/3] qemu-file writing performance improving
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <e4709bce-7053-a37f-1bcf-e3af1d241197@openvz.org>
Date: Mon, 13 Apr 2020 15:10:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0058.eurprd05.prod.outlook.com
 (2603:10a6:200:68::26) To AM0PR08MB5268.eurprd08.prod.outlook.com
 (2603:10a6:208:155::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.45] (31.148.204.195) by
 AM4PR0501CA0058.eurprd05.prod.outlook.com (2603:10a6:200:68::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend
 Transport; Mon, 13 Apr 2020 12:10:30 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d922ef28-e769-4454-cb58-08d7dfa3a915
X-MS-TrafficTypeDiagnostic: AM0PR08MB3379:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3379263208AFB24A6CE4949AB6DD0@AM0PR08MB3379.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB5268.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(376002)(136003)(346002)(366004)(396003)(8936002)(81156014)(31696002)(956004)(42882007)(52116002)(4326008)(8676002)(6486002)(36756003)(53546011)(66476007)(66946007)(478600001)(16576012)(2906002)(31686004)(2616005)(316002)(66556008)(16526019)(26005)(186003)(5660300002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27czmmqrpjsAK1Z8VkbprkKiOqmyuDe4yA7Dseq3x54hamwmfRea2HBTouRYigvwg2hj4GUiEt1+I4cjKfA2APJZ4LwKDo0QfuZFdjpT4lhddfP3pctVFDagYe12QeyxTd2TQcBRPQFJlmQ5lFKvKh9gx9Jt/YFfTrAo3UiP3fI2AF2c+oi2e4uym++mWApk8Q25dZjT+28rF8f0n/BfntBDrD4YmVk4qd2XD9ZxudJvj+Ei0pBDXquQnbA7eXUpLxJsTxaInuYfradQ9LX5I2omOJ+x3uiXcEEd+gGsB6aTDx23XjHjJCrO6aa+8BlWf1fmVjAONnMyIJW00M9n2z6MpdeIDunzVvH1PA4xe81Mnk/6T8iqk7jGFp+WY/OCDbUFYB70Jumuuy9WdoHJwILc9pVTuk0WJ1dvalf6RaEAOIpGWzQK+G4TEiSXvPC5
X-MS-Exchange-AntiSpam-MessageData: m5qI7yhRDmIa2iTxdvhD1P/t5mhpW+TGU6UX8jZpEOMETUaencKo+Akgxm5EFj6cZAY/NEZBH6XhHb9sw76+xX3SlIvNTwPZt+EA4hOKyH0vuuuSMyWMk+qsni+2PFToox3rIkjESYO1kr7hgpbYfA==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: d922ef28-e769-4454-cb58-08d7dfa3a915
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 12:10:30.7284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Yr1UU14ds6bZTSGdl07LLs31GeO1YXP+yxaF3YWWiM3FTsIU7tV5upTQyG/g/ucehTZrVi5jec+ls+Q4UiisQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3379
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.94
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
Cc: dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 2:12 PM, Denis Plotnikov wrote:
> Problem description: qcow2 internal snapshot saving time is too big on HDD ~ 25 sec
>
> When a qcow2 image is placed on a regular HDD and the image is openned with
> O_DIRECT the snapshot saving time is around 26 sec.
> The snapshot saving time can be 4 times sorter.
> The patch series propose the way to achive that. 
>
> Why is the saving time = ~25 sec?
>
> There are three things:
> 1. qemu-file iov limit (currently 64)
> 2. direct qemu_fflush calls, inducing disk writings
in a non-aligned way, which results further in READ-MODIFY-WRITE
operations at the beginning and at the end of the writing data.
Within synchronous operations this slow-downs the process a lot!

> 3. ram data copying and synchronous disk wrtings
>
> When 1, 2 are quite clear, the 3rd needs some explaination:
>
> Internal snapshot uses qemu-file as an interface to store the data with
> stream semantics.
> qemu-file avoids data coping when possible (mostly for ram data)
> and use iovectors to propagate the data to an undelying block driver state.
> In the case when qcow2 openned with O_DIRECT it is suboptimal.
>
> This is what happens: on writing, when the iovectors query goes from qemu-file
> to bdrv (here and further by brdv I mean qcow2 with posix O_DIRECT openned backend),
> the brdv checks all iovectors to be base and size aligned, if it's not the case,
> the data copied to an internal buffer and synchronous pwrite is called.
> If the iovectors are aligned, io_submit is called.
>
> In our case, snapshot almost always induces pwrite, since we never have all
> the iovectors aligned in the query, because of frequent adding a short iovector:
> 8 byte ram-page delimiters, after adding each ram page iovector.
>
> So the qemu-file code in this case:
> 1. doesn't aviod ram copying
> 2. works fully synchronously
>
> How to improve the snapshot time:
>
> 1. easy way: to increase iov limit to IOV_MAX (1024).
> This will reduce synchronous writing frequency.
> My test revealed that with iov limit = IOV_MAX the snapshot time *~12 sec*.
>
> 2. complex way: do writings asynchronously.
> Introduce both base- and size-aligned buffer, write the data only when
> the buffer is full, write the buffer asynchronously, meanwhile filling another
> buffer with snapshot data.
> My test revealed that this complex way provides the snapshot time *~6 sec*,
> 2 times better than just iov limit increasing.

We also align written data as flush operations over the disk
are not mandatory.

> The patch proposes how to improve the snapshot performance in the complex way,
> allowing to use the asyncronous writings when needed.
>
> This is an RFC series, as I didn't confident that I fully understand all
> qemu-file use cases. I tried to make the series in a safe way to not break
> anything related to qemu-file using in other places, like migration.
>
> All comments are *VERY* appriciated!
>
> Thanks,
> Denis
>
> Denis Plotnikov (3):
>   qemu-file: introduce current buffer
>   qemu-file: add buffered mode
>   migration/savevm: use qemu-file buffered mode for non-cached bdrv
>
>  include/qemu/typedefs.h |   2 +
>  migration/qemu-file.c   | 479 +++++++++++++++++++++++++++++++++++++++++-------
>  migration/qemu-file.h   |   9 +
>  migration/savevm.c      |  38 +++-
>  4 files changed, 456 insertions(+), 72 deletions(-)
>


