Received: from eggs.gnu.org ([2001:4830:134:3::10]:48964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cnN1O-0002qz-JT
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cnN1J-0007v2-LI
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:16:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35160
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cnN1J-0007u2-DT
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:16:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2DADiU5063135
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 06:16:04 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 294ea2jne5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 06:16:04 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 13 Mar 2017 10:16:02 -0000
Date: Mon, 13 Mar 2017 11:15:57 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1489386583-11564-3-git-send-email-jasowang@redhat.com>
References: <1489386583-11564-1-git-send-email-jasowang@redhat.com>
	<1489386583-11564-3-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170313111557.6dcf0554.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH V2 3/3] virtio: validate address space
 cache during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 13 Mar 2017 14:29:43 +0800
Jason Wang <jasowang@redhat.com> wrote:

> We don't check the return value of address_space_cache_init(), this
> may lead buggy driver use incorrect region caches. Instead of
> triggering an assert, catch and warn this early in
> virtio_init_region_cache().
> 
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/virtio/virtio.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
