Received: from eggs.gnu.org ([2001:4830:134:3::10]:34213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkrli-0000lp-1z
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkrld-0005op-8N
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:01:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkrld-0005oL-37
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:01:49 -0400
Date: Thu, 24 Aug 2017 15:01:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170824150142.5923c653.cohuck@redhat.com>
In-Reply-To: <1503576029-24264-1-git-send-email-thuth@redhat.com>
References: <1503576029-24264-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>

On Thu, 24 Aug 2017 14:00:29 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The storage attribute devices are only meant to be instantiated one
> time, internally. They can not be used by the user, so mark them with
> user_creatable = false.
> 
> Suggested-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-stattrib-kvm.c | 4 ++++
>  hw/s390x/s390-stattrib.c     | 4 ++++
>  2 files changed, 8 insertions(+)

Thanks, applied.
