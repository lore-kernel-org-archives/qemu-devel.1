Received: from eggs.gnu.org ([2001:4830:134:3::10]:58916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxpl-00039q-MH
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxpi-0001rq-In
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:55:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQxpi-0001rk-9q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:55:30 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 459B5A2039
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 14:55:30 +0000 (UTC)
References: <20170109153914.27424-1-berrange@redhat.com>
	<20170109153914.27424-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4334752-59c6-ba69-a43a-b94f75fc8766@redhat.com>
Date: Tue, 10 Jan 2017 08:55:23 -0600
MIME-Version: 1.0
In-Reply-To: <20170109153914.27424-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MH3p2ose1Hb1aUILNdilc1LUExi1j5dvW"
Subject: Re: [Qemu-devel] [PATCH v2 5/8] io: add ability to associate an
 error with a task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MH3p2ose1Hb1aUILNdilc1LUExi1j5dvW
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b4334752-59c6-ba69-a43a-b94f75fc8766@redhat.com>
Subject: Re: [PATCH v2 5/8] io: add ability to associate an error with a task
References: <20170109153914.27424-1-berrange@redhat.com>
 <20170109153914.27424-6-berrange@redhat.com>
In-Reply-To: <20170109153914.27424-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 09:39 AM, Daniel P. Berrange wrote:
> Currently when a task fails, the error is never explicitly
> associated with the task object, it is just passed along
> through the completion callback. This adds the ability to
> explicitly associate an error with the task.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/task.h | 32 ++++++++++++++++++++++++++++++++
>  io/task.c         | 23 +++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>=20

>  /**
> + * qio_task_set_error:
> + * @task: the task struct
> + * @err: pointer to the error, or NULL
> + *
> + * Associate an error with the task, which can later
> + * be retrieved with the qio_task_propagate_error()
> + * method. This method takes ownership of @err, so
> + * it is not valid to access it after this call
> + * completes. If @err is NULL this is a no-op. If
> + * this is call multiple times, only the first

s/call/called/

> + * provided @err will be recorded, later ones will
> + * be discarded and freed.
> + */

With the typo fix,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MH3p2ose1Hb1aUILNdilc1LUExi1j5dvW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdPXbAAoJEKeha0olJ0Nq6sAH/0C49f4hC2h8mmrbnVgPqf28
mwHq7LFbNHz3IA6Z94M8JrhTAvL3tIJ8PQ96hgFO61GEq3lIq4wHkgUQ/TGVJ9vT
7hH/846gTRIH+R6Oui5JI9bOfDKQn/Y2D7KxTXRjjAQdpdEoOY11V8rHiv763uI6
ppoiKL2RykvFjgkySOm4YaYxziM5lE/s5nnetGON2SenH0ZKb+wf3Ep6oD2Y946R
4Tv1dNAHj6wFxE1ibQHpdJQLuPMeMp3lBq+mVGWWLiUQQo4MI5Nxg06cnaR5kupo
vxmKaBvvNHt93mS5LzLoNKFKcutjENkUvGzm/G/ItMmp6hNP6m9pkoJ3EMH0fmc=
=4coX
-----END PGP SIGNATURE-----

--MH3p2ose1Hb1aUILNdilc1LUExi1j5dvW--
