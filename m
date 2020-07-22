Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70959C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343AC2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tSDeXqxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343AC2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyGu7-0000Ga-H4
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jyGtS-0008Gd-7p
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:42:54 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:22451 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jyGtQ-00066d-Dz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:42:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyCxoErV+ylRDzZkiR9Yx9pOrsaMvDyLbdwyGWBouSfNT9aX6TwhCj+2L9GFm4DrKzYh37Vat0AyXXrFKSL1SLpIRkxjXYavVGtBrJoKN/MDaB9I4NQuL8ZPWpqDVjf4BAESITLTZjUjwP+HhdGGB4hYJ8Sll0WwKRPgcwe9Phz4j3dRxqFdzP2xQg61oJD0EN2ezupMbSuM4oVmbjf1zDL7qScH8cr9RrkCLjuOlDbI6k2uBd7yHa94psLaSTfLfmivrMp1gaxaI1CBsPShE2gXtyV6fb6CXz1PMn2uiXH2CENKBbnWgWGS0VzEnqQOfSa9/mrfJr9Rx5Wv4GhcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOuATVPqsg26czJyhT1LNSXR92AVk/WoZarxOsFlBtw=;
 b=mhZcSHrbE2KKNskbD86/mNW+EvwADsoaxzi5tYAz4lgENXK3dbX6SDnum8BelGpRFSNh77XfJuqo8p7MapfhgQAbxLrAA2ecn8PP49i9DpE3XOP8ZAdDTOjUmI3Y1p1B09qnqE9nMmbBT/VAAAB93a6ewc4geKX1E9je0iqFLPBE6YnwjYmdNnVHuT4FK/YbLQVluB8t7S/6nYZFNAIH6denZmGKGj5Iezcqd4QxJgFaS23Bhjh30xiDf32uRYPlinZ3vQgsveDX/iKb05kssmcDj5egFpu7oNb0LuKFwbjuqiLg+V0ppWRi0OAaBgSYaYEXJ/FY+qN2KpF9GrD6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOuATVPqsg26czJyhT1LNSXR92AVk/WoZarxOsFlBtw=;
 b=tSDeXqxQ3EKbjvWSD+JZs6r2Qcnpja5ylh66lbQIrbrtdsLcs2ttISAf0GCMAePgdSN4dSXMQRCysC0kBW8qc2S1MdTvxkn1VI8mE7Oq1fZhSQXX96i9JbWKaaEuaZbIFmz4u7AXrdb6cIApM/LOgBscGXJ3MuDYxkxvizZEpx0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB3316.eurprd08.prod.outlook.com (2603:10a6:208:5f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 15:42:50 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd%7]) with mapi id 15.20.3195.025; Wed, 22 Jul 2020
 15:42:50 +0000
Subject: Re: [PATCH v0 0/4] background snapshot
To: Peter Xu <peterx@redhat.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722145034.GZ535743@xz-x1>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <8146768f-7804-e239-41a0-3f7997f6b75d@virtuozzo.com>
Date: Wed, 22 Jul 2020 18:42:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200722145034.GZ535743@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0035.eurprd07.prod.outlook.com
 (2603:10a6:200:42::45) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (5.138.110.191) by
 AM4PR0701CA0035.eurprd07.prod.outlook.com (2603:10a6:200:42::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.17 via Frontend
 Transport; Wed, 22 Jul 2020 15:42:49 +0000
X-Originating-IP: [5.138.110.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae3e2f23-d6b1-4434-6f8c-08d82e55e390
X-MS-TrafficTypeDiagnostic: AM0PR08MB3316:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB331636D4E3F92CF7CBFEE024CF790@AM0PR08MB3316.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51vOy6ZC1lnpLUg5DJTIszc1JENRg6rW40JAuFLTYbi2ONjdnyPuZbS0Ktw4qZLv5Thwbmwc78k3KJjhAEQltfmHbTz8L5t0pY7CLJndp4QJY3+WEGWBOy47Gi0eImTCsky42XP3o+weu8NDvY/QlhwH95MArgYDFDVmCgLN9dZD0f4OX+JmzSMENxHzZPc7vQ2ZZslk9ir09no7MTCpUglLZD7a0CrdZJl6KkU0GDcOzdEz2dP9gLzY+7rYdqkr5abIkpZaY7C6+pvJVT0F3BzpqhB6KdPvxmHDg9KH6OCthEDDBJYPAgpTOkvfu6feq7SInYnX+1LXK+kLl/Vtcu0kM7NubyoCA4nSLspM2//Apa605+SXIHmEfDQ0f5A3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(396003)(376002)(346002)(136003)(16576012)(316002)(8676002)(4326008)(86362001)(8936002)(52116002)(31696002)(2906002)(66556008)(956004)(66946007)(66476007)(26005)(6486002)(31686004)(186003)(83380400001)(5660300002)(2616005)(53546011)(16526019)(6916009)(36756003)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7+WvsNSi4oDjc61o3oWflQUc3ePDSqksYq7/9rvWHo5Wgomx/fwl+kA9n4kUg8JtZANlLSKLs5sXRBMiV3SvAmfHsMPu+FjKhym5evqqxcBkVxgIj1fdBYddWaWphmtmGYJXV5VE+WK0cd9OrG2AEUarOailNpA+eY+Lq4ZV2P3YM4gRd5XUedTzivxxYVcK1jjNmwB6zZU4umiIKepiiA6yW2GXeDZT8d5DY9qFZ03jmmHDuIgVKTgp2OvWoo9R7KlmQCBtPG3DW+T9J5P1I6Ap6PmFw0j+dhynY4mFMpN6iTRHZk0lWVnnZJw8wfinQohAx3la9ZZHmybUNsSbOO18w1XJu3PBiXGmFvQdN3EToGztRkMc4QgQ1C9auBoZTvnoDEDpO1UO5lhL8kyyUUgamP4BPQEkGvMPHtIiHKt9BxXUg50U+oUzCu3xXHkljk1vvXIW7SCJ4a6oe/JwgbDsJGEakSznyBDr3AKPgyg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3e2f23-d6b1-4434-6f8c-08d82e55e390
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3745.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 15:42:50.0465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF37RFCC/3muupA9LtsHyaV8L5pOnDE40z1jcqELiO5+mXwa55wjImlIePQ25MlhnZqAwqj7rgBge5faNt3KfBz69Kcv4zSbkkoTBY+I9RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3316
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 11:42:50
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
Cc: quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, den@openvz.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 22.07.2020 17:50, Peter Xu wrote:
> Hi, Denis,
Hi, Peter
> ...
>> How to use:
>> 1. enable background snapshot capability
>>     virsh qemu-monitor-command vm --hmp migrate_set_capability background-snapshot on
>>
>> 2. stop the vm
>>     virsh qemu-monitor-command vm --hmp stop
>>
>> 3. Start the external migration to a file
>>     virsh qemu-monitor-command cent78-bs --hmp migrate exec:'cat > ./vm_state'
>>
>> 4. Wait for the migration finish and check that the migration has completed state.
> Thanks for continued working on this project! I have two high level questions
> before dig into the patches.
>
> Firstly, is step 2 required?  Can we use a single QMP command to take snapshots
> (which can still be a "migrate" command)?

With this series it is required, but steps 2 and 3 should be merged into 
a single one.
>
> Meanwhile, we might also want to check around the type of backend RAM.  E.g.,
> shmem and hugetlbfs are still not supported for uffd-wp (which I'm still
> working on).  I didn't check explicitly whether we'll simply fail the migration
> for those cases since the uffd ioctls will fail for those kinds of RAM.  It
> would be okay if we handle all the ioctl failures gracefully,

The ioctl's result is processed but the patch has a flaw - it ignores 
the result of ioctl check. Need to fix it.
> or it would be
> even better if we directly fail when we want to enable live snapshot capability
> for a guest who contains other types of ram besides private anonymous memories.

I agree, but to know whether shmem or hugetlbfs are supported by the 
current kernel we should
execute the ioctl for all memory regions on the capability enabling.

Thanks,
Denis

