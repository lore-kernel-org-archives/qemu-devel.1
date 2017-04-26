Received: from eggs.gnu.org ([2001:4830:134:3::10]:50720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lgo-0005jZ-Ob
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Lgn-0000Ls-R8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3Lgn-0000LF-LJ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:04:57 -0400
Date: Wed, 26 Apr 2017 13:04:50 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426120450.GL18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
	<1492845627-4384-7-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492845627-4384-7-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/18] crypto: hash: add hash driver
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

On Sat, Apr 22, 2017 at 03:20:15PM +0800, Longpeng(Mike) wrote:
> 1) makes the public APIs in hash-nettle/gcrypt/glib static,
>    and rename them with "nettle/gcrypt/glib" prefix.
> 
> 2) introduces hash framework, including QCryptoHashDriver
>    and new public APIs.
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/hash-gcrypt.c | 19 +++++++++++++------
>  crypto/hash-glib.c   | 19 +++++++++++++------
>  crypto/hash-nettle.c | 19 +++++++++++++------
>  crypto/hash.c        | 13 +++++++++++++
>  crypto/hashpriv.h    | 31 +++++++++++++++++++++++++++++++
>  5 files changed, 83 insertions(+), 18 deletions(-)
>  create mode 100644 crypto/hashpriv.h

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
