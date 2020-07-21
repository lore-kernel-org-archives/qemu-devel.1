Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52082C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214FD2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wpudigBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214FD2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrRi-00077s-Dk
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxrQ6-0006Z8-3y; Tue, 21 Jul 2020 08:30:55 -0400
Received: from mail-eopbgr30111.outbound.protection.outlook.com
 ([40.107.3.111]:12256 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jxrPz-0003Gr-Cb; Tue, 21 Jul 2020 08:30:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP56a77b0AfbRCDv6RxwILDK6Iaj+//rkeg/bDb0QiKMlIwTcL/qGSK6rNC9z18ssat6iPCqnIP5mxi2If3dv7rxPCoSqRluCNb1I6NtY9RsrZybPjHb/2NWyXlDO4t4ZfPiAA/eok3fs9Tt2o4kmLIKrEsp2XZQZ6uhxQ0Cs8J5Rw2fITTW9XktXqBvTRIQDZaGQ8K9eQXVcFJA1Cqyk7UqNsCHwAJSz0fYkEJLX/t/xOnGI/XCV3FNlJU1eLSOC+d3jSDR4Pg9KHmQ/AX0Pl6qRJ4hiXQ/swGa/r74UPrPfJVjJdv7Hzuudut/EMD6/FyAwQkPYa+AZB/9IbxZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7DqMrsyE/HJqtjIvE3eIHct2a7TkMO7QYgcFxro2Bk=;
 b=cOeepBYXxORLTG/lMsCR6JqMAUrNsVFQ7jjMppGuNfMP0WobyNeFbBHfiHJ+FFyUXlkl3zt4xleMLrThFpw+iwotidZapDeQFfYU/8wcjT3gZJCNRyaPtg9e5SbVuVZRH0D3HlabmvHBrWWOfWTIGOn6hq3ug9GmKbuvo8YUQHGRqnTALQcI+j/PPqSy0hrU5Y4rqpLyzpCg8LkNB2ttzjiJELgP4fXDxdC8k0JZO7+vkTcBXsozL3epeB5dcaV6hw35cPm91jdgdAqQtplE0+bJ2sdYgTBWHKIqBRIz5Aq/selcC4NkBkzs1/JesbG8sAUBc6iOijy0g3K4Vk/BWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7DqMrsyE/HJqtjIvE3eIHct2a7TkMO7QYgcFxro2Bk=;
 b=wpudigBvHSUc5Q8D6qolCPDMV3HCAEuaw4qsoiCoTaG03VV4DD5UKS1QQVPxvOHeEmhm4WnaFebGFECg5FHvaOIhQ/h71jE/jDfwccO3hTJQ/M+DVEy8jT2E3x0yz3Ke8II9tTr+f0fY3TJ/898H67sD0lVM50cfm0Js8CR1DPk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3718.eurprd08.prod.outlook.com (2603:10a6:20b:81::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 21 Jul
 2020 12:30:43 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 12:30:43 +0000
Subject: Re: [PATCH v7 31/47] block: Use child access functions for QAPI
 queries
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-32-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <1e15532d-c3b3-6676-d8bb-e37d8a9b2cc0@virtuozzo.com>
Date: Tue, 21 Jul 2020 15:30:39 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-32-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.14 via Frontend Transport; Tue, 21 Jul 2020 12:30:41 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3858d1ec-e6b9-4706-de7a-08d82d71e2e8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3718FBF18A6018C34B9949D6F4780@AM6PR08MB3718.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFkVLMhoXwocF7tR9duLeNX6lRy+YF5k7X+w+GjloZXVHTl+5DGXobi9VVAyBtxWp55PvMF+SywhxU1OA5MpAFQMUbZe0NgjloZyYd2Knf7q64ZqnaN31BUbr+JwYghJoxRu05HV85xtI1IJo/IqnSfaKmhgavrr+gRL3W3CLhcy3eGcKsYCugFbL/y8E0/RBkEkragjrgnB1FOk3vz753sjxrwYl87wV/nUseQBBFvP9pNk3OYBx/EaCjamCBlyzVtF0EL0tvbZoJuXse582qIfhA7Ung0Sw53FQQ6ZtIVgy39oXF+spr6gOssayruKtl2VUfvcXzZaR+apj0UBmYf63Cu0FKShtjEV3of/7ClhmNEFZbOvpFcDkwTy/AKo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39840400004)(136003)(396003)(376002)(8676002)(66556008)(66476007)(66946007)(6512007)(316002)(31686004)(2906002)(54906003)(6486002)(16526019)(186003)(31696002)(26005)(4744005)(36756003)(2616005)(83380400001)(956004)(44832011)(52116002)(6506007)(478600001)(5660300002)(4326008)(53546011)(86362001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2gNTCmjFknChzcpARfbM0aIhweDKUdpmxdm01j5Jc7RWAo97M3d5uNlwnOjeE1tjkqqTtdYW3W7lET9FlltIIsKOTlcae/XeYEWRbIpNu1c5/ytdCu435d7GK+FRBSRebs9+NZezajAUEDayjihBrD8wNtOw+INP2WRXcPLyTFsA6hP8Jj6CiuLehIE1A9ub8qGYq/Q93kNL3ZP8Is/qIU6pA0okOEeYzKpC2hGzQ0uxcpOBbANozZ9ppaUdhETxkIuINU6tRAsyXL8WVm9qhj+/F1la27/3ypB77b6ielEwsA5gjzNTozXQNB3XZtlfr4DrIo80tbUFW+5fp0XrhXItTj5VVF7DlGfIxFsmNpZwDk5UeqLsVWdvIuDW+QnLcQ0nRheOvgnP5f2wq/Yg8wm2BAkqQeD8n52Y6dUtsq11VhA1M3W0CHfDWOK4mVxlcK+GvZl1pum+ovXxmMzTLpuWdtH51I/YPlIPaVqZOAWIaWv/5G45byrdtvfMVE9k
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3858d1ec-e6b9-4706-de7a-08d82d71e2e8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 12:30:43.7509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37V2HK1TS8lAqf5kyGpsE7B06Tzmyim4aJ904iPus5f+dVkOy7ygGx/o3Kqt8VZMcqoIsW6QUxMcfTDhSFXRrgB3ioAVvT4BIjOtCAYvN7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3718
Received-SPF: pass client-ip=40.107.3.111;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 08:30:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:21, Max Reitz wrote:
> query-block, query-named-block-nodes, and query-blockstats now return
> any filtered child under "backing", not just bs->backing or COW
> children.  This is so that filters do not interrupt the reported backing
> chain.  This changes the output for iotest 184, as the throttled node
> now appears as a backing child.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qapi.c               | 33 ++++++++++++++++++++-------------
>   tests/qemu-iotests/184.out |  8 +++++++-
>   2 files changed, 27 insertions(+), 14 deletions(-)

...


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



