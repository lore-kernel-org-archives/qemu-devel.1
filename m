Received: from eggs.gnu.org ([2001:4830:134:3::10]:33839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJb23-000808-UO
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJb20-00053v-PB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:18:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gJb20-00022C-C1
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:18:48 -0500
Date: Mon, 5 Nov 2018 09:18:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181105091831.GA10887@stefanha-x1.localdomain>
References: <20181004143009.24693-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20181004143009.24693-1-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] tracetool: Include thread id information
 in log backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 11:30:09AM -0300, Fabiano Rosas wrote:
> Currently the log backend prints the process id of QEMU at the start
> of each output line, but since threads share the same PID there is no
> clear distinction between their outputs.
>=20
> Having the thread id present in the log makes it easier to see when
> output comes from different threads. E.g.:
>=20
> 12423@1538597569.672527:qemu_mutex_lock waiting on mutex 0x1103ee60 (/roo=
t/qemu/util/main-loop.c:236)
> ...
> 12430@1538597569.503928:qemu_mutex_unlock released mutex 0x1103ee60 (/roo=
t/qemu/cpus.c:1238)
> 12431@1538597569.503937:qemu_mutex_locked taken mutex 0x1103ee60 (/root/q=
emu/cpus.c:1257)
> ^here
>=20
> In the above, 12423 is the main process id and 12430 & 12431 are the
> two vcpu threads.
>=20
>  (qemu) info cpus
>  * CPU #0: thread_id=3D12430
>    CPU #1: thread_id=3D12431
>=20
> Suggested-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  scripts/tracetool/backend/log.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb4ArnAAoJEJykq7OBq3PIvSwH/RCVofnINeZbGACTExTJq9Lt
4tEp4+jL8oKRKZOaqEHbVPSw3jvHNMGgdJlYKwrcZaFQ/TvFK2QR0XBMYsH9kErS
eNNnO271NKEHCz4gPpvN0bmhOanfxn9Rm1L3V7mtcjjLNjNT4Y1SrgSwRB2gyAwS
ahsM2Lqkv6YXTnRpTq33lDWLyrlXVROvtqcB83XebSiQMNzVZ8MOinulyFmNueEy
U0px+iSvfw/tIuM7b0ifBbZc1iEN3W0Nu/8Qet/rTgvW538mZnMehjXfkH8JmHXO
/aVMWn18pGIckNPnjfCCRxr2ZD2XwCBE/jniGcnXChlJcUPVKUYCYOka8xmWZ1w=
=Rq05
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
