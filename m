Received: from eggs.gnu.org ([209.51.188.92]:59536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDoqY-00075w-Ou
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDoqT-0000cO-LI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:23:22 -0400
Date: Tue, 9 Apr 2019 12:18:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190409111852.GC16944@stefanha-x1.localdomain>
References: <20190406040422.5276-1-aruna.15@cse.mrt.ac.lk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20190406040422.5276-1-aruna.15@cse.mrt.ac.lk>
Subject: Re: [Qemu-devel] [PATCH 4/4] Header cleanups: Removed unwanted
 includes from cpu-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2019 at 09:34:22AM +0530, Aruna Jayasena wrote:
> Removed unwanted includes from cpu-common.h
> This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
>=20
> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> ---
>  include/exec/cpu-common.h | 2 --
>  1 file changed, 2 deletions(-)

Hi Aruna,
I'd like to review and apply your patches.  It's a little difficult
to understand the structure since there are several email threads with
subject lines ("PATCH 4/4") that imply a relationship, but they were
sent on different dates.

The usual structure of the first patch submission is:

  [PATCH 0/4] qemu-common.h: clean up qemu-common.h
  +--- [PATCH 1/4] qemu-common.h: drop unused includes in util/
  +--- [PATCH 2/4] ...
  +--- [PATCH 3/4] ...
  +--- [PATCH 4/4] ...

Here PATCH 0 is a cover letter that describes the purpose of this patch
series.  The actual patches (1, 2, 3, and 4) are part of the email
thread started by the cover letter.  This relationship allows tools to
treat the emails as a single patch series and it makes it easier for
human reviewers to review your patches in their inbox.

If you send a new revision of the patch series to address code review
feedback:

  [PATCH v2 0/4] qemu-common.h: clean up qemu-common.h
  +--- [PATCH v2 1/4] qemu-common.h: drop unused includes in util/
  +--- [PATCH v2 2/4] ...
  +--- [PATCH v2 3/4] ...
  +--- [PATCH v2 4/4] ...

The "v2" revision number indicates that this series obsoletes the first
patch submission.

Please resend your patches and follow this structure.  You can use
git-send-email --thread --no-chain-reply-to master.. to send the patch
series.  Normally --thread and --no-chain-reply-to are defaults and you
don't have to specify them explicitly.

If you need help, feel free to ping me on IRC.  You may find it useful
to send the email to yourself as a test first before sending to
qemu-devel@nongnu.org.

Stefan

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrH+cAAoJEJykq7OBq3PIdXYH/0Ry2IGRPtOjpvHkAJoS4VyR
ycCZ8cGS6rR7qOCKP/9BKOBdx71qAyAcp2EFtd1HYYAm28J3XXVaSnpcaDZ3q3ir
dBo/JH/z/WhsGLM8guNtlwiE//we2zCyAJWJgC6dGFZ5EuvsIBsWmiqJkopM+SZG
LIrT+DjgCNKSKJBJI31vwDL+OkqDsHtAYDc0cjQ/nKpkE95D6teAo9jyYye3QU9j
jsJicjSWbsfvk52SUCMIDtNjz96zJvYaMn/1vyhL6xiOm9lXRwYUEjI5WAFm4mRl
uLxMiYY9SMrEEMmkrKJbPvW7BnTkAYKFnsKiP11Rwns/zO2i/p8MdOBnW2YPXSA=
=n19E
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
