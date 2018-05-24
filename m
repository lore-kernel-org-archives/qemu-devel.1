Received: from eggs.gnu.org ([2001:4830:134:3::10]:53926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fLmd6-0003x1-V8
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fLmd3-0001wJ-PS
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:33:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fLmd3-0001w8-LK
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F79C4022407
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 09:33:49 +0000 (UTC)
Date: Thu, 24 May 2018 10:28:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180524092837.GD20733@stefanha-x1.localdomain>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
In-Reply-To: <20180524043952.11245-5-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] monitor: add lock to protect
 mon_fdsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2018 at 12:39:52PM +0800, Peter Xu wrote:
>  int monitor_fdset_get_fd(int64_t fdset_id, int flags)
>  {
> -#ifndef _WIN32
> +#ifdef _WIN32
> +    return -ENOENT;

stubs/fdset.c:monitor_fdset_get_fd() should return -ENOENT instead of -1
now.

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBoXFAAoJEJykq7OBq3PIjfUIAMKdKmBUxE0aHO10hLU+PYkI
79/HD8uhZ3YD1rqQ1VzadTFYCTq0Av32KJ/RVWhKsEQxm8P/30+BY+sjVVEOSFX/
QIvAQ6/nTlGEp3qR7ugrJSiShKouiivmSNDGDy8F3o5+hfgK47+sTIe0zyxAg0TH
HQkMQfRPso+BHUQLHWnh7GQwr50gaNdhcG3zG57vmggIXMU2UgrACnMgyO/gi5CF
mrAhbcfClRcYmjWMHHFPzGScmUhLcPOD16/QkQ5uhHGMZBgpgb7uxyo5nx/pq+4D
8EmnPTl5wBSxMlBDq7R5mgtGWH8afhNgiDjuh5yZwD1FBj3Yn9eR0O25Z0B353I=
=P/c1
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
