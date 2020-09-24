Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93270C47423
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D902020878
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hxY/zHZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D902020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWpR-0005PR-To
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kLWoi-0004zq-Jg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:22:08 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com
 ([40.107.243.56]:25728 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kLWog-0005xa-9R
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:22:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2B87cX1u29+Y4vxhS7fHRQQSrRPlZxQHB13840wsXR/2i8+kvqO1ZKjeiRBS133AOUVG+JoXxeDBdyd788ZoFruuzH2xSwsozWEpfnP3XmVhb17Xfo9Yi8TrNG/mfwGxiEUo5XZ5zBuUYv7wXk3A1XelxV5dk9rls+Xqrzxx0ZVK5kKZ5ZjzJ8ZuwkVhoH3rzIg8Y/vngSL3bL1zHeNQ3Qh1Z/DqPXZ8nacrIqOkBYje3W3+EnwrTnj8ixv/eGeqp4tygB+V0jyZRXhXsB9o7VJgqiVjlUtlTg1DxIgK2fj+61DSteAZAZG1XbpsCsENsQzgnYOPjq84xVsWSgl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq2crxUm/CiprIFzaXEF31SKjL9OlEAOL5toV9VOHaQ=;
 b=YUF3FtS/at6ogK6XkulMhjZQcPcPWNsY4SLlzDBrsX42vS59VdtXIESBygTO7moIGPRQ1MwQ2fY9TC3q1mck1KsqvgNgPGyV3Od3qiHCM+c6NsoMzq4tM/u9qV8toavFk6AqRBGIAU67jbNwAxTYuMvSeHD7ow2dmdm+YJFBukBI+YXKX4pyo+LnwgSLPyjOBsqGWbfQGkoYxLvTb9S8FPaUqKb1a9n/Fh6TdOnBxA+1akcXagCM2krrWKulAc8JcIR72GWrMk711Og/f1LEgpD8L/nx2kBpE4pvLXNn5k5v24LcWhzM3RGww1T5e089ZJNGM/XwcGxPyN2TJ6NtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq2crxUm/CiprIFzaXEF31SKjL9OlEAOL5toV9VOHaQ=;
 b=hxY/zHZWqAJOIRqY26ZxzzwzVFbqjXkCitI14rTcCYaIE+djnCCJ0yjKtD/eeRUHozJNK2NHEZWM76w679+r7mRoXzzxSnEbzXVbztn4ZAM0pfQIZJdTXNdq0w36SDeF5Ibu7aHLtM8qeKgOJ4tUenNJSovMVW/aYLHIfY9T8aI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 19:07:00 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 19:07:00 +0000
Date: Thu, 24 Sep 2020 19:06:53 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: SEV guest debugging support for Qemu
Message-ID: <20200924190653.GA8180@ashkalra_ubuntu_server>
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
 <20200924135342.GE2792@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924135342.GE2792@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM3PR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:0:56::15) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 19:06:59 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91ba89a3-6f52-426d-d8cb-08d860bd03a1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447CD7FEFC7E4D5D628FA3E8E390@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d22CI7TNLnasTsmTOZLzBt+i5382TmSUBV8DMh2KAUTmHskL//ceIuynV4Vk+at+oKZ7YbK1eN3DBNkjAfCqAc6MARFJZoXsjwITuYGJvEOfnIN5u1Y4qBYsi/yrIGNH4yMqQC/7r/bB867u0dh887rGxt71bm3+eJcmCFhLF3rLmndVAaCCx/hJVoZrmBfruyyqHQqSXFwyvGaBSIgiGvVjAatmm0y7Z9BRr/tXzZhHUb0Z9PzuBDNM33HR02hzqffBZGV5FFZSxlwxdQTBvk/Tw3eJK4AI8hiof4P+miBixiEVjtHQG23CBdR0WLxEbEB7FgV1DtfJxdk4gvbgkAjlDEDsEYQUD2KPg0DQPQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(478600001)(86362001)(6666004)(44832011)(186003)(956004)(966005)(4326008)(26005)(83380400001)(9686003)(6916009)(316002)(66476007)(45080400002)(66946007)(8936002)(66556008)(8676002)(33656002)(55016002)(33716001)(1076003)(5660300002)(6496006)(2906002)(16526019)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sLz7y9RVv3Jobv4hu24HB7iNHc+Yr5hB3ohF87zJ2+pBoWZRQQGJTeqCK3Td9MmTusCfc6bl4/gQVy6a1J8dQryFOuOQPS4lb27U1++ttmYwR2cVFFgS8ky7qqA++oS4Ww71EzJAnJ1GDcl47x9hdE4AS5/OA6S3GoIyrO3HM+s2Lpz3oktu2KprB64WyqHiw/saBYLhOvjAPRju5j1W7CZ61gUjbqvzdNxEbZaC6jaUNzQ7GDfEL0gm9uXwKOQ99KYsg6V/+BEyUAGxqmoydVJgn+GI+fLGrOxO44de111JEnWgqq/rEvOCTSna1a+/5Joa7Lsd7FLFiDReCD3VVaxpgZggEQS1DnbAl9mHLjPVuRkUjGkaYh0oANMMIUAqflkPgdOHezS8AtUMMWJP9/0ReCJHSqXtNH9IBburZ0wtlqQ1ZV0UHXrolazphQ/zsD+GVEEpY+rTzwdCA7i5Gwe8hOUx1CuDCmiul47zgTDGzvrPYdeKmRQsSU91PNGqfpLgLW0XqIX8UtttN4JEza74Fia7kj696TDfCQjOd3ASwwU0V2IeTAJPwhuhIVVoG/48txDEiscc73Jm8DnPnLvkrBxxoDCs/7DjG743y3RAIJ7D15UyHfr0jQsq9DJdZOxJu0vuTnF3PncmK87GeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ba89a3-6f52-426d-d8cb-08d860bd03a1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:07:00.1827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBy/z0ZW1YPmDVNUIPmK0bmI/J2hHnUzeyBTi2SsY1X5hDGOoB35h7WMjFdLIlI/9hCKF6031IIsAUF/h7CY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Received-SPF: none client-ip=40.107.243.56; envelope-from=Ashish.Kalra@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:22:03
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: pbonzini@redhat.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 qemu-devel@nongnu.org, thomas.lendacky@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Dave,

Thanks for your response, please see my replies inline :

On Thu, Sep 24, 2020 at 02:53:42PM +0100, Dr. David Alan Gilbert wrote:
> * Ashish Kalra (ashish.kalra@amd.com) wrote:
> > Hello Alan, Paolo,
> > 
> > I am following up on Brijesh’s patches for SEV guest debugging support for Qemu using gdb and/or qemu monitor.
> > I believe that last time, Qemu SEV debug patches were not applied and have attached the link to the email thread and Paolo’s feedback below for reference [1].
> > I wanted to re-start a discussion on the same here with the Qemu community and seek the feedback on the approaches which we are considering :
> > Looking at Qemu code, I see the following interface is defined, for virtual memory access for debug : cpu_memory_rw_debug(). 
> > Both gdbstub (target_memory_rw_debug() ) and QMP/HMP (monitor/misc.c : memory_dump() ) use this standard and well-defined interface to access guest memory for debugging purposes. 
> > 
> > This internally invokes the address_space_rw() accessor functions which we had  "fixed" internally (as part of the earlier patch) to invoke memory region specific debug ops. 
> > In our earlier approach we were adding debug ops/callbacks to memory regions and as per comments on our earlier patches, Paolo was not happy with this debug API for
> > MemoryRegions and hence the SEV support for Qemu was merged without the debug support.
> > 
> > Now, we want to reuse this cpu_memory_rw_debug() interface or alternatively introduce a new generic debug interface/object in the Qemu. This 
> > debug interface should be controlled through the global machine policy.
> 
> Let me leave the question of how the memory_rw_debug interface should
> work to Paolo.
> 
> > For e.g., 
> > # $QEMU -machine -debug=<a debug object>
> > or
> > # $QEMU -machine -debug=sev-guest-debug
> > 
> > The QMP and GDB access will be updated to use the generic debug  interface. The generic debug interface or the cpu_memory_rw_debug() interace will introduce hooks to call a 
> > vendor specific debug object to delegate accessing the data. The vendor specific debug object may do a further checks before and after accessing the memory.
> 
> I'm not sure that needs a commandline switch for it; since you can
> already get it from the guest policy in the sev object and I can't think
> of any other cases that would need something similar.

Yes, i agree with that, so i am now considering abstracting this vendor
specific debug interface via CPUClass object instead of doing it via
MemoryRegions. 

> > Now, looking specifically at cpu_memory_rw_debug() interface, this interface is invoked for all guest memory accesses for debugging purposes and it also does 
> > guest VA to GPA translation via cpu_get_phys_page_attrs_debug(), so we can again add a vendor specific callback here to do guest VA to GPA translations specific
> > to SEV as SEV guest debugging will also require accessing guest page table entries and decrypting them via the SEV DBG_DECRYPT APIs and additionally clearing
> > the C-bit on page table entries (PxEs) before using them further for page table walks.
> > 
> > There is still an issue with the generic cpu_memory_rw_debug() interface, though it is used for all guest memory accesses for debugging and we can also handle
> > guest page table walks via it (as mentioned above), there are still other gdb/monitor commands such as tlb_info_xx() and mem_info_xx() which also do guest page
> > table walks, but they don’t go through any generic guest memory access/debug interface, so these commands will need to be handled additionally for SEV.
> 
> If some of those should be using the debug interface and aren't then
> please fix them anyway.
> 
> > The vendor specific debug object (added as a hook to generic debug object or the generic cpu_memory_rw_debug() interface) will do further checks before and after accessing the memory.
> > 
> > e.g., in the case of SEV,
> > 
> > 1. Check the guest policy, if guest policy does not allow debug then return an error.
> > 
> > 2. If its an MMIO region then access the data.
> > 
> > 3. If its RAM region then call the PSP commands to decrypt the data.
> > 
> > 4. If caller asked to read the PTE entry then probably clear the C-bits after reading the PTE entry.
> 
> Does that work if the guest is currently running?
> 

I assume you are asking that is this done when guest is being debugged,
the above steps are only done when the guest is paused and being debugged.

Thanks,
Ashish

> 
> > 5. many more checks
> > 
> > Looking fwd. to your feedback/comments on the above approach or other any other suggestions.
> > 
> > Thanks,
> > Ashish
> > 
> > [1] -> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fnext.patchew.org%2FQEMU%2F20180308124901.83533-1-brijesh.singh%40amd.com%2F20180308124901.83533-29-brijesh.singh%40amd.com%2F&amp;data=02%7C01%7Cashish.kalra%40amd.com%7Cd21e40d3527d4dba609c08d86091490e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637365524404435805&amp;sdata=P%2F6DqPQmUObJipkbbeXcrUdCqulePiqxSU6OB8xUEWo%3D&amp;reserved=0
> > 
> -- 
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

