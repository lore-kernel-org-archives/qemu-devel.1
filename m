Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F5CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6313D20751
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a9uJdz6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6313D20751
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCquS-0002Ek-LJ
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 16:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <brijesh.singh@amd.com>) id 1jCqts-0001ok-2S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1jCqtq-0004di-VT
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:27:20 -0400
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com
 ([40.107.94.42]:6197 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1jCqto-0004aK-7i; Fri, 13 Mar 2020 16:27:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBoa8OfALQImWgndRxMy7lRfvWiLYpbZW8AXKxASMzncN11vL7XOEj/v/J7cC2WEDbsDGGT+OooUnlyMfhbXIO6DYMKZdariHGZq4b7Hk4mFKYPIv3yUUof2sxRO2SRIN77rdP1EHde8Zz211Lc0QB/2ZVM/9UwSexm+ulEK/KNXObGb1HVBNfPrI0HlVA/JbKH2u3iyFq9DyiQ3Bd1At2u1Aaz/dhT29hdi37uDzn8+VH9V276cy5QW6acbnumHee589ALG5Blir+RREinKMExg9nlTAF2vehp0XQcOj97mbVFOGEP5LPEmqFzwdOFw3aUzOXm+4VHaMZayTzinyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hXHw2jJHMgQTTe4PJr0PS2bHb9uxxdnbdKQVwDtXDA=;
 b=AUtUwVi76beMJConU484qvdI30SjcuIszlQ5Sh0oitB20TlSR3wXScEQ34xK0XvHo89BHCQkGKN2L7BPGQSVVQ0bSCkgAzOd7gcrZJlhdfH2WITB1C2MUnn3itqhUI0NuD19Z3jYtZtYqJltLIt+/8KwwAoeVKOgRSg0sKlfmfOwh1lY3iX7fAsA64gHoBxRQTqVRlEj46QQFXhSUQrd1f77ZsTS7dZie0g1xU8+bXmVZK8N4fcPV/gwy4Tfu3fFQ1foCvBn6F7EW8PVP8kamKaxBCqDhQhzCk0EIqyImG+BHlvaSMESj3E9oKqLuCh6vLjphh7t9ZlnDd28iMMQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hXHw2jJHMgQTTe4PJr0PS2bHb9uxxdnbdKQVwDtXDA=;
 b=a9uJdz6VRoyBk/FAB/Nd39Bef0XZ80j6dk7hkQiImTFXNC+zjJX5Aa8e5nQpkLxtwZJTCEZRTOqZFB5D/BoN2nMn5CzqKJu/KELBi1GhzlL4jLmF+X6vUrBFkGrO3t8DEkhmsfgKc82mF77tPa3EyrRm9aroJh6zw3u8MrXkFHs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from CY4PR12MB1926.namprd12.prod.outlook.com (2603:10b6:903:11b::11)
 by CY4PR12MB1749.namprd12.prod.outlook.com (2603:10b6:903:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 20:27:11 +0000
Received: from CY4PR12MB1926.namprd12.prod.outlook.com
 ([fe80::e5ec:63d5:a9a8:74c4]) by CY4PR12MB1926.namprd12.prod.outlook.com
 ([fe80::e5ec:63d5:a9a8:74c4%12]) with mapi id 15.20.2793.021; Fri, 13 Mar
 2020 20:27:11 +0000
Subject: Re: [PATCH V2] vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200226094357.25061-1-jasowang@redhat.com>
 <20200226142839.4263de9b.pasic@linux.ibm.com>
 <20200226083654-mutt-send-email-mst@kernel.org>
 <20200226163618.31aa86ed.pasic@linux.ibm.com>
 <20200226115009-mutt-send-email-mst@kernel.org>
 <20200227140215.2d12149c.pasic@linux.ibm.com>
 <20200227104233-mutt-send-email-mst@kernel.org>
 <20200313134446.782c5f7c.pasic@linux.ibm.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a79eec52-ec68-31a8-f692-17da0723e36c@amd.com>
Date: Fri, 13 Mar 2020 15:27:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <20200313134446.782c5f7c.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: DM5PR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:3:151::20) To CY4PR12MB1926.namprd12.prod.outlook.com
 (2603:10b6:903:11b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by
 DM5PR19CA0010.namprd19.prod.outlook.com (2603:10b6:3:151::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Fri, 13 Mar 2020 20:27:09 +0000
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3124ff0c-fe8d-4b16-1816-08d7c78ce887
X-MS-TrafficTypeDiagnostic: CY4PR12MB1749:|CY4PR12MB1749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB17491ABDB6FE285EBE34713FE5FA0@CY4PR12MB1749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(26005)(186003)(16526019)(31696002)(52116002)(44832011)(6486002)(66946007)(66476007)(478600001)(31686004)(6512007)(66556008)(2616005)(956004)(86362001)(6506007)(53546011)(81156014)(81166006)(8936002)(6666004)(8676002)(5660300002)(36756003)(110136005)(4326008)(54906003)(316002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1749;
 H:CY4PR12MB1926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aN0BJADt7GPidJoS0Dh+kDDO7kLYxYzeWIXLq31yEEKXRleyUZYbniYsA/jE+89DeKLBx466INOhkhxzpIrRD1/48Si8ZKqa5GmkEaxqCl2Dnq8XQD0y1wRLjTFeCV6aj08pobcIo6Q4yPOkMW3ke9aO4k49J0qfNfwafB7fx8JT68AP8/GHHZN+wOJlxscjDqoQ0id7NQaJje9sTGqIwam6/WV3zbazyhBnUjjGqrpBvzvGDqaaukrSVI+Lg4qV1k97m90gB+Y1pub7XI3v33ZpqWjwFgHj51Qcy7F8dqH+tCupattK78+oNVOLPo7NqNgxLjrKb2PcMqryxzoFr8NX++7I5eIh/jzuPDA3dedqs1VRwbaCu8A3I9sRQjIIoNVUGoDe/sdfslScl34AZ3nUbbFFn227oOR5AssAxYVgvV5nX5JE7moMBm9DQicQ
X-MS-Exchange-AntiSpam-MessageData: Zn79CuwCZkHRCBzYFp6t0Df9dAnB+DYZcCyGLLp0vnI8nYCzNNeRHdVkrTaqOoL6Rq0kCTodBeKNmYDcbPhP3un0jKh6OXH48jas5pr5wkjsvT/Pd9kTwjU+0SwSof2qPL2L/Gftn/4/+b7g8axrbg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3124ff0c-fe8d-4b16-1816-08d7c78ce887
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 20:27:10.9219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqgOr7o/NRzBpQqtwhcJBOcN9g7MPofKCo9gjvk+6+wJwpTysldx7zfYQ05adTVYm8hPpnV+FruTfq734MS6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1749
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.42
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 brijesh.singh@amd.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 3/13/20 7:44 AM, Halil Pasic wrote:
> [..]
>>> CCing Tom. @Tom does vhost-vsock work for you with SEV and current qemu?
>>>
>>> Also, one can specify iommu_platform=on on a device that ain't a part of
>>> a secure-capable VM, just for the fun of it. And that breaks
>>> vhost-vsock. Or is setting iommu_platform=on only valid if
>>> qemu-system-s390x is protected virtualization capable?
>>>
>>> BTW, I don't have a strong opinion on the fixes tag. We currently do not
>>> recommend setting iommu_platform, and thus I don't think we care too
>>> much about past qemus having problems with it.
>>>
>>> Regards,
>>> Halil
>>
>> Let's just say if we do have a Fixes: tag we want to set it correctly to
>> the commit that needs this fix.
>>
> I finally did some digging regarding the performance degradation. For
> s390x the performance degradation on vhost-net was introduced by commit
> 076a93d797 ("exec: simplify address_space_get_iotlb_entry"). Before
> IOMMUTLBEntry.addr_mask used to be based on plen, which in turn was
> calculated as the rest of the memory regions size (from address), and
> covered most of the guest address space. That is we didn't have a whole
> lot of IOTLB API overhead.
>
> With commit 076a93d797 I see IOMMUTLBEntry.addr_mask == 0xfff which comes
> as ~TARGET_PAGE_MASK from flatview_do_translate(). To have things working
> properly I applied 75e5b70e6, b021d1c044, and d542800d1e on the level of
> 076a93d797 and 076a93d797~1.
>
> Regarding vhost-vsock. It does not work with iommu_platform=on since the
> very beginning (i.e. 8607f5c307 ("virtio: convert to use DMA api")). Not
> sure if that is a good or a bad thing. (If the vhost driver in the kernel
> would actually have to do the IOTLB translation, then failing in case
> where it does not support it seems sane. The problem is that
> ACCESS_PLATFORM is used for more than one thing (needs translation, and
> restricted memory access).)
>
> I don't think I've heard back from AMD whether vsock works with SEV or
> not... I don't have access to HW to test it myself.


I just tried vhost-vsock on AMD SEV machine and it does not work. I am
using FC31 (qemu 4.1.1.1.fc31).


> We (s390) don't require this being backported to the stable qemus,
> because for us iommu_platform=on becomes relevant with protected
> virtualization, and those qemu versions don't support it.
>
> Cheers,
> Halil
>

