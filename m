Received: from eggs.gnu.org ([2001:4830:134:3::10]:59237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gACiA-0000IU-Hu
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gACi4-0002Sb-Vw
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:31:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gAChz-0002Pa-Ci
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:31:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ABOMMi129363
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:31:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1eqxvh1k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:31:13 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 10 Oct 2018 12:31:11 +0100
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-3-akrowiak@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 10 Oct 2018 13:31:03 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-3-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <53e4697e-ab58-f186-ba64-88ab88be2f4b@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v10 2/6] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>



On 10/09/2018 07:52 PM, Tony Krowiak wrote:
> A new CPU model feature and two new CPU model facilities are
> introduced to support AP devices for a KVM guest.
> 
> CPU model features:
> 
> 1. The S390_FEAT_AP CPU model feature indicates whether AP
>    instructions are available to the guest. This feature will
>    be enabled only if the AP instructions are available on the
>    linux host as determined by the availability of the
>    KVM_S390_VM_CRYPTO_ENABLE_APIE VM attribute which is exposed
>    by KVM only if the AP instructions are available on the
>    host.
> 
>    This feature must be turned on from userspace to execute AP
>    instructions on the KVM guest. The QEMU command line to turn
>    this feature on looks something like this:
> 
> 	qemu-system-s390x ... -cpu xxx,ap=on ...
> 
>    This feature will be supported for zEC12 and newer CPU models.
>    The feature will not be supported for older models because
>    there are few older systems on which to test and the older
>    crypto cards will be going out of service in the relatively
>    near future.
> 
> CPU model facilities:
> 
> 1. The S390_FEAT_AP_QUERY_CONFIG_INFO feature indicates whether the
>    AP Query Configuration Information (QCI) facility is available
>    to the guest as determined by whether the facility is available
>    on the host. This feature will be exposed by KVM only if the
>    QCI facility is installed on the host.
> 
> 2. The S390_FEAT_AP_FACILITY_TEST feature indicates whether the AP
>    Facility Test (APFT) facility is available to the guest as
>    determined by whether the facility is available on the host.
>    This feature will be exposed by KVM only if APFT is installed
>    on the host.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
