Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D81C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7091B2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="EW62omft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7091B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHMW-0002XH-Os
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1kBHDb-0005LB-99; Thu, 27 Aug 2020 08:41:27 -0400
Received: from mail-am6eur05on2109.outbound.protection.outlook.com
 ([40.107.22.109]:35407 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1kBHDX-0006cM-IR; Thu, 27 Aug 2020 08:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH27l64eYahu9w/i7W/JCK815VUQ5VZ3pi6QIbYIAuFVB/zwJa0vc9RA65uQbIjVsUwmqk7x4DOh75Wdian0K3BwRposGBP6OOECADz0NF627Ys2oWFjsNzWdfgts9v6RKh6UEAJ7/GR8XXq0CubgPG2PwVmeuEKdySyw9/+SaQgWuaHWvcQwdDaoM7tQKyRDW/7qdCXzADN56ynnFXiod685VZSlJFErzrAS4miLV180SkmPQG44+uWHUCYuO7d6LusOowvjr/OKzfsnaG0iNPqOwOdz5FmlYWn74yqhTqZc6Hxk59R2tSL8ouZ4qbuKr06nB7d+VI0jAyPKS2JeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHBKPtJch9EQNivoXVz5eP7WagRpBKNKmWMsiRIkkRU=;
 b=hwSAORezQiAONH7fKInSOIGKmYAFg49cxSlL0poIjou+D0CVAx+CwfV6HZVYav99TR8f3l1d6GtXgruKM19HYeNCU4dGDKI/38Pj3JMSDb56RMP6RfwaccDNKgvK2X8+3QAC75tGtvmIlyQmB4uuhHtiTkNWkWi4HVh9OkbcmalNK4lQDRwn0P3k+moKb99a8ESgRLOVNTIpD4m8BOpFvaSaRrgfwtGi1zImHSBapHCXLIEPXlLDjdiCsYHE+A1lK4QRMWULFmJ9MaSmtMq0p8odJ9G7r/KLGTZ6/rMcQn0W+mrzKXCLLkWRq9pFdUQh1KOny1RfUg01nngo8x4GuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHBKPtJch9EQNivoXVz5eP7WagRpBKNKmWMsiRIkkRU=;
 b=EW62omftzUgbItbQiqDXUizb3ZtKCTEF4cNDSZLQrku71dnH9ZhEljoUaAg2FdgSIy1x8uHS5LAnji+L5eAXKts9CdKjiOs5jibSfxQUh5ZKX/rzyb5VT5W6BxvC49HSEEFXySoqf1IhA16q6f0H6ZJ6o+8Y5lABZs/24EIxBM8=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB5207.eurprd08.prod.outlook.com (2603:10a6:20b:ea::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 12:41:14 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 12:41:14 +0000
Subject: Re: [PATCH v8 0/6] block: seriously improve savevm/loadvm performance
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200709132644.28470-1-den@openvz.org>
 <a722fc99-b367-dbd8-fd45-de7fb1a18f5d@openvz.org>
Message-ID: <2d738b26-d107-5f2c-0cfe-f20af71e7f6f@openvz.org>
Date: Thu, 27 Aug 2020 15:41:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a722fc99-b367-dbd8-fd45-de7fb1a18f5d@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0131.eurprd05.prod.outlook.com
 (2603:10a6:7:28::18) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR05CA0131.eurprd05.prod.outlook.com (2603:10a6:7:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 12:41:13 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d7c9bd-64b9-4f08-f8da-08d84a867c15
X-MS-TrafficTypeDiagnostic: AM6PR08MB5207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB520785C75710782C7F214CA6B6550@AM6PR08MB5207.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cej/9jowLb3GDtc1c620vgDm0STJyzmoXncBuL5RogoTNxTAr88E7zpUPmibc+PcJs+3WwKiVxI/0h+AZzzlPVynleZqHxt4vGdrSsVn4g2J36tOTi3IbRRj2BHebI+B+6e18mfMLm+M+5mwanBQpKcJkswY8SphP3RJXwQVbfhM3Hlt0oZr2mnnrYH/tMYAmFVVv7PSHkBSO27wXORq7oWeotXNjhOz13A9Vm14LYnX9TyNyy5K8aLzuHYISKS0QCf2ROKjGm9R53Jr6jyATe6tuTEMbImZC28stfm6pE9tJWNi9Uu3eE1qWxVFlL4jmjrWhdwxAnLB+Mo2oS/BvAjqd9paJZ8UY3a43pVrm9GaDgJM4Kbde5z5vuA5eQJAK2NZ7azbm/KcvsU+Wgcu56aGfBvF8nI2IYK1mrLPV7ojNegSh+6xLc28fhgVhyljVW6/2IgoXqRJfrfAiPPpVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(31696002)(31686004)(2616005)(107886003)(42882007)(4326008)(83170400001)(83380400001)(956004)(8676002)(2906002)(53546011)(186003)(66476007)(16526019)(66556008)(8936002)(36756003)(66946007)(26005)(6486002)(54906003)(16576012)(52116002)(478600001)(316002)(966005)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: g7TUwv1vaOTfHP9ufuy8uIu/OQwYjRYtJ+22D02TyeXQynnC5f3E2JU9se2h8gmFJ9m5d/5VPtdkYUL7waOPg5sD7EAJQwaPHHYWhJROVCUkpxjOs+8wpTo41qJ77W5sn6pfPRcIypSFfMF0owTTc9CtQrUUIo9vU9Afkje7/StZPrkoaqo4u5kBbcHMAV44VcQ99t2gQzNku3T1SzsAP5ud2uF4ba73ayh9fcs0x/bHjShw8in8qcoA6CVr2hxzK/EHBX3pXkrexgO2ZP7dGKoKa/cd/JenIjGzkpWaPaGUf9KKhgWRSQwYxEjpLxNTXU2IzC9xtQmnmSCjnQNB9TIgLduzq3TWWVQ9p+8w6ukm29gnMCJiWLKOjWuCwhsCQi1UwFsaHiAGXGyEDQpNnRow/GZ5H6Jo0jyag1scOE5ygipFvlQt2GHdueXBrfXIaJFUyLneHvbz2djtJ90qDMHUB5qd+YJPNN3BUSZbBhFzglWmAvAFCVzBkQ0KIGYs7TCyAKktab5P/m6KOq9OJrQFCRn8QtPpU6ib3LcaNHswgEzFEsp+TKQd05gx+Udhu/z5BBUCHicBEsMBSioVYiBhPAHB5OYy5jvvgQ1zw634aAs5kV75NXJhwOY0O+7Qgsi6GoriRheh1fjrpa26uA==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d7c9bd-64b9-4f08-f8da-08d84a867c15
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 12:41:14.2721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHCdFXxqWhA/lzF3SbY6w/hJBE1dK6e9usyKStCTcHzxDNikoWYy31FNVsNSIj1LOHF/UX38BwfsnM88LGcWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5207
Received-SPF: pass client-ip=40.107.22.109; envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:41:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 10:42 AM, Denis V. Lunev wrote:
> On 7/9/20 4:26 PM, Denis V. Lunev wrote:
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
>>
>> This patch series is an implementation of idea discussed in the RFC
>> posted by Denis Plotnikov
>> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg01925.html
>> Results with this series over NVME are better than original code
>>                 original     rfc    this
>> cached:          1.79s      2.38s   1.27s
>> non-cached:      3.29s      1.31s   0.81s
>>
>> Changes from v7:
>> - dropped lock from LoadVMState
>> - fixed assert in last patch
>> - dropped patch 1 as queued
>>
>> Changes from v6:
>> - blk_load_vmstate kludges added (patchew problem fixed)
>>
>> Changes from v5:
>> - loadvm optimizations added with Vladimir comments included
>>
>> Changes from v4:
>> - added patch 4 with blk_save_vmstate() cleanup
>> - added R-By
>> - bdrv_flush_vmstate -> bdrv_finalize_vmstate
>> - fixed return code of bdrv_co_do_save_vmstate
>> - fixed typos in comments (Eric, thanks!)
>> - fixed patchew warnings
>>
>> Changes from v3:
>> - rebased to master
>> - added patch 3 which removes aio_task_pool_wait_one()
>> - added R-By to patch 1
>> - patch 4 is rewritten via bdrv_run_co
>> - error path in blk_save_vmstate() is rewritten to call bdrv_flush_vmstate
>>   unconditionally
>> - added some comments
>> - fixes initialization in bdrv_co_vmstate_save_task_entry as suggested
>>
>> Changes from v2:
>> - code moved from QCOW2 level to generic block level
>> - created bdrv_flush_vmstate helper to fix 022, 029 tests
>> - added recursive for bs->file in bdrv_co_flush_vmstate (fix 267)
>> - fixed blk_save_vmstate helper
>> - fixed coroutine wait as Vladimir suggested with waiting fixes from me
>>
>> Changes from v1:
>> - patchew warning fixed
>> - fixed validation that only 1 waiter is allowed in patch 1
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Fam Zheng <fam@euphon.net>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>
>>
> ping
ping V2

