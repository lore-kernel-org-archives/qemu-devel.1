Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA66BC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC72123404
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC72123404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I3O-0000jV-Op
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i3Hpg-00027f-La
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i3Hpf-00062H-7L
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:39:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17144
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1i3Hpc-0005yZ-Gd; Thu, 29 Aug 2019 06:39:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7TAbk0o095475; Thu, 29 Aug 2019 06:38:58 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2upbudu30n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2019 06:38:58 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7TAYTWu004813;
 Thu, 29 Aug 2019 10:38:56 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 2umpctrbt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2019 10:38:56 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7TAcugt55116046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 10:38:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE66C112066;
 Thu, 29 Aug 2019 10:38:55 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F583112062;
 Thu, 29 Aug 2019 10:38:54 +0000 (GMT)
Received: from [9.102.23.98] (unknown [9.102.23.98])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 29 Aug 2019 10:38:53 +0000 (GMT)
To: Greg Kurz <groug@kaod.org>
References: <156576293464.29984.1631520917528142744.stgit@aravinda>
 <20190829122108.36c226c3@bahia.lan>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <35775479-e5fe-fc90-cc19-d6b6f8f3a570@linux.vnet.ibm.com>
Date: Thu, 29 Aug 2019 16:08:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190829122108.36c226c3@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-29_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290117
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [Qemu-ppc] [patch-for-4.2 PATCH v11 0/6]
 target-ppc/spapr: Add FWNMI support in QEMU for PowerKVM guests
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thursday 29 August 2019 03:51 PM, Greg Kurz wrote:
> On Wed, 14 Aug 2019 11:40:50 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 
>> This patch set adds support for FWNMI in PowerKVM guests.
>>
>> System errors such as SLB multihit and memory errors
>> that cannot be corrected by hardware is passed on to
>> the kernel for handling by raising machine check
>> exception (an NMI). Upon such machine check exceptions,
>> if the address in error belongs to guest then KVM
>> invokes guests' 0x200 interrupt vector if the guest
>> is not FWNMI capable. For FWNMI capable guest
>> KVM passes the control to QEMU by exiting the guest.
>>
>> This patch series adds functionality to QEMU to pass
>> on such machine check exceptions to the FWNMI capable
>> guest kernel by building an error log and invoking
>> the guest registered machine check handling routine.
>>
>> The KVM changes are now part of the upstream kernel
>> (commit e20bbd3d). This series contain QEMU changes.
>>
>> Change Log v11:
>>   - Moved FWNMI SPAPR cap defaults to 4.2 class option
>>   - Fixed issues with handling fwnmi KVM capability
>>
> 
> Hi Aravinda,
> 
> I'm afraid this series needs rebasing. It doesn't apply
> cleanly on current ppc-for-4.2 (SHA1 b1e8156743).

This was based on the latest 4.2 at the time of posting (14th Aug).
Meanwhile may be due to changes to 4.2 it is not applying cleanly. I
will rebase it to the latest 4.2 and post it again.

Regards,
Aravinda

> 
> Cheers,
> 
> --
> Greg
> 
>> Change Log v10:
>>   - Reshuffled the patch sequence + minor fixes
>>
>> Change Log v9:
>>   - Fixed kvm cap and spapr cap issues
>>
>> Change Log v8:
>>   - Added functionality to check FWNMI capability during
>>     VM migration
>> ---
>>
>> Aravinda Prasad (6):
>>       Wrapper function to wait on condition for the main loop mutex
>>       ppc: spapr: Introduce FWNMI capability
>>       target/ppc: Handle NMI guest exit
>>       target/ppc: Build rtas error log upon an MCE
>>       ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS calls
>>       migration: Include migration support for machine check handling
>>
>>
>>  cpus.c                   |    5 +
>>  hw/ppc/spapr.c           |   78 +++++++++++++
>>  hw/ppc/spapr_caps.c      |   29 +++++
>>  hw/ppc/spapr_events.c    |  268 ++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/ppc/spapr_rtas.c      |   78 +++++++++++++
>>  include/hw/ppc/spapr.h   |   25 ++++
>>  include/qemu/main-loop.h |    8 +
>>  target/ppc/cpu.h         |    1 
>>  target/ppc/kvm.c         |   38 +++++++
>>  target/ppc/kvm_ppc.h     |   13 ++
>>  target/ppc/trace-events  |    1 
>>  11 files changed, 542 insertions(+), 2 deletions(-)
>>
>> --
>> Signature
> 
> 

-- 
Regards,
Aravinda

