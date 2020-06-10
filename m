Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D856C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92C220734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BkO6ZsPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92C220734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiu3t-0005J0-Us
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiu2X-0003vi-Ce; Wed, 10 Jun 2020 02:16:45 -0400
Received: from mail-db8eur05on2103.outbound.protection.outlook.com
 ([40.107.20.103]:10080 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiu2V-0003zN-45; Wed, 10 Jun 2020 02:16:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn6qW3LoCtSNje5F4UAWaxUYl9Jqbbtz6+08gjcLJIHZg8KKh859x6bc8CdfmOahzYivuQwLH17IuPNuKPt3dkYZlWEoyZiCwCYCq/mB7kGhQM4HiduGZ2n3DinnvOwBhSJRJOdlR906QjI/oHGNK7uSxeyaxddi7IZnEWIU6ggeWwlXFoP1zTpCtRFfBm84s/HauUVmNq6eEYD27s+XOj+n+E/8wOu+cy7uKu5Owh1HdbDA/RKVD3Px4DeR8rTtOafyX61/JogX7w4+p6+a33dPjx/jIxAGDO8HgD+1K46LGZSTvueVR5srEBCTyXwe6dlJEc6nvS80TzsbDJtn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAkTMRS+TfIWXPXlxOzyM2thV/jCgT4hlOPPUQGBkFg=;
 b=kkVMLK/lGaHOQmIjTbEVP7nX8ZLNsA6A3BQC2hLCiA++ueOWQmJA8K3nYwiK7KGvIxz3cnvUE5si24I+Hzhu1lvg4NfmU4Dn/878BGO0pzhyHTnyt94rpTplMkY8/7jBxKLmfXIojCF6u2mRPchMgufe3ttc5KkZMGD93cdOAYSkBFrJUzHMn/JAxgN52VkUDYob1aIePBkt11P77sh08E24+3odNgBK8V1BW/Gq1ha8tXWVhv9YPdgbCgVo/9jbOCPSsYSemcQx9m3nFLsjeqeU6AHpnQOi3mmhx6TCyD3ILEO2XF+/I0QajYUKNLQHhLSNq5NtkmKSDb8g1oYaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAkTMRS+TfIWXPXlxOzyM2thV/jCgT4hlOPPUQGBkFg=;
 b=BkO6ZsPhJkpUBKLQb3m7XkdNor/5pL08QQVDPZNqXEReIuqHuLdId/oKNK60Ce++fm/wNWjrHNTv6MxhlxHGjS2T0EMLMNMqPGbpVaWuPzUPc4MC1EEYEI/krFv6PhMyYIkuyzhj614zfjiyXMSg7aZRoNjaaFDoYCiAxgJkWWE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 06:16:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 06:16:40 +0000
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
To: Sam Eiderman <sameid@google.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, david.edmondson@oracle.com
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f93b4d9a-4963-74e9-4f52-f95a187f6055@virtuozzo.com>
Date: Wed, 10 Jun 2020 09:16:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0112.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0PR06CA0112.eurprd06.prod.outlook.com (2603:10a6:208:ab::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 06:16:39 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0bece5d-24c7-4d95-23f4-08d80d05d68b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54300B9DA1777E14325A1383C1830@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NV5MmKokztGTMBpexO73IQ8/DBuSBv2Hg+vxFs3hcUsxZFstg6zlVw+lMSWb7YOoBmloHGMCXzyaW16bEynW4pb4rD7j2fKNIyi69UTmOHCTW7iyke0Wfy2KEr3uxqCxqL9p3bsfyA7CSGKDWFfeovNcXDyDSyDGmom+7DzSaRZOAS3E9Sp7ZSpDgWRZ4EhjikGRG9SKWtN9MrOb6WjrSztL5oUg3wqXXxE12ErqRwsSgx2RJT+9A8SMMKKdxaExUlrVcvwUF/iFWXWRNClmxOcnjhCEalVpCyVkca44VpsjapXI1IQ4WINQxWoC4uB2/wHEuYbhXt6skraK25Pe0SRZ6J7v00z6ndidgxKDlHpFYyhoZ/LASSsLeCKAJSQB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(396003)(366004)(136003)(376002)(16526019)(31686004)(186003)(478600001)(36756003)(5660300002)(2906002)(26005)(4326008)(83380400001)(8676002)(86362001)(66476007)(66946007)(66556008)(16576012)(8936002)(316002)(6486002)(52116002)(2616005)(31696002)(956004)(54906003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CJPvk5eLPShqvB94Bo/zbCTj1zhNLwGW7vmJAkR4nApi+WakYhASkjJJd01KWq8uX2vuchn4c86Sz2FrNIE+YyOo3nErA+cQVz4GmYTZxPvRdBVmpzhShsBzA0qKRGR3HTskwsvNvzXKxCUEYk3IbFXHJJ084SUvxnQYtQkinguBOCXrj08RcMYehQWjKWmb533njnkP0mwp55TRhiXzxAoP5ohmjtDtylzsFQXjRowwCk017BSsTfciRmJwpgOb/Eoh1apkNSo4NVr/9K764+Pped6u0FRtmLfD+SfB+I/rTA/ObLo32KvTHeS2KT3acinnBUSTlbzT3iMP7XNAVTRUqNrAvOcaWv/QeZ9dw4hhmhfmprvMU790tJIznJBt3T6RrVjLTzv2cRtj4F8Q2dlqf8r6LRK8/kKB5jVHImyxqEqHXYq1WFwvoe+6ytJD2G3GkLoa3lDU9j+STzJUoD+sbLsCgHPbxLc44ThTH1fDsQ1TbOsf+cJefq0ysFM4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bece5d-24c7-4d95-23f4-08d80d05d68b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 06:16:39.9341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9f1hQdmCoLI0+PDstN3IuG4B7qX4MLcbCD3e873hLsKXuyaWjfujUpSwLZYquRUNQUqA6ptDGzCn/eVn5cRbsSPSMJOwfQwSwbh/ceis8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.20.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 02:16:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Tony Zhang <tzz@google.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sam!

10.06.2020 08:28, Sam Eiderman wrote:
> Hi,
> 
> 168468fe19c8 ("qemu-img: Add --target-is-zero to convert") has added a
> nice functionality for cloud scenarios:
> 
> * Create a virtual disk

What is the format of your target?

> * Convert a sparse image (qcow2, vmdk) to the virtual disk using
> --target-is-zero
> * Use the virtual disk
> 
> This saves many unnecessary writes - a qcow2 with 1MB of allocated
> data but with 100GB virtual size will be converted efficiently.
> 
> However, does this pose a problem if the virtual disk is not zero initialized?
> 
> Theoretically - if all unallocated blocks contain garbage - this
> shouldn't matter, however what about allocated blocks of zero? Will
> convert skip copying allocated zero blocks in the source image to the
> target since it assumes that the target is zeroed out first thing?
> 

Yes, the feature is only for really zero-initialized target, it will skip "allocated" zeroes as well.

What you want - copying only allocated blocks of backing-supporting format - looks like "top" mode of
mirror and backup block jobs. Didn't you considered using qemu itself (in stopped mode, i.e. cpus are
not running) or new qemu-storage-daemon instead of qemu-img? With this approach you'll have the whole
power of QMP commands to manage block-layer, including block-jobs.

-- 
Best regards,
Vladimir

