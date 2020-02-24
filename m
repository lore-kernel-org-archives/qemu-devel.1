Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7EEC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4FE20732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mqq2221a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4FE20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Hdc-0005HD-NF
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j6HZ1-00019V-Lo
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j6HZ0-0006Fr-G1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:30:39 -0500
Received: from mail-eopbgr770055.outbound.protection.outlook.com
 ([40.107.77.55]:3142 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j6HZ0-0006D6-9q
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:30:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmuujTeqJIM1HyXrsuiQK9kEbAaalA2pxdpB5jNDE7nCRf3v67FGYsMEfkUQXJY7uydQ45bK4OPX+RosLm3y8P/B1KomJm3MYFrzHcCHuAsiPAel11/AdvXUwGmGexj8x/q2XSBfpfYWR1iooVAWYHDW4VfqySGeuNigq2NYem2naIyjzL1Z4Y3dEnOJsmRyNsOWSP4NJBZAV2SjwY/zs3IHkHxJQflz4tU4tyaSiY1NjHnGLwWHrNx53+QKmWKoAI8EhsgWxx/ZoBYi90TKqiKdAU5nxUL2FxrKzA62DZ2dKnbfsJh6QDO5lHBLLvYNYWPjmSDRkxmak3gwra+HMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBktjg86PEEOhIOI5qrHNMTzrvq0wxdevHGizPnE3N0=;
 b=QsqV/3ZUDL1+D3fJtw8mvYC2umNsyroKDyXCti2zTyOTSmwrp0Gx9nExMIEN4dTKbTEBW237ILWpN6ovvkhShjczsA1LZfJhzKXozMFU63lHKFvgmHfnWZWQwtpBNrVljhfs3W32JrhC1tt49ovvVrQ97TAKUoj/Bju41788YG4cyh+zxxzejH1948+yGVxAXS/xXGd1jg/z5G5TRuK+pb1/Fo9GNYrQtZ5RFRqr/F39kT4LNqyuUmNA57mZYDCE0xA9BqHPCsTuCs75GOyzI5Cgj495Bm7C4NqftBJwCauC/jUHHg948fgWz+VfxH9fA8v24vaZjyjJctfvKJuq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBktjg86PEEOhIOI5qrHNMTzrvq0wxdevHGizPnE3N0=;
 b=Mqq2221a2isTSpApyMhcY8UFKvn9PFgBvma9YQ98T9Py0BeSig3PiHf75S+hYhVhlx6yunJk5Vst5YAsz0NpUF/LcvvZ4n/4oDO2FtvWUmbT6qukrkn52B2Nk2iF1TKA4wbg4YVJ8eNyc+2n0bBCA6GVA8Bd2nx9Q21d4GfikYo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2463.namprd12.prod.outlook.com (2603:10b6:802:22::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Mon, 24 Feb
 2020 17:30:36 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2008:df09:34a9:62fa%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:30:36 +0000
Subject: Re: [PATCH v4 10/16] hw/i386: Introduce apicid functions inside
 X86MachineState
To: Igor Mammedov <imammedo@redhat.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161785243.48948.11368379114010493667.stgit@naples-babu.amd.com>
 <20200224180133.3a3bdf4c@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <af05e3db-6818-c07f-ddfd-87560d95d6f4@amd.com>
Date: Mon, 24 Feb 2020 11:30:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200224180133.3a3bdf4c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:805:de::38) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 SN6PR05CA0025.namprd05.prod.outlook.com (2603:10b6:805:de::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.11 via Frontend Transport; Mon, 24 Feb 2020 17:30:34 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c8a2a16-cd2b-434d-6019-08d7b94f4256
X-MS-TrafficTypeDiagnostic: SN1PR12MB2463:
X-Microsoft-Antispam-PRVS: <SN1PR12MB246354591D6BF81E820989ED95EC0@SN1PR12MB2463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(86362001)(31696002)(81166006)(8676002)(316002)(16576012)(8936002)(81156014)(36756003)(52116002)(5660300002)(44832011)(66556008)(4326008)(2616005)(956004)(31686004)(6486002)(6916009)(478600001)(53546011)(2906002)(186003)(16526019)(26005)(66946007)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2463;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GnTKUNYhBb1LwznMJbOPe/wh0TDXt+lBs5VeuZmy/jUcW9VbM7QjaNvdq+G0KXpTbXeUKC0yIUMjy3j+wysbvCU9R8Bb6O5EAgBM8VSxeyxd0VN73NUSD63P4iXe7Y6I2RTYkw4/hkRo1iaLdaS+/+ePsxUjdnjxnjWighd5OMbHbSonK9osGn7KuCnYMgqKWXhzOJLNAjWSl0+oVryyhQdiWM1yNkR+i5gE3de9Fj7ePWIBh1tJHpo+Lac4mquN3KFuTVPhWVotSi9G36Os0CGMKZ6mCr6BI+l/Jt+RTjbE7giyFpvIv3WcxaqQbKgudGP53e6qZyR2Kd4a3kHMuFEIn4wDMDVu6SIwWc1CFmOpRNDJrDZ+PLZf9OmUR9/E8KMrK4dOBDkHTbyPF1jDrlLjI+9QhG+x4PGlrBdOi7rDGbR6uVtUKyeZHNWn5Sj
X-MS-Exchange-AntiSpam-MessageData: iI1NQVGmbc9W+IYE3nDerEsXKgTEYP4dXh4nNEwk/yXHtKI6MlXi0gIZgzRuT/NIsrL60ecPFC7R1XEJcJoCWNXpdz6u701GYUK5V5+/UvG7GrqmQnIvdIpGtYtIE+K1E870P8s+rteqALkRcTKICw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8a2a16-cd2b-434d-6019-08d7b94f4256
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 17:30:36.4355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hUGZBiF8PzpU0jMzZFYwFqmqq3eWT8XULex7TDvGlF2p8DWPg5J2lGKWgKajVQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2463
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.55
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/24/20 11:01 AM, Igor Mammedov wrote:
> On Thu, 13 Feb 2020 12:17:32 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Introduce model specific apicid functions inside X86MachineState.
>> These functions will be loaded from X86CPUDefinition.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  include/hw/i386/x86.h |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>> index 38c2d27910..75c2462770 100644
>> --- a/include/hw/i386/x86.h
>> +++ b/include/hw/i386/x86.h
>> @@ -79,6 +79,15 @@ typedef struct {
>>      uint16_t boot_cpus;
>>      unsigned smp_dies;
>>  
>> +    /* Apic id specific handlers */
>> +    uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
>> +                                    unsigned cpu_index);
>> +    void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
>> +                                 X86CPUTopoIDs *topo_ids);
>> +    apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
>> +                                      const X86CPUTopoIDs *topo_ids);
>> +    uint32_t (*apicid_pkg_offset)(X86CPUTopoInfo *topo_info);
>> +
>>      /*
>>       * Address space used by IOAPIC device. All IOAPIC interrupts
>>       * will be translated to MSI messages in the address space.
>>
>>
> 
> Suggest to move defaults into this patch as well. i.e.
> move parts that replace direct calls with hooks from 12/16
> and set default hooks (i.e. non EPYC ones) in x86's machine_class_init().
> 
> This way It's immediately obvious what you are changing and then
> followup EPYC related patch won't be cluttered by non related defaults
> conversion.
> 

Ok. Sure.

