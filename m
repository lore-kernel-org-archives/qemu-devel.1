Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106F6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED4A20780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YAgiWZvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED4A20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxQp-0003e3-33
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqxKT-0007dC-9d; Thu, 02 Jul 2020 07:24:33 -0400
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com
 ([40.107.21.91]:28609 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqxKP-0006Sq-Eg; Thu, 02 Jul 2020 07:24:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgSLxvEaJlMEAs53Z/AGozYaZzpStHyn0fyKhm/nOwixx1imERMhMD/VZ81GTfEdxGTDEp6HNY+dne4443o+2bpbAE8VYWJx7XucSYsLrWqZ8eyQA8mMkLcc2zp4VIExi67qbfin9Qly4JAkktM75x6Ayblay8rqdZwK9LXq5+3J4fqr3U5N0GWBLYglTYJ9QNIUSro+irpWEQhv4on48ys84Vf2I5xGzkll43VtZ95znqtBpbh8TPIQIkYI63+v2UfvSzoNZjwB6GdFgMdOhln0LJkYt4wCeb7u1K6OVK9S+h0MlnCEa5H9t9Tte021Sc5GfKjBz535DUlCqGQsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsgHCVMYP4fglyeSKlHxylLAwoW5DaL7a1FAeG1/tbM=;
 b=HEXIMuV7o+IQV8kTz44ZyuxhTFYzbXzvN1LDpehWykWOtxDytYDyaOqxms6eDrrSkcFJqFKBICji60fPnBkeByV37YY5iJQmXRMGrK45LI585j9n/ZnxbA5n/yAwpA2zPrRUHApBNNQO4cEaeqBB4xUM7KepXtn0C7r9MluDK1klXONKH5bID2BVG5+sMxZtuPSihUQCnlisjSalt5zBnl9G2zt0LJaKd1tYZb88dv62Vy+YxVHhhcnBeXvUCS1esJzMErMkprayvAFJWqooJEgV9QkihyafB+yq7Fpt0ziNIv87tgRZhSCJ5IagxOu/xC/adnP1gQkexy/wSGeonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsgHCVMYP4fglyeSKlHxylLAwoW5DaL7a1FAeG1/tbM=;
 b=YAgiWZvtUNsb1O5YdC7ZiHupDawu7ODgQokJakzpI/JSeDkNlCuMskXeSI9zTj3f8St9xjOPWWJWWO8SsAhKXMhcRjWaRSSZqe0+6aFznozPubMK1WNgO6Kv1me1KzcaTBBxM7hzad/XhRzrYoFmCXKQY80zEpGNbmEwIjZ29lQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4788.eurprd08.prod.outlook.com (2603:10a6:20b:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 11:24:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 11:24:25 +0000
Subject: Re: [PATCH 0/4] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b4ac8f7c-ebe9-6fa8-9b03-b12b457a3e5c@virtuozzo.com>
Date: Thu, 2 Jul 2020 14:24:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200630084552.46362-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0123.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.54) by
 AM0PR01CA0123.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Thu, 2 Jul 2020 11:24:24 +0000
X-Originating-IP: [185.215.60.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1df4ab4d-c577-4c06-8e74-08d81e7a79c2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4788:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4788E2B969B39E630994A7DAC16D0@AM6PR08MB4788.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyMxUtd9etgBFF+HLzUq2//bB36gxlM3etKcZTwb7iEeDckzEzi97/RtzyrgBMErvTL65on2WAKG7A1jtWBXzDDwbX3d2erIwWiAyzq76tTuT7x9U52PIG4wvsFAfvIOWWaLb+d05H+GgDJ/ngeLEq/Kk/2rQOelUOCCiakeSu2I09mTXjOJQJGjfGGximjIaRNG8OIlWwaoxoPm3lwq5TtFQ8s0izBvKOb/nzjUvrw9M8xYeMnDPfbwdJ+CiDeUPJ+wq1Lkj/f8TMb786CNlbmRuMQ5ghT3Jltm4eGMLCOoz8QCeTtPE+z8goJFBoCXgSdPVwhvCpQw9jBCfAId3LcJiJr3rXWEpVcxkipw6DQkWzrrER+4GSHmUDVBWiJ0Gxe1Jwt8VEWNr3SilIKFoQxTaSd9N515i9suvEvpgWjMPdgHDBZUOXfk1Kfx8cSKYMqzA6xQQYESSKLAFVrEOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39840400004)(366004)(376002)(346002)(54906003)(6486002)(16526019)(4326008)(5660300002)(83380400001)(52116002)(956004)(2616005)(26005)(31696002)(86362001)(2906002)(478600001)(66556008)(66476007)(186003)(16576012)(316002)(66946007)(8936002)(966005)(36756003)(8676002)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xduqggVdJ71zNBlxK9FMv72oKWVZRfLWIAmwE2D6uiV/ON8nekHnKZZD0Fgmsfx5dD71znIUzaLy5DR/1GvF3hOK8yGTHx5+X6kT3IaavQNWXQadkP9wDvm47t7if7lrAfSAIR1EQ92lZovk/sYkEm+9BohuXNWW1G8jkHEZ+qpdP17Oc9cY4AqIMHlek9Wc6PmKNKCwxm9mZVFYeobMWF+Dq3rySvAHSuuCxBXM5/uLj6DO02Iw9sBx4rWx/72sb6tfsrLPMXcgz6BzpTOFuw9CuzIqHT6262LM/QLA76W5SBKx84fFtV9VW8QhYKX0UgZhcp+btSOu2enoFusKJueyKcUI21dZqPZTClEmZ004BgIwLxFpZsQXqFIUzp0pTS+kjRwRbSPDgEiMGv1U4wg59RTvHGQc/QYnCkYFT8h3TXM7f0qYgTsyDFcq0B51A8XCtY9HHfBkxutwiPMigOliJpdy2CTNK/firJHSmY0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df4ab4d-c577-4c06-8e74-08d81e7a79c2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 11:24:25.1836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DO28S7QqsP/uk4geq3wtJsl6EA7MzWfOXPoTFrtB9o6iJfnr2dKVlH4Ypihd8J80gHrNh4qJYCuI/IFpmo77HRFFn18DSLbdqnkeGnkS/Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4788
Received-SPF: pass client-ip=40.107.21.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 07:24:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hmm, seems, you didn't use scripts/get_maintainer.pl, as neither Eric nor John are in Cc. Add them.

30.06.2020 11:45, Max Reitz wrote:
> RFC v1: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00912.html
> RFC v2: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00915.html
> 
> Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-v1
> Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-v1
> 
> 
> Hi,
> 
> This new migration parameter allows mapping block node names and bitmap
> names to aliases for the purpose of block dirty bitmap migration.
> 
> This way, management tools can use different node names on the source
> and destination and pass the mapping of how bitmaps are to be
> transferred to qemu (on the source, the destination, or even both with
> arbitrary aliases in the migration stream).
> 
> v1 (as opposed to the RFC):
> - Added an iotest
> - Allow mapping of not only node names, but also of bitmap names to
>    aliases
> - Make this a migration parameter instead of adding a whole new QMP
>    command
> - Added patch 1 for good measure
> 
> 
> Max Reitz (4):
>    migration: Prevent memleak by ...params_test_apply
>    migration: Add block-bitmap-mapping parameter
>    iotests.py: Add wait_for_runstate()
>    iotests: Test node/bitmap aliases during migration
> 
>   qapi/migration.json            |  83 +++++-
>   migration/migration.h          |   3 +
>   migration/block-dirty-bitmap.c | 372 +++++++++++++++++++++----
>   migration/migration.c          |  33 ++-
>   tests/qemu-iotests/300         | 487 +++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/300.out     |   5 +
>   tests/qemu-iotests/group       |   1 +
>   tests/qemu-iotests/iotests.py  |   4 +
>   8 files changed, 931 insertions(+), 57 deletions(-)
>   create mode 100755 tests/qemu-iotests/300
>   create mode 100644 tests/qemu-iotests/300.out
> 


-- 
Best regards,
Vladimir

