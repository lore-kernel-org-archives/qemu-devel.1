Received: from eggs.gnu.org ([209.51.188.92]:55513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ghHIv-0004yG-H3
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ghHIu-0001vD-LI
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:06:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1ghHIu-0001rY-8Y
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:06:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09H4OaY078297
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 12:06:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pwn18g37k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 12:05:59 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 9 Jan 2019 17:05:57 -0000
Date: Wed, 9 Jan 2019 18:05:51 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
References: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190109180551.5976c1f4@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/vfio-ap: Implement hot
 plug/unplug of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peter.maydell@linaro.org, pasic@linux.vnet.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, david@redhat.com, alifm@linux.ibm.com, alex.williamson@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, fiuczy@linux.ibm.com, rth@twiddle.net

On Tue,  8 Jan 2019 11:01:50 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Introduces hot plug/unplug support for the vfio-ap device. Note that only one
> vfio-ap device can be attached to the ap-bus, so a vfio-ap device can only be
> hot plugged if the '-device vfio-ap,sysfsdev=$path_to_mdev' option is not
> specified on the QEMU command line.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
