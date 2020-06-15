Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248ACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E209D206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rXqrw+YM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E209D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkoMN-0005lL-8H
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jkoLa-00055O-Ue; Mon, 15 Jun 2020 08:36:19 -0400
Received: from mail-am6eur05on2101.outbound.protection.outlook.com
 ([40.107.22.101]:4929 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jkoLW-0003RU-Pi; Mon, 15 Jun 2020 08:36:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYA73MLhzIdqrq9gVKVaT0hJ6/I95Zy54MSuItY4RnD4ygRFJmBDE4dl+qOIo79NyVnPvlrKP+oFqA4g6bbvDJ9jfyzVdERzE+fnEf/y3o/F8SmFDkSsg5KwPzCic2fQPKej9r4UdxXDz2T3PKq0gWkbhtXwkVu1l2nn2Ckb0IoLgljv9D7siUYghP7RnMJhNKMNDg9p3JFv/VD4wv71ezxhgF77DNhIA67Apsq7RNErCHufHRc1mX1xVZGX+guHhziwo59our2k3nnTLXWcBmlNLv7NuWH9y2Iwnjr/3uuq44W9APsG55PvrNCx107NStPzSpWHvnYwgpfcTArwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bt+/xDIsPBF56jj21/CH8jt5Y/RmOUZi+L436gd+SE=;
 b=d+vSp6pBY1UulUrYf6uyGHHaN7my6ELScSUOK0Aokf3bdqU+7SUqOOrUdzyvvebGRYbEHhvbIulrcvNRWYiFhr4XVjeuZlcrCssYle3UPKv+cLaGInYaFif5akATEWNla56VPiGj5Jdl/jUoaKOQMBTyDypSz8UbjA20S2Cco/5MF5f4ndGumIvqKLaHBziv61ySb7ae56XlW6byuz713uaArbyfyjb6JmZ14fgHEiZ4w2t5ZLt4J7G8M7UJz56QP6M9Xuw/cIA9bMFBcEML1XRVzvTlzO+gAap8z8HyyCzHVYCpu2S0i4O69Xh/j0l8NiV03KDYSq0uW9my9b1Atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bt+/xDIsPBF56jj21/CH8jt5Y/RmOUZi+L436gd+SE=;
 b=rXqrw+YMhkucqnZQYNucttu9ldQxX3I/d7YEJdI7NtMrGibXSp5iPTOuzFur4tE7ZFz3vkG/Xmkns1g+V2ERDuMG7UPvhpjgI9Xj1cNHI9Tr8xIOi9rTcWxbdQmfXhiTsSg7UhMlTmyzgK0B5omHt5L92mpgNZJQtyFut0BV4Pg=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4469.eurprd08.prod.outlook.com (2603:10a6:20b:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Mon, 15 Jun
 2020 12:36:10 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 12:36:10 +0000
Subject: Re: [PATCH v3 0/4] block: seriously improve savevm performance
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200611171143.21589-1-den@openvz.org>
 <20200615121714.GJ2883@work-vm>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <6931b77c-73ad-010a-daf3-8c7c99c20d10@openvz.org>
Date: Mon, 15 Jun 2020 15:36:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200615121714.GJ2883@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0502CA0019.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::29) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.81] (31.148.204.195) by
 HE1PR0502CA0019.eurprd05.prod.outlook.com (2603:10a6:3:e3::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Mon, 15 Jun 2020 12:36:09 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d485be9f-7fc4-4b88-7c7a-08d81128aecc
X-MS-TrafficTypeDiagnostic: AM6PR08MB4469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4469E0F7CCB24DBD8601DFC3B69C0@AM6PR08MB4469.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWuKRKoGMYq5etInqJNRQL8kKNANP9cTOkJOD7QG/C8/JKNvA9oKfjVxBVLdh+wdQgbCOFINQktc3YuioykMTsvDGgwvw8vX/KEs/5NdX4t8o7+S9L2wOjMI7au6B16EtPdHhtyXNTZftCIy+35XMTxFWp4BzH8U02/CCK11j+eJtSpy+9rrO9lTbNByyKpDhCSY5zeIv0YsF+U2Ep1ekIDrw8hiZWoW0SXRqikm+mIQrw01DcUCkkQce6iOoebZpkeoxhyw5K8SX/FSfylGn3sQ7wQ2tHu/5GitqmdTRQ79BolgxQJaDTXt4eAxeL09nI2wfFO0LHgqUs22p6+1I35Lk+OAlFlwpWEzdRg00xTGSNEn2Rr+Q0F7VD/+7hHB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39840400004)(396003)(2616005)(31686004)(66946007)(2906002)(8676002)(6486002)(6916009)(8936002)(36756003)(83380400001)(956004)(66556008)(66476007)(5660300002)(42882007)(31696002)(316002)(52116002)(83170400001)(53546011)(16526019)(4326008)(107886003)(186003)(54906003)(26005)(16576012)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1r/ye2ASyiSpL/XTY5Lj12Pj4S7zNKSJUWg9QUqEwn+Onb73uSu4rHYv1WUHgN8JgLyWpOQpE/BeX7jhrObSfBtVOPwu4UzwQh/EwkscWPIo5s/Qv8vFJ0nKEe2rmenbFTgHNkHYpCHMy+1OCm0fCYlfDmLP+BAmQF5lPr5QmNbp2LHVWu0bzXfcI2BObC11G3l+I0P0V9C9HTw5syxP0WjeD5gy6uz4Vs3RD66i43D/hM4JcjSMV4esSJdHdLp/9swJnSvMxFVkI3pjdSMSV16Vx5BeaBAn601PMY1oxAAju5rBrF9UzM0MXONfW59IqbhKpFAOxQxEfI1Crp0/C9UQItyI2DNz813CV0v6xVfiTMdIxpvg5dv8168bJghRNzEtr+0TIY0zUuF1LUadpM2eejrcp2qJa0bBERnQLOViP1KE9I0vFWqxCTs9QlL+L8YvDalgi4nVfawdc5dsZrPYLs+OqXjnyOfxkVH2WBSFkVchJMlgcv/hLHRfhHRJ
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: d485be9f-7fc4-4b88-7c7a-08d81128aecc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 12:36:10.3445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4EGLs+FlTh7bp7JXb0beY90Ox3ZhohJT5bN5HEnqFDTDz+7V5UhwJjrx16auLiPEVHytImLhsDKyN2lXnb4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4469
Received-SPF: pass client-ip=40.107.22.101; envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:36:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 3:17 PM, Dr. David Alan Gilbert wrote:
> * Denis V. Lunev (den@openvz.org) wrote:
>> This series do standard basic things:
>> - it creates intermediate buffer for all writes from QEMU migration code
>>   to QCOW2 image,
>> - this buffer is sent to disk asynchronously, allowing several writes to
>>   run in parallel.
>>
>> In general, migration code is fantastically inefficent (by observation),
>> buffers are not aligned and sent with arbitrary pieces, a lot of time
>> less than 100 bytes at a chunk, which results in read-modify-write
>> operations with non-cached operations. It should also be noted that all
>> operations are performed into unallocated image blocks, which also suffer
>> due to partial writes to such new clusters.
> It surprises me a little that you're not benefiting from the buffer
> internal to qemu-file.c
>
> Dave
There are a lot of problems with this buffer:

Flushes to block driver state are performed in the abstract places,
pushing
  a) small IO
  b) non-aligned IO both to
       1) page size
       2) cluster size
It should also be noted that buffer in QEMU file is quite small and
all IO operations with it are synchronous. IO, like ethernet, wants
good queues.

The difference is on the table.

Den

