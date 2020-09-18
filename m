Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D102C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396C1206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="djYtH00R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396C1206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMhn-0001DV-3B
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kJLed-0000kI-1X
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 15:02:43 -0400
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com
 ([40.107.237.49]:9025 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kJLea-0001la-GQ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 15:02:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLAuC1qsgY1dWQiownUSY19EnnYlWZ3RhxaTP8Ag05Mko863h6eLJxuk0j06td3vk8V014MElUtyJKAhik6OHyDI5aJYXxgeyvGZi+VARy0d2XFUa+vgBnePt52iSPrrqkcBwF8S2AC1E5WpsnfmQH9J8/0FjWaQQXoEqNdwxdnWAu6tFOQE5x+vZwUkZiscAvatfh4MfWJ8+Fdo9IBwal3o9tCXj4kFfP9cAOvhvVvRxLVXWrQfZPcVmUszZhU7xWbeiQfrts6xNkZu+m/N2ciXAsALJICZK093Oa09ZSdfwb7vjz7YEs0r1/NmslC1WGpKzQ3z5MvwigxlFGNkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knhn7QSG9dmoeHRKmlfPWQaIcuuB3klstsH9Ue7WGaA=;
 b=idOAPcvTB/R8c5TJrO6XwbgHiqhd6kYJIwI++MQPA2WgaHAkcxVhYb1xtvtMxNvShtr7LzsHZjKp4LiRowWDbTXrgLfpBforUWJw7dIx81xjgsauzUKBcm4ougjfFB2p83VCRDeiALMFuOjQyw75tPkdLq9p5e6InZ2piJpOBZSMc/V9I518mXegYxkOJwAHRb004lXa49W9JDddJRClrLbH4sY7bO10ZnMcBIp6fJCtNGzmTcRAza+BuS9AmyFuZKBgB3gNN0B94mJRM4ObVYPy40FTiGGOGU28Q8g4DJthOygcwZ/s5i1OPHXUHGg3QzNVS0UtiyIKf6xY6jlsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knhn7QSG9dmoeHRKmlfPWQaIcuuB3klstsH9Ue7WGaA=;
 b=djYtH00RAHsDGOWAelsjCJS7fx5Aw+4DaNhb3691gDAEOGYTdx66Q07NXvYjx6Ul0LOMutyhTC1bHe2pW5KKAQFXqwa7wy9GromdFpOvVYzDWe1Zlcs5vJYwO7u47QmPMmHk+8op5V66zL5EwY61BdGfgosCXTi+/87VuO1jR9s=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Fri, 18 Sep 2020 18:47:34 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 18:47:34 +0000
Subject: Re: [PATCH v3 0/5] Qemu SEV-ES guest support
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1600205384.git.thomas.lendacky@amd.com>
 <20200917172802.GS2793@work-vm>
 <de0e9c27-8954-3a77-21db-cad84f334277@amd.com>
 <20200918100048.GF2816@work-vm>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <57a939bd-9489-2114-730b-bee9ec040b31@amd.com>
Date: Fri, 18 Sep 2020 13:47:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200918100048.GF2816@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:d3::9) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by
 SA0PR11CA0004.namprd11.prod.outlook.com (2603:10b6:806:d3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Fri, 18 Sep 2020 18:47:32 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c458d086-a974-43ae-9d46-08d85c034dd3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00285ECFA32A958FF1C09CDFEC3F0@DM5PR1201MB0028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmFuLX92mWCK6wMXK73lc/8KvCaDmDkB5tknH9kpUmvrTPdJ4teAs3J3jsURQubF12mLRwE7bOvwK6bCe8YEcYI/CcQZu1w664BQY5B3cBbjNYheM03gupb6cCDTSWMkdkQBaaT/iD3owlUnhU4Rb9ETZXSvfZ4TjLPigb3v2x5PPC5Z8MvJFj7ROtc+h7JkSnT4SBadj+LnnpS4Vhl9y3oYMHfL/mkV8hVtHW9ZRNx8IuYdbHXsCirRSTUThQLnbfBNQM5LiyLD3FBNtdLWKid7YX3iTLWXBNb/yVPZHjRDJzcVo8zXnYQnEEwkkDQzjWPYPgMfAWP62mvM0OPGii1vcptFx1j5jeD5HvdFYe2GnMwUdwJHvyp1QI0MhGllGjjTEoZw+9TB+wJUBExSBdJYjIi6ehFjMfegQv9gbeAVgcyZBPkHPtkVEGuuoFzZSmefg/YNg+X9R1peRx4ywElBvNgro+r9ttpPMGiYRej8CYBkb4p8akg1jVa/C2ys
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(316002)(6486002)(8676002)(6916009)(2616005)(31696002)(7416002)(956004)(966005)(5660300002)(45080400002)(66476007)(54906003)(6512007)(66556008)(478600001)(66946007)(86362001)(52116002)(83380400001)(4326008)(2906002)(31686004)(26005)(53546011)(36756003)(186003)(8936002)(16526019)(6506007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bQd0Er7wTbG++uLguLQXFLciJkp2rVE1F4Pz7AMXE8KxI0IJYLVsUPNBjhOwFnvWvFCeNjUqRD69xhz1YuRY3EgNUfCd9WHxuUyZkXTCJDqw0XfJMH4bi291xAIZLiOQ9p6BZ5KHulFVUL5wfg6yst51H/EaWEYdlWVAGPtn4CexaCYdJgCy7a3SF7TtOczIZkuxP1fUUBuQ8AS+ZOTkEQCkO+9REh7shKNG/TMfsjIqqH8unHo3nQYZhzsxqQ6ehJfMyZm98W0MzBJxDprQ86fGOQZcbN9r0LgZDNJBBWRent2ZKUUU364viUQr5pQkPg2tsSRYzf+jM0JTmuRiDMQditpVI7PdTxtgaltodfbin66DQVGWzAEKYMuw6E0gRbppQbC3g/dOaWUqa3Ox4fRnjPQ+8e654B++6n4mnJuSN8z7iWWrKWI0TvrH9fKLNjoLJV8MDl/lkucBieT6Q3oMHfKAsbWEAmtbfX/rKYENKdzrwkfajXT9zY6VsqFujOIKBXKKALgxlA/lfIbIOsrLLWU8YdpYxy8PprjdY0nRPIZO15D1zaT+EmJOxF2/ttJx++P6gwouN0JUmLQC+hUEg/QZv5XWL0AZH9y1QvZ25DKQ3+jzshAnjcgqJtVMzbwl9RShLJBVZuMlR+e1/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c458d086-a974-43ae-9d46-08d85c034dd3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:47:33.9573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3BgvAYOFcWd8On8KybcHdyb9TBOH/bHJV5zrjeoe3tvxnTEvyBOYJx1KfLgD/h1pu0tMvyUKgmdEP3qiDgBNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
Received-SPF: none client-ip=40.107.237.49;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 15:02:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, LH_URI_DOM_IN_PATH=1.42,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/20 5:00 AM, Dr. David Alan Gilbert wrote:
> * Tom Lendacky (thomas.lendacky@amd.com) wrote:
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
>>
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
> Yep, that's fair enough - I was curious if we'll hit anything
> accidentally still reading it.
> 
> How does SEV-ES interact with the 'NODBG' flag of the guest policy - if
> that's 0, and 'debugging of the guest' is allowed, what can you actually
> do?

The SEV-ES KVM patches will disallow debugging of the guest, or at least 
setting breakpoints using the debug registers. Gdb can still break in, but 
you wont get anything reasonable with register dumps and memory dumps.

The NODBG policy bit enables or disables the DBG_DECRYPT and DBG_ENCRYPT 
APIs. So if the guest has allowed debugging, memory dumps could be done 
using those APIs (for encrypted pages). Registers are a different story 
because you simply can't update from the hypervisor side under SEV-ES.

Under SEV you could do actual debugging if the support was developed and 
in place.

Thanks,
Tom

> 
> Dave
> 
>> Thanks,
>> Tom
>>
>>>
>>> Dave
>>>
>>>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F24593.pdf&amp;data=02%7C01%7Cthomas.lendacky%40amd.com%7Cecf88d6f7bd0494d1b0e08d85bb9c19b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637360201727448609&amp;sdata=e6CbpjDDvCUG2q9pk6OSsty0QB5HuhueVAM4t8iygT8%3D&amp;reserved=0
>>>> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdeveloper.amd.com%2Fwp-content%2Fresources%2F56421.pdf&amp;data=02%7C01%7Cthomas.lendacky%40amd.com%7Cecf88d6f7bd0494d1b0e08d85bb9c19b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637360201727448609&amp;sdata=%2FUzJB5K%2F8rOMF%2B%2BVPXjg%2BJBLgD4uLW6U82Wvf8pXq%2BA%3D&amp;reserved=0
>>>> [3] 30937f2f98c4 ("OvmfPkg: Use the SEV-ES work area for the SEV-ES AP reset vector")
>>>>       https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftianocore%2Fedk2%2Fcommit%2F30937f2f98c42496f2f143fe8374ae7f7e684847&amp;data=02%7C01%7Cthomas.lendacky%40amd.com%7Cecf88d6f7bd0494d1b0e08d85bb9c19b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637360201727458605&amp;sdata=0FmiYEdIEtDjw1VIGaeeRrto%2FZpvH1esIgE93gXyagM%3D&amp;reserved=0
>>>>
>>>> ---
>>>>
>>>> These patches are based on commit:
>>>> d0ed6a69d3 ("Update version for v5.1.0 release")
>>>>
>>>> (I tried basing on the latest Qemu commit, but I was having build issues
>>>> that level)
>>>>
>>>> A version of the tree can be found at:
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FAMDESE%2Fqemu%2Ftree%2Fsev-es-v11&amp;data=02%7C01%7Cthomas.lendacky%40amd.com%7Cecf88d6f7bd0494d1b0e08d85bb9c19b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637360201727458605&amp;sdata=w1tfrMDgruZBDxNHgKLhpKtQ50Ua%2FMy9IfkSXfne2xg%3D&amp;reserved=0
>>>>
>>>> Changes since v2:
>>>> - Add in-kernel irqchip requirement for SEV-ES guests
>>>>
>>>> Changes since v1:
>>>> - Fixed checkpatch.pl errors/warnings
>>>>
>>>> Tom Lendacky (5):
>>>>     sev/i386: Add initial support for SEV-ES
>>>>     sev/i386: Require in-kernel irqchip support for SEV-ES guests
>>>>     sev/i386: Allow AP booting under SEV-ES
>>>>     sev/i386: Don't allow a system reset under an SEV-ES guest
>>>>     sev/i386: Enable an SEV-ES guest based on SEV policy
>>>>
>>>>    accel/kvm/kvm-all.c       |  73 ++++++++++++++++++++++++++
>>>>    accel/stubs/kvm-stub.c    |   5 ++
>>>>    hw/i386/pc_sysfw.c        |  10 +++-
>>>>    include/sysemu/cpus.h     |   2 +
>>>>    include/sysemu/hw_accel.h |   5 ++
>>>>    include/sysemu/kvm.h      |  18 +++++++
>>>>    include/sysemu/sev.h      |   3 ++
>>>>    softmmu/cpus.c            |   5 ++
>>>>    softmmu/vl.c              |   5 +-
>>>>    target/i386/cpu.c         |   1 +
>>>>    target/i386/kvm.c         |   2 +
>>>>    target/i386/sev-stub.c    |   5 ++
>>>>    target/i386/sev.c         | 105 +++++++++++++++++++++++++++++++++++++-
>>>>    target/i386/sev_i386.h    |   1 +
>>>>    14 files changed, 236 insertions(+), 4 deletions(-)
>>>>
>>>> -- 
>>>> 2.28.0
>>>>
>>

