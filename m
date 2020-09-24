Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F3CC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5442220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uLrR8o8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5442220C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXIV-0002Iu-SF
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brijesh.singh@amd.com>)
 id 1kLXFd-0000xL-Bc
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:49:57 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com
 ([40.107.92.87]:31585 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brijesh.singh@amd.com>)
 id 1kLXFb-0000mF-3n
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNOHehBcCaJwaI75CJpf7pYaKW5Js7diEeECdqdmGUTQmVDTmJFqRhDnVEeud5TYh9JzijO/4tv15Lep/zqVd7iOGyfhjo0MyPvGeYZ8FxIOuMsDIrn1GerWK4ZugVrPLifK9+rjdsLjVi4QwhwKsH4Yzw4XbnwLfJOfRF9dzqhqXJLyqPJklUOmzVgIgZp948oC4E/ObXKi8xt4yqeWcdcYHR9HO/lXfTRVj8nZiahITiPGf1jB+j2O4oYcXKBaGL0Viv7k/7UISji287u9tEes7VDoTfxQehR2qX8amTHmkNYljnEfDpj2iayp8hvi0aCCWdqp+mzrZSgem4xulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BckY/EcreZ3lHGwCa6y9G+NPKs8bZPAxCzjtdeXHj5Y=;
 b=ZPlWm647d3VzVbhG40yLvjF0Dg1U9NyertkJNbUA2eA22Na6iKmqhJnQHepGBY2vkrv6NRF3bR38q9fI+3gPmtOcNq+DFgxFgAf6I+ci1HvIH8k2SaCw5NuabpQcsSi2d4LO4FB02N6J0NDRyD7504cSsijeo5Gsw2ut3U1MzuwTB5ZrLyzSsVZVvDy6ugDIqGi/nnz5hcTp3MHqITwNJd9FwAgKjBJB1QOSIxAiUAOB+6hHNM74nXBLvfVBJfa6H8mHdKv7zfQCdp3uIz8mky1+Mow/AMcckn62x+kk2kjIbmd6UFoRixx0i7C7sJ6GwBr+6exXjBZIZkCEz9RQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BckY/EcreZ3lHGwCa6y9G+NPKs8bZPAxCzjtdeXHj5Y=;
 b=uLrR8o8bUxRM4lG7LhjgAkddY+fG8CoMVOJ/E3KBlYDNRYiQzagDqIYel/MJVNRDlTnAElPLOvZ0GLG7KiFdQLGDxKkBXHBPtO9brFUrKq55LPYgeMOMgfJuljCv+yJChPp5GmsW9axpp0OLEsLJ1Nnu/P8FuDiSuj+Z5f+3CGo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 19:34:50 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::6d9c:78e0:e7cb:558f]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::6d9c:78e0:e7cb:558f%7]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 19:34:50 +0000
Subject: Re: SEV guest debugging support for Qemu
To: Ashish Kalra <ashish.kalra@amd.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
 <20200924135342.GE2792@work-vm>
 <20200924190653.GA8180@ashkalra_ubuntu_server>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a35415c9-6e50-5260-e0e6-e36b9f16f2b2@amd.com>
Date: Thu, 24 Sep 2020 14:37:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200924190653.GA8180@ashkalra_ubuntu_server>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA9PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:806:a7::6) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 SA9PR10CA0001.namprd10.prod.outlook.com (2603:10b6:806:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 19:34:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c62bcaf3-2d77-4095-d348-08d860c0e73b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44139A1CCA5895D68DD923C8E5390@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2Zs0fHfpLWKiVILtpHGpxhEYRkfBTFi/SBfbmFNik23+qwN8xTwbGQ5+jpjDnAD19EmgM/s/FRStPEPRBJWGYSXa9cupENSOjb4YFu8WPWTAWxkWdCWtnFVGow11lrpas7RmjbJGF6jMlrheaT/5TRyRkaT+xMBpQeHQBRi4+FgpmJEt4v+DhpXxmFMsvjabgKgrA1vphIv7seYBN7GVowVDJlb5uE4eI+YB87bOCQMdhRfsgUO9MqlSv4egZmnryvJ4xxgetYi6XtCWHCPrlxUCg1+xn6Vurj/P6MFdRqK4TYQcqNiXZTnwJ3YvopnEphcsCwsgSKa106FRSKhv+L/0SKvFoXFgSrAsJAQl4Z0+34ni0tkTwAU1rvU7jdgqHnhWrh5k1RsorDMyjcZVypT6gRWtHBSjPcfVe9Pc2Lv/8Jmh0czE3nAfoNZWikl3bh8ez9BrUOfA4h9GJ6GkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2718.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(2616005)(31686004)(956004)(16526019)(66556008)(45080400002)(478600001)(86362001)(44832011)(53546011)(6506007)(8936002)(83380400001)(186003)(6486002)(52116002)(66476007)(66946007)(6512007)(26005)(316002)(31696002)(6666004)(4326008)(5660300002)(8676002)(2906002)(966005)(36756003)(110136005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nu5dn0oPCE5+/z020OHmnitcw8WofJkBLKvO8UQUbTcxhGG0h8yD4K+Ryd9DGuFO924rXIAUG+w1/bLU65TxdRVISg3QIM+tjI28tLBCLesBk+iqWySH8Kss1fxWPRew/Fm9SlMCmQLlf9KlmVg0L7cSCYHqLF8ZwPqgd4e7bQidOOApNg/wQjI9qh4zSgKOFgjjF8tvtogTlE6t3pTQ01D7h5tsVYt5azzKQ6Mk29H7Rioaljpx3H1/14OpwNoqj6y4GncMlCYNKLo0yePCGFrs6ZZh+jp7rUjVD4rVb7Xa/G8iO6dlw7GfKyfSARYqht9VPkM+XUNuzBLzKOWOt9vGMygPxRgbix1wuJdIkBoT5IjK57LdT16/4j7M13+vo9AGqon2hoiCefOWq7W+abUAWSU2iUdarsnuEvSzkfDb9Bm/lHUbc28ODYzHMkZhUTzktjUPkl8iSKd8i8B4IDoVDhbOYO17qSoYpvYKBN0JfjhA5HTZWHzbkdFkvODcLwaNg7GR4qFScgZzjIpTQitArZVypdsYIU0NB3ayUSUSWApKRPllu2n2UROqiAm2RDXLl0m7tqS4Fs0PcO7E/WE8GFl/Mpp6mcRXRPEszjH7u1KFKclo0X6hfK6apuBGZbhJ1Z6JRzhVkVcEE18lbg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62bcaf3-2d77-4095-d348-08d860c0e73b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:34:50.3589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVyOjSdLQ19cblqXdl8C1N19EuJipRicVs3H9OCdNPOce3d3s9DFCxQYffprLWQ4uXK3V9ptfX608CyTqFEy8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
Received-SPF: none client-ip=40.107.92.87; envelope-from=brijesh.singh@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:49:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: pbonzini@redhat.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 qemu-devel@nongnu.org, thomas.lendacky@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 9/24/20 2:06 PM, Ashish Kalra wrote:
> Hello Dave,
>
> Thanks for your response, please see my replies inline :
>
> On Thu, Sep 24, 2020 at 02:53:42PM +0100, Dr. David Alan Gilbert wrote:
>> * Ashish Kalra (ashish.kalra@amd.com) wrote:
>>> Hello Alan, Paolo,
>>>
>>> I am following up on Brijesh’s patches for SEV guest debugging support for Qemu using gdb and/or qemu monitor.
>>> I believe that last time, Qemu SEV debug patches were not applied and have attached the link to the email thread and Paolo’s feedback below for reference [1].
>>> I wanted to re-start a discussion on the same here with the Qemu community and seek the feedback on the approaches which we are considering :
>>> Looking at Qemu code, I see the following interface is defined, for virtual memory access for debug : cpu_memory_rw_debug(). 
>>> Both gdbstub (target_memory_rw_debug() ) and QMP/HMP (monitor/misc.c : memory_dump() ) use this standard and well-defined interface to access guest memory for debugging purposes. 
>>>
>>> This internally invokes the address_space_rw() accessor functions which we had  "fixed" internally (as part of the earlier patch) to invoke memory region specific debug ops. 
>>> In our earlier approach we were adding debug ops/callbacks to memory regions and as per comments on our earlier patches, Paolo was not happy with this debug API for
>>> MemoryRegions and hence the SEV support for Qemu was merged without the debug support.
>>>
>>> Now, we want to reuse this cpu_memory_rw_debug() interface or alternatively introduce a new generic debug interface/object in the Qemu. This 
>>> debug interface should be controlled through the global machine policy.
>> Let me leave the question of how the memory_rw_debug interface should
>> work to Paolo.
>>
>>> For e.g., 
>>> # $QEMU -machine -debug=<a debug object>
>>> or
>>> # $QEMU -machine -debug=sev-guest-debug
>>>
>>> The QMP and GDB access will be updated to use the generic debug  interface. The generic debug interface or the cpu_memory_rw_debug() interace will introduce hooks to call a 
>>> vendor specific debug object to delegate accessing the data. The vendor specific debug object may do a further checks before and after accessing the memory.
>> I'm not sure that needs a commandline switch for it; since you can
>> already get it from the guest policy in the sev object and I can't think
>> of any other cases that would need something similar.
> Yes, i agree with that, so i am now considering abstracting this vendor
> specific debug interface via CPUClass object instead of doing it via
> MemoryRegions. 
>
>>> Now, looking specifically at cpu_memory_rw_debug() interface, this interface is invoked for all guest memory accesses for debugging purposes and it also does 
>>> guest VA to GPA translation via cpu_get_phys_page_attrs_debug(), so we can again add a vendor specific callback here to do guest VA to GPA translations specific
>>> to SEV as SEV guest debugging will also require accessing guest page table entries and decrypting them via the SEV DBG_DECRYPT APIs and additionally clearing
>>> the C-bit on page table entries (PxEs) before using them further for page table walks.
>>>
>>> There is still an issue with the generic cpu_memory_rw_debug() interface, though it is used for all guest memory accesses for debugging and we can also handle
>>> guest page table walks via it (as mentioned above), there are still other gdb/monitor commands such as tlb_info_xx() and mem_info_xx() which also do guest page
>>> table walks, but they don’t go through any generic guest memory access/debug interface, so these commands will need to be handled additionally for SEV.
>> If some of those should be using the debug interface and aren't then
>> please fix them anyway.
>>
>>> The vendor specific debug object (added as a hook to generic debug object or the generic cpu_memory_rw_debug() interface) will do further checks before and after accessing the memory.
>>>
>>> e.g., in the case of SEV,
>>>
>>> 1. Check the guest policy, if guest policy does not allow debug then return an error.
>>>
>>> 2. If its an MMIO region then access the data.
>>>
>>> 3. If its RAM region then call the PSP commands to decrypt the data.
>>>
>>> 4. If caller asked to read the PTE entry then probably clear the C-bits after reading the PTE entry.
>> Does that work if the guest is currently running?
>>
> I assume you are asking that is this done when guest is being debugged,
> the above steps are only done when the guest is paused and being debugged.


I don't why we need to pause the guest. Ideally we should be able to
connect to Qemu monitor and run the "x" command to dump memory. IIRC, if
paging is enabled then monitor will walk the guest page table to reach
to gpa. Something like this in the Qemu monitor console should work:

x /10i $eip


> Thanks,
> Ashish
>
>>> 5. many more checks
>>>
>>> Looking fwd. to your feedback/comments on the above approach or other any other suggestions.
>>>
>>> Thanks,
>>> Ashish
>>>
>>> [1] -> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fnext.patchew.org%2FQEMU%2F20180308124901.83533-1-brijesh.singh%40amd.com%2F20180308124901.83533-29-brijesh.singh%40amd.com%2F&amp;data=02%7C01%7Cashish.kalra%40amd.com%7Cd21e40d3527d4dba609c08d86091490e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637365524404435805&amp;sdata=P%2F6DqPQmUObJipkbbeXcrUdCqulePiqxSU6OB8xUEWo%3D&amp;reserved=0
>>>
>> -- 
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>

