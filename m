Received: from eggs.gnu.org ([2001:4830:134:3::10]:42576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dDYOo-000475-Tf
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dDYOm-00005m-Au
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:40:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dDYOm-00005E-1P
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:40:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4OFdvLo095141
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 11:40:28 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2an7nxatfe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 11:40:28 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 24 May 2017 16:40:24 +0100
Date: Wed, 24 May 2017 17:40:17 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170524121048.10067-1-lvivier@redhat.com>
References: <20170524121048.10067-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170524174017.7f5218c3.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] migration: remove register_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Dmitry Fleytman <dmitry@daynix.com>, qemu-ppc@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, sam.bobroff@au1.ibm.com, Peter Xu <peterx@redhat.com>

On Wed, 24 May 2017 14:10:48 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> We can replace the four remaining calls of register_savevm() by
> calls to register_savevm_live(). So we can remove the function and
> as we don't allocate anymore the ops pointer with g_new0()
> we don't have to free it then.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/net/vmxnet3.c            |  8 ++++++--
>  hw/s390x/s390-skeys.c       |  9 +++++++--
>  hw/s390x/s390-virtio-ccw.c  |  8 ++++++--
>  include/migration/vmstate.h |  8 --------
>  migration/savevm.c          | 16 ----------------
>  slirp/slirp.c               |  8 ++++++--
>  6 files changed, 25 insertions(+), 32 deletions(-)

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
