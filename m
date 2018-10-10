Received: from eggs.gnu.org ([2001:4830:134:3::10]:58841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gAJ1t-0007mH-NI
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gAJ1m-0006cy-0V
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:16:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50196
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gAJ1l-0006bG-Q9
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:16:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9AI4q61144372
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:16:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n1m7gp7qw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:16:08 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 10 Oct 2018 19:16:07 +0100
References: <20181010170309.12045-1-akrowiak@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 10 Oct 2018 20:15:55 +0200
MIME-Version: 1.0
In-Reply-To: <20181010170309.12045-1-akrowiak@linux.ibm.com>
Content-Language: en-US
Message-Id: <ceeafd70-b1d3-9e80-d357-65740dd125cd@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 0/6] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, mimu@linux.ibm.com


On 10/10/2018 07:03 PM, Tony Krowiak wrote:
> This patch series is the QEMU counterpart to the KVM/kernel support for 
> guest dedicated crypto adapters. The KVM/kernel model is built on the 
> VFIO mediated device framework and provides the infrastructure for 
> granting exclusive guest access to crypto devices installed on the linux 
> host. This patch series introduces a new QEMU command line option, QEMU 
> object model and CPU model features to exploit the KVM/kernel model.
> 
> See the detailed specifications for AP virtualization provided by this 
> patch set in docs/vfio-ap.txt for a more complete discussion of the 
> design introduced by this patch series.
> 
> v10 => v11 Change log:



Series seems to work fine.

Christian


> =====================
> * Replaced DO_UPCAST macros in ap.c
> * Initializing GError in vfio_ap_get_group() function (BUG)
> * Updated s390 maintainers with new files in MAINTAINERS
> * Fixed memory leak in vfio_ap_get_group() function
> 
> v9 => v10 Change log:
> ====================
> * Removed KVM_S390_VM_CPU_FEAT_AP feature from kvm.h
> * Moved check for KVM_S390_VM_CRYPTO_ENABLE_APIE from patch 2/6 to patch
>   3/6
> * Removed vfio from all function names in ap-bridge.c 
> * Removed unused macros and structure from ap-bridge.h
> * Removed unused macros from ap-device.h
> 
> v8 => v9 Change log:
> ===================
> * Removed all references to VFIO in AP bridge and bus
> * Expose AP feature only if the KVM_S390_VM_CRYPTO_ENABLE_APIE VM attribute
>   is exposed by KVM - i.e., if AP instructions are available on the linux
>   host.
> * Enable AP interpretation only if AP feature is switched on; no need to
>   disable because it is disabled by default.
> 
> v7 => v8 Change log:
> ===================
> * Enable SIE interpretation AP instructions if the CPU model feature for
>   AP instructions is turned on for the guest.
> 
> v6 => v7 Change log;
> ===================
> * Changed email address for Signed-off-by
> 
> v5 => v6 Change log:
> ===================
> * Added reset handling fo vfio-ap device
> * Added a bridge/bus to AP device object model - thanks to Halil Pasic
> 
> v4 => v5 Change log:
> ===================
> * Added MAINTAINERS entries for VFIO AP
> * Added explanation for why we are only supporting zEC12 and newer CPU 
>   models.
> * Changed CPU model feature qci=on|off to apqci=on|off
> * Misc. minor changes
> 
> v3 => v4 Change log:
> ===================
> * Made vfio-ap device unpluggable for now
