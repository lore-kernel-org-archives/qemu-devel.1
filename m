Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EAAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F149C20714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F149C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfiR-0005d6-8D
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 14:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1jyfhk-0005BH-Ks; Thu, 23 Jul 2020 14:12:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1jyfhi-0007Vu-FL; Thu, 23 Jul 2020 14:12:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06NI1cCt015428; Thu, 23 Jul 2020 14:12:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32fe3djk7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 14:12:24 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NI1sZX016273;
 Thu, 23 Jul 2020 14:12:23 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32fe3djk6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 14:12:23 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NI18jZ029931;
 Thu, 23 Jul 2020 18:12:22 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03wdc.us.ibm.com with ESMTP id 32brq9pcyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 18:12:22 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06NICHvd18809434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 18:12:17 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BCCF78064;
 Thu, 23 Jul 2020 18:12:19 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E1E27805C;
 Thu, 23 Jul 2020 18:12:18 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.108.134])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jul 2020 18:12:18 +0000 (GMT)
Subject: Re: [RFC PATCH] s390x/pci: vfio-pci breakage with disabled mem
 enforcement
To: Alex Williamson <alex.williamson@redhat.com>
References: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
 <20200723102916.7cf15b43@w520.home>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <237cfdd5-d861-3527-7786-2a9398398392@linux.ibm.com>
Date: Thu, 23 Jul 2020 14:12:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200723102916.7cf15b43@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-23_09:2020-07-23,
 2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230129
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 14:12:24
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 12:29 PM, Alex Williamson wrote:
> On Thu, 23 Jul 2020 11:13:55 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> I noticed that after kernel commit abafbc55 'vfio-pci: Invalidate mmaps
>> and block MMIO access on disabled memory' vfio-pci via qemu on s390x
>> fails spectacularly, with errors in qemu like:
>>
>> qemu-system-s390x: vfio_region_read(0001:00:00.0:region0+0x0, 4) failed: Input/output error
>>
>>  From read to bar 0 originating out of hw/s390x/s390-pci-inst.c:zpci_read_bar().
>>
>> So, I'm trying to figure out how to get vfio-pci happy again on s390x.  From
>> a bit of tracing, we seem to be triggering the new trap in
>> __vfio_pci_memory_enabled().  Sure enough, if I just force this function to
>> return 'true' as a test case, things work again.
>> The included patch attempts to enforce the setting, which restores everything
>> to working order but also triggers vfio_bar_restore() in the process....  So
>> this isn't the right answer, more of a proof-of-concept.
>>
>> @Alex: Any guidance on what needs to happen to make qemu-s390x happy with this
>> recent kernel change?
> 
> Bummer!  I won't claim to understand s390 PCI, but if we have a VF
> exposed to the "host" (ie. the first level where vfio-pci is being
> used), but we can't tell that it's a VF, how do we know whether the
> memory bit in the command register is unimplemented because it's a VF
> or unimplemented because the device doesn't support MMIO?  How are the
> device ID, vendor ID, and BAR registers virtualized to the host?  Could

On s390 this info is all advertised/accessed via special instructions 
(my PoC qemu patch was intercepting one of these sorts of instructions 
from the guest and modifying it).

> the memory enable bit also be emulated by that virtualization, much
> like vfio-pci does for userspace?  If the other registers are
> virtualized, but these command register bits are left unimplemented, do
> we need code to deduce that we have a VF based on the existence of MMIO
> BARs, but lack of memory enable bit?  Thanks,

Yeah, I'm thinking we might need something to this effect for s390 at 
least.  But I'm curious if Niklas/Pierre have any add'l thoughts about 
that since they touched the virtfn stuff recently for s390 PCI.

> 
> Alex
> 
>> @Nilkas/@Pierre: I wonder if this might be related to host device is_virtfn?
>> I note that my host device lspci output looks like:
>>
>> 0000:00:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx Virtual Function]
>>
>> But the device is not marked as is_virtfn..  Otherwise, Alex's fix
>> from htps://lkml.org/lkml/2020/6/25/628 should cover the case.
>>
>>
>>
>> Matthew Rosato (1):
>>    s390x/pci: Enforce PCI_COMMAND_MEMORY for vfio-pci
>>
>>   hw/s390x/s390-pci-inst.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
> 


