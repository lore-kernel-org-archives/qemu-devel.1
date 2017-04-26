Received: from eggs.gnu.org ([2001:4830:134:3::10]:51191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lhk-0006cQ-P2
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lhg-0000ez-Oa
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3Lhg-0000ej-I8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:05:52 -0400
Date: Wed, 26 Apr 2017 13:05:46 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426120546.GN18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
	<1492845627-4384-9-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492845627-4384-9-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/18] crypto: hmac: introduce
 qcrypto_hmac_ctx_new for gcrypt-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: arei.gonglei@huawei.com, longpeng.mike@gmail.com, qemu-devel@nongnu.org, weidong.huang@huawei.com

On Sat, Apr 22, 2017 at 03:20:17PM +0800, Longpeng(Mike) wrote:
> 1) Fix a handle-leak problem in qcrypto_hmac_new(), doesn't free
>    ctx->handle if gcry_mac_setkey fails.
> 
> 2) Extracts qcrypto_hmac_ctx_new() from qcrypto_hmac_new() for
>    gcrypt-backend impls.
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/hmac-gcrypt.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
