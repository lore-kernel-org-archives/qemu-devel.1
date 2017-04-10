Received: from eggs.gnu.org ([2001:4830:134:3::10]:35541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVev-00013i-MA
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVes-00086X-Is
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:30:53 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVes-00085x-Co
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:30:50 -0400
Received: by mail-wm0-x244.google.com with SMTP id o81so8553697wmb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:30:50 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:30:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410093047.GH2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/10] blockjob: separate monitor and
 blockjob APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:39:23PM +0100, Paolo Bonzini wrote:
> We already have different locking policies for APIs called by the monitor
> and the block job.  Monitor APIs need consistency across block_job_get
> and the actual operation (e.g. block_job_set_speed), so currently there
> are explicit aio_context_acquire/release calls in blockdev.c.
>=20
> When a block job needs to do something instead it doesn't care about lock=
ing,
> because the whole coroutine runs under the AioContext lock.  When moving
> away from the AioContext lock, the monitor will have to call new
> block_job_lock/unlock APIs, while blockjob APIs will take care of this
> for the users.
>=20
> In preparation for that, keep all the blockjob APIs together in the
> blockjob.c file.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 206 +++++++++++++++++++++++++++++++------------------------=
------
>  1 file changed, 105 insertions(+), 101 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61DHAAoJEJykq7OBq3PI4g4H/1hkDIHXULzexKNxPfKXlIFG
T8IaroATzcFzMnapnMklUOq/nJnV3XTn3EMoHrQe41mIgu1qGqs2oHkB9tgkWgyX
n14dAXwY52XXtUEPlDaOLaZbiGWrshdSGnKyQ+/9yke2kt1WwNU5RR87OQiZxKfQ
167mA0JCSV2dBqwx3Cch12kPL+bX7IHv8cYbrnN/kYsJbGNZIEHkHATWOQt58GXP
LYgkHwreTEl+f5l/Qri0jzk5yVLQTO2gxCdEx+T+S3ClCyW3zcwolxY2e6vPzoOD
aj01rmMqHozoTcb5rkDu2sfKIPFUOtKez9ak9y7P6oGdRN7cQB7eLWVeLnUUOOk=
=gGx1
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
