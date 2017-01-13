Received: from eggs.gnu.org ([2001:4830:134:3::10]:33920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRyjy-0007Z4-Q1
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRyju-0004TN-HJ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:05:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37726
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cRyju-0004SO-At
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:05:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0DA5Xa1043015
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:05:40 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27xqwf1sva-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:05:35 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 13 Jan 2017 10:04:06 -0000
Date: Fri, 13 Jan 2017 11:04:01 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1484256243-1982-1-git-send-email-mst@redhat.com>
References: <1484256243-1982-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170113110401.7f2ec899.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-ccw: fix ring sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Thu, 12 Jan 2017 23:26:22 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Current code seems to assume ring size is
> always decreased but this is not required by spec:
> what spec says is just that size can not exceed
> the maximum. Fix it up.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/virtio/virtio.h | 1 +
>  hw/s390x/virtio-ccw.c      | 2 +-
>  hw/virtio/virtio.c         | 5 +++++
>  3 files changed, 7 insertions(+), 1 deletion(-)

Yes, makes sense. Queued to s390-next.
