Received: from eggs.gnu.org ([2001:4830:134:3::10]:49273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUrmH-0005vE-LG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUrmG-0005T3-SC
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:48:21 -0400
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-12-pbonzini@redhat.com>
	<20170710162419.GS14195@stefanha-x1.localdomain>
	<c5efa0c6-92a1-76f6-c1ba-34b36ef93cbd@redhat.com>
	<20170711094356.GI17792@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <16c674cf-0474-61e6-6f0d-cfb059d30532@redhat.com>
Date: Tue, 11 Jul 2017 11:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170711094356.GI17792@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8HfB2J67u7IRcwLhOL4xctRkWt9IueLC3"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 11/11] block/snapshot: do not
 take AioContext lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8HfB2J67u7IRcwLhOL4xctRkWt9IueLC3
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, famz@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <16c674cf-0474-61e6-6f0d-cfb059d30532@redhat.com>
Subject: Re: [Qemu-block] [PATCH 11/11] block/snapshot: do not take AioContext
 lock
References: <20170706163828.24082-1-pbonzini@redhat.com>
 <20170706163828.24082-12-pbonzini@redhat.com>
 <20170710162419.GS14195@stefanha-x1.localdomain>
 <c5efa0c6-92a1-76f6-c1ba-34b36ef93cbd@redhat.com>
 <20170711094356.GI17792@stefanha-x1.localdomain>
In-Reply-To: <20170711094356.GI17792@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/07/2017 11:43, Stefan Hajnoczi wrote:
>>>
>>> 1. Must be called under BQL?
>>> 2. Can I/O requests be in flight?
>>> 3. Is it thread-safe?
>>>
>>> Otherwise it will be a nightmare to modify the code since these
>>> constraints are not enforced by the compiler and undocumented.
>> Good point.  Are (1) and (3) different ways to say the same thing or d=
o
>> you have other differences in mind?
> There is a difference between (1) and (3).  If a function is thread-saf=
e
> then callers can invoke it without any constraints.  If a function
> requires a specific lock to be held then that it puts a constraint on
> the caller.
>=20
> We do have thread-safe functions in the block layer: simple functions
> that fetch a BDS field atomically.  There is no need to hold the BQL fo=
r
> them.

Ok, so we are in (somewhat violent) agreement.  "It's not thread-safe"
pretty much means "must be called under BQL".

I look forward to extending Marc-Andr=E9's -Wthread-safety experiments to=

cover bdrv_drained_begin/end!

Paolo


--8HfB2J67u7IRcwLhOL4xctRkWt9IueLC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAllkntIACgkQv/vSX3jH
roOCxgf+MYn8nU/VqrrUW0kG+OEfdUbvmlVdTw3KQreT3yf2d0rPWpIWynU0h7Nv
CiYNqYIiPVtQpD+utcwpQpE8JWwBm8LQpEVITMfBt5YsbtWr5+WRxIhFotmKU+6o
F1sKSWcadGuavjEmjsW8a4I6cQiEPBnIfKGwUcycesFmy/GeuY28LKRP0L/ZKJDv
POFaF1ZEBykXilDraPVv0eQyuAnyFpaiq7xY16F+nck3ue2LT/JcSg5gDZwvfZnq
avS6Xq3+6asjanqBvVWszdGb1Bf6nHU2bkBGA2DqJbOmhGDQCUO9yF3p2E/3Mi5+
UxmjXMPhOG8E78DBybFKqmwFhsCnGA==
=qCso
-----END PGP SIGNATURE-----

--8HfB2J67u7IRcwLhOL4xctRkWt9IueLC3--
