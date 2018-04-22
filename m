Received: from eggs.gnu.org ([2001:4830:134:3::10]:48618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAHgE-0005tR-K7
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAHgB-0008I0-GA
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:17:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58368
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fAHgB-0008Hq-AR
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:17:31 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3MGDt2o136972
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:17:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hgk1xrbg8-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:17:30 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Sun, 22 Apr 2018 12:17:29 -0400
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180419135150.7bbc667d.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Sun, 22 Apr 2018 12:17:22 -0400
MIME-Version: 1.0
In-Reply-To: <20180419135150.7bbc667d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <994fce24-053f-b4cc-8423-069f1ee39481@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/5] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 04/19/2018 07:51 AM, Cornelia Huck wrote:
> On Sun, 15 Apr 2018 15:07:19 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>>   default-configs/s390x-softmmu.mak |    1 +
>>   docs/vfio-ap.txt                  |  649 +++++++++++++++++++++++++++++++++++++
>>   hw/s390x/Makefile.objs            |    1 +
>>   hw/s390x/ap-device.c              |   39 +++
>>   hw/vfio/Makefile.objs             |    1 +
>>   hw/vfio/ap.c                      |  191 +++++++++++
>>   include/hw/s390x/ap-device.h      |   38 +++
>>   include/hw/vfio/vfio-common.h     |    1 +
>>   linux-headers/asm-s390/kvm.h      |    2 +
>>   linux-headers/linux/vfio.h        |    2 +
>>   target/s390x/cpu_features.c       |    3 +
>>   target/s390x/cpu_features_def.h   |    3 +
>>   target/s390x/cpu_models.c         |    2 +
>>   target/s390x/gen-features.c       |    3 +
>>   target/s390x/kvm.c                |    1 +
>>   ui/keycodemapdb                   |    2 +-
>>   16 files changed, 938 insertions(+), 1 deletions(-)
>>   create mode 100644 docs/vfio-ap.txt
>>   create mode 100644 hw/s390x/ap-device.c
>>   create mode 100644 hw/vfio/ap.c
>>   create mode 100644 include/hw/s390x/ap-device.h
> Can we please get a MAINTAINERS entry for ap? While I'm obviously happy
> to take things through the s390x tree, ap is not something I can easily
> review (or even test), so I'd like to see an entry with dedicated (IBM)
> maintainers.

Will do .... who would you like to see in this list?

>
> Also, hw/vfio/ap.c and docs/vfio-ap.c should be added to the generic
> s390 section.

Okay.

>
