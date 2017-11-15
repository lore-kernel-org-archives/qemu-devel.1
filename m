Received: from eggs.gnu.org ([2001:4830:134:3::10]:41910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEuDl-0000kr-CE
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEuDi-00024p-9R
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:43:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eEuDh-00023Y-WF
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:42:58 -0500
Date: Wed, 15 Nov 2017 09:42:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171115094246.GC8130@stefanha-x1.localdomain>
References: <20171106094643.14881-1-peterx@redhat.com>
	<150996313592.327.4353631543325177108@bafd83ae6430>
	<20171106130800.GA4764@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20171106130800.GA4764@xz-mi>
Subject: Re: [Qemu-devel] [RFC v3 00/27] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, lvivier@redhat.com, quintela@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, marcandre.lureau@redhat.com, shajnocz@redhat.com, pbonzini@redhat.com, jdenemar@redhat.com, dgilbert@redhat.com


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 09:08:00PM +0800, Peter Xu wrote:
> On Mon, Nov 06, 2017 at 02:12:17AM -0800, no-reply@patchew.org wrote:
> > Hi,
> >=20
> > This series seems to have some coding style problems. See output below =
for
> > more information:
> >=20
> > Subject: [Qemu-devel] [RFC v3 00/27] QMP: out-of-band (OOB) execution s=
upport
> > Type: series
> > Message-id: 20171106094643.14881-1-peterx@redhat.com
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> >=20
> > BASE=3Dbase
> > n=3D1
> > total=3D$(git log --oneline $BASE.. | wc -l)
> > failed=3D0
> >=20
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> >=20
> > commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> > for c in $commits; do
> >     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
> >     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailb=
ack -; then
> >         failed=3D1
> >         echo
> >     fi
> >     n=3D$((n+1))
> > done
> >=20
> > exit $failed
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > From https://github.com/patchew-project/qemu
> >  * [new tag]               patchew/20171106094643.14881-1-peterx@redhat=
=2Ecom -> patchew/20171106094643.14881-1-peterx@redhat.com
> > Switched to a new branch 'test'
> > 5525c4e791 tests: qmp-test: add oob test
> > ccc9e4c399 tests: qmp-test: verify command batching
> > 7f45b4c6c0 docs: update QMP documents for OOB commands
> > 58cfe877d2 monitor: enable IO thread for (qmp & !mux) typed
> > 5e1d56ce74 qmp: isolate responses into io thread
> > aef4275536 qmp: let migrate-incoming allow out-of-band
> > 5e68beacf3 qmp: support out-of-band (oob) execution
> > 43c7215a30 qapi: introduce new cmd option "allow-oob"
> > e11127ba4b monitor: send event when request queue full
> > 45cef4f7e4 qmp: add new event "request-dropped"
> > 485da28be1 monitor: separate QMP parser and dispatcher
> > 4892fe9ca2 monitor: let monitor_{suspend|resume} thread safe
> > 1b86166d9c monitor: introduce monitor_qmp_respond()
> > 0f48093add qmp: introduce some capability helpers
> > 8d3f33043d qmp: negociate QMP capabilities
> > 023b386d0e qmp: introduce QMPCapability
> > 2bde5ca8ce monitor: allow to use IO thread for parsing
> > f4cc112f80 monitor: create monitor dedicate iothread
> > 3590fdc1d4 monitor: let mon_list be tail queue
> > 11c818a9ac monitor: unify global init
> > 36d3efb87d monitor: move the cur_mon hack deeper for QMP
> > bf3e493a86 qjson: add "opaque" field to JSONMessageParser
> > 17367fe7a1 monitor: move skip_flush into monitor_data_init
> > 0c98d4baa4 qobject: let object_property_get_str() use new API
> > aa4b973dd5 qobject: introduce qobject_get_try_str()
> > 981ccebc1e qobject: introduce qstring_get_try_str()
> > d40ba38085 char-io: fix possible race on IOWatchPoll
> >=20
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > Checking PATCH 1/27: char-io: fix possible race on IOWatchPoll...
> > Checking PATCH 2/27: qobject: introduce qstring_get_try_str()...
> > Checking PATCH 3/27: qobject: introduce qobject_get_try_str()...
> > Checking PATCH 4/27: qobject: let object_property_get_str() use new API=
=2E..
> > Checking PATCH 5/27: monitor: move skip_flush into monitor_data_init...
> > Checking PATCH 6/27: qjson: add "opaque" field to JSONMessageParser...
> > Checking PATCH 7/27: monitor: move the cur_mon hack deeper for QMP...
> > Checking PATCH 8/27: monitor: unify global init...
> > Checking PATCH 9/27: monitor: let mon_list be tail queue...
> > Checking PATCH 10/27: monitor: create monitor dedicate iothread...
> > Checking PATCH 11/27: monitor: allow to use IO thread for parsing...
> > Checking PATCH 12/27: qmp: introduce QMPCapability...
> > Checking PATCH 13/27: qmp: negociate QMP capabilities...
> > Checking PATCH 14/27: qmp: introduce some capability helpers...
> > Checking PATCH 15/27: monitor: introduce monitor_qmp_respond()...
> > Checking PATCH 16/27: monitor: let monitor_{suspend|resume} thread safe=
=2E..
> > ERROR: braces {} are necessary for all arms of this statement
> > #28: FILE: monitor.c:4014:
> > +    if (atomic_dec_fetch(&mon->suspend_cnt) =3D=3D 0)
> > [...]
> >=20
> > ERROR: Missing Signed-off-by: line(s)
>=20
> Will add it in next post.  I still haven't found a good way to let
> magit add this line for me every time automatically.

If you don't want to type "git commit -s" all the time you could use the
"format.signOff =3D on" git-config(1) variable.

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaDAwWAAoJEJykq7OBq3PIABsH/3tC90MpvD51fEqFwp8U6KU8
nil/HLL4qeMkL/iNMvmgZ89GAiO+kbNtzwBp+VhqqreBfqyW3JWDqxV/jnnOTY0d
CltE3qPDnUkabBzyayTCCSUS6zPF25gzmjTKTbmMmfXAv9/BFzfbK1qLFcdpvqwW
9ed2W5xroGixP4g3WKO6y/W8937gCOESEKXesL3vFoiCJ+Ys1DuxfEI+BUYz7hgz
Fj87aI8toOhUBkbFrlQoL/DcyoZywNPxlX4vuaKhULXR/IPO1mGb3F5h58AEZPFr
UU5EcMbbKUXEcT+iplNckmAS3OWRetBs9fZcwqUZxjxwJe+8qPkZwsaAbFk35BY=
=Molo
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
