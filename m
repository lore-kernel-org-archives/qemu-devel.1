Received: from eggs.gnu.org ([2001:4830:134:3::10]:44080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fC0HR-0004I9-Ha
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fC0HO-0006CY-Ay
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:07:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36548
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fC0HO-0006Bv-1T
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:07:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3RA4PXv008635
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:07:00 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hm1dms623-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:06:59 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Fri, 27 Apr 2018 04:06:59 -0600
References: <20180427100244.14258-1-zyimin@linux.ibm.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Fri, 27 Apr 2018 18:06:54 +0800
MIME-Version: 1.0
In-Reply-To: <20180427100244.14258-1-zyimin@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <8f9b68d3-552b-e3bf-1c55-1cce56e61627@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/1] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

Wrong operation. Please ignore this series.


=D4=DA 2018/4/27 =CF=C2=CE=E76:02, Yi Min Zhao =D0=B4=B5=C0:
> Currently the code misses FMB functionality. This patch fixup this. Onl=
y common
> FMB is supported now.
>
> bb/zyimin/fmb
>
> Yi Min Zhao (1):
>    s390x/pci: add common fmb
>
>   hw/s390x/s390-pci-bus.c  |  3 ++-
>   hw/s390x/s390-pci-bus.h  | 16 +++++++++++++
>   hw/s390x/s390-pci-inst.c | 60 +++++++++++++++++++++++++++++++++++++++=
++++++++-
>   hw/s390x/s390-pci-inst.h |  1 +
>   4 files changed, 78 insertions(+), 2 deletions(-)
>
