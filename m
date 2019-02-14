Received: from eggs.gnu.org ([209.51.188.92]:41128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1guFv9-0003Ya-Gt
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1guFv5-0001bf-MH
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:15:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33598
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1guFv0-0001Vm-Ee
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:15:10 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1EC6UMj118229
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:15:02 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qn7ycs2rf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:15:02 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 14 Feb 2019 12:15:00 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Feb 2019 13:14:53 +0100
Message-Id: <1550146494-21085-1-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3] [RFC] s390x/vfio: VFIO-AP interrupt control
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

This QEMU patch is to be used in conjonction with the following patch
series in LINUX.

vfio: ap: ioctl definitions for AP Queue Interrupt Control

The LINUX patch series handle all the interception in KVM
and we do not need to take care of the interception in QEMU.

The goal of this patch is to define the apqi CPU feature which
will be proposed by KVM when the AP Interrupt Control facility
is to be available in the guest.

This feature must be turned on by QEMU to intercept AP instructions
on the KVM guest.
The QEMU command line to turn this feature on looks something like:

    qemu-system-s390x ... -cpu xxx,apqi=on ...


Pierre Morel (1):
  s390x/cpumodel: Set up CPU model for AQIC interception

 target/s390x/cpu_features.c     | 1 +
 target/s390x/cpu_features_def.h | 1 +
 target/s390x/cpu_models.c       | 1 +
 target/s390x/gen-features.c     | 1 +
 4 files changed, 4 insertions(+)

-- 
2.7.4
