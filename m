Received: from eggs.gnu.org ([2001:4830:134:3::10]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkr7b-0001h1-2S
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkr7S-0002pq-TO
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:20:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56701
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dkr7S-0002pS-MQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:20:18 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7OCJJMS032434
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 08:20:18 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2chwm5uv7t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 08:20:18 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 24 Aug 2017 13:20:16 +0100
References: <1503576029-24264-1-git-send-email-thuth@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 14:20:09 +0200
MIME-Version: 1.0
In-Reply-To: <1503576029-24264-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <93d7ba64-7f79-7bea-ce27-e995104ffa80@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] s390x/s390-stattrib: Mark the
 storage attribute as not user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>



On 08/24/2017 02:00 PM, Thomas Huth wrote:
> The storage attribute devices are only meant to be instantiated one
> time, internally. They can not be used by the user, so mark them with
> user_creatable = false.
> 
> Suggested-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
