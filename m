Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31536C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CAF207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="Na7ir7Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CAF207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8fDz-0005E4-11
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 03:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k8fDC-0004JY-FL; Thu, 20 Aug 2020 03:42:14 -0400
Received: from mail-eopbgr130094.outbound.protection.outlook.com
 ([40.107.13.94]:26496 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1k8fDA-0007A9-0b; Thu, 20 Aug 2020 03:42:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf0SK0nALv7Qn7G/Y/rdtKQuMiJTsWl1VGvNO1ddWgxh2sQyvKXYn4BR+p77nPSmLSlBnrhEXav3l2o7F2n7SLRsgU+D5QUePCSlOh9WtQ1IvL0c7uVSu5oheP8TLW3C2zwS0AayKULbXNwchgpxftmBBArQn3jr4tY/3mi6pVc97tWhyBUu8Bzg09YbS49vr0n+jZbXm1wlEA4x1uRw76WR9eUAJezvd/MlyhGw75Us62hy+EPls9xhwh24s2quEunR6gdI52uFz3FQblTU4SKV4f4wvcC/ZlqOy64DICtYsWQ3qT1j90fUT7GbuxgE/LYDHfBxeL26OCBrsBFCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6PHKvub98e5K3ZZ4j2ziUJ4WXKGkaJq9ozopuMrXEE=;
 b=gCtVaXF6iE183o6jHP9LVPvZlGOld4keCrC8y9nVBCyCeOBBBwIg25ivX1vV5k14kcqVQkkcxhCXzzfrc7EW5ZkD3+vOud5Z0Ga3Od2A3K7NEDgMaS7f6JWFsWABaBFBhfio/W72riY6xsbSSNnH3+gYUi+7yh3qoV+lb5YgwHx/LP3ZTwf5M+DHFZXVNSHvxfCE/Dclo90b9NXMyA33tFFY93hurRuSDljrF+Z8GgZFcbtjx2qz8k/DZAs7t5O6A4LCjWT33VvgUJ4LFSNNREsHSuh9dvKle/ps4QwOB5nCJcxnfGFxHFiTV46mIQL0fPhIIxQdX+3Z4ZNn/spd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6PHKvub98e5K3ZZ4j2ziUJ4WXKGkaJq9ozopuMrXEE=;
 b=Na7ir7EdnpPyuknu1fyFADRk4ZFdrW7refMKYyp9nHlc4PnJHMg/zYk5574/AoWedpef+B0kB+MqwRPhiaxbOtJ/PWM9JHTJ60C6rrqOeHK8eyV5IzoUJhCK0pgGGsNPHzzUaH3mjro4uN+hgXYUe4TfwE4EAr45KwfrzzE9fvc=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3221.eurprd08.prod.outlook.com (2603:10a6:209:49::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 20 Aug
 2020 07:42:04 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 07:42:04 +0000
Subject: Re: [PATCH v8 0/6] block: seriously improve savevm/loadvm performance
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200709132644.28470-1-den@openvz.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <a722fc99-b367-dbd8-fd45-de7fb1a18f5d@openvz.org>
Date: Thu, 20 Aug 2020 10:42:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200709132644.28470-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::16) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 AM0PR02CA0003.eurprd02.prod.outlook.com (2603:10a6:208:3e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 07:42:03 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd681d6-aac2-4cb0-4735-08d844dc882e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB322142C5F312C14C31F1C9EDB65A0@AM6PR08MB3221.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6Rqz98JMcRV9lgpU6Bso1dQkMtwlLMFGJeKrbHylWdqIh8YIJatbvEysg3124QsrykhuXLobfm69l2VeaboSxn/I6lnguG7H+RGJaPd2aH1r0iJbfj8eif2LzUpTqHu0oE2oSOdgQqd7pbsAOtAFpVqKQTsDApIANgr/pfup+HWL3ckJ6FUyD9zXVAyZvCDKYqL49A0krNfXox+4nY4C2C9nsXiTggh54cqeRjGNXZSk5ahtd/+1nqPSg/RRKGlwhBJ1UVFCoMLCSYn2/RvD9bK1xf3cLjfSy0oIQr5oXkAyKHi3k1XU0kJkkSJ0HwM7iShfRQ0GI59ONjni05jXgsqZd4dT7kHJOqmKtDueFB9et8T0bCl/IE8Mij4K6XQvzmwtGRFWWN+MbaxLwID+6Juy6AxJEOR2JVd8gXdiU0dGAx87bT/nTFguJKgGIYRMqqQc3oMhYDp/HnP4lsWDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(366004)(376002)(136003)(346002)(83380400001)(66476007)(8936002)(83170400001)(16576012)(107886003)(478600001)(4326008)(966005)(316002)(36756003)(54906003)(52116002)(31686004)(66556008)(66946007)(5660300002)(6486002)(42882007)(31696002)(2906002)(2616005)(186003)(16526019)(53546011)(26005)(956004)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tXpGuS1kXJDXdOiuDlL0uumPMu8OH4CTBWGe9UdfaKh7YBIRKG+BC11Lmm7NI/Akk9kbo4Av6NN9t/druSlkWqp6fWc+h5XVDAgODIzWd/Q9J19dN5hR8CHJnlCAACJYBal7rZ32Z/KAsdYDyDQ46D9UnhqKXW/bKf5hH+L+08SwrKFTxcdJOYdUH9zGttcKrU2ldQ1c/7zoTMMA4m4q78jdw+VnZHPkYWNyGyBUvaWU4r3RrEbg7Hr+MQrg/3tT5R+wXhWz09eIFuYB4gJYWJTInJl7YD1d2GMBonF78FwS9go7W7rcSyO9TS5UeYC3HzjGQ70bnO9ChKZFr1E8a2dIawyUcUVx70/FnUqgC4jjTQInHQGEyVsO6eY7pz1OK2gGxAoNIeDnRBzAUyyMRxBhIjC1aioGeb/egzfrykdXkgiS4VIumwWtzDo132+tBJLWMG1hAhuyjlBGc2keZI+eTPHdDEYqL2A8njwr49qlMQrTguHh+8nwab2RPLRB6V6h6iAGYq/vQMld77hrF2JtZnsuY63Tjieucu9BC4msoEKzUR4RiScjN5f+Y9uretAHmJB94PxU6mP+I8aIoB9wtvAtkl2C1GAACTWg2Jy0HTQUU5hNQFssyk9O9O32NooS+MWEboZJ7JBaGOSxSg==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd681d6-aac2-4cb0-4735-08d844dc882e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 07:42:04.2402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/su98BO0x/FhhlSB5d1AvwLRZW/h7rxuffncEojnQoydy+yTWo5A1PmP65BTJqXEQ7326v/bkdrNu/FmQUodg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3221
Received-SPF: pass client-ip=40.107.13.94; envelope-from=den@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:42:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 4:26 PM, Denis V. Lunev wrote:
> This series do standard basic things:
> - it creates intermediate buffer for all writes from QEMU migration code
>   to QCOW2 image,
> - this buffer is sent to disk asynchronously, allowing several writes to
>   run in parallel.
>
> In general, migration code is fantastically inefficent (by observation),
> buffers are not aligned and sent with arbitrary pieces, a lot of time
> less than 100 bytes at a chunk, which results in read-modify-write
> operations with non-cached operations. It should also be noted that all
> operations are performed into unallocated image blocks, which also suffer
> due to partial writes to such new clusters.
>
> This patch series is an implementation of idea discussed in the RFC
> posted by Denis Plotnikov
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg01925.html
> Results with this series over NVME are better than original code
>                 original     rfc    this
> cached:          1.79s      2.38s   1.27s
> non-cached:      3.29s      1.31s   0.81s
>
> Changes from v7:
> - dropped lock from LoadVMState
> - fixed assert in last patch
> - dropped patch 1 as queued
>
> Changes from v6:
> - blk_load_vmstate kludges added (patchew problem fixed)
>
> Changes from v5:
> - loadvm optimizations added with Vladimir comments included
>
> Changes from v4:
> - added patch 4 with blk_save_vmstate() cleanup
> - added R-By
> - bdrv_flush_vmstate -> bdrv_finalize_vmstate
> - fixed return code of bdrv_co_do_save_vmstate
> - fixed typos in comments (Eric, thanks!)
> - fixed patchew warnings
>
> Changes from v3:
> - rebased to master
> - added patch 3 which removes aio_task_pool_wait_one()
> - added R-By to patch 1
> - patch 4 is rewritten via bdrv_run_co
> - error path in blk_save_vmstate() is rewritten to call bdrv_flush_vmstate
>   unconditionally
> - added some comments
> - fixes initialization in bdrv_co_vmstate_save_task_entry as suggested
>
> Changes from v2:
> - code moved from QCOW2 level to generic block level
> - created bdrv_flush_vmstate helper to fix 022, 029 tests
> - added recursive for bs->file in bdrv_co_flush_vmstate (fix 267)
> - fixed blk_save_vmstate helper
> - fixed coroutine wait as Vladimir suggested with waiting fixes from me
>
> Changes from v1:
> - patchew warning fixed
> - fixed validation that only 1 waiter is allowed in patch 1
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>
>
ping

