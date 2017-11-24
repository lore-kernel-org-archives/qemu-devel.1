Received: from eggs.gnu.org ([2001:4830:134:3::10]:57798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eIC8T-0000Uj-09
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eIC8N-0008Vz-TK
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:27:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eIC8N-0008U8-N7
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:27:03 -0500
Date: Fri, 24 Nov 2017 11:27:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171124112701.GB11868@stefanha-x1.localdomain>
References: <1511505030-3669-1-git-send-email-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <1511505030-3669-1-git-send-email-yang.zhong@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3] rcu: reduce more than 7MB heap memory
 by malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 24, 2017 at 02:30:30PM +0800, Yang Zhong wrote:
> diff --git a/configure b/configure
> index 0c6e757..6292ab0 100755
> --- a/configure
> +++ b/configure
> @@ -426,6 +426,7 @@ vxhs=""
>  supported_cpu="no"
>  supported_os="no"
>  bogus_os="no"
> +malloc_trim="yes"

Looks pretty good, sorry I forgot to mention two things:

Please add the --enable-malloc-trim/--disable-malloc-trim options so
it's easy to build QEMU with or without this feature.  For example, if
someone is debugging a performance issue they may wish to rebuild with
--disable-malloc-trim to confirm that trimming hasn't caused a
regression.

Also please change this line to malloc_trim="" so the "Disabling
malloc_trim with non-libc memory allocator" error message is only
printed when --enable-malloc-trim was explicitly given by the user.
Otherwise the message is always printed when QEMU is built with
jemalloc/tcmalloc - that's too noisy.

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaGAIFAAoJEJykq7OBq3PIw3EH/id6At2qEUwPTCPVacZf3I/J
NaVQ65dt5pyseirQvIK7+APDLQ4et9nWB/TdlLI8XD9LwAM4GTvyqZRPMnsEoPbz
QX2tnfvY7qz0hLZNVB46bbzKXQJWofOWwpX2prbJwfdgw+pA8BhpMxdCBYs9scYI
89SNMCBJywh8g856QzRznJQX86jZwBbDCS0Y4TN7Zr7M6GMhoWsfmtvIkq01pRyz
UnsEpKZL87PMY7aVPr6nCuxc7YgC4lAJaR+w4IwsGLpGoNi2PqrzvW5sVYueuQFs
tE87Eu41/BJtwkCrqOqJyZGnJLV94AjTHVTVzvjcB5YQprzKNC6g/WLu9YyVgmA=
=jiVW
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
