Received: from eggs.gnu.org ([2001:4830:134:3::10]:40040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOilW-0002m7-Kx
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOilS-0003fB-VF
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:25:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cOilS-0003ez-MR
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:25:50 -0500
Date: Wed, 4 Jan 2017 10:25:40 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170104102540.GC10541@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <586c7aad.0834c80a.d7aff.122e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <586c7aad.0834c80a.d7aff.122e@mx.google.com>
Subject: Re: [Qemu-devel] [PATCH] Crypto: fix leak in ivgen essiv init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: qemu-devel@nongnu.org, liqiang6-s@360.cn

On Tue, Jan 03, 2017 at 08:31:34PM -0800, Li Qiang wrote:
> From: Li Qiang <liqiang6-s@360.cn>
> 
> On error path, the 'salt' doesn't been freed thus leading
> a memory leak. This patch avoid this.
> 
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  crypto/ivgen-essiv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
> index 634de63..cba20bd 100644
> --- a/crypto/ivgen-essiv.c
> +++ b/crypto/ivgen-essiv.c
> @@ -48,6 +48,7 @@ static int qcrypto_ivgen_essiv_init(QCryptoIVGen *ivgen,
>                             &salt, &nhash,
>                             errp) < 0) {
>          g_free(essiv);
> +        g_free(salt);
>          return -1;
>      }

Looks good, thanks, added to the crypto-next queue.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
