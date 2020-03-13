Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2633820724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2633820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCjz1-0004y1-CF
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwV-0001Ce-CS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jCjwT-0006zH-Qy
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jCjwT-0006xx-J2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:01:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DCvkMP073890
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yqxhsehhj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:01:32 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Fri, 13 Mar 2020 13:01:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:01:26 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02DD1PID59900132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 13:01:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D9CEA405C;
 Fri, 13 Mar 2020 13:01:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE7B9A4070;
 Fri, 13 Mar 2020 13:01:24 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.9.63])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 13:01:24 +0000 (GMT)
Date: Fri, 13 Mar 2020 14:00:57 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 14/15] docs: Add protvirt docs
In-Reply-To: <20200311132151.172389-15-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-15-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031313-0012-0000-0000-000003907727
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-0013-0000-0000-000021CD4CAB
Message-Id: <20200313140057.0c5d90c4@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130067
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 09:21:50 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Lets add some documentation for the Protected VM functionality.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  docs/system/index.rst    |  1 +
>  docs/system/protvirt.rst | 56
> ++++++++++++++++++++++++++++++++++++++++ 2 files changed, 57
> insertions(+) create mode 100644 docs/system/protvirt.rst
> 
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index 6e5f20fa1333ce23..74afbd7cc3fc0296 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -34,3 +34,4 @@ Contents:
>     deprecated
>     build-platforms
>     license
> +   protvirt
> diff --git a/docs/system/protvirt.rst b/docs/system/protvirt.rst
> new file mode 100644
> index 0000000000000000..6c8cf0f7910eae86
> --- /dev/null
> +++ b/docs/system/protvirt.rst
> @@ -0,0 +1,56 @@
> +Protected Virtualization on s390x
> +=================================
> +
> +The memory and most of the registers of Protected Virtual Machines
> +(PVMs) are encrypted or inaccessible to the hypervisor, effectively
> +prohibiting VM introspection when the VM is running. At rest, PVMs
> are +encrypted and can only be decrypted by the firmware, represented
> by an +entity called Ultravisor, of specific IBM Z machines.
> +
> +
> +Prerequisites
> +-------------
> +
> +To run PVMs a machine with the Protected Virtualization feature
> +which is indicated by the Ultravisor Call facility (stfle bit
> +158) is required. The Ultravisor needs to be initialized at boot by
> +setting `prot_virt=1` on the kernel command line.

I'd add "of the host" just to make it extra clear

> +
> +If those requirements are met, the capability
> `KVM_CAP_S390_PROTECTED` +will indicate that KVM can support PVMs on
> that LPAR. +
> +
> +QEMU Settings
> +-------------
> +
> +To indicate to the VM that it can transition into protected mode, the
> +`Unpack facility` (stfle bit 161 represented by the feature
> +`S390_FEAT_UNPACK`) needs to be part of the cpu model of the VM.
> +
> +All I/O devices need to use the IOMMU.
> +Passthrough (vfio) devices are currently not supported.
> +
> +Host huge page backings are not supported. However guests can use
> huge +pages as indicated by its facilities.
> +
> +
> +Boot Process
> +------------
> +
> +A secure guest image can either be loaded from disk or supplied on
> the +QEMU command line. Booting from disk is done by the unmodified
> +s390-ccw BIOS. I.e., the bootmap is interpreted, multiple components
> +are read into memory and control is transferred to one of the
> +components (zipl stage3). Stag3 does some fixups and then transfers
> +control to some program residing in guest memory, which is normally
> +the OS kernel. The secure image has another component prepended
> +(stage3a) that uses the new diag308 subcodes 8 and 10 to trigger the
> +transition into secure mode.
> +
> +Booting from the image supplied via the QEMU command line requires
> +that the file passed via -kernel has the same memory layout as would
> +result from the disk boot. This memory layout includes the encrypted
> +components (kernel, initrd, cmdline), the stage3a loader and
> +metadata. In case this boot method is used, the command line
> +options -initrd and -cmdline are ineffective. The preparation of a
> PVM +image is done by genprotimg of the s390-tools package.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


