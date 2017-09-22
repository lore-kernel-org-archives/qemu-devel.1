Received: from eggs.gnu.org ([2001:4830:134:3::10]:49927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvKxe-0002Ww-R6
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvKxc-00022N-Qq
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:13:30 -0400
Date: Fri, 22 Sep 2017 20:09:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922100934.GF4998@umbus.fritz.box>
References: <20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a59b2c71-fe1d-1ef6-e885-703c3f33893c@kaod.org>
	<20170921094226.0e4c4ac6@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <20170921094226.0e4c4ac6@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 09:42:26AM +0200, Igor Mammedov wrote:
> On Thu, 21 Sep 2017 08:04:55 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 09/21/2017 05:54 AM, Nikunj A Dadhania wrote:
> > > David Gibson <david@gibson.dropbear.id.au> writes:
> > >  =20
> > >> On Wed, Sep 20, 2017 at 12:48:55PM +0530, Nikunj A Dadhania wrote: =
=20
> > >>> David Gibson <david@gibson.dropbear.id.au> writes:
> > >>> =20
> > >>>> On Wed, Sep 20, 2017 at 12:10:48PM +0530, Nikunj A Dadhania wrote:=
 =20
> > >>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> > >>>>> =20
> > >>>>>> On Wed, Sep 20, 2017 at 10:43:19AM +0530, Nikunj A Dadhania wrot=
e: =20
> > >>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> > >>>>>>> =20
> > >>>>>>>> On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wr=
ote: =20
> > >>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> > >>>>>>>>> =20
> > >>>>>>>>>> On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania =
wrote: =20
> > >>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> > >>>>>>>>>>> =20
> > >>>>>>>>>>>> On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhani=
a wrote: =20
> > >>>>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> > >>>>>>>>>>>>> =20
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> I thought, I am doing the same here for PowerNV, number=
 of online cores
> > >>>>>>>>>>>>>>> is equal to initial online vcpus / threads per core
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>    int boot_cores_nr =3D smp_cpus / smp_threads;
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> Only difference that I see in PowerNV is that we have m=
ultiple chips
> > >>>>>>>>>>>>>>> (max 2, at the moment)
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>         cores_per_chip =3D smp_cpus / (smp_threads * pn=
v->num_chips); =20
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> This doesn't make sense to me.  Cores per chip should *a=
lways* equal
> > >>>>>>>>>>>>>> smp_cores, you shouldn't need another calculation for it.
> > >>>>>>>>>>>>>> =20
> > >>>>>>>>>>>>>>> And in case user has provided sane smp_cores, we use it=
=2E =20
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> If smp_cores isn't sane, you should simply reject it, no=
t try to fix
> > >>>>>>>>>>>>>> it.  That's just asking for confusion. =20
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> This is the case where the user does not provide a topolo=
gy(which is a
> > >>>>>>>>>>>>> valid scenario), not sure we should reject it. So qemu de=
faults
> > >>>>>>>>>>>>> smp_cores/smt_threads to 1. I think it makes sense to ove=
r-ride. =20
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> If you can find a way to override it by altering smp_cores=
 when it's
> > >>>>>>>>>>>> not explicitly specified, then ok. =20
> > >>>>>>>>>>>
> > >>>>>>>>>>> Should I change the global smp_cores here as well ? =20
> > >>>>>>>>>>
> > >>>>>>>>>> I'm pretty uneasy with that option. =20
> > >>>>>>>>>
> > >>>>>>>>> Me too.
> > >>>>>>>>> =20
> > >>>>>>>>>> It would take a fair bit of checking to ensure that changing=
 smp_cores
> > >>>>>>>>>> is safe here. An easier to verify option would be to make th=
e generic
> > >>>>>>>>>> logic which splits up an unspecified -smp N into cores and s=
ockets
> > >>>>>>>>>> more flexible, possibly based on machine options for max val=
ues.
> > >>>>>>>>>>
> > >>>>>>>>>> That might still be more trouble than its worth. =20
> > >>>>>>>>>
> > >>>>>>>>> I think the current approach is the simplest and less intrusi=
ve, as we
> > >>>>>>>>> are handling a case where user has not bothered to provide a =
detailed
> > >>>>>>>>> topology, the best we can do is create single threaded cores =
equal to
> > >>>>>>>>> number of cores. =20
> > >>>>>>>>
> > >>>>>>>> No, sorry.  Having smp_cores not correspond to the number of c=
ores per
> > >>>>>>>> chip in all cases is just not ok.  Add an error message if the
> > >>>>>>>> topology isn't workable for powernv by all means.  But users h=
aving to
> > >>>>>>>> use a longer command line is better than breaking basic assump=
tions
> > >>>>>>>> about what numbers reflect what topology. =20
> > >>>>>>>
> > >>>>>>> Sorry to ask again, as I am still not convinced, we do similar
> > >>>>>>> adjustment in spapr where the user did not provide the number o=
f cores,
> > >>>>>>> but qemu assumes them as single threaded cores and created
> > >>>>>>> cores(boot_cores_nr) that were not same as smp_cores ? =20
> > >>>>>>
> > >>>>>> What?  boot_cores_nr has absolutely nothing to do with adjusting=
 the
> > >>>>>> topology, and it certainly doesn't assume they're single threade=
d. =20
> > >>>>>
> > >>>>> When we start a TCG guest and user provides following commandline=
, e.g.
> > >>>>> "-smp 4", smt_threads is set to 1 by default in vl.c. So the gues=
t boots
> > >>>>> with 4 cores, each having 1 thread. =20
> > >>>>
> > >>>> Ok.. and what's the problem with that behaviour on powernv? =20
> > >>>
> > >>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has t=
he
> > >>> default value of 1 in vl.c. In powernv, we were setting nr-cores li=
ke
> > >>> this:
> > >>>
> > >>>         object_property_set_int(chip, smp_cores, "nr-cores", &error=
_fatal);
> > >>>
> > >>> Even when there were multiple cpus (-smp 4), when the guest boots u=
p, we
> > >>> just get one core (i.e. smp_cores was 1) with single thread(smp_thr=
eads
> > >>> was 1), which is wrong as per the command-line that was provided. =
=20
> > >>
> > >> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
> > >> thread.  If you can't supply 4 sockets you should error, but you
> > >> shouldn't go and change the number of cores per socket. =20
> > >=20
> > > OK, that makes sense now. And I do see that smp_cpus is 4 in the above
> > > case. Now looking more into it, i see that powernv has something call=
ed
> > > "num_chips", isnt this same as sockets ? Do we need num_chips separat=
ely? =20
> >=20
> > yes that would do for cpus, but how do we retrieve the number of=20
> > sockets ? I don't see a smp_sockets.=20
> I'd suggest to rewrite QEMU again :)
>=20
> more exactly, -smp parsing is global and sometimes doesn't suite
> target device model/machine.
> Idea was to make it's options machine properties to get rid of globals
> and then let leaf machine redefine parsing behaviour.
> here is Drew's take on it:
>=20
> [Qemu-devel] [PATCH RFC 00/16] Rework SMP parameters
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg376961.html
>=20
> considering there weren't pressing need, the series has been pushed
> to the end of TODO list. Maybe you can revive it and make work for
> pnv and other machines.

Right, making the core smp parsing more flexible might be good.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE4V4ACgkQbDjKyiDZ
s5KRBw//Va5kbRM5RkI5Ci9Xve6+cCZq4xZoN1wH5+ASUxGs6NoxwM+NVLedWHNY
uvU0jDe4PhixuA6rThnz/jivbwQM33pJdkjsXGmcoW3eAWv5RV+aEEp75lspKewJ
qE4J8MoAbYXt3b+/gkgUn0ugMnoXQIPLSQYYPGsrXpCOxrb36ydwlxB0evtISKhF
yPEvHNDYE+e9csfqPWcgO2oPSI4em+U/0/Yp+kWbFuqKrevsKTGmVQye+eOcNt8i
zflb2keXVX58hPnWINxICu0XJ9eQ8n54GoQJY2fct6wgxJzf2Pe6AG12MZdso+a1
BuABVaLSFkKevPEhsvJBbwzXGltrIEsNeO0wB9a1VSh8hyB2Gam248ct/iSRLODe
MHO2XKPL4RGN5y/JH/C4Xi4kG+Yj/c/xs3NySQbWo0H8i0IpyoXc3q+yMZ6hc8jj
mQiszwOnAsgnitMgbOEl5dSgOmea6lhOaMIxvmGJs1ORhKGZRXs/9A8xBSJMk/6O
NuV+kdJO5DkwdgH0RlN5+xdrG4CDCjTnj4dM7WQ+KFWme90nyI62mJip7s+TT/Ft
wm2yZ/wj5QNU73N2t0lFpmL32aZy5pee7wxIVrCGf2c/VFdvjQXMIZlhuLdmGvBI
qXz3Um3zxqggZz9nvt2gtZl6/M/hg+fAXK55Gt0JC2Ykjf4LOY0=
=1vnR
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
