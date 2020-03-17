Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0BBC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B2520714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B2520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJsf-0005la-1V
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <walling@linux.ibm.com>) id 1jEJrd-0004vz-Dg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1jEJrb-00050V-TG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:35:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1jEJrb-0004vh-JK; Tue, 17 Mar 2020 17:35:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02HLXgtA064351; Tue, 17 Mar 2020 17:35:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yrtk8hax6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2020 17:35:01 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02HLXhie064411;
 Tue, 17 Mar 2020 17:35:01 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yrtk8hawr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2020 17:35:01 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02HLTl9i025922;
 Tue, 17 Mar 2020 21:35:00 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03wdc.us.ibm.com with ESMTP id 2yrpw6bg23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2020 21:35:00 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02HLYwJH54985180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2020 21:34:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 877237805E;
 Tue, 17 Mar 2020 21:34:58 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B8797805C;
 Tue, 17 Mar 2020 21:34:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.143])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Mar 2020 21:34:56 +0000 (GMT)
Subject: Re: [PATCH v6 0/2] Use DIAG318 to set Control Program Name & Version
 Codes
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
Message-ID: <30ee6db8-930e-562d-5c85-9ff2f73185e1@linux.ibm.com>
Date: Tue, 17 Mar 2020 17:34:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-17_09:2020-03-17,
 2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170082
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: borntraeger@de.ibm.com, rth@twiddle.net, cohuck@redhat.com,
 frankja@linux.ibm.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please note: a new patch is in the works to extend the SCCB for the SCLP
response for RSCPI. This will help alleviate the issue of losing space 
for CPU
entries. The appropriate patch will be introduced at the beginning of this
series once it is ready for upstream.


Thanks for your patience and understanding,
- Collin

On 1/24/20 5:14 PM, Collin Walling wrote:
> Changes from v5 -> v6
>
>      Migration and DeviceObject Code:
>          - load/save/needed functions now check if kvm_enabled before calling
>              kvm_get/set and has_feat (respectively)
>
>      QEMU->KVM Code:
>          - added kvm_s390_* stubs for get/set functions for TCG compilation
>
>      VCPU Discussion:
>          - calculate the maximum allowed cpu entries by taking the SCCB size,
>              subtracting the offset where the CPU entries begin, then dividing
>              by the size of a CPU Entry struct
>          - if the number of CPU entries exceeds the maximum allowed entries,
>              print a warning and break out of the loop
>          - no longer imposing a reduced CPU max
>
> Last post: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05535.html
>
> The data associated with DIAGNOSE 0x318 helps to identify the underlying
> hypervisor level (pre-determined by an internal set of codes), as well as the
> guest environment (such as Linux, z/VM, etc). These patches, in tandem with
> KVM, allow this instruction to be enabled at the guest level, and also to
> enable migration of this data.
>
> The DIAGNOSE 0x318 instruction is a privileged instruction that is executed by
> the Linux kernel once and only once during setup (IPL). This requires
> interception by KVM to handle the instruction call safely. The instruction sets
> an 8-byte value corresponding to the environment the control program (i.e.
> guest) is running with, as well as what hypervisor it is running on.
>
> An update to the analogous KVM patches associated with this patchset are
> forthcoming and I will provide a link to the post as a reply to this chain.
>
> Guest support for the diag 318 instruction is accomplished by implementing a
> device class, a cpu model feature, and adjusting the Read Info struct. The Read
> Info struct adjustment coincidentally reduces the maximum number of VCPUs we
> can have for a single guest by one.
>
> The instruction is determined by a Read Info byte 134 bit 0. This new byte
> expands into the space of the Read Info SCCB, which also contains CPU entries
> at the tail-end of this block of data. Due to this expansion, we lose space for
> one CPU entry.
>
> A guest can still run safely with the original 248 maximum CPUs, but will lose
> access to the 248th CPU entry, meaning that the hypervisor will be unable to
> retrieve any information regarding that CPU (weather this means the guest
> will actually run with 247 CPUs when 248 are specified is uncertain to me, but
> the guest operates just fine on my end).
>
> A device class is used for this instruction in order to streamline the
> migration and reset of the DIAG 318 related data.
>
> A CPU model feature is added for this instruction, appropriately named diag318,
> and is available starting with the zEC12 full model, though as long as KVM can
> support emulation of this instruction, we can theoretically enable it for _any_
> CPU model. It is recommended to explicitly enable the feature via
> -cpu ...,diag318=on (or via libvirt feature XML).
>
> Collin L. Walling (2):
>    s390/kvm: header sync for diag318
>    s390: diagnose 318 info reset and migration support
>
>   hw/s390x/Makefile.objs              |  1 +
>   hw/s390x/diag318.c                  | 85 +++++++++++++++++++++++++++++++++++++
>   hw/s390x/diag318.h                  | 40 +++++++++++++++++
>   hw/s390x/s390-virtio-ccw.c          | 17 ++++++++
>   hw/s390x/sclp.c                     | 13 ++++++
>   include/hw/s390x/sclp.h             |  2 +
>   linux-headers/asm-s390/kvm.h        |  4 ++
>   target/s390x/cpu_features.h         |  1 +
>   target/s390x/cpu_features_def.inc.h |  3 ++
>   target/s390x/gen-features.c         |  1 +
>   target/s390x/kvm-stub.c             | 10 +++++
>   target/s390x/kvm.c                  | 29 +++++++++++++
>   target/s390x/kvm_s390x.h            |  2 +
>   13 files changed, 208 insertions(+)
>   create mode 100644 hw/s390x/diag318.c
>   create mode 100644 hw/s390x/diag318.h
>

