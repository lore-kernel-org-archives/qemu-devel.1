Received: from eggs.gnu.org ([2001:4830:134:3::10]:50766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNc6-0007Z0-Ec
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNc2-0002e6-P1
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:13:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGNc2-0002dv-Jl
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:13:38 -0500
Date: Mon, 12 Dec 2016 10:13:33 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161212101333.GB15611@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
	<1481530092-20240-2-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481530092-20240-2-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2 1/7] qapi: crypto: add
 defination about HMAC algorithms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: eblake@redhat.com, armbru@redhat.com, stefanha@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Mon, Dec 12, 2016 at 04:08:06PM +0800, Longpeng(Mike) wrote:
> This patch introduce HMAC algorithms relevant defination, they will
> be used by the following patch.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  qapi/crypto.json | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index f4fd93b..e63862a 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -55,6 +55,23 @@
>  
>  
>  ##
> +# @QCryptoHmacAlgorithm:
> +#
> +# The supported algorithms for hash-based message authentication code
> +#
> +# @md5: HMAC-MD5
> +# @sha1: HMAC-SHA1
> +# @sha256: HMAC-SHA256
> +# @sha512: HMAC-SHA512
> +#
> +# Since 2.9
> +##
> +{ 'enum': 'QCryptoHmacAlgorithm',
> +  'prefix': 'QCRYPTO_HMAC_ALG',
> +  'data': ['md5', 'sha1', 'sha256', 'sha512']}

There's not actually any concept of hmac algorithms - you have standard
hash algorithms used in the hmac calculation. IOW, you don't need to
add this enum. The hmac APIs should just use QCryptoHashAlgorithm as
their input.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
