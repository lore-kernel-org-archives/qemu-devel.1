Received: from eggs.gnu.org ([2001:4830:134:3::10]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3LgR-0005Tp-0h
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3LgN-0000Bt-55
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:04:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3LgM-0000Bg-Vt
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:04:31 -0400
Date: Wed, 26 Apr 2017 13:04:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426120424.GK18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
	<1492845627-4384-6-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492845627-4384-6-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/18] crypto: cipher: add cipher driver
 framework
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

On Sat, Apr 22, 2017 at 03:20:14PM +0800, Longpeng(Mike) wrote:
> 1) makes the public APIs in cipher-nettle/gcrypt/builtin static,
>    and rename them with "nettle/gcrypt/builtin" prefix.
> 
> 2) introduces cipher framework, including QCryptoCipherDriver
>    and new public APIs.
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/cipher-builtin.c | 64 +++++++++++++++++--------------------------
>  crypto/cipher-gcrypt.c  | 72 +++++++++++++++++++++----------------------------
>  crypto/cipher-nettle.c  | 71 ++++++++++++++++++++----------------------------
>  crypto/cipher.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  crypto/cipherpriv.h     | 40 +++++++++++++++++++++++++++
>  include/crypto/cipher.h |  1 +
>  6 files changed, 190 insertions(+), 123 deletions(-)
>  create mode 100644 crypto/cipherpriv.h

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
