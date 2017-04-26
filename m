Received: from eggs.gnu.org ([2001:4830:134:3::10]:50405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lft-00055Y-5e
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lfp-0008N0-D0
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:04:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3Lfp-0008MV-6V
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:03:57 -0400
Date: Wed, 26 Apr 2017 13:03:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426120351.GJ18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
	<1492845627-4384-5-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492845627-4384-5-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/18] crypto: cipher: introduce
 qcrypto_cipher_ctx_new for builtin-backend
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

On Sat, Apr 22, 2017 at 03:20:13PM +0800, Longpeng(Mike) wrote:
> Extracts qcrypto_cipher_ctx_new() from qcrypto_cipher_new() for
> builtin-backend impls.
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/cipher-builtin.c | 101 ++++++++++++++++++++++++++----------------------
>  1 file changed, 55 insertions(+), 46 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
