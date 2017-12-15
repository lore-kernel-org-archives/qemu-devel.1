Received: from eggs.gnu.org ([2001:4830:134:3::10]:53898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePpOe-00077z-S1
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePpOb-00058i-L2
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:47:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePpOb-00057J-DK
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:47:21 -0500
Date: Fri, 15 Dec 2017 12:47:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215124711.GF26982@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-8-peterx@redhat.com>
	<20171213154806.GH7173@stefanha-x1.localdomain>
	<20171215081141.GN7780@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <20171215081141.GN7780@xz-mi>
Subject: Re: [Qemu-devel] [RFC v5 07/26] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 04:11:41PM +0800, Peter Xu wrote:
> On Wed, Dec 13, 2017 at 03:48:06PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 01:51:41PM +0800, Peter Xu wrote:
> > > diff --git a/vl.c b/vl.c
> > > index 1ad1c04637..1ec995a6ae 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -3144,7 +3144,6 @@ int main(int argc, char **argv, char **envp)
> > >      qemu_init_exec_dir(argv[0]);
> > > =20
> > >      module_call_init(MODULE_INIT_QOM);
> > > -    monitor_init_qmp_commands();
> > > =20
> > >      qemu_add_opts(&qemu_drive_opts);
> > >      qemu_add_drive_opts(&qemu_legacy_drive_opts);
> > > @@ -4690,6 +4689,8 @@ int main(int argc, char **argv, char **envp)
> > >      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
> > >      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
> > > =20
> > > +    monitor_init_globals();
> >=20
> > Why did you move monitor_init_qmp_commands() down here?
> >=20
> > There are many function calls between the old position and the new
> > position.  Did you check all of them to make sure they don't touch the
> > monitor which is now totally uninitialized?
>=20
> Yeh, this patch is a bit hairy, but I really think we should do it.
> Because there are too many places (as you have seen) that we inited
> monitor stuff in different places.

But why did you move it down here?  Can you replace the
monitor_init_qmp_commands() call instead?

Stefan

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM8RPAAoJEJykq7OBq3PIfHwH/RaGdKFYgb/PEZukFeZlRSp6
pVUzfg7HZw8Od6hCgSBTiEb8NijUqJH61o/vFFXMWE3dZlAQozwIs0+YjzpUTGyp
e+1ihRizBRC56BQFbmOxlbC/s1BNVbvi19t1Dqg/c4a1W0ZzTQv9dSvI+jpx45qn
rR1H4zp80c8hVpPWkKD9aJbIZxrkbZkl7kWqL8JlbpIZ9Qnw34XXbE6rM2VCcrev
uWh3FL2o7UGlcgo/eRK0PxS1F/cwI+ImEHOECUYfmtax9JwQ1qAL+L+WLNtRhcrb
dK+HCplxYwISkBIF0UxdaNteadFUtb8anN4KtoJ80MbfYStByqbjl9ZJaigHvsc=
=jpwA
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
