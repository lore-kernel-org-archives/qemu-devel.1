Received: from eggs.gnu.org ([209.51.188.92]:40677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmKuN-0006BI-1T
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmKuL-0004wQ-Rf
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:57:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59958
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gmKuL-0004pR-I5
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:57:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0NFoBRP166245
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 10:57:33 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q6twt9ab5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 10:57:32 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 23 Jan 2019 15:57:30 -0000
Date: Wed, 23 Jan 2019 16:57:17 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190121110354.2247-4-cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-4-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190123165717.5e580021@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 3/5] vfio-ccw: add
 capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 21 Jan 2019 12:03:52 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Allow to extend the regions used by vfio-ccw. The first user will be
> handling of halt and clear subchannel.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Looks OK to me, but I did not look to hard. I'm likely to invest more
when v3 comes along.

Regards,
Halil
