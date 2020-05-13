Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CFAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 22:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0EE2065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 22:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0EE2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ08T-00012S-Qa
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 18:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jZ07d-0000Sz-1Z; Wed, 13 May 2020 18:45:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jZ07b-00031r-Uk; Wed, 13 May 2020 18:45:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04DMXs5M116617; Wed, 13 May 2020 18:45:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31016sw1yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 18:45:00 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04DMgDF9136005;
 Wed, 13 May 2020 18:45:00 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31016sw1y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 18:45:00 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04DMZ00n032574;
 Wed, 13 May 2020 22:44:59 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02wdc.us.ibm.com with ESMTP id 3100ubj5a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 22:44:59 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04DMivwU13566368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 22:44:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D24E178063;
 Wed, 13 May 2020 22:44:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E25DF78066;
 Wed, 13 May 2020 22:44:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.196.213])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 13 May 2020 22:44:56 +0000 (GMT)
Subject: Re: [PATCH v1 7/8] s390/kvm: header sync for diag318
To: Cornelia Huck <cohuck@redhat.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200508230823.22956-8-walling@linux.ibm.com>
 <20200513090508.79b7fc54.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <65c903c6-b076-94e0-badc-472e25e248a9@linux.ibm.com>
Date: Wed, 13 May 2020 18:44:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513090508.79b7fc54.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-13_09:2020-05-13,
 2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 impostorscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130193
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 18:45:01
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 3:05 AM, Cornelia Huck wrote:
> On Fri,  8 May 2020 19:08:22 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  linux-headers/asm-s390/kvm.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
>> index 0138ccb0d8..b661feafdc 100644
>> --- a/linux-headers/asm-s390/kvm.h
>> +++ b/linux-headers/asm-s390/kvm.h
>> @@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
>>  #define KVM_S390_VM_CRYPTO		2
>>  #define KVM_S390_VM_CPU_MODEL		3
>>  #define KVM_S390_VM_MIGRATION		4
>> +#define KVM_S390_VM_MISC		5
>>  
>>  /* kvm attributes for mem_ctrl */
>>  #define KVM_S390_VM_MEM_ENABLE_CMMA	0
>> @@ -171,6 +172,10 @@ struct kvm_s390_vm_cpu_subfunc {
>>  #define KVM_S390_VM_MIGRATION_START	1
>>  #define KVM_S390_VM_MIGRATION_STATUS	2
>>  
>> +/* kvm attributes for KVM_S390_VM_MISC */
>> +#define KVM_S390_VM_MISC_ENABLE_DIAG318		0
>> +#define KVM_S390_VM_MISC_DIAG318			1
>> +
>>  /* for KVM_GET_REGS and KVM_SET_REGS */
>>  struct kvm_regs {
>>  	/* general purpose regs for s390 */
> 
> Hm... remind me what the state of the kernel part is?
> 

Kernel code to execute the instruction is in place today. A kernel
running on real hardware (or at least LPAR) can successfully execute the
instruction if the hardware supports it.

The Linux commit is: 4ad78b8651aacf26b3ab6d1e784952eb70469c43

The KVM code is still under review, since most of it needs to align with
the QEMU changes as well. Guest kernels executing the instruction rely
on both QEMU and KVM support. KVM handles the execution and interception
of the instruction, while QEMU handles enabling the instruction (by
negotiating with KVM to allow it and then setting the appropriate SCLP
bit) and migration of the data.

The latest changes to the KVM code is a new IOCTL that allows QEMU to
negotiate with KVM to actually enable the diag318 feature. By default,
KVM treats the feature as "disabled" unless userspace explicitly asks
for it.

The KVM discussion is: https://www.spinics.net/lists/kvm/msg215758.html

-- 
--
Regards,
Collin

Stay safe and stay healthy

