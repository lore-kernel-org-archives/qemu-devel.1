Received: from eggs.gnu.org ([2001:4830:134:3::10]:47577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fON6Q-0000YN-W4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fON6N-0001CS-TS
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:54:51 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fON6N-0001CB-M2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:54:47 -0400
Received: by mail-wm0-x242.google.com with SMTP id x2-v6so46355778wmh.5
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 05:54:47 -0700 (PDT)
Date: Thu, 31 May 2018 13:54:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531125444.GJ27838@stefanha-x1.localdomain>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
	<1525918138-6189-4-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwgQ89ZNnFUwFHTC"
Content-Disposition: inline
In-Reply-To: <1525918138-6189-4-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 3/9 V5] configure: add libpmem support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--rwgQ89ZNnFUwFHTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2018 at 10:08:52AM +0800, junyan.he@gmx.com wrote:
>  ##########################################
> +# check for libpmem
> +
> +if test "$libpmem" != "no"; then
> +  cat > $TMPC <<EOF
> +#include <libpmem.h>
> +int main(void)
> +{
> +  pmem_is_pmem(0, 0);
> +  return 0;
> +}
> +EOF
> +  libpmem_libs="-lpmem"

PMDK uses pkg-config, please take advantage of it instead of hardcoding
flags.  See $pkg_config in ./configure for examples.

This will allow QEMU to detect PMDK on a wider range of systems.

--rwgQ89ZNnFUwFHTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD/CUAAoJEJykq7OBq3PIAkIIAJ0ywT9BIxYM71vTLIKA7CMv
HvYG1gFEEXHndpNCKp+NEMec6S4uQ9MukEFabVWclWFK7ZqGE7tdm0b92fxCF2Tf
CgoJexNSM1/qjPHREfMM6PwPFBbroAVCMY/VVC3HVuUY2Sl3SSB4sBOuSxWPiABr
pRgx3xip8mPuVGvDLTNTuQJ1M1EZTFzBg9QRKJ0cFAG9zwMFbBCYgXSNUKQq6V4n
/UdD11FSWcCpPnPBw99oEcjEYSTcP0F49O9faMtyj0DYYvQMTgpcuO7+NHw+HB/A
bydvgQdlrZDVtYwsDSp4mKxBn0lu90h4Bcl7IQPVTW0QaCj3IvqPEo9T9xP0QAg=
=7keZ
-----END PGP SIGNATURE-----

--rwgQ89ZNnFUwFHTC--
