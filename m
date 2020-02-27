Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB8CC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5EE2469C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EruzZKDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5EE2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Ptx-0004Ff-9h
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 15:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Thomas.Lendacky@amd.com>) id 1j7PtK-0003nG-Nn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Thomas.Lendacky@amd.com>) id 1j7PtJ-0006VC-EF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:36:18 -0500
Received: from mail-eopbgr770051.outbound.protection.outlook.com
 ([40.107.77.51]:45124 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1j7PtF-0006UH-5h; Thu, 27 Feb 2020 15:36:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw2RqOB0q5UsX6x2XJTbLzuVwrT0bZiaJwqRQ2w0escJgfgdBrCHYZMHSfYeCRixICghRRVSNg5GD3PR7MKf3bEoTp8ShngDhzVn9P7C9rmElQ4oWL0mxINIenjsviYkEic9cvMFASmfEynGTq+lXzmMd2Md0KQJyKSUUslCgdIoxsiXIBX4aecNTphseTlygsnOoJRhzF/DpMIq4E1gjqK+AzURGSPd8smOcBdsJXX8grC0G68gOIUVJwXUVa14pqCqlITeKOKyHNhpXiStjC17iIcEIj3X8OpDzqFzuVNioPPG8TNsCFVrM/MPsmaPNrAD4eLDg4GPzX8uWpTNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gadi/VmnMLyNbIwWDmby+nNGloEWow4PX166EzD00CU=;
 b=oB65EX977ZktWAQ50eREpRQhFL0c2vKcF3lBJ8BeYHm323sDv/yAsFes6+dt8XoX1omIl4SbdE4+QgVyP7T/sq3SAdw5pq9WcmCh0s+R8N4juYSTDed0q+TwDtusWrKzgVysMZGmDcC/nqMEIS9qoc5JYPj/Eo91kDCDdSEOU6IU8ZXH/CKMlsGJxT5NMJqchtQbxT7Rw2+I8USfzeA8dnbFqjyOKeTNIWkTrcGW6GT60jfF244vPX4iGMDcu9K80y/7HCsMoQGI3NehW61PVaO3p7RIJ0gRFroVVvz/TmUhSlTPMLP8goX85wvN/4P75FxRwqGikjLagpiw2nUQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gadi/VmnMLyNbIwWDmby+nNGloEWow4PX166EzD00CU=;
 b=EruzZKDCNNW1M+cJiRn+rYFxWzw3TqnfbhnIkvg3vPu3JcWZZEzaEvcY71C8x3JwOqOCmV77I74WA9aPWBR1FVFz78yPXQISeNbTQzw+1vpQn3gbgloYzEZm+wXPC//hi4gFCf9y5tjnJnpo314SYTQvFdgxeiLgA2zyeTRByz0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 20:36:10 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 20:36:10 +0000
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1cbd9ac3-1b84-4c0b-a8fc-024ee9f409d2@amd.com>
Date: Thu, 27 Feb 2020 14:36:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200227140215.2d12149c.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:3:ae::15) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.74] (165.204.77.1) by
 DM5PR15CA0053.namprd15.prod.outlook.com (2603:10b6:3:ae::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 20:36:10 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dcd3fdc4-eff0-427d-c3ea-08d7bbc4ae2c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:|DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34665E2517D01CC677F308D4ECEB0@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(189003)(8936002)(8676002)(36756003)(53546011)(26005)(16526019)(186003)(2906002)(478600001)(81156014)(5660300002)(6486002)(81166006)(4326008)(52116002)(66476007)(54906003)(110136005)(16576012)(2616005)(66946007)(66556008)(31686004)(316002)(86362001)(31696002)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3466;
 H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7dMvwqqpvq5v9ZRbfo1dEtGq0fDi0n5V7GBvOQRb6svtjwUuz35MSNYTLALxJG3QgCYXVj/t+sONdPmXDJNNwa8NLLFoG3MkKEFcmJNJeN+YN2DePhpPggJr2h9OZkI375UG0fz8oa3ienpvisu+xfuUBLzP7kdWLcRpoGw2MO4rJZrQzc3VYPhHclAkmavoCEge0ej+5W4EDw1WHgukz7q+PBaP3p0DNQsv/TABzBwxvfS8SuPcJvFP0iO311mK1yjZSVL5UpmXoS/+EwSSGOmIwcLrWvWoXW8gMQkFdDDjQeLSqBdbD66wyXvo0OxDKyGMAS2S6imKtc74Q8XENKmIg3qAwY4MqXb34olOWK1AgJNwwPgtZpLX23Vvib2p5wB3wuDqX8MotgOcpjq+epBTyrJro1DVy+9y6rWoZsSixbsKtCyi5aDhhX/aceg
X-MS-Exchange-AntiSpam-MessageData: RZZgX9LHZ6MyzDd3A/eOtL5iS0OTPBVfJdwX8Dhnv/2w/ubUrNn4RhyfaCw65Q9uDNNZ8kwnoPI/XmdTH4/oartil/gx/3KHYzyH49nbgTsHSrNAB6kckMI3tahZLhPyEjjl/LBg5vCeZHFm/JGL4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd3fdc4-eff0-427d-c3ea-08d7bbc4ae2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 20:36:10.7817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC9FRneClHTjMGeQg3k//vvmH6EzIFbXl7RhmFHPTCmdsu00UoJrzS50kzRBsoFFRq2qFWkB30UdqoXBUDZimA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.51
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
Cc: Jason Wang <jasowang@redhat.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 7:02 AM, Halil Pasic wrote:
> On Wed, 26 Feb 2020 11:52:26 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Wed, Feb 26, 2020 at 04:36:18PM +0100, Halil Pasic wrote:
>>> On Wed, 26 Feb 2020 08:37:13 -0500
>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>
>>>> On Wed, Feb 26, 2020 at 02:28:39PM +0100, Halil Pasic wrote:
>>>>> On Wed, 26 Feb 2020 17:43:57 +0800
>>>>> Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>>> We turn on device IOTLB via VIRTIO_F_IOMMU_PLATFORM unconditionally on
>>>>>> platform without IOMMU support. This can lead unnecessary IOTLB
>>>>>> transactions which will damage the performance.
>>>>>>
>>>>>> Fixing this by check whether the device is backed by IOMMU and disable
>>>>>> device IOTLB.
>>>>>>
>>>>>> Reported-by: Halil Pasic <pasic@linux.ibm.com>
>>>>>> Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
>>>>>> Cc: qemu-stable@nongnu.org
>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>
>>>>> Tested-by: Halil Pasic <pasic@linux.ibm.com>
>>>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>>>>
>>>>> Thank you very much for fixing this! BTW as I mentioned before it
>>>>> fixes vhost-vsock with iommu_platform=on as well.
>>>>
>>>> Fixes as in improves performance?
>>>
>>> No, fixes like one does not get something like:
>>> qemu-system-s390x: vhost_set_features failed: Operation not supported (95)
>>> qemu-system-s390x: Error starting vhost: 95
>>> any more.
>>>
>>> Regards,
>>> Halil
>>>
>>> [..]
>>
>> But can commit c471ad0e9bd46 actually boot a secure guest
>> where iommu_platform=on is required?
>>
> 
> No, of course it can not. But I'm not sure about AMD SEV. AFAIU without
> Jason's patch it does not work for AMD SEV. Tom already stated that with
> SEV they don't need the IOVA translation aspect of ACCESS_PLATFORM, but
> I have no idea if the condition vdev->dma_as == &address_space_memory
> catches them as well or not. They probably have !=.
> 
> CCing Tom. @Tom does vhost-vsock work for you with SEV and current qemu?

Adding Brijesh for this, too.

> 
> Also, one can specify iommu_platform=on on a device that ain't a part of
> a secure-capable VM, just for the fun of it. And that breaks
> vhost-vsock. Or is setting iommu_platform=on only valid if
> qemu-system-s390x is protected virtualization capable?
> 
> BTW, I don't have a strong opinion on the fixes tag. We currently do not
> recommend setting iommu_platform, and thus I don't think we care too
> much about past qemus having problems with it.
> 
> Regards,
> Halil
> 

