Received: from eggs.gnu.org ([2001:4830:134:3::10]:54713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dI9tX-0002oT-No
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dI9tS-0001mN-Rd
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:31:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36511
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dI9tS-0001mH-KU
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:31:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v568SoIF017100
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 04:31:13 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2awp6b794w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 04:31:13 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Jun 2017 04:31:12 -0400
References: <20170531193434.6918-1-david@redhat.com>
	<20170531193434.6918-2-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Jun 2017 10:31:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170531193434.6918-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <b04767ab-a3c4-7a02-33d7-3e27837ec17d@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/2] s390x/cpumodel: take care of the
 cpuid format bit for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On 05/31/2017 09:34 PM, David Hildenbrand wrote:
> Let's also properly forward that bit. It should always be set. I
> verified it under z/VM, it seems to be always set there. For now,
> zKVM guests never get that bit set when the CPU model is active.
> 
> The PoP mentiones, that z800 + z900 (HW generation 7) always set this
> bit to 0, so let's take care of that.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

applied, thanks.
