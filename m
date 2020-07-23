Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DAFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 08:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B62A20658
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 08:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l7u4PaTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B62A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyWDf-0008Vg-Ip
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 04:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jyWCx-0007km-35
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 04:04:03 -0400
Received: from mail-db8eur05on2106.outbound.protection.outlook.com
 ([40.107.20.106]:58734 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jyWCu-0005oJ-KA
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 04:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjUEhMNVmbfoc6IkgER+Q5jLS0XZQZIVtYXYTS5ze8kNNwOZWEislZgbYhV4Vq7kxZU9C81Ggw8BHicewz9wLnmorlEx5QkrGQvllkQqtG1usCJrpUuNFtb9wrE4zeCGf/6/gdodZwb/jagSWK73Sna8WU+JVkQKNEMiOaJI/GtRLDeUaZ1o3FWh7PL8arUpYZ5STF46oLw7OhPTcV7bQTIr4RycjSbopl63ivMupeYsxlxIjNF5yaiGN00KHPzRXTEFciMzrC7sGO2X04Jbr40dD54BJAgAq6h6pL6r7AaAjTTsSGFT+QRD+BeyiO9gZvUeFP4FhbvVadBlaeQxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaYX8C5iHxKxhgGMplBc3yMOfW/qEo9y6b5L1+/idYE=;
 b=hrK/8DWbZsOxcUn6L2dpxoO7hUjQyk7sbpFMKzbPlnFo9sDVfsAhiWB1IPSzKPeS15KWtPFx0Bz0/nwFHzDWfusOi9PuBqpw50XOJYi6ksFjlxZ3d223X6Fl8ohsRwAFhgjSuTQHhutgZopiljLvotPlfLCc5iJEVW4ijhWO87E03QGP5wadRMbsHdsvjtX8FnIZP3S+ZkT/EAJu7bFqpFBtv355+7A8W0cTZ/NzZK85lNXAOYgvkUNsPcrt6U5H9mPy87YN+nk61GEgwrlJjU0e9wsT0+YTCQY1Dc1H3A/2OI8Xpk+48W+o4q2dr+MHYhPTYO/g4U0d0q3gCYw8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaYX8C5iHxKxhgGMplBc3yMOfW/qEo9y6b5L1+/idYE=;
 b=l7u4PaTNgBlDJMYAxqI0cqasBqifaAHcyGsiCKXJLzKNNifesNgZF5Phx2eRcT0iwfhpPfx45Ma0lQTlyELd/sWh46zrKPcCVGcknfCzs3jIML3+jhhL0HUA5nt0X0nzf+itnKJPwI6XiEoA5g5nWBJeev32aIRwn+dhhjsjxbU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM4PR08MB2868.eurprd08.prod.outlook.com (2603:10a6:205:e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 23 Jul
 2020 08:03:57 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd%7]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 08:03:57 +0000
Subject: Re: [PATCH v0 0/4] background snapshot
To: Peter Xu <peterx@redhat.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722145034.GZ535743@xz-x1>
 <8146768f-7804-e239-41a0-3f7997f6b75d@virtuozzo.com>
 <bf3fd4f4-31a1-9d13-94b0-e3b026edb6b1@virtuozzo.com>
 <20200722163009.GA535743@xz-x1>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <a34af0de-a6ce-59f1-13bf-4f99e0e41c55@virtuozzo.com>
Date: Thu, 23 Jul 2020 11:03:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200722163009.GA535743@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (178.34.160.112) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 08:03:57 +0000
X-Originating-IP: [178.34.160.112]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0d4d5c4-1363-48d7-e1bb-08d82edef38e
X-MS-TrafficTypeDiagnostic: AM4PR08MB2868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB28686C14C9E38820A30A6AFCCF760@AM4PR08MB2868.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ve5hO1X03QF79saPZayYogqQ4cH0w+iMVjy4DktNg5z3gQdSQXj0yk4/ZK568It1nZP21ddR6aF8DyBmEgRwdGU505fWv3Rmx+uDmFkZcikxZZyyIbHPb4+6HB/OvXpBK9JZZKBR1qklNXMjlKKIAgjDMl6QoSwGO3vZ1sSIHLl6eehp8WV1v6n1EO3BhYtaW3JA/gv4HdkKSaSf7x922QLtC+gwypZUmuIE7DOjpivYOO/jzka9iDKwtyhn1hbPc1tTxE2UhtZN62O3uKaKipIsk5/5rwF8xy+fa9i8TnIRM1+Q0Nm+p5HUMVWv16EqJazIzRjeafO44Xnsgz3Kj30V1IeYlUBvvf6Svlp+UT6Tp6vdwkpqLVX6MT62/Z9L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39840400004)(366004)(6486002)(478600001)(31686004)(5660300002)(36756003)(53546011)(4326008)(956004)(2616005)(86362001)(52116002)(31696002)(6916009)(66476007)(16526019)(66946007)(66556008)(8936002)(8676002)(26005)(186003)(83380400001)(16576012)(2906002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QLg1O/JlSJKxjbGNl0TUYd7uzWIBLAiQGiX4Ln9WLakIBEZVqE8OgUzgpCpcWePl0Kh+JHC64IRRgkOkF6+0kBUUh5zxZ2vp9RLbMu6sn63HsmIOrshOBkvO0f1fOeGEMHlLFXBAKnQZiypUXt8ztCIjpZs3nFyx7InW42dPh+QkQgeVCe0nGvUVwdXyAWJ/tHqdkZy7Ch7fSDrODmUA/UPBx6sXjnNLbnHCjWs9vAXMHcffxpa9tEEPRzcZ2n2UYYK/tiYz+TUx1KEXt2gR1NykLvVjdRAvkva/tE/97f/aWfh09yLQNZevkat4TA1+yft66u+0zHcIy44zma+v2ahW6HNGK94A+Hi1RJZjmEiJOuLRSGhWPtzOQs45x2nIj77JbCveazNwTHDdcRdm60yWtpfYttrHKJgtdcUEQkGXfpTVo2c1w1kaHVRYz+1A7+I68W7++cfpXM6HjgCMAvWx+g1Q2ClewK5pV9TnUrg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d4d5c4-1363-48d7-e1bb-08d82edef38e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3745.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:03:57.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3G6bns4vIIjphil+7wgCcHz6HAVtPqh4+7YBFaWzxOVXElDUMTpP0DuttWAylsvB+P5mKzDG0ghDFdV1ZnYa6aaFgPc+A1EBCUEDOuJXow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2868
Received-SPF: pass client-ip=40.107.20.106;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 04:03:58
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



On 22.07.2020 19:30, Peter Xu wrote:
> On Wed, Jul 22, 2020 at 06:47:44PM +0300, Denis Plotnikov wrote:
>>
>> On 22.07.2020 18:42, Denis Plotnikov wrote:
>>>
>>> On 22.07.2020 17:50, Peter Xu wrote:
>>>> Hi, Denis,
>>> Hi, Peter
>>>> ...
>>>>> How to use:
>>>>> 1. enable background snapshot capability
>>>>>      virsh qemu-monitor-command vm --hmp migrate_set_capability
>>>>> background-snapshot on
>>>>>
>>>>> 2. stop the vm
>>>>>      virsh qemu-monitor-command vm --hmp stop
>>>>>
>>>>> 3. Start the external migration to a file
>>>>>      virsh qemu-monitor-command cent78-bs --hmp migrate exec:'cat
>>>>>> ./vm_state'
>>>>> 4. Wait for the migration finish and check that the migration
>>>>> has completed state.
>>>> Thanks for continued working on this project! I have two high level
>>>> questions
>>>> before dig into the patches.
>>>>
>>>> Firstly, is step 2 required?  Can we use a single QMP command to
>>>> take snapshots
>>>> (which can still be a "migrate" command)?
>>> With this series it is required, but steps 2 and 3 should be merged into
>>> a single one.
> I'm not sure whether you're talking about the disk snapshot operations, anyway
> yeah it'll be definitely good if we merge them into one in the next version.

After thinking for a while, I remembered why I split these two steps.
The vm snapshot consists of two parts: disk(s) snapshot(s) and vmstate.
With migrate command we save the vmstate only. So, the steps to save
the whole vm snapshot is the following:

2. stop the vm
     virsh qemu-monitor-command vm --hmp stop

2.1. Make a disk snapshot, something like
     virsh qemu-monitor-command vm --hmp snapshot_blkdev drive-scsi0-0-0-0 ./new_data
    
3. Start the external migration to a file
     virsh qemu-monitor-command vm --hmp migrate exec:'cat ./vm_state'

In this example, vm snapshot consists of two files: vm_state and the disk file. new_data will contain all new disk data written since [2.1.] executing.

>
>>>> Meanwhile, we might also want to check around the type of backend
>>>> RAM.  E.g.,
>>>> shmem and hugetlbfs are still not supported for uffd-wp (which I'm still
>>>> working on).  I didn't check explicitly whether we'll simply fail
>>>> the migration
>>>> for those cases since the uffd ioctls will fail for those kinds of
>>>> RAM.  It
>>>> would be okay if we handle all the ioctl failures gracefully,
>>> The ioctl's result is processed but the patch has a flaw - it ignores
>>> the result of ioctl check. Need to fix it.
>> It happens here:
>>
>> +int ram_write_tracking_start(void)
>> +{
>> +    if (page_fault_thread_start()) {
>> +        return -1;
>> +    }
>> +
>> +    ram_block_list_create();
>> +    ram_block_list_set_readonly(); << this returns -1 in case of failure but I just ignore it here
>> +
>> +    return 0;
>> +}
>>
>>>> or it would be
>>>> even better if we directly fail when we want to enable live snapshot
>>>> capability
>>>> for a guest who contains other types of ram besides private
>>>> anonymous memories.
>>> I agree, but to know whether shmem or hugetlbfs are supported by the
>>> current kernel we should
>>> execute the ioctl for all memory regions on the capability enabling.
> Yes, that seems to be a better solution, so we don't care about the type of ram
> backend anymore but check directly with the uffd ioctls.  With these checks,
> it'll be even fine to ignore the above retcode, or just assert, because we've
> already checked that before that point.
>
> Thanks,
>


