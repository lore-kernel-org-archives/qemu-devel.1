Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5983C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8066923359
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m5HDl8x0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8066923359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppB2-0003PZ-Pu
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jppAL-0002d7-Qp; Mon, 29 Jun 2020 04:29:26 -0400
Received: from mail-eopbgr60094.outbound.protection.outlook.com
 ([40.107.6.94]:5186 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jppAI-00048R-Qw; Mon, 29 Jun 2020 04:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUIReHv2SBNTHgGMOMXtae2CWSq23EKdlnxTRIzqY85iOhUI18E3ttsFWvTtd3h3BdGL2yBgvK1rsrnoBvtsT5Z6SoFAkz5k4LHlhQy6FxfCrZkNLdl31pcQhbpPkaCXoZNUhvFVKeMyBBDKZooPDydpND9ZFADpL0xtue5DIB6G66cjmbVJXG3Yuw2MwxJH0uCDPXlLtQMSPRuHRJBC3RtIougjlpRNOyPyPPD7x0YMNpXtQ+rv0LYRysWuspTFG65VZe2GUlCojv3jngq4+nlaFQqbKZA9L+MjU56esVG3fBCLOg2axXL8H7US9N5ylXbi5xObOF8S7gzutSdaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGGWWiuA3zNMVicQamqi5Q7UH3mWEskAOUIkgFVD+O0=;
 b=F3T3olMzT1V4lE8zLla+Fh6P3ZhNbBO0tJOjYIlaL1WbVKzh8bN0sHm6hI/nI7QinDaqdZ+yq7oGB/jE1lDzV3gw9BOlt7JrFEcSJCMqzICY7cmCeIsyLaN3fuRzXHlgXGdnmUjfdBtGSw2R3WtuhL0bBo133nGYNoMfOWv/xfvYTHvqzp8K5fCk51TdPqIzjf0uW3dRHIsJBVkPjTwK0HT4upll0QIa5vROWp9NtXqaFo6/uwMc9pyalKGp1bX/MYkEjnavVbY9Hzjq039/CMDTzSx+S6hZp19WbNofAuGeq+O+iNJ+TgPqO3yO7nvur7Btn8mdLqkSqqg46lMFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGGWWiuA3zNMVicQamqi5Q7UH3mWEskAOUIkgFVD+O0=;
 b=m5HDl8x0Nsk8egFNI6olA7H3B1B7soYxn06ScJmLsBSWNj1vECAE1hFP+2mhuvdEncuB1aESqEXkmX4R/R/7HysfvYHKNU7Mjo/Gxoy2ca7l/h5SAr42DofxlqSYLHryPT/abXGMaBXAq61CjK8P5ML9IjoKxU/dViAYjZ3LRjA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4071.eurprd08.prod.outlook.com (2603:10a6:20b:a7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 08:29:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 08:29:18 +0000
Subject: Re: [PATCH 09/46] error: Avoid error_propagate() after
 migrate_add_blocker()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-10-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4355ee71-7c99-2cc0-3c5f-7b7b46ab7bac@virtuozzo.com>
Date: Mon, 29 Jun 2020 11:29:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 08:29:18 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44747f8a-1a18-4a46-bd8e-08d81c068432
X-MS-TrafficTypeDiagnostic: AM6PR08MB4071:
X-Microsoft-Antispam-PRVS: <AM6PR08MB40710EAE676230097E8A47D4C16E0@AM6PR08MB4071.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gBti7zQCNPAgFGcOjJyn/NDL947Q3FRLo9jTY2xDiiVwzrnS2I75FwT9/iHs3BBcfEIsX2giwaTaC4LDz+9jWH+6awtbT5fosHG4MOp9Vfg1rTtpqoc9G3ekEy21OMXpQb6zSjIAckn5+4g9/Uvly+cUprHLNNQBrKrvUkDhMY+5mtFPLpyKwxL1cx7RIO1n9/ZMXe24tCi9wVd0ne5lyQHv7jaw4ecJmUfyIKC8wjhSrf9o6wlw/e8z3NCH8D4CBY2JPZ/CFlNs75nXilfPLL4DcwvM15WkAUUGGUsdCxi7uiLOPdoL8tTkWanmMTp5ndS6QQK+a81DqpAbqUG/9oK+UfQm5JicoP0ub2DiOf2zpOCclO0LFw74P0RcBoM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39830400003)(366004)(186003)(52116002)(26005)(6486002)(4326008)(2616005)(31696002)(66476007)(66946007)(66556008)(956004)(5660300002)(2906002)(478600001)(16526019)(36756003)(83380400001)(8936002)(316002)(16576012)(8676002)(31686004)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ObH09SzbiW0TrwJMVGSKTtq9w+ZdFNblqpJFP0tfL4y0eoxUfDnzPAYVQQQ65QTJllFU4jBt9g1x8aC9lT6v0IIluqOzsXKymLiLQWA/V6SoXQ9WHKCYOoe1xdX+K8ff7i6U27ph6PtJsG0m0CjVTq3n33wkOhciEUGL5RGPkOkvyeCWyaHEEcqS47seeEAB7TgqgAHyyodoagjCtGCKn2VOQabU8ghLK6Un63noJG8PCZUFBkoB68wd/BMu0yPi/pL5z4kIFS/vlVHpiyTNSnJFoOTA6R88ay+p5tnbiszPqJQb2hC42mDEvWw4a3yCZL1VgBT5gQqY12sbCmUHZBLPHvJa6bLqyN7+6/zGqYWkDV7OFMME/OfczCroCn0fpcRXsxn/0wL09rCGIJBdRZ+CnZmjbxF6dJuzm14s037kqX6wjg8srzV8OJ/EzQEIPiSB81OzIU0G8AbPBSbofu4Qk3SvsEq+90NUEDL4Lc0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44747f8a-1a18-4a46-bd8e-08d81c068432
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 08:29:18.7528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3uOCbSOvmfgVwlaVdGixdyAiuhgTEsfwa/w7qL4MUNIg36FSMYHN8DX2t8oNkSuyKpPY6OV+hk80W98CW/Nqwwvw2IXbV0YwLl6kjRiiLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4071
Received-SPF: pass client-ip=40.107.6.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 04:29:19
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> When migrate_add_blocker(blocker, &errp) is followed by
> error_propagate(errp, err), we can often just as well do
> migrate_add_blocker(..., errp).
> 
> Do that with this Coccinelle script:
> 
>      @@
>      expression blocker, err, errp;
>      expression ret;
>      @@
>      -    ret = migrate_add_blocker(blocker, &err);
>      -    if (err) {
>      +    ret = migrate_add_blocker(blocker, errp);
>      +    if (ret < 0) {
> 	     ... when != err;
>      -        error_propagate(errp, err);
> 	     ...
> 	 }
> 
>      @@
>      expression blocker, err, errp;
>      @@
>      -    migrate_add_blocker(blocker, &err);
>      -    if (err) {
>      +    if (migrate_add_blocker(blocker, errp) < 0) {
> 	     ... when != err;
>      -        error_propagate(errp, err);
> 	     ...
> 	 }
> 
> Double-check @err is not used afterwards.  Dereferencing it would be
> use after free, but checking whether it's null would be legitimate.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block/parallels.c            | 5 ++---
>   block/qcow.c                 | 6 ++----
>   block/vdi.c                  | 6 ++----
>   block/vhdx.c                 | 5 ++---
>   block/vmdk.c                 | 6 ++----
>   block/vpc.c                  | 5 ++---
>   block/vvfat.c                | 5 ++---
>   hw/display/virtio-gpu-base.c | 5 +----
>   hw/intc/arm_gic_kvm.c        | 4 +---
>   hw/intc/arm_gicv3_its_kvm.c  | 4 +---
>   hw/intc/arm_gicv3_kvm.c      | 4 +---
>   hw/misc/ivshmem.c            | 4 +---
>   hw/scsi/vhost-scsi.c         | 4 +---
>   13 files changed, 20 insertions(+), 43 deletions(-)
> 

[..]

> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index ad0ebabc87..87bc4aeca1 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -113,9 +113,7 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)

Remove unused local_err

with fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>           GITS_CTLR)) {
>           error_setg(&s->migration_blocker, "This operating system kernel "
>                      "does not support vITS migration");
> -        migrate_add_blocker(s->migration_blocker, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        if (migrate_add_blocker(s->migration_blocker, errp) < 0) {
>               error_free(s->migration_blocker);
>               return;
>           }

[..]


-- 
Best regards,
Vladimir

