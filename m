Received: from eggs.gnu.org ([209.51.188.92]:44487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2C9I-0005rV-Hm
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2C9H-0001UQ-Nh
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:50:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1h2C9H-0001Tc-Dd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:50:39 -0500
Date: Fri, 8 Mar 2019 09:50:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190308095036.GC12318@stefanha-x1.localdomain>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John G Johnson <john.g.johnson@oracle.com>
Cc: =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, sstabellini@kernel.org, Jag Raman <jag.raman@oracle.com>, konrad.wilk@oracle.com, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 03:29:41PM -0800, John G Johnson wrote:
> > On Mar 7, 2019, at 11:27 AM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> > On Thu, Mar 07, 2019 at 02:51:20PM +0000, Daniel P. Berrang=E9 wrote:
> >> On Thu, Mar 07, 2019 at 02:26:09PM +0000, Stefan Hajnoczi wrote:
> >>> On Wed, Mar 06, 2019 at 11:22:53PM -0800, elena.ufimtseva@oracle.com =
wrote:
> >>>> diff --git a/docs/devel/qemu-multiprocess.txt b/docs/devel/qemu-mult=
iprocess.txt
> >>>> new file mode 100644
> >>>> index 0000000..e29c6c8
> >>>> --- /dev/null
> >>>> +++ b/docs/devel/qemu-multiprocess.txt
> >>>=20
> >>> Thanks for this document and the interesting work that you are doing.
> >>> I'd like to discuss the security advantages gained by disaggregating
> >>> QEMU in more detail.
> >>>=20
> >>> The security model for VMs managed by libvirt (most production x86, p=
pc,
> >>> s390 guests) is that the QEMU process is untrusted and only has access
> >>> to resources belonging to the guest.  SELinux is used to restrict the
> >>> process from accessing other files, processes, etc on the host.
> >>=20
> >> NB it doesn't have to be SELinux. Libvirt also supports AppArmor and
> >> can even do isolation with traditional DAC by putting each QEMU under
> >> a distinct UID/GID and having libvirtd set ownership on resources each
> >> VM is permitted to use.
> >>=20
> >>> QEMU does not hold privileged resources that must be kept away from t=
he
> >>> guest.  An escaped guest can access its image file, tap file descript=
or,
> >>> etc but they are the same resources it could already access via device
> >>> emulation.
> >>>=20
> >>> Can you give specific examples of how disaggregation improves securit=
y?
> >=20
> > Elena & collaborators: Dan has posted some ideas but please share yours
> > so the security benefits of this patch series can be better understood.
> >=20
>=20
> 	Dan covered the main point.  The security regime we use (selinux)
> constrains the actions of processes on objects, so having multiple proces=
ses
> allows us to apply more fine-grained policies.

Please share the SELinux policy files, containerization scripts, etc.
There is probably a home for them in qemu.git, libvirt.git, or elsewhere
upstream.

We need to find a way to make the sandboxing improvements available to
users besides yourself and easily reusable for developers who wish to
convert additional device models.

Thanks,
Stefan

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgjrsAAoJEJykq7OBq3PIEAoH/1puIYXQfuACGIzmU+DFyu9w
2sb+QlDwF0UQPhV5PQGO2pYQTDir+92pEetAg+aXPyD6fWbpGKIzclb5K1TptuX7
XbyHHhG39PlmrTQ+GQPqtOt0ss4Mm+GeI6inGOxxTlOT0FU9kV0HyENvAsTiY3pG
3GcFdCsMVE6L468cE9wm/zhFWmRHP2uyCtfauZTIICcstrCa1X00oHN0nX5Qu4CE
8NHQ/4j1S7BnXwjpr05H40GbyjYCAycSPAPfcTcRuAPtHiWT7Iu/v6WbsM8hsFvp
oKOl9M+lR5tuzF2gW3d8wr8ZXgGwPMBepvrnRSvdtv5ApXWzjt31LzmpJCNfAUQ=
=B2t/
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
