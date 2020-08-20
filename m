Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BFEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 06:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECD52078D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 06:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECD52078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8eOl-0005DL-5y
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 02:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8eOF-0004nc-DI; Thu, 20 Aug 2020 02:49:35 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:34363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8eOD-0000vu-RY; Thu, 20 Aug 2020 02:49:35 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.192])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id E456258DA53A;
 Thu, 20 Aug 2020 08:49:30 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 08:49:30 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00174816515-0578-489e-a663-f2570cede469,
 02C359FD435C2C4122574921AFFD4D91C9CEEBEA) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 2/8] linux-headers: Update for KVM_DEV_XIVE_GRP_SOURCE_INFO
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200819130843.2230799-1-clg@kaod.org>
 <20200819130843.2230799-3-clg@kaod.org>
 <20200820005851.GE271315@yekko.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <68768ef7-a0b3-64e1-9ec2-d9313546c53a@kaod.org>
Date: Thu, 20 Aug 2020 08:49:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820005851.GE271315@yekko.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: e3ee062c-5735-47ba-9a76-0559dd6338f2
X-Ovh-Tracer-Id: 2087981378396130211
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtledgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeelgfejveehieefffduueehvdevfedtleeiudekjeegveeigfeifefhtdfffedtnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 02:41:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 2:58 AM, David Gibson wrote:
> On Wed, Aug 19, 2020 at 03:08:37PM +0200, Cédric Le Goater wrote:
>> To be sent with the linux-headers update when support is merged.
> 
> Ah, so this isn't ready to go just yet.

No indeed. We should get the QEMU part correct first, and handle 
safely the source characteristics of the host.

C.  

 
> 
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  linux-headers/asm-powerpc/kvm.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
>> index 264e266a85bf..aeb8e8c4633b 100644
>> --- a/linux-headers/asm-powerpc/kvm.h
>> +++ b/linux-headers/asm-powerpc/kvm.h
>> @@ -690,6 +690,7 @@ struct kvm_ppc_cpu_char {
>>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
>>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
>>  #define KVM_DEV_XIVE_GRP_SOURCE_SYNC	5       /* 64-bit source identifier */
>> +#define KVM_DEV_XIVE_GRP_SOURCE_INFO	6       /* 64-bit source identifier */
>>  
>>  /* Layout of 64-bit XIVE source attribute values */
>>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
>> @@ -721,6 +722,13 @@ struct kvm_ppc_xive_eq {
>>  	__u8  pad[40];
>>  };
>>  
>> +#define KVM_XIVE_SOURCE_FLAG_STORE_EOI	0x00000001
>> +
>> +/* Layout of source characteristics (8 bytes) */
>> +struct kvm_ppc_xive_src {
>> +	__u64 flags;
>> +};
>> +
>>  #define KVM_XIVE_EQ_ALWAYS_NOTIFY	0x00000001
>>  
>>  #define KVM_XIVE_TIMA_PAGE_OFFSET	0
> 


