Received: from eggs.gnu.org ([2001:4830:134:3::10]:43366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRLsH-0006yi-SP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRLsE-0006gR-NT
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:35:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRLsE-0006g3-Fp
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:35:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58ADD7EAB9
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:35:42 +0000 (UTC)
Date: Wed, 11 Jan 2017 16:35:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170111163535.GB9269@stefanha-x1.localdomain>
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <20170104132625.28059-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-thread: introduce QemuLockCnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2017 at 02:26:17PM +0100, Paolo Bonzini wrote:
> +/* Decrement a counter, and return locked if it is decremented to zero.
> + * It is impossible for the counter to become nonzero while the mutex
> + * is taken.
> + */
> +bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt)
> +{
> +    int val = atomic_read(&lockcnt->count);

Why does qemu_lockcnt_inc() use atomic_mb_read() while this function
uses plain atomic_read()?

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdl7XAAoJEJykq7OBq3PIABEIAJEsZ4rFP35sWQ9BON1NrIA3
Ks7V2n6HEUgBrU4uAKDhMARz5508MlN7xTE9ZtNwbve/JUNuABYUsPQA/5VVNk/t
ALH13wDV7o13XOO19MqLCB1XctJHB8tPt8g+WKjuXbR2h+cX13xYwdunNA4mPYPv
0OctcZGh45ZYurf/SrB2sLCbfyltwHX+XUefoTUthar/q9/RvcBoVfN9Xj5VLhdO
1wdV0HFMGRiuOe1LXZRCMADeHsk8hIe1E/4lAgYyFVAaqICu5+hgqzMnG1X2PRvf
x8Kjo9CkMOyBq/M7pT3gMi4Xu6vPpoA+3yv4mm/MnQRUG/I38PJtmrtA6dyUgr0=
=kkKb
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
