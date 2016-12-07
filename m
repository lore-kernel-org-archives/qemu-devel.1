Received: from eggs.gnu.org ([2001:4830:134:3::10]:47849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEYC0-0005pr-1n
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEYBw-0002P5-Bf
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:07:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cEYBw-0002P1-5X
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:07:08 -0500
Date: Wed, 7 Dec 2016 09:07:02 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161207090702.GA21167@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481074285-178976-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481074285-178976-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] cryptodev: remove single-DES
 support in cryptodev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: arei.gonglei@huawei.com, eblake@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, qemu-devel@nongnu.org

On Wed, Dec 07, 2016 at 09:31:25AM +0800, Longpeng(Mike) wrote:
> Single-DES is obsolete and it's broken/useless for decades, we should
> remove it in cryptodev, as suggested by Daniel.
> Guest who wants to use this obsolete cipher alg will use its built-in
> implementation instead.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  backends/cryptodev-builtin.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
> index a4224f4..5fb2836 100644
> --- a/backends/cryptodev-builtin.c
> +++ b/backends/cryptodev-builtin.c
> @@ -205,10 +205,6 @@ static int cryptodev_builtin_create_cipher_session(
>              return -1;
>          }
>          break;
> -    case VIRTIO_CRYPTO_CIPHER_DES_ECB:
> -        mode = QCRYPTO_CIPHER_MODE_ECB;
> -        algo = QCRYPTO_CIPHER_ALG_DES_RFB;
> -        break;
>      default:
>          error_setg(errp, "Unsupported cipher alg :%u",
>                     sess_info->cipher_alg);

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
