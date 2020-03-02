Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E55AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 08:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D575A24695
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 08:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A+3twvme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D575A24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8goi-0007gN-Pc
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 03:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8go7-0007DX-GT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8go6-0006Ep-Dc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:52:11 -0500
Received: from mail-eopbgr60115.outbound.protection.outlook.com
 ([40.107.6.115]:38232 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j8go0-0006DF-6R; Mon, 02 Mar 2020 03:52:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkcS4oqjxRyO5mL1VKUPu26UpgNUNkvmOaTaUo5xlNRnrkSDRXrpTk/I+FHtrkWRoBgMrlOnqwX4ju7ZfpgsVGINWnToULZXq5n6zNlMZDHQXj7hpT2wujvHagv4fL8UyVgJ0WSJjPV5OePe7qvH7H2XhQD46xrmKH5zW5VvfKAEUeOgh+Jog3TbVbwXmkXY/IdtoDyApoUNxu6QFIJB6IkzErNgY4HkF9UeR5HMbVshJ/ZlYE3Ut1ooaeNoVNKCKD3tTXAXZAfe8n7rnyKSzRaNK8qTqyUhjDD4/uRqIVxFQeCZC4ZmKBI8zLVKoNHvMXv7g7IOwcq+L5rXJFYbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s7xwk4wANy1qVDHp8Ba/VN3fq3U1pt3/pS/2kHg2XY=;
 b=cXb3ouRU7S9JXYmFsa8RwNA0DfQuN1nntXv9YreI2Od4K99toNuDhsMUIImZlvxtQtW5W4h7Odg1NJbSaMNBP05uNf+F9v/cV7HsYskPngtjv78oNAWxwjHWbLypGA8VmaVN0iyoLRS6Tpts0kL/GrHSJHEZSyUGHa+tjoyjy3koTp4ptIvRZkzy+Y7RpcFVhbzbrvLcGeDhCIQnMDgnGxBJkZYewpqbpwdSWO+g7G6CDbW0bMcIhFqaafor18OKdY1GF1Lyf67Yh6DYnj+JrYlDQl/UvOxH5TWB3GiKwiDBKxdlD1lWmqIR1KXwgbbwgCghAoeM0vd1tRAD4jCcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s7xwk4wANy1qVDHp8Ba/VN3fq3U1pt3/pS/2kHg2XY=;
 b=A+3twvmeuSsTcMTdhDCfBqSHlKd/dsje55Jxjaf/RSV0MprvxrSkSL7WkrXiQchyiIATIEpJVE6MyTXHv1S/eU2GJyP8ZMPSFTLtgS6VQK6eSaWC3lLhYiy61JC9JwviwrklrYxU5Icl9BisbJcLqj3tm/XM+3vK+L2tVBe6tdY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3111.eurprd08.prod.outlook.com (52.135.165.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Mon, 2 Mar 2020 08:52:00 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 08:52:00 +0000
Subject: Re: [PATCH v2 0/4] qcow2: Implement zstd cluster compression method
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200302082111.21205-1-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200302115157951
Message-ID: <2dffd0d2-7a1d-3ecd-1fbc-b89ff270ab21@virtuozzo.com>
Date: Mon, 2 Mar 2020 11:51:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200302082111.21205-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::25)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 08:51:59 +0000
X-Tagtoolbar-Keys: D20200302115157951
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 116d0390-71e2-44f4-b4c7-08d7be86f8b0
X-MS-TrafficTypeDiagnostic: AM6PR08MB3111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB31114EA7E20C41DEC5CB6B06C1E70@AM6PR08MB3111.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39840400004)(366004)(396003)(346002)(189003)(199004)(16526019)(8936002)(26005)(186003)(31696002)(86362001)(8676002)(16576012)(478600001)(956004)(2616005)(6486002)(81156014)(81166006)(4326008)(36756003)(5660300002)(2906002)(316002)(31686004)(52116002)(66946007)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3111;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOWCv9CMG1vdgXlnOzJUoAZvVpIhMn19N0THCmFVc26g3BWE4wbx3qDPQk/cwFplOv4rW5PPbPGmh6V5hBypFwwI7n3m5hN4NXNUsdkFonc6tLZYF3j0uJ9EAeglK4FOtpRpUcNMzR2MIeXQpHfJhrAQ+2blCC9RD9gxiSa0NbLTAQ5Nfd4Zal5Q07JLxUEJ936kOKoS8SWrLGuRZRlLCNfJHxarUXUI2rkW67zCVNAiF0Z9yCahQpfgTn7XlQ71xDTZe5GfS9wvj6cyD+LExagZZaVKxB3CF3MaNmKWLzhzS9xxtEf+teSscuDeotwzeWzUoti3SmDx4zpe5ZlRKLgfS96bpY7uv/1K+De3xaKF1FKFFY7qH6evU46xx9eoldbX/3Ff8TgNLEdYA0MeYXoJ8qgnN3mDs9Ye1k+axn2tInF1IgMoumR+fvZ8dgWe
X-MS-Exchange-AntiSpam-MessageData: aqpD1CVN9Zf9CmSmWe648bB/WW57qyXbgbnS2ogPCkgatTyLhfVPMRSGatwZsppiLzIfey3lUo+HBPoAyeXW0O4m7jDiVTHSQPCtfnEuqVUzNwhB5YH5Ox5aOkCvE7OtnBxX+Enlb+WZaHoN3x1axQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116d0390-71e2-44f4-b4c7-08d7be86f8b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 08:52:00.4848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAkvGWub1UVXFSRsVjYntgVdrABbQxtILlE/wIh9l4ISE+FGPcAIUpS+QdmCdHYC5MmR7MvR6wS2YqnlQe6sAKy+S7xdUaFaW6Or6LFYTRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3111
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
Cc: kwolf@redhat.com, den@openvz.com, qemu-block@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Doesn't apply to master, as zstd already exists in ./configure :) (for migration)


02.03.2020 11:21, Denis Plotnikov wrote:
> v2:
>    * rework compression type setting [Vladimir]
>    * squash iotest changes to the compression type introduction patch [Vladimir, Eric]
>    * fix zstd availability checking in zstd iotest [Vladimir]
>    * remove unnecessry casting [Eric]
>    * remove rudundant checks [Eric]
>    * fix compressed cluster layout in qcow2 spec [Vladimir]
>    * fix wording [Eric, Vladimir]
>    * fix compression type filtering in iotests [Eric]
> 
> v1:
>    the initial series
> 
> ---
> zstd comression method is faster than the only available zlib.
> The series adds zstd to the methods available for clusters compression.
> 
> The implementation is done with respect to the recently added compression
> type additional header to the qcow2 specification.
> 
> Denis Plotnikov (4):
>    qcow2: introduce compression type feature
>    qcow2: rework the cluster compression routine
>    qcow2: add zstd cluster compression
>    iotests: 287: add qcow2 compression type test
> 
>   docs/interop/qcow2.txt           |  20 ++++
>   configure                        |  29 +++++
>   qapi/block-core.json             |  23 +++-
>   block/qcow2.h                    |  18 ++-
>   include/block/block_int.h        |   1 +
>   block/qcow2-threads.c            | 197 ++++++++++++++++++++++++++++---
>   block/qcow2.c                    | 116 ++++++++++++++++++
>   tests/qemu-iotests/031.out       |  14 +--
>   tests/qemu-iotests/036.out       |   4 +-
>   tests/qemu-iotests/049.out       | 102 ++++++++--------
>   tests/qemu-iotests/060.out       |   1 +
>   tests/qemu-iotests/061.out       |  34 +++---
>   tests/qemu-iotests/065           |  20 ++--
>   tests/qemu-iotests/080           |   2 +-
>   tests/qemu-iotests/144.out       |   4 +-
>   tests/qemu-iotests/182.out       |   2 +-
>   tests/qemu-iotests/242.out       |   5 +
>   tests/qemu-iotests/255.out       |   8 +-
>   tests/qemu-iotests/287           | 127 ++++++++++++++++++++
>   tests/qemu-iotests/287.out       |  43 +++++++
>   tests/qemu-iotests/common.filter |   3 +-
>   tests/qemu-iotests/group         |   1 +
>   22 files changed, 666 insertions(+), 108 deletions(-)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
> 


-- 
Best regards,
Vladimir

