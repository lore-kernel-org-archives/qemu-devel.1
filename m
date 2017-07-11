Received: from eggs.gnu.org ([2001:4830:134:3::10]:58784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuGx-00074m-JS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUuGt-0007UP-RU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:28:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dUuGt-0007UH-LO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:28:07 -0400
Date: Tue, 11 Jul 2017 13:28:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170711122802.GL7116@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
	<1499158630-75260-13-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499158630-75260-13-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/18] crypto: introduce some common
 functions for af_alg backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: arei.gonglei@huawei.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, longpeng.mike@gmail.com

On Tue, Jul 04, 2017 at 04:57:04PM +0800, Longpeng(Mike) wrote:
> The AF_ALG socket family is the userspace interface for linux
> crypto API, this patch adds af_alg family support and some common
> functions for af_alg backend. It'll be used by afalg-backend crypto
> latter.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  configure            |  22 ++++++++++
>  crypto/Makefile.objs |   1 +
>  crypto/afalg.c       | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  crypto/afalgpriv.h   |  55 ++++++++++++++++++++++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 crypto/afalg.c
>  create mode 100644 crypto/afalgpriv.h
> 
> diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
> new file mode 100644
> index 0000000..d21160c
> --- /dev/null
> +++ b/crypto/afalgpriv.h
> @@ -0,0 +1,55 @@

> +
> +struct QCryptoAFAlg {
> +    int tfmfd;
> +    int opfd;
> +    char *name;

What actually uses this 'name' field ?  I'm not seing anything in the
patch series that ever reads it, once set. So can we just delete it
perhaps ?

> +    struct msghdr *msg;
> +    struct cmsghdr *cmsg;
> +};

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
