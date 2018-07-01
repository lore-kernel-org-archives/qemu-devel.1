Received: from eggs.gnu.org ([2001:4830:134:3::10]:51002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1fZcFv-0001kP-Qa
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 09:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1fZcFs-0008LY-M6
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 09:19:07 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:58450
	helo=deadmen.hmeau.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <herbert@gondor.apana.org.au>)
	id 1fZcFs-0008Kf-Aw
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 09:19:04 -0400
Date: Sun, 1 Jul 2018 21:18:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20180701131855.5sjnvyvhiq7ktzg3@gondor.apana.org.au>
References: <cover.1529422492.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529422492.git.alifm@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Detect & register virtio-crypto
 algos only if it can be supported by backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com, mst@redhat.com

On Tue, Jun 19, 2018 at 11:41:32AM -0400, Farhan Ali wrote:
> Hi,
> 
> Currently the Linux virtio-crypto driver registers the crypto
> algorithm without verifying if the backend actually supports the
> algorithm.
> 
> This kernel patch series adds support for registering algorithm
> with Linux crypto layer, only if the algorithm is supported by
> the backend device. This also makes the driver more compliant with
> the virtio-crypto spec [1].
> 
> I would appreciate any feedback or comments on this.
> 
> Thank you
> Farhan
> 
> Reference
> ---------
> [1] Virtio crypto spec proposal https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00816.html
> 
> ChangeLog
> ---------
> v2 -> v3
>     - Add Christian Borntrager's acks for the patches.
> 
> v1 -> v2
>    - Modify comment as suggested by Arei (patch 1)
>    - Modify error message as suggested by Arei (patch 2)
> 
> Farhan Ali (2):
>   crypto/virtio-crypto: Read crypto services and algorithm masks
>   crypto/virtio-crypto: Register an algo only if it's supported
> 
>  drivers/crypto/virtio/virtio_crypto_algs.c   | 112 ++++++++++++++++++---------
>  drivers/crypto/virtio/virtio_crypto_common.h |  25 +++++-
>  drivers/crypto/virtio/virtio_crypto_core.c   |  29 +++++++
>  drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 +++++++++++++++++--
>  4 files changed, 202 insertions(+), 45 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
