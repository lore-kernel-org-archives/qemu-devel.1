Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429B7206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iE15noR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429B7206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jysy7-0003lk-F9
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jysxP-00034N-G6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:21:31 -0400
Received: from mail-eopbgr60132.outbound.protection.outlook.com
 ([40.107.6.132]:8126 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jysxM-0005V0-8z
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:21:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd4dQN8InR+VjuqJsfpOH5nOpPyOqI5wSxB+vym3FG6uZbJ1Qq3K+utN5GA0WPf2dFT19/cra/zhgcdJy5nVTD76OVWQWJJpvd9WhcJAl6s4K3bVI0IRnONtNslBCXQsjjlcW/Ghh0cWQ1vWw1PcNrKPSCiY6xykT6LjCmIeYCi5wdoYj1daQLMTqLWmPdgBF8OXfc925TA0y2i6xMpUBgFK+AuucMHfIMDTnSmA7CDvBK2vyLXKjg1UcrcSdAenucxvKrDZ/IZEl0xy0EXoNCyL1+QlMb0QODI0E2XtK8OAMnjzkIzQdbzPqnuz8P3JazaJPUA7fgMIn3MuftJw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4avcN8pQK6x/0ASnQrHUyeuMofOxiLo6SzmaheejTU=;
 b=EOke/6b0eE8hd0YA0no+lzVXYc20/7HLnY0MP44UYjxv0SDnSNvwyZCZA8bvm2hkF34+df1jabqtMtfZ/rCQgaHGQIfpMsayvy1MIKk7j/5krJv9GFi8UU35eDUY4jPC4iEEIeSQzv50MYXK1i6gzfkJIcbINFFgWQuJF26TmlnGkuKcslCoSonwoucQtlj2xce7Mv8e2e8a1rlCR9nXlidEJkIMCQ8uuBUW8X8XNLjQJvjWzec5kxfmqmWTR1qXG78ICNigBIhJD8YpQsdC7rYVS5rzhW1u0rR15hPwqsp2wEhPLOaCqInnofYKdS5PeGnoNadZfOoCaPR8hJKZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4avcN8pQK6x/0ASnQrHUyeuMofOxiLo6SzmaheejTU=;
 b=iE15noR3LQy+TLsH6lhG1bxNY2c2JTigHUMw/9Gc8iR4Tn88imLILGBaS1+/+t+Mdw5IGYmpicxZ8oULeZZnEgGQuF/QvzCHdGsrK5te143gwUf9/9SW1tE1YXq3ATtMey/BztcgKfTZQxVCBAk1Uj4/i69HZHVB8DzzIUGMVlI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB5492.eurprd08.prod.outlook.com (2603:10a6:208:185::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 08:06:20 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5d21:ce58:6f11:b5dd%7]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 08:06:20 +0000
Subject: Re: [PATCH v0 0/4] background snapshot
To: Peter Xu <peterx@redhat.com>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722145034.GZ535743@xz-x1>
 <8146768f-7804-e239-41a0-3f7997f6b75d@virtuozzo.com>
 <bf3fd4f4-31a1-9d13-94b0-e3b026edb6b1@virtuozzo.com>
 <20200722163009.GA535743@xz-x1>
 <a34af0de-a6ce-59f1-13bf-4f99e0e41c55@virtuozzo.com>
 <20200723173952.GB831087@xz-x1>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <8e289570-8fe3-0511-5404-6ad0c0e2df35@virtuozzo.com>
Date: Fri, 24 Jul 2020 11:06:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200723173952.GB831087@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0009.eurprd07.prod.outlook.com
 (2603:10a6:200:42::19) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (178.34.163.135) by
 AM4PR0701CA0009.eurprd07.prod.outlook.com (2603:10a6:200:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend
 Transport; Fri, 24 Jul 2020 08:06:19 +0000
X-Originating-IP: [178.34.163.135]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7396e776-e574-444a-24b0-08d82fa872c1
X-MS-TrafficTypeDiagnostic: AM0PR08MB5492:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB54921810ECFA076C4A8E8733CF770@AM0PR08MB5492.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkM6WuKDUMWeQ8Rh7ldnftuWBOMSKwNM+8r+4AXWrhBwmtZM/KZQVlDl/yZC8kabsyiAWzKypP6KlEZUggp2TmCyJ31roAXZ38cQMI5dCZMvJS8fsi1h2yb0AzHkv6TPu0tDITT97B+7e4yXBSrtcG0xVL2TZvia8fZgR9LX5MgeM1vkwZEUoCyuewzfIXPGPvkca/Tzo7zphKs5x8Ij0kfGKuDuZUrjzBYl89Z5PPDnWEZ9LPRTZmHXag3TwYG1hpmQfbslN5E+QlmBKAmSw7RYxzJrmbOUSACkqHt1tW5AFWWY26uk2c4g5N0TYlq9JgSuS/16Q/GT5pADQCe5ZC2GzWr7aOdLERcAZy7g7UVmNQMedQ+K5dGmOQnGeZZqQqEqyj/ma1RckjJcPmTPLvYfeMWT1WSqLlheUBSACqwE2Lu+hubHg0eE+uFU/00nX8gQmp6pQZBv9gMDIC+hqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(39840400004)(376002)(396003)(5660300002)(52116002)(6916009)(83380400001)(478600001)(53546011)(6486002)(36756003)(2906002)(16526019)(66946007)(66556008)(186003)(66476007)(26005)(316002)(16576012)(31686004)(31696002)(966005)(86362001)(4326008)(8936002)(2616005)(956004)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ivcdFodfDfcPRy01v9P51NEqlPXqHgbtJypskhOUJbRj2klnDvDZXGFpRPg21hoQZxslTwK2A61m07zF5+UYdwI5Hs8grjp9LLUFIKxIQKkEqSCU/RWzZEKFMsvC+sbnJFrJp/gfQhsWdyZ7DOS8lnCAj35DlhvCma9zbRU54oht2vffOu6uOCMftdEUACP/0I886v9nW4N+2oJPHyzeLhuh/eabhvp+kFaoqJkdpWIJ/rQaSKw+1rI/EMPshAn/BmAWwNWb6ZzjwAqG8WuSYnQn0CawM8CPlVOTB4Yj6c8IgU21pr6KIowJes13FqA6zjDtNyk4OleOMg1g1Xk49XDudl/ihXTjI76oZTmQGQ0XfhMCb/teyMp0MNDcDVWp2ULh/KqydlztoudzUE8LU+Z6TPUs142sV69HPewqRiX0U9c754wkHzH9i+mC2dN1pWVtDXLBZ21vtCSreI0ah0zCKE0PZvvrRAnA14UkYgc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7396e776-e574-444a-24b0-08d82fa872c1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3745.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:06:20.0855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uofmbu/YmqeU+/Zo3n4mucWl7x3g3V1unqbcSukWAep790b7n1YELpAk9T+ZVB+cabc4kMvktSmzTvfDUXZx60q4p/QO4MWNteqLgmVRvd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5492
Received-SPF: pass client-ip=40.107.6.132;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:21:25
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



On 23.07.2020 20:39, Peter Xu wrote:
> On Thu, Jul 23, 2020 at 11:03:55AM +0300, Denis Plotnikov wrote:
>>
>> On 22.07.2020 19:30, Peter Xu wrote:
>>> On Wed, Jul 22, 2020 at 06:47:44PM +0300, Denis Plotnikov wrote:
>>>> On 22.07.2020 18:42, Denis Plotnikov wrote:
>>>>> On 22.07.2020 17:50, Peter Xu wrote:
>>>>>> Hi, Denis,
>>>>> Hi, Peter
>>>>>> ...
>>>>>>> How to use:
>>>>>>> 1. enable background snapshot capability
>>>>>>>       virsh qemu-monitor-command vm --hmp migrate_set_capability
>>>>>>> background-snapshot on
>>>>>>>
>>>>>>> 2. stop the vm
>>>>>>>       virsh qemu-monitor-command vm --hmp stop
>>>>>>>
>>>>>>> 3. Start the external migration to a file
>>>>>>>       virsh qemu-monitor-command cent78-bs --hmp migrate exec:'cat
>>>>>>>> ./vm_state'
>>>>>>> 4. Wait for the migration finish and check that the migration
>>>>>>> has completed state.
>>>>>> Thanks for continued working on this project! I have two high level
>>>>>> questions
>>>>>> before dig into the patches.
>>>>>>
>>>>>> Firstly, is step 2 required?  Can we use a single QMP command to
>>>>>> take snapshots
>>>>>> (which can still be a "migrate" command)?
>>>>> With this series it is required, but steps 2 and 3 should be merged into
>>>>> a single one.
>>> I'm not sure whether you're talking about the disk snapshot operations, anyway
>>> yeah it'll be definitely good if we merge them into one in the next version.
>> After thinking for a while, I remembered why I split these two steps.
>> The vm snapshot consists of two parts: disk(s) snapshot(s) and vmstate.
>> With migrate command we save the vmstate only. So, the steps to save
>> the whole vm snapshot is the following:
>>
>> 2. stop the vm
>>      virsh qemu-monitor-command vm --hmp stop
>>
>> 2.1. Make a disk snapshot, something like
>>      virsh qemu-monitor-command vm --hmp snapshot_blkdev drive-scsi0-0-0-0 ./new_data
>> 3. Start the external migration to a file
>>      virsh qemu-monitor-command vm --hmp migrate exec:'cat ./vm_state'
>>
>> In this example, vm snapshot consists of two files: vm_state and the disk file. new_data will contain all new disk data written since [2.1.] executing.
> But that's slightly different to the current interface of savevm and loadvm
> which only requires a snapshot name, am I right?

Yes
> Now we need both a snapshot
> name (of the vmstate) and the name of the new snapshot image.

Yes
>
> I'm not familiar with qemu image snapshots... my understanding is that current
> snapshot (save_snapshot) used internal image snapshots, while in this proposal
> you want the live snapshot to use extrenal snapshots.
Correct, I want to add ability to make a external live snapshot. (live = 
asyn ram writing)
>    Is there any criteria on
> making this decision/change?
Internal snapshot is supported by qcow2 and sheepdog (I never heard of 
someone using the later).
Because of qcow2 internal snapshot design, it's quite complex to 
implement "background" snapshot there.
More details here: 
https://www.mail-archive.com/qemu-devel@nongnu.org/msg705116.html
So, I decided to start with external snapshot to implement and approve 
the memory access intercepting part firstly.
Once it's done for external snapshot we can start to approach the 
internal snapshots.

Thanks,
Denis

