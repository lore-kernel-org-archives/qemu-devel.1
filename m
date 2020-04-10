Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9E9C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 08:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4182120753
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xi9b3lpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4182120753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMpLr-0000Ob-FT
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 04:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMpLB-0008MT-TW
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 04:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMpLA-000372-TC
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 04:48:45 -0400
Received: from mail-eopbgr30121.outbound.protection.outlook.com
 ([40.107.3.121]:6766 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMpL6-00032j-C6; Fri, 10 Apr 2020 04:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjaJ5whykPxyEQseZaW+bcjWIiVkSSi4YoggAe1puMCGQ8XOQUpRyiYHsFthr7OS1gFAnHQKiV7VUPqJvAaJpBssLUfBjVM5hZD0NvbuySrNgfOox3acCHjAsG1hr/1/T58tgG4wBDP+Iz7CRlwe7J6Om5699nPE1jWyG6r08fdQ/O9NDtygZv0dt+2ecEp3E9QdxOsNWdaHnltH4OxvBwOwOe2ThCxMoG0RDdoxlDldeF7EoF5JJqzLwDqa81dQK3wAZdAql+oVSazdaCNsA1ae4pRT7powkYnjmizR5NC+Ak5aPPEYGRIywJBmD6QAl+UF5bvMH3y4+0TCjOOB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHjfs4yYT/9/QO4jMKTBHkWLBtN/TGFsUHOojb24zR8=;
 b=iPn/hg+/PQtQXtCKMzh0IZS33xhLlIu7jWrsgWFaIrGk2AJWV8SPQOde6FpoFMJWU+EonBGitLokObubHTZ+0TgLHZDF5p+RAAahGG8uGUZ5JqP1hHcUXr9LY3tUWgUSb5yhWcMr3vv/oM7og+lXyS+XiZvnQykq/a/JN/UGeoXv9JKvNOULIkA5KHGQHIR/+hFsUs4BGBVrtIik/jaWxf7Sa4ezxfdr/gxgTv8hwImHgli2R4gjU1LXKKNLMsL0Q+/o6esI2FX/vSWgSFkGIA1XDpyehzRpOY5fYJCtAWu60ciqtcZ9Gg0XcQDg6kZGfhfRnK5h36AmrworzHn0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHjfs4yYT/9/QO4jMKTBHkWLBtN/TGFsUHOojb24zR8=;
 b=Xi9b3lpt7NtTTao9GZIQdfvrrjpwVATNRejsKBxeEwgbnr80fJLp4ZR2CWTKvE8jzRjgL82l3xu7MzDi+5+FF2bmAI7bISRB1fzpBNlUpbpkos1Kn5SBIaR6uEd9S2fSaFETHTZzOVtFQK+yPUP+dTdXSLO/RP/+vAio/wlzkts=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5349.eurprd08.prod.outlook.com (2603:10a6:20b:107::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 10 Apr
 2020 08:48:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 08:48:36 +0000
Subject: Re: [PATCH v4 06/30] qcow2: Add get_l2_entry() and set_l2_entry()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <bd054be18d469233e7ebcb81d8e8190c1f2eda0a.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200410114834353
Message-ID: <82d3d5b6-8b79-3639-931d-7bb576d5c818@virtuozzo.com>
Date: Fri, 10 Apr 2020 11:48:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <bd054be18d469233e7ebcb81d8e8190c1f2eda0a.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.134) by
 ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Fri, 10 Apr 2020 08:48:35 +0000
X-Tagtoolbar-Keys: D20200410114834353
X-Originating-IP: [185.215.60.134]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2a67e0e-faa7-4e7e-1c7c-08d7dd2bf528
X-MS-TrafficTypeDiagnostic: AM7PR08MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5349FE60A7DD7A3550DFDB7FC1DE0@AM7PR08MB5349.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(39840400004)(366004)(346002)(376002)(136003)(956004)(52116002)(26005)(16576012)(107886003)(5660300002)(54906003)(8936002)(8676002)(2616005)(86362001)(478600001)(81156014)(36756003)(316002)(31686004)(16526019)(66476007)(6486002)(66946007)(4326008)(2906002)(66556008)(31696002)(186003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjVH4EHPIr4WgCF3aCFeaSRZ3Y1iRMZnWWlX7GuLW3EzmRrqQ7T5jvScyJnqTXBVSb/g1OigKbtRI6pVkurHFja5InhXE7kLYJKVaRcqkYNz5niTliUuJQyKnmORD/iEx9szOjdmepnuaZ37Bm/mxu+5+EIAbm4Df3foltGRn6syprhx9WA7MWwN8CXAtXR/whod9MLEdTdDyYx9njzP7EGhYIjdh16bmV9G5Doa2HvPBN1yTaIGipaanzJvN9phs3BrXOvmIAkLhIDt/OLBLiDRTpNiTPwrdhQuVLRsQYB12nO5EGUy9VG0NeWGRW2aaw9/e6h7NacSLKztn9WvCH/8jf4I0KkH8joOGaVvjmOTFZDoNjRo79wWkUIeg/HOFd4+1c0n9HSdbmx16VxekAsU/pRuEQ9kATEjTn3TrBbBal5h4gPFVqDYQlj0wum6
X-MS-Exchange-AntiSpam-MessageData: bNHDuR363yzhBmrT0wTqpGw0UQ8EAVX5t7nkI+c0UZQhLgig17HyCr/Zlb7e68sRNZ6nrzIAhcpsrObBM/EURXJ3i3uTZ0Ty3o3j+C+5K7Aw1yJ0D0pXS5tYt3rWXbB/CcrgWEbWmzP8I2NxWVRBFA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a67e0e-faa7-4e7e-1c7c-08d7dd2bf528
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 08:48:36.4833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+dWYGd+9rBSYDprnokeK2Xgh1D+1+ZA+f+/nBw5qa0nLOZYnX1MOSRgTf9owOLpjfX8TIYVkRX1SUvltQVJy55VUnj/7dhSH3q/sjI0+es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5349
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.121
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> The size of an L2 entry is 64 bits, but if we want to have subclusters
> we need extended L2 entries. This means that we have to access L2
> tables and slices differently depending on whether an image has
> extended L2 entries or not.
> 
> This patch replaces all l2_slice[] accesses with calls to
> get_l2_entry() and set_l2_entry().

and it replaces some l2_table[] as well.

I found one not-updated case, in qcow2-refcount.c:

        ret = bdrv_pwrite_sync(bs->file, l2e_offset,
                               &l2_table[i], sizeof(uint64_t));

But on the other hand, if l2_table will be enhanced somehow, this should
be updated other way, as we don't get l2_entry, but write it...

Also, I don't quite like the naming: you'll update in further patch the interface

to be [gs]et_l2_entry and [gs]et_l2_bitmap..

But get_l2_entry, don't return the whole entry, only one half of it, same for set_l2_entry...

May be, good to make a comment above [gs]et_l2_entry definitions.

anyway,
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

