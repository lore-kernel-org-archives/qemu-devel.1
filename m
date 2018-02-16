Received: from eggs.gnu.org ([2001:4830:134:3::10]:42252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emf57-0006R8-15
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emf56-0005ct-4j
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:25:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1emf55-0005cc-SU
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:25:36 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GCOYJq123610
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:25:34 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g5x6ethkn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:25:31 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 12:25:28 -0000
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518735273-16089-6-git-send-email-walling@linux.vnet.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 13:25:24 +0100
MIME-Version: 1.0
In-Reply-To: <1518735273-16089-6-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <8dc0f46d-6306-e5c5-45f8-80767cbf698b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 05/12] s390-ccw: move auxiliary IPL data
 to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com

On 15.02.2018 23:54, Collin L. Walling wrote:
> The s390-ccw firmware needs some information in support of the
> boot process which is not available on the native machine.
> Examples are the netboot firmware load address and now the
> boot menu parameters.
> 
> While storing that data in unused fields of the IPL parameter block
> works, that approach could create problems if the parameter block
> definition should change in the future. Because then a guest could
> overwrite these fields using the set IPLB diagnose.
> 
> In fact the data in question is of more global nature and not really
> tied to an IPL device, so separating it is rather logical.
> 
> This commit introduces a new structure to hold firmware relevant
> IPL parameters set by QEMU. The data is stored at location 204 (dec)
> and can contain up to 7 32-bit words. This area is available to
> programming in the z/Architecture Principles of Operation and
> can thus safely be used by the firmware until the IPL has completed.
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
you might want to add your s-o-b here ...
[...]
-- 
Regards,
 Viktor Mihajlovski
