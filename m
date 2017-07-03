Received: from eggs.gnu.org ([2001:4830:134:3::10]:51216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@kernel.org>) id 1dS9Eo-0006ao-7R
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@kernel.org>) id 1dS9El-00046E-21
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@kernel.org>) id 1dS9Ek-00044t-SK
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:50:30 -0400
Date: Mon, 3 Jul 2017 23:50:25 +0200
From: Cornelia Huck <cohuck@kernel.org>
Message-ID: <20170703235025.178b085a@cornelias-tuxedo>
In-Reply-To: <20170703213414.94298-1-pasic@linux.vnet.ibm.com>
References: <20170703213414.94298-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390x: vmstatify config migration
 for virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

Am Mon,  3 Jul 2017 23:34:14 +0200
schrieb Halil Pasic <pasic@linux.vnet.ibm.com>:

> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
> flexibility (extending using subsections) and for fun.
> 
> To achieve this we need to hack the config_vector, which is
> VirtIODevice (that is common virtio) state, in the middle of the
> VirtioCcwDevice state representation.  This is somewhat ugly, but we
> have no choice because the stream format needs to be preserved.
> 
> Almost no changes in behavior. Exception is everything that comes with
> vmstate like extra bookkeeping about what's in the stream, and maybe
> some extra checks and better error reporting.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> 
> I was pondering whether to drop or to keep the r-b's I've got for v2.
> I've decided to keep the r-b's because the change corresponding to v3
> are IMHO non-substantive and  because the patch isn't exactly small
> (can't be re-reviewed in a couple of seconds).
> 
> All r-b people are on cc and encouraged to scream at me if they don't
> agree to keep their r-b.

No screams from me, I don't think the changes are substantive enough to
drop my r-b.

(I haven't looked at the new patch in detail.)
