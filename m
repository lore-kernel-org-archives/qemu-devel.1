Received: from eggs.gnu.org ([209.51.188.92]:39442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmKos-0003T1-76
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmKor-0001vr-Fe
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:52:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gmKor-0001ut-5a
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:52:01 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0NFoHRx009177
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 10:51:58 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q6u80g4gy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 10:51:57 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 23 Jan 2019 15:51:55 -0000
Date: Wed, 23 Jan 2019 16:51:48 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190121110354.2247-6-cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-6-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190123165148.55aba88b@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] vfio-ccw: add handling for async
 channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Mon, 21 Jan 2019 12:03:54 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Add a region to the vfio-ccw device that can be used to submit
> asynchronous I/O instructions. ssch continues to be handled by the
> existing I/O region; the new region handles hsch and csch.
> 
> Interrupt status continues to be reported through the same channels
> as for ssch.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

I had a look, and I don't have any new concerns.(New like not raised
before.)

Regards,
Halil
