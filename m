Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27624C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF692074D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="olZFieDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF692074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGqll-0001WF-TH
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <brijesh.singh@amd.com>) id 1jGqk6-0007J8-N9
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1jGqk4-0005VH-Hu
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:05:46 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com
 ([40.107.223.75]:53149 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1jGqjz-0005Qx-JW; Tue, 24 Mar 2020 17:05:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+/A+/cX3MlBeDtuJTQxjdLR1Z3GJF6vpNnyo/hxnwPrU/bH5BahUYd5nJrUi+iF13KrSil1bKTNC0dgfMgcA/7rvVUSfJALM0fgLKcqgk6n45nBIh01Msn759o8XkYE7LME4pVKPKhClm7tHFnk3s3SmgDMvIiMF/pZhYlZ8IQhGdY3m+2BseQ2RPRLsib/oEcHzDnga8KKlW/JZkbcl8sViI2gfPempQwHi45c2Sh3ZUbBNrIKatLHycFqU/CR39qwkH7Mzq/fL07ngP3W9mtLPjYFz4+3edXFLjVJzyr3Ti7PIN232mvGC7v+irGY09hPmWRZ5eJL6dVr4RxNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxUR7gOySfBysgfbxKn3YDX1S8UpJCoO0CrnTj3HrFA=;
 b=hINsm7f9BvnGVT6HdPCkGw3/NTsoEPiFOWRJXcVn8FdnyFVJndPz2kcDH767G+Wwx3dmqE6ZMsEuPAsAFrK1xKQKohyuNztJF/eBdDZ+AuJjXOV8wAPNjGJSAzKXhlCQG/UXeiWA4Ny3xTdzaYCasE56rUrSD50IWWX+aFRIolIe9MY9ScfgLqJ2cf6vMk+VBOq+5pWrquh53qK13cHrFhsQa8U4bgyqVw1VjY0FwIEVXYpaN/Hjjcb/WlGJgfIusaPyc/gvy9XhJM08xTL9qB3+Pq5heVpgZTRIEYRGBxbFb0Bt3a2k6edaWBxu2kn7AkXQDa5EuSOQT5ToavMZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxUR7gOySfBysgfbxKn3YDX1S8UpJCoO0CrnTj3HrFA=;
 b=olZFieDEDMuEMgF4E/NvAvyJQRexBZCSWJRjuKuG+vxe0ay9tH09jhxL2cWrhx23Q9vpiGLBmUxG27dc9S3JP9bPmg7k9StmXLJYA4g/UyMIlhKnMnYcFfEkYxH+iY7C1Yx9qIFI0+wIgCCJlFIXIXBhFm7GmmWKhAmCwaGqSJo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Tue, 24 Mar
 2020 21:05:37 +0000
Received: from SA0PR12MB4400.namprd12.prod.outlook.com
 ([fe80::60d9:da58:71b4:35f3]) by SA0PR12MB4400.namprd12.prod.outlook.com
 ([fe80::60d9:da58:71b4:35f3%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 21:05:37 +0000
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when switching
 to protected mode
To: Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
 <20200227132402.67a38047.pasic@linux.ibm.com>
 <8622efeb-1a4a-338f-d363-53818b00d195@redhat.com>
 <20200319164050.78a01702.pasic@linux.ibm.com>
 <d7d91f47-19d3-06cf-879c-c9556a924a2f@redhat.com>
 <20200320194317.1cf36b00.pasic@linux.ibm.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <792d460f-af14-de36-9ce2-c802e46fd1d4@amd.com>
Date: Tue, 24 Mar 2020 16:07:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
In-Reply-To: <20200320194317.1cf36b00.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: DM5PR22CA0014.namprd22.prod.outlook.com
 (2603:10b6:3:101::24) To SA0PR12MB4400.namprd12.prod.outlook.com
 (2603:10b6:806:95::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by
 DM5PR22CA0014.namprd22.prod.outlook.com (2603:10b6:3:101::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Tue, 24 Mar 2020 21:05:34 +0000
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d55da75a-20d4-4f32-38e2-08d7d0371981
X-MS-TrafficTypeDiagnostic: SA0PR12MB4462:|SA0PR12MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4462481F5B78FA1CE981BA9AE5F10@SA0PR12MB4462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(2906002)(6666004)(53546011)(81156014)(81166006)(186003)(6512007)(8676002)(6506007)(26005)(31686004)(52116002)(6486002)(86362001)(4326008)(966005)(16526019)(31696002)(8936002)(66556008)(45080400002)(316002)(44832011)(36756003)(66476007)(478600001)(110136005)(956004)(66946007)(2616005)(54906003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4462;
 H:SA0PR12MB4400.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGKrahynSB8rFOv5M8+W1BBtkEdMUrfwiFebT3WGubduknMJ+EuMgiyMv3MHQYfQVTOUPIdf96r39rgBoKmUQcU2+q15wIYeMRYrcqyc7/jvLZXwafpsH1MiIKAA5NwXa0iAY2ud/0E/+JfAiMdBrUUg9xeK6KmGlWNfZhhL3/xxUsMf6jSDRVQTpXckFF/N2CXn4+CSj482h/pvCOmHw9CtKZzT/FgO1Ei/KYe8I0KxxJDbMAnyylUPdXwkduATZE+vT8cDi30ffcLU9ecAyxhenBjri+cYv18f5RcOh3/8JMKIfeMKrhdSdfeoah1ZpRkgdB2ulJ3pTRQwz53Z7wWHUz769vkhRuZ1bmFwLXjET0rOnS2HXfKY9fkN3I1lhVgycb7nIZMcpNnaYOtUE5ce9xe2fzKSFPhDNxrc9Ll0a9UMCSD8EPOA5iqjEE5y/I8toPijUFny0lBrG+rvhijQkdnjccjVPVh+7dJlqHSSQJKC3U6MimvBf0+gIA3qjYZhcwnZoYAidq+jW88o8w==
X-MS-Exchange-AntiSpam-MessageData: eluqgu3+qe7XpiRtJ+u7lEhSoFHhhZ/nRNUbN5U34hCgJsutNrU7oaKJslBaeAnmQe/MDveM8rOTRyopcFXDOtuHtxdl5Z45aFQLq/kkGigSW4BA2+q+NMhElMGS4rDACrrzxm8rKOKzLggoLczaqA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55da75a-20d4-4f32-38e2-08d7d0371981
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 21:05:36.8819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYVDEz4240cj5URCypcDSQ8cgqW6kYKSVuOZC0r4z2p2DvMzE7ZAvEIGw/N0Smhhhdt30tna2UaOpHAlRxPJYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.223.75
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, brijesh.singh@amd.com,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 3/20/20 1:43 PM, Halil Pasic wrote:
> On Thu, 19 Mar 2020 18:31:11 +0100
> David Hildenbrand <david@redhat.com> wrote:
>
>> [...]
>>
>>>> I asked this question already to Michael (cc) via a different
>>>> channel, but hare is it again:
>>>>
>>>> Why does the balloon driver not support VIRTIO_F_IOMMU_PLATFORM? It
>>>> is absolutely not clear to me. The introducing commit mentioned
>>>> that it "bypasses DMA". I fail to see that.
>>>>
>>>> At least the communication via the SG mechanism should work
>>>> perfectly fine with an IOMMU enabled. So I assume it boils down to
>>>> the pages that we inflate/deflate not being referenced via IOVA?
>>> AFAIU the IOVA/GPA stuff is not the problem here. You have said it
>>> yourself, the SG mechanism would work for balloon out of the box, as
>>> it does for the other virtio devices. 
>>>
>>> But VIRTIO_F_ACCESS_PLATFORM (aka VIRTIO_F_IOMMU_PLATFORM)  not
>>> presented means according to Michael that the device has full access
>>> to the entire guest RAM. If VIRTIO_F_ACCESS_PLATFORM is negotiated
>>> this may or may not be the case.
>> So you say
>>
>> "The virtio specification tells that the device is to present
>> VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
>> device "can only access certain memory addresses with said access
>> specified and/or granted by the platform"."
>>
>> So, AFAIU, *any* virtio device (hypervisor side) has to present this
>> flag when PV is enabled. 
> Yes, and balloon says bye bye when running in PV mode is only a secondary
> objective. I've compiled some references:
>
> "To summarize, the necessary conditions for a hack along these lines
> (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:
>
>   - secure guest mode is enabled - so we know that since we don't share
>     most memory regular virtio code won't
>     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM" 
> (Michael Tsirkin, https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F2%2F20%2F1021&amp;data=02%7C01%7Cbrijesh.singh%40amd.com%7C52b79b5c9e894dd968c508d7ccfe9479%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203266090844487&amp;sdata=aNS%2FW2nL27mPSl1Xz3iXUY31qtrzmVHYhzVHEILAaQQ%3D&amp;reserved=0)
> I.e.: PV but !VIRTIO_F_ACCESS_PLATFORM \implies bugy hypervisor
>
>
> "If VIRTIO_F_ACCESS_PLATFORM is set then things just work.  If
> VIRTIO_F_ACCESS_PLATFORM is clear device is supposed to have access to
> all of memory.  You can argue in various ways but it's easier to just
> declare a behaviour that violates this a bug."
> (Michael Tsirkin, https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F2%2F21%2F1626&amp;data=02%7C01%7Cbrijesh.singh%40amd.com%7C52b79b5c9e894dd968c508d7ccfe9479%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203266090854439&amp;sdata=d3knybBUZ5NL0Lv1C2JS040A3toiCxXVYLkBlzXSrqc%3D&amp;reserved=0)
> This one is about all memory guest, and not just the buffers transfered
> via the virtqueue, which surprised me a bit at the beginning. But balloon
> actually needs this.
>
> "A device SHOULD offer VIRTIO_F_ACCESS_PLATFORM if its access to memory
> is through bus addresses distinct from and translated by the platform to
> physical addresses used by the driver, and/or if it can only access
> certain memory addresses with said access specified and/or granted by
> the platform. A device MAY fail to operate further if
> VIRTIO_F_ACCESS_PLATFORM is not accepted. "
> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.oasis-open.org%2Fvirtio%2Fvirtio%2Fv1.1%2Fcs01%2Fvirtio-v1.1-cs01.html%23x1-4120002&amp;data=02%7C01%7Cbrijesh.singh%40amd.com%7C52b79b5c9e894dd968c508d7ccfe9479%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203266090854439&amp;sdata=RBx8cBr8I%2FWFChtVFTjBygRiHIXMmsjT8W%2BwLaTNQ24%3D&amp;reserved=0)
>
>
>> In that regard, your patch makes perfect sense
>> (although I am not sure it's a good idea to overwrite these feature
>> bits
>> - maybe they should be activated on the cmdline permanently instead
>> when PV is to be used? (or enable )).
> I didn't understand the last part. I believe conserving the user
> specified value when not running in PV mode is better than the hard
> overwrite I did here. I wanted a discussion starter.
>
> I think the other option (with respect to let QEMU manage this for user,
> i.e. what I try to do here) is to fence the conversion if virtio devices
> that do not offer VIRTIO_F_ACCESS_PLATFORM are attached; and disallow
> hotplug of such devices at some point during the conversion.
>
> I believe that alternative is even uglier.
>
> IMHO we don't want the end user to fiddle with iommu_platform, because
> all the 'benefit' he gets from that is possibility to make a mistake.
> For example, I got an internal bug report saying virtio is broken with
> PV, which boiled down to an overlooked auto generated NIC, which of
> course had iommu_platform (VIRTIO_F_ACCESS_PLATFORM) not set.
>
>>> The actual problem is that the pages denoted by the buffer
>>> transmitted via the virtqueue are normally not shared pages. I.e.
>>> the hypervisor can not reuse them (what is the point of balloon
>>> inflate). To make this work, the guest would need to share the pages
>>> before saying 'host these are in my balloon, so you can use them'.
>>> This is a piece of logic we
>> What exactly would have to be done in the hypervisor to support it?
> AFAIK nothing. The guest needs to share the pages, and everything works.
> Janosch, can you help me with this one? 
>
>> Assume we have to trigger sharing/unsharing - this sounds like a very
>> architecture specific thing?
> It is, but any guest having sovereignty about its memory may need
> something similar.
>
>> Or is this e.g., doing a map/unmap
>> operation like mapping/unmapping the SG?
> No this is something different. We need stronger guarantees than the
> streaming portion of the DMA API provides. And what we actually want
> is not DMA but something very different.
>
>> Right now it sounds to me "we have to do $ARCHSPECIFIC when
>> inflating/deflating in the guest", which feels wrong.
>>
> It is wrong in a sense. Drivers are mostly supposed to be portable. But
> balloon is not a run of the mill device. I don't see any other way to
> make this work.
>
>>> need only if the host/the device does not have full access to the
>>> guest RAM. That is in my opinion why the balloon driver fences
>>> VIRTIO_F_ACCESS_PLATFORM.> Does that make sense?
>> Yeah, I understood the "device has to set VIRTIO_F_ACCESS_PLATFORM"
>> part. Struggling with the "what can the guest driver actually do" part.
>>
> Let me try to reword this. The point of PV is that the guest has
> exclusive access to his pages unless the guest decides to share some
> of the using a dedicated ultravisor call.
>
> The point of the memballoon is, as far as I understand, to effectively
> dynamically manage the guests memory size within given boundaries, and
> without requiring memory hotplug. The basic idea is that the pages in
> the balloon belong to the host. The host attempting to re-use a
> non-shared page of a guest leads to problems. AFAIR the main problem
> was that shall we ever want to deflate such a page (make it again
> available for guest use) we would need to do an import, and that can
> only work if we have the exact same content as when it was exported.
> Otherwise integrity check fails as if we had a malicious hypervisor,
> that is trying to inject stuff into the guest.
>
> I'm sure Janosch can provide a better explanation.
>
> I really don't see another way, how memory ballooning could work with
> something like PV, without the balloon driver relinquishing the guests
> ownership of the pages that are going to leave the guest via the balloon.
>
> On that note ccing the AMD SEV people. Balloon is at this point
> dysfunctional for them as well. @Tom: Right? If yes what problems need to
> be solved so virtio-balloon can work under SEV?


Yes, Balloon does not work for SEV as well. I did not investigated in
the great detail on what it will take to make it work. At that time the
main issue was that the balloon virtio device did not had
VIRTIO_F_ACCESS_PLATFORM flag set. So, we were failing to create a
shared virtio ring. The current SEV does not have integrity protection
support so we should be okay to release the buffer from guest and import
the buffer into the guest. We probably need to deal with some cache
flushes because cache may still contain the data with different C-bit
etc. AMD has recently published the SNP architecture, which supports the
integrity protection and it appears that this architecture provides some
instruction which guest can used by the guest to validate and invalidate
the pages as it leaves and enter the guest memory space. Overall, i
think its doable but devil in the detail.

> Regards,
> Halil 
>
>

