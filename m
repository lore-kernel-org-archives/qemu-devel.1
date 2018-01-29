Received: from eggs.gnu.org ([2001:4830:134:3::10]:59277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9TU-0006tk-Jt
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9TQ-00044o-R7
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:27:52 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eg9TQ-00044S-JI
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:27:48 -0500
Received: by mail-wr0-x244.google.com with SMTP id d9so7208212wre.3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 05:27:48 -0800 (PST)
Date: Mon, 29 Jan 2018 13:27:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129132745.GG20446@stefanha-x1.localdomain>
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <20180125175949.7780-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] curl: convert to CoQueue
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


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 06:59:49PM +0100, Paolo Bonzini wrote:
> Now that CoQueues can use a QemuMutex for thread-safety, there is no
> need for curl to roll its own coroutine queue.  Coroutines can be
> placed directly on the queue instead of using a list of CURLAIOCBs.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabyFRAAoJEJykq7OBq3PIeegIAMR9PPEHYPg2yZtqD/htf74p
3VeC8pQB4KROjMEcCdFbhYm7yWI5HbXdm1BMQktTxD6yP89ECmjbwxVAFzBh+iJB
/mVjGRPmRGvfnd4vuOpZRq4pg3hp3vFxZKquy//F7eNYkt72GwLLulp0C1IciBvY
4Bry0beZWAYC21FbYx99bMgj6fzjw7NyOkF3PdTIzwgUXiQyqwwAE5oWkEZ6jz9Y
3D+nymq2cyuHMlVhFhniLryF5kix0Tdse1h6OdSrVLFjAW7v21HUp/y7lfl6QNu0
9zKZUHZg5+e4M0zH0/6ZDH2bfz2H/e2T4hB1dRQNbXnjmqeIv0vrYhrwtKbMJK8=
=SeP4
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
