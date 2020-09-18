Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B074C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F085723787
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0oxW4z/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F085723787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIua-0005Vq-MM
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kJIis-0000JV-5v
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:54:54 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com
 ([40.107.236.82]:21920 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kJIip-0000HT-Hj
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:54:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhSyIpKxWURnpuyqE2I7xbV9BLpJXVu0t0wWGzfDhm4OBP+6VgLzJttzTQAvOK/e07dGtb4oyK96HTb4pGFeHrHgdtJoiVAmNBFiPRUwzsEVdxl5GSQorWU6NHdFukhYyWB1gOq1LGhpkSFMuXhzE+OsuT/zKV3X9P3Ksn3dSQpeUEAfUfNvHzlHTyxOG+R2Ws1I1p8sWUqUeYvX4FYggZMJT6m27D9udttEhEniDg5rPLXAcERDgot/CCu/yCeXwHKaNgimsjcvEhsOW8LeVSHdpAb1PLvI0KZPOTI4ue0scRO+KPjmE6vk8ZV7O5m/9yVa+mVk1kLO/0UoDjA5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BycUv4pszm94BzhWaGJEGHFRTrKe/BwDmoBgDlyjJ7w=;
 b=J5GOfmF2zmqcI9qpwfVMwhnGvQX5ZVV9zKsKuLSvT7U3/YNbROBz+75qJEwrq+w6TUClkAZ+79mBEQiiALs6MbZGGbdwDGvBna5ghTJfT5ohBwspPMySbAXR81Vh2/YAIObH0yOpK9UrxhUZQatz9j1BWaaEWvw55/egjcw95Nid/RP3w+grpxo6JvLou8UxNgyNY4ZYUMaXlZVTKgwOImDBgr7LE7ebhyVyny5HtUqiNT7KxKHU+XPip/VJQq08OzUhCLP5ZNxJ2vY4jLwY7ZbL1YOq3ArpFZm819MhY9HaGo4qNZlAoRHOz2D/6JlMYZPfhZaV4irk9PJQhzUIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BycUv4pszm94BzhWaGJEGHFRTrKe/BwDmoBgDlyjJ7w=;
 b=0oxW4z/Hcz3J7Y7CzPFcn0D83HwzjgQze9chwSai4m85DVt8JinJgARTqDavWtlRiCYRrk+3PSUbmALHC9J+CywSi2/zAVTZck0xFUd8KHNW+9gBpAf1z7sRkGElSQe3nCaudzbDNVgWL2uz8cJFUsEeqE4z2SdblzshPgg6ml4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Fri, 18 Sep 2020 15:54:49 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 15:54:49 +0000
Subject: Re: [PATCH v3 0/5] Qemu SEV-ES guest support
To: Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1600205384.git.thomas.lendacky@amd.com>
 <20200917172802.GS2793@work-vm>
 <de0e9c27-8954-3a77-21db-cad84f334277@amd.com>
 <20200918034015.GD14678@sjchrist-ice>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <6091782b-32ab-cf68-fc51-aae618f565e8@amd.com>
Date: Fri, 18 Sep 2020 10:54:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200918034015.GD14678@sjchrist-ice>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:805:f2::43) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by
 SN6PR04CA0102.namprd04.prod.outlook.com (2603:10b6:805:f2::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 15:54:48 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dc5dd7b-ff14-4b5d-fb80-08d85beb2c1d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435344F909C8D22CACA35118EC3F0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95ZtekND1mNpyhk5NHNgj9HWYVc2tvk83UY6yxCrwXorKwrsMLYXo6/XHX48uMeffjz03sZ1Uhd4jMEE5+V93tfVDBeoRGrX6BzV0NDTNERSjk2Hqe9hw87ADLjedZfzoJtQidh5AmM08mcV3NdOwvhVZvnZM4tZHKxHhgZo63ZG+J50u9ti3t0Vypzlk9qgl1QVOUi+1BrOyTmMrHQOnVkZM5bcn4uOfYGB6RoXhASKxLUYWWMDPr0qzrxGDJJne+die/sFh6xKWYXAP1+D51dzQZstu4rE1KU5eOsgfyJko83L4RcYoaTxuzzImFLojpdZ3dSedbwGveS3w97ZXtMF6Avxz9gXHMljmDzaKIZRANOI26ZtQUTevrr5NPlK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(52116002)(4326008)(8676002)(186003)(31686004)(36756003)(86362001)(16526019)(6512007)(478600001)(316002)(31696002)(6916009)(26005)(6506007)(66946007)(54906003)(53546011)(5660300002)(66556008)(66476007)(2616005)(7416002)(6486002)(956004)(8936002)(2906002)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MfBknLAwFdf/ustKHjcn4DYE+vR5qJER7aIWgeKT7816EVSjUBZ9vUctC5AMU3ed/3uIy/RwPhLByu3Zh9tO9a9Wc3vwLnPXsOVbXYsnw8Ahge4A0nOZ5RG7oQQcrrZ4AlQjLAqYhD6tioMnFu9VSZXc2ifpvjkDTu/Zw/wY0W2kgQeFktaNUqmlymnTEqJwQB7sqxJlnFY7qLqeVSrVxaqBSpAP8aNfqEU4YPmhvRYQU4KkJjxT4jFYILaFS0cqOrHBlrHJ1X1ZGPdne8ed9/JCZm1VHWws/eVIyqSDKvK+HKp3c23Nu97Sv5B/K5BX5Vp9lal+dEosfWhMVA2cAsGaOiYgK/0TnXOQKgtyzDm7R1qw9aSzstovfNe1e0Z+9woyzJClEniwkBTg+sZRsQVygD/Go2YmbcnWM3JvZCQJdb5Cpujd8dssI75/WtSeOi/xTKeUgmLHvsTEOdyUrRseDuSTf2Ny2MtqL+Unv91TIOkpydNe7Pc1Y1wvCVtdmkZVRHFuZzo3ngsXb6CcvgbYI5h8JGSNHiZDuBtR7Al4F5cF6fxi1y4bb7I2hR6vFV4fW0ZLbmbeHiE+TCqKw2ivKna+sWq+tRWpBq6NOO7w5O6hpSUDgWn+ajJXsuQqUeMHMGQrSxuMJzHJbfSGsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc5dd7b-ff14-4b5d-fb80-08d85beb2c1d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 15:54:49.1678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvV/NysbjRxUx09FOZCJgvezGDCtxE8S7oUM98MDUcaAtdiqPE3weWjfJHUw7PBmcQLQZ8sVoh2pyibBSZJgeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
Received-SPF: none client-ip=40.107.236.82;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 11:54:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Connor Kuehl <ckuehl@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 10:40 PM, Sean Christopherson wrote:
> On Thu, Sep 17, 2020 at 01:56:21PM -0500, Tom Lendacky wrote:
>> On 9/17/20 12:28 PM, Dr. David Alan Gilbert wrote:
>>> * Tom Lendacky (thomas.lendacky@amd.com) wrote:
>>>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>>>
>>>> This patch series provides support for launching an SEV-ES guest.
>>>>
>>>> Secure Encrypted Virtualization - Encrypted State (SEV-ES) expands on the
>>>> SEV support to protect the guest register state from the hypervisor. See
>>>> "AMD64 Architecture Programmer's Manual Volume 2: System Programming",
>>>> section "15.35 Encrypted State (SEV-ES)" [1].
>>>>
>>>> In order to allow a hypervisor to perform functions on behalf of a guest,
>>>> there is architectural support for notifying a guest's operating system
>>>> when certain types of VMEXITs are about to occur. This allows the guest to
>>>> selectively share information with the hypervisor to satisfy the requested
>>>> function. The notification is performed using a new exception, the VMM
>>>> Communication exception (#VC). The information is shared through the
>>>> Guest-Hypervisor Communication Block (GHCB) using the VMGEXIT instruction.
>>>> The GHCB format and the protocol for using it is documented in "SEV-ES
>>>> Guest-Hypervisor Communication Block Standardization" [2].
>>>>
>>>> The main areas of the Qemu code that are updated to support SEV-ES are
>>>> around the SEV guest launch process and AP booting in order to support
>>>> booting multiple vCPUs.
>>>>
>>>> There are no new command line switches required. Instead, the desire for
>>>> SEV-ES is presented using the SEV policy object. Bit 2 of the SEV policy
>>>> object indicates that SEV-ES is required.
>>>>
>>>> The SEV launch process is updated in two ways. The first is that a the
>>>> KVM_SEV_ES_INIT ioctl is used to initialize the guest instead of the
>>>> standard KVM_SEV_INIT ioctl. The second is that before the SEV launch
>>>> measurement is calculated, the LAUNCH_UPDATE_VMSA SEV API is invoked for
>>>> each vCPU that Qemu has created. Once the LAUNCH_UPDATE_VMSA API has been
>>>> invoked, no direct changes to the guest register state can be made.
>>>>
>>>> AP booting poses some interesting challenges. The INIT-SIPI-SIPI sequence
>>>> is typically used to boot the APs. However, the hypervisor is not allowed
>>>> to update the guest registers. For the APs, the reset vector must be known
>>>> in advance. An OVMF method to provide a known reset vector address exists
>>>> by providing an SEV information block, identified by UUID, near the end of
>>>> the firmware [3]. OVMF will program the jump to the actual reset vector in
>>>> this area of memory. Since the memory location is known in advance, an AP
>>>> can be created with the known reset vector address as its starting CS:IP.
>>>> The GHCB document [2] talks about how SMP booting under SEV-ES is
>>>> performed. SEV-ES also requires the use of the in-kernel irqchip support
>>>> in order to minimize the changes required to Qemu to support AP booting.
>>>
>>> Some random thoughts:
>>>     a) Is there something that explicitly disallows SMM?
>>
>> There isn't currently. Is there a way to know early on that SMM is enabled?
>> Could I just call x86_machine_is_smm_enabled() to check that?
> 
> KVM_CAP_X86_SMM is currently checked as a KVM-wide capability.  One option
> is to change that to use a per-VM ioctl() and then have KVM return 0 for
> SEV-ES VMs.
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 416c82048a..4d7f84ed1b 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -145,7 +145,7 @@ int kvm_has_pit_state2(void)
> 
>   bool kvm_has_smm(void)
>   {
> -    return kvm_check_extension(kvm_state, KVM_CAP_X86_SMM);
> +    return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
>   }

This will work. I'll have to modify the has_emulated_msr() op in the 
kernel as part of the the SEV-ES support to take a struct kvm argument. 
I'll be sure to include a comment that the struct kvm argument could be 
NULL, since that op is also used during KVM module initialization and is 
called before VM initialization (and therefore a struct kvm instance), too.

Thanks,
Tom

> 
>   bool kvm_has_adjust_clock_stable(void)
> 
>>>     b) I think all the interfaces you're using are already defined in
>>> Linux header files - even if the code to implement them isn't actually
>>> upstream in the kernel yet (the launch_update in particular) - we
>>> normally wait for the kernel interface to be accepted before taking the
>>> QEMU patches, but if the constants are in the headers already I'm not
>>> sure what the rule is.
>>
>> Correct, everything was already present from a Linux header perspective.
>>
>>>     c) What happens if QEMU reads the register values from the state if
>>> the guest is paused - does it just see junk?  I'm just wondering if you
>>> need to add checks in places it might try to.
>>
>> I thought about what to do about calls to read the registers once the guest
>> state has become encrypted. I think it would take a lot of changes to make
>> Qemu "protected state aware" for what I see as little gain. Qemu is likely
>> to see a lot of zeroes or actual register values from the GHCB protocol for
>> previous VMGEXITs that took place.
> 
> Yeah, we more or less came to the same conclusion for TDX.  It's easy enough
> to throw an error if QEMU attempts to read protected state, but without
> other invasive changes, it's too easy to unintentionally kill the VM.  MSRs
> are a bit of a special case, but for REGS, SREGS, and whatever other state
> is read out, simply letting KVM return zeros/garbage seems like the lesser
> of all evils.
> 

