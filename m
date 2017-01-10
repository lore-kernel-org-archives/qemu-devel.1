Received: from eggs.gnu.org ([2001:4830:134:3::10]:50366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRFYu-0004nx-U5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRFYr-0001gL-1N
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRFYq-0001gA-RF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:16 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E64FE61B9C
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 09:51:16 +0000 (UTC)
Date: Tue, 10 Jan 2017 16:38:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170110163858.GB19869@stefanha-x1.localdomain>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20170106155543.12827-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2017 at 03:54:58PM +0000, Daniel P. Berrange wrote:
> diff --git a/io/Makefile.objs b/io/Makefile.objs
> index 9d8337d..94cb74e 100644
> --- a/io/Makefile.objs
> +++ b/io/Makefile.objs
> @@ -8,3 +8,5 @@ io-obj-y += channel-watch.o
>  io-obj-y += channel-websock.o
>  io-obj-y += channel-util.o
>  io-obj-y += task.o
> +trace-obj-y += trace.o
> +trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o

Is there a way to eliminate this boilerplate?  If the directory has a
trace-events file then it requires trace.o/trace-dtrace.o.

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdQ4iAAoJEJykq7OBq3PI99YH/1RC43c53x9qSCIAVKrUJJUg
C7zGuuY5cFjUifkpxPTrTWA7x72tKckMLRAVab6q83vsx8XLK1KKD8QaqPBsf7S2
smnr5Cbsx/b7cHcH1MooCQoP0uqw14jupIO4l94lo1DkeIRCrLqWDkMdJBAGgfgH
jmf7nORjxkQAb1axzCTyNx5xVc/4z+UC95o+wrPmIvxtUJClvuMYXY6uuMT5FHnd
tvSZHG7UmKnFDIvAdUYgP6/IOTNyfEIqVWntt4paHpc7VXVIG4zs+0HieSlvedX1
Bko+cOLj+y9OynS8f5Uy8H1IdRa9AFBQ5+Px6nqot10pjuXhXN23G3Pnl7beFns=
=7T1Y
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
