Received: from eggs.gnu.org ([209.51.188.92]:38747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gp41c-0006nl-TM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 23:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gp41Z-0004eA-JG
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 23:32:27 -0500
References: <20190131040154.3770-1-mahaocong_work@163.com>
	<20190131040154.3770-2-mahaocong_work@163.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <38fb8b6a-25e1-f5fd-8921-edecbf4a21b9@redhat.com>
Date: Wed, 30 Jan 2019 22:32:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190131040154.3770-2-mahaocong_work@163.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9Y7Yt31rrjGiuIe0Xi8c8GXXlP0FVHA73"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/1] drive-mirror: add
 incremental mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, mahaocong <mahaocong@didichuxing.com>, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Y7Yt31rrjGiuIe0Xi8c8GXXlP0FVHA73
From: Eric Blake <eblake@redhat.com>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, mahaocong
 <mahaocong@didichuxing.com>, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <38fb8b6a-25e1-f5fd-8921-edecbf4a21b9@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 1/1] drive-mirror: add incremental mode
References: <20190131040154.3770-1-mahaocong_work@163.com>
 <20190131040154.3770-2-mahaocong_work@163.com>
In-Reply-To: <20190131040154.3770-2-mahaocong_work@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 10:01 PM, mahaocong wrote:
> From: mahaocong <mahaocong@didichuxing.com>
>=20

You are STILL missing the commit message body, even though I requested
it [1].  Please 'git commit --amend', and paste in the contents that you
are sticking in your 0/1 cover letter that actually describe the details
behind this patch. Also, since you are sending a single patch, you don't
need a 0/1 cover letter (they are mandatory if you send 2 or more
patches in series; but don't add anything when you send just one patch,
although they don't hurt, as long as you do a correct division between
cover letter having information for the reviewer and patch itself having
a self-contained commit message).

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00122.html

> Signed-off-by: mahaocong <mahaocong@didichuxing.com>

I previously mentioned [2] that you probably want to use a proper name
(typically more than one word), not a username. While I am not in a
position to argue whether 'mahaocong' is how you sign legal documents,
or what you may use in other open source projects, it is at least
courteous to reply to a reviewer's request when stating that you are
intentionally not going to do something about the request.

[2] https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00407.html

> ---

Here, after the --- marker, is a good place to describe how v3 differs
from v2, to speed up reviewers efforts if they have already looked at
the earlier version, and want to see what you changed in response to
their comments.

Just a UI review on my part (I haven't looked at the code proper, in
part because I'm still waiting for you to fix the commit message problem
- it's tough to justify reviewing in more depth when there are things
from the earlier version that are still not corrected)

> +++ b/qapi/block-core.json
> @@ -1727,6 +1727,11 @@
>  #        (all the disk, only the sectors allocated in the topmost imag=
e, or
>  #        only new I/O).
>  #
> +# @bitmap: the name of user-created-bitmap which is used on incrementa=
l mode
> +#          drive-mirror. If user select incremental mode, bitmap shoul=
d not be
> +#          null, and can not set granularity, because the mirror bitma=
p should
> +#          have the same granularity with user-created-bitmap.

Missing a '(since 4.0)' tag. The grammar is awkward; maybe:

@bitmap: the name of a pre-existing bitmap to use in incremental mode;
must be present for incremental mode and absent otherwise. In
incremental mode, granularity should not be set, because the bitmap's
granularity is used instead.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--9Y7Yt31rrjGiuIe0Xi8c8GXXlP0FVHA73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxSelAACgkQp6FrSiUn
Q2orHwf+PFTYavuOn5I4Rlw5f9tm489fabknPoMvuBl/0+WSDPbWj+oUwXpDn+GE
CInDELQFqoTNzj7wLJS+z2+6ZndjbS2P0egsSMI601OVfn2ZDuK/F/j2bX9/ESu0
LuMT3s68zInFtJvW32Z947V1b+4uratdRFmbI2nWa6yAbIETa4zwJNrK3n73CbrI
RKM9zsCU5irfW44zEcuWZZ4JgU12yYnulZlRIN0+IIYdm5W/slkBLy15VdGX3bSq
+mg+T0ScHIO/zHFdDoB0G3OwD//YoLLkyaoQhtfuUyqRbj7yqGM7z5XJMy7dOH/e
wM7BtyAS9SLar3zTXNPW6LoQ+kx4QA==
=/RdJ
-----END PGP SIGNATURE-----

--9Y7Yt31rrjGiuIe0Xi8c8GXXlP0FVHA73--
