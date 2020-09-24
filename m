Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC864C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F1B239E5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kna5fLx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F1B239E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZDs-000565-A5
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kLZAv-0001BD-Jo
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:53:14 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com
 ([40.107.243.54]:32225 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kLZAr-0007Vc-AL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:53:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLI9bOLc01kpH+hP8K73qmZMH1e53t4oeLD36MNO0NLdhI3M7wGoBlBriIDL/d1QC8KvW3RMuJt0IQ3NiN9JsIn24SAsuzshlv0WoD4IUKkyUuD9TrWEoQ8QQzKIAGwt7yxJRebuJoarGm9ecLzbbz4gHaQ/L99xw7xxzZ9R3zbspx749EFFCycQtLOzgQuw5f40L0c7NOYu3FnQkv1yupS381KPEqP54XAxgZ8J4wp8tsI+APFYFHxdsifMDxXz5S1o5Hthe/3hmn0zUowgJ0i98m0HGbLNzd8We2jCCvxT6aPPoZeKPbDMKrFzts5REmejMdJcRhCkH3C8aFjKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNym5ZKQr7RNJ9mpvNWLRccvGNs0SwJO2FRVBoMOUBQ=;
 b=HMYUDCvTqLpBNH6YSsaJJao+o7GpLfn++4m5ZLuz3mopmLNUUPSv5IBBi+IaVawcIRTxYUV4evJYIwLD5VUp+FZZvQWCdH1yi9Q45eFNZC1U19Yh1zOoZuoriXEFJRZdSykFsuT8D4UCp/GIdGCEhPPaYNw/c+KF8BNDQ66jfWfO0cDBYkCpIHp5vaXVvdADCQXRc64goAbBFH7rtETg14TOu93JJWvGTb4lbhOTOfn3JMXh3gXwzgOuCyQi9tNFjwgzEebRA5UKutJ3XCOenqwM5F0OLIUysOClJjxkXiWnjxb3MleJ3lsvQmVTtunTqjK7lSW4by049OkDKNtDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNym5ZKQr7RNJ9mpvNWLRccvGNs0SwJO2FRVBoMOUBQ=;
 b=kna5fLx0Ax7/XUwRzGFnANuo5RpNiGv6P02ZVOEyPK3ejMiQjSc/L3M/MZGBJ2P42JCaVlrdxuOlulfsT3IPoUgbrBq2SoySlfzeLGfF7tQ3onnH+fv4QF12xfxe49EjUB9cLi/3olhVwPZuAqzhoqiN5y0/q9Xi03AI1pvC/Eo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 21:53:03 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 21:53:03 +0000
Date: Thu, 24 Sep 2020 21:52:56 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: SEV guest debugging support for Qemu
Message-ID: <20200924215256.GA8562@ashkalra_ubuntu_server>
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
 <20200924135342.GE2792@work-vm>
 <20200924190653.GA8180@ashkalra_ubuntu_server>
 <a35415c9-6e50-5260-e0e6-e36b9f16f2b2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a35415c9-6e50-5260-e0e6-e36b9f16f2b2@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN6PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:805:f2::21) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SN6PR04CA0080.namprd04.prod.outlook.com (2603:10b6:805:f2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 21:53:02 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13ddc930-e114-4784-baf8-08d860d435eb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45907E9B880E6914D4B107FF8E390@SA0PR12MB4590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W43zKmKB6A1XiQHQez8R4DRwykgodcxU/fMoceAthEkEzPOgrt9Fot07pGzgaMd9uH12Rlxha0jKlenh2H3w4zIIX1cJoTs5GTznUtTNoFidc18wJQ9qsXRBg3A6JGaZZtwo+4bCX/hfGnMqbuG6+5i4RX4wh392LZbchXIVTUqsrwiplyjCs61vLrtvn82IjBuJe534YR+WxpCU7Dys+hwxuV7zr1PJiLjvsF3H/nn8CS6Bjlc/7LkPdSHbmAXYT6XgV+hGlXYex9yVulwO2OIMdXzpJISBIG3WkY9zEFx3Xm8i0POXL9NJphde4BZ2iBJ9yyrSCMZsIGQkt9yfTLZxYrQBN92N+PL44SQA2CQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(6862004)(45080400002)(956004)(52116002)(186003)(1076003)(16526019)(966005)(2906002)(8676002)(316002)(6636002)(478600001)(5660300002)(4326008)(26005)(66946007)(86362001)(6666004)(44832011)(53546011)(66476007)(66556008)(6496006)(8936002)(33656002)(9686003)(83380400001)(55016002)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: skZZjyi7kSo5ImLGiJOeD4gxYlUSP938Mc3sInOuXSjr8JWmhF9AsBHbuBEyUI4sdAt+9LiKbIMsgph63ztDPVdbbg2eDqdzIJx7ML4E5Lix6yFTPGbXn1J8dXFm0gqG3y1VVLJ+rkK1LUzZvlndskSnsXwg7DtY9En9SWhsTMcqIiXTDpvpmYzdvtcTL+AYrWB0om1ZnrGExJXWPoJfXY/uF9FOChu/Karx75bk3hcUwt2fesaxnxykU4JdUG11bIUXVF07IDXiSkq0ldpECG12xLn+N/oxu/4WdbrJP7RQwgRMeKrpVZBVxp3itIFdJA/+HRG/QwTcO+XMZU2GnrvCdctdiMG5UtY4I3qnG7x9pg5/OlU4DopWxELalsGwy9xgLWGUzzJi6R4RbeMJxfjzU9ZZzxuXCpYoobeuCMRV6kFler1anyA5V1Z4UHKGGiYQe0GXWw3hdXFPm094hYNZxZbEguzv+xTztn4QDgvIIVCzTb0K9ODBVJdTQQk5xIs9hwWteM2YAUAXoegsGu8WeslTiMNmFAo7Wxt28gKNgJZO6qkVS45r0j6JtqmTGaD/gkB9NAnBc8wdWf0lP+7PhvbvZKh3r2JoxayA9p3vFUTfIaG0iImuCYHoV5ys/7q7lz4ZGqZclgwZW/NLvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ddc930-e114-4784-baf8-08d860d435eb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 21:53:02.9498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkkfEJl24UDk8HN6wcu00dV+pCobFjooHPY6z+mukuUSLjEGSyKa73S5gxAbIJqbE6uhRObRZWcbMdVAvazRLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
Received-SPF: none client-ip=40.107.243.54; envelope-from=Ashish.Kalra@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 17:53:04
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
Cc: pbonzini@redhat.com, thomas.lendacky@amd.com, jon.grimm@amd.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 02:37:33PM -0500, Brijesh Singh wrote:
> 
> On 9/24/20 2:06 PM, Ashish Kalra wrote:
> > Hello Dave,
> >
> > Thanks for your response, please see my replies inline :
> >
> > On Thu, Sep 24, 2020 at 02:53:42PM +0100, Dr. David Alan Gilbert wrote:
> >> * Ashish Kalra (ashish.kalra@amd.com) wrote:
> >>> Hello Alan, Paolo,
> >>>
> >>> I am following up on Brijesh’s patches for SEV guest debugging support for Qemu using gdb and/or qemu monitor.
> >>> I believe that last time, Qemu SEV debug patches were not applied and have attached the link to the email thread and Paolo’s feedback below for reference [1].
> >>> I wanted to re-start a discussion on the same here with the Qemu community and seek the feedback on the approaches which we are considering :
> >>> Looking at Qemu code, I see the following interface is defined, for virtual memory access for debug : cpu_memory_rw_debug(). 
> >>> Both gdbstub (target_memory_rw_debug() ) and QMP/HMP (monitor/misc.c : memory_dump() ) use this standard and well-defined interface to access guest memory for debugging purposes. 
> >>>
> >>> This internally invokes the address_space_rw() accessor functions which we had  "fixed" internally (as part of the earlier patch) to invoke memory region specific debug ops. 
> >>> In our earlier approach we were adding debug ops/callbacks to memory regions and as per comments on our earlier patches, Paolo was not happy with this debug API for
> >>> MemoryRegions and hence the SEV support for Qemu was merged without the debug support.
> >>>
> >>> Now, we want to reuse this cpu_memory_rw_debug() interface or alternatively introduce a new generic debug interface/object in the Qemu. This 
> >>> debug interface should be controlled through the global machine policy.
> >> Let me leave the question of how the memory_rw_debug interface should
> >> work to Paolo.
> >>
> >>> For e.g., 
> >>> # $QEMU -machine -debug=<a debug object>
> >>> or
> >>> # $QEMU -machine -debug=sev-guest-debug
> >>>
> >>> The QMP and GDB access will be updated to use the generic debug  interface. The generic debug interface or the cpu_memory_rw_debug() interace will introduce hooks to call a 
> >>> vendor specific debug object to delegate accessing the data. The vendor specific debug object may do a further checks before and after accessing the memory.
> >> I'm not sure that needs a commandline switch for it; since you can
> >> already get it from the guest policy in the sev object and I can't think
> >> of any other cases that would need something similar.
> > Yes, i agree with that, so i am now considering abstracting this vendor
> > specific debug interface via CPUClass object instead of doing it via
> > MemoryRegions. 
> >
> >>> Now, looking specifically at cpu_memory_rw_debug() interface, this interface is invoked for all guest memory accesses for debugging purposes and it also does 
> >>> guest VA to GPA translation via cpu_get_phys_page_attrs_debug(), so we can again add a vendor specific callback here to do guest VA to GPA translations specific
> >>> to SEV as SEV guest debugging will also require accessing guest page table entries and decrypting them via the SEV DBG_DECRYPT APIs and additionally clearing
> >>> the C-bit on page table entries (PxEs) before using them further for page table walks.
> >>>
> >>> There is still an issue with the generic cpu_memory_rw_debug() interface, though it is used for all guest memory accesses for debugging and we can also handle
> >>> guest page table walks via it (as mentioned above), there are still other gdb/monitor commands such as tlb_info_xx() and mem_info_xx() which also do guest page
> >>> table walks, but they don’t go through any generic guest memory access/debug interface, so these commands will need to be handled additionally for SEV.
> >> If some of those should be using the debug interface and aren't then
> >> please fix them anyway.
> >>
> >>> The vendor specific debug object (added as a hook to generic debug object or the generic cpu_memory_rw_debug() interface) will do further checks before and after accessing the memory.
> >>>
> >>> e.g., in the case of SEV,
> >>>
> >>> 1. Check the guest policy, if guest policy does not allow debug then return an error.
> >>>
> >>> 2. If its an MMIO region then access the data.
> >>>
> >>> 3. If its RAM region then call the PSP commands to decrypt the data.
> >>>
> >>> 4. If caller asked to read the PTE entry then probably clear the C-bits after reading the PTE entry.
> >> Does that work if the guest is currently running?
> >>
> > I assume you are asking that is this done when guest is being debugged,
> > the above steps are only done when the guest is paused and being debugged.
> 
> 
> I don't why we need to pause the guest. Ideally we should be able to
> connect to Qemu monitor and run the "x" command to dump memory. IIRC, if
> paging is enabled then monitor will walk the guest page table to reach
> to gpa. Something like this in the Qemu monitor console should work:
> 
> x /10i $eip
> 
> 

Yes that works, what i basically meant that monitor will invoke a set of debugging
interfaces to get gpa and then dump guest memory even while guest is
running.

Thanks,
Ashish

> >
> >>> 5. many more checks
> >>>
> >>> Looking fwd. to your feedback/comments on the above approach or other any other suggestions.
> >>>
> >>> Thanks,
> >>> Ashish
> >>>
> >>> [1] -> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fnext.patchew.org%2FQEMU%2F20180308124901.83533-1-brijesh.singh%40amd.com%2F20180308124901.83533-29-brijesh.singh%40amd.com%2F&amp;data=02%7C01%7Cashish.kalra%40amd.com%7Cd21e40d3527d4dba609c08d86091490e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637365524404435805&amp;sdata=P%2F6DqPQmUObJipkbbeXcrUdCqulePiqxSU6OB8xUEWo%3D&amp;reserved=0
> >>>
> >> -- 
> >> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>

