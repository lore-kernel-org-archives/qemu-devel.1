Received: from eggs.gnu.org ([2001:4830:134:3::10]:49921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvKxe-0002Wv-HB
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvKxc-00022U-Tb
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:13:30 -0400
Date: Fri, 22 Sep 2017 20:08:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922100858.GE4998@umbus.fritz.box>
References: <871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a59b2c71-fe1d-1ef6-e885-703c3f33893c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <a59b2c71-fe1d-1ef6-e885-703c3f33893c@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 08:04:55AM +0200, C=E9dric Le Goater wrote:
> On 09/21/2017 05:54 AM, Nikunj A Dadhania wrote:
> > David Gibson <david@gibson.dropbear.id.au> writes:
> >=20
> >> On Wed, Sep 20, 2017 at 12:48:55PM +0530, Nikunj A Dadhania wrote:
> >>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>
> >>>> On Wed, Sep 20, 2017 at 12:10:48PM +0530, Nikunj A Dadhania wrote:
> >>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>>
> >>>>>> On Wed, Sep 20, 2017 at 10:43:19AM +0530, Nikunj A Dadhania wrote:
> >>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>>>>
> >>>>>>>> On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wrot=
e:
> >>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>>>>>>
> >>>>>>>>>> On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania wr=
ote:
> >>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>>>>>>>>
> >>>>>>>>>>>> On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania =
wrote:
> >>>>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I thought, I am doing the same here for PowerNV, number o=
f online cores
> >>>>>>>>>>>>>>> is equal to initial online vcpus / threads per core
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>    int boot_cores_nr =3D smp_cpus / smp_threads;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Only difference that I see in PowerNV is that we have mul=
tiple chips
> >>>>>>>>>>>>>>> (max 2, at the moment)
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>         cores_per_chip =3D smp_cpus / (smp_threads * pnv-=
>num_chips);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> This doesn't make sense to me.  Cores per chip should *alw=
ays* equal
> >>>>>>>>>>>>>> smp_cores, you shouldn't need another calculation for it.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> And in case user has provided sane smp_cores, we use it.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> If smp_cores isn't sane, you should simply reject it, not =
try to fix
> >>>>>>>>>>>>>> it.  That's just asking for confusion.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> This is the case where the user does not provide a topology=
(which is a
> >>>>>>>>>>>>> valid scenario), not sure we should reject it. So qemu defa=
ults
> >>>>>>>>>>>>> smp_cores/smt_threads to 1. I think it makes sense to over-=
ride.
> >>>>>>>>>>>>
> >>>>>>>>>>>> If you can find a way to override it by altering smp_cores w=
hen it's
> >>>>>>>>>>>> not explicitly specified, then ok.
> >>>>>>>>>>>
> >>>>>>>>>>> Should I change the global smp_cores here as well ?
> >>>>>>>>>>
> >>>>>>>>>> I'm pretty uneasy with that option.
> >>>>>>>>>
> >>>>>>>>> Me too.
> >>>>>>>>>
> >>>>>>>>>> It would take a fair bit of checking to ensure that changing s=
mp_cores
> >>>>>>>>>> is safe here. An easier to verify option would be to make the =
generic
> >>>>>>>>>> logic which splits up an unspecified -smp N into cores and soc=
kets
> >>>>>>>>>> more flexible, possibly based on machine options for max value=
s.
> >>>>>>>>>>
> >>>>>>>>>> That might still be more trouble than its worth.
> >>>>>>>>>
> >>>>>>>>> I think the current approach is the simplest and less intrusive=
, as we
> >>>>>>>>> are handling a case where user has not bothered to provide a de=
tailed
> >>>>>>>>> topology, the best we can do is create single threaded cores eq=
ual to
> >>>>>>>>> number of cores.
> >>>>>>>>
> >>>>>>>> No, sorry.  Having smp_cores not correspond to the number of cor=
es per
> >>>>>>>> chip in all cases is just not ok.  Add an error message if the
> >>>>>>>> topology isn't workable for powernv by all means.  But users hav=
ing to
> >>>>>>>> use a longer command line is better than breaking basic assumpti=
ons
> >>>>>>>> about what numbers reflect what topology.
> >>>>>>>
> >>>>>>> Sorry to ask again, as I am still not convinced, we do similar
> >>>>>>> adjustment in spapr where the user did not provide the number of =
cores,
> >>>>>>> but qemu assumes them as single threaded cores and created
> >>>>>>> cores(boot_cores_nr) that were not same as smp_cores ?
> >>>>>>
> >>>>>> What?  boot_cores_nr has absolutely nothing to do with adjusting t=
he
> >>>>>> topology, and it certainly doesn't assume they're single threaded.
> >>>>>
> >>>>> When we start a TCG guest and user provides following commandline, =
e.g.
> >>>>> "-smp 4", smt_threads is set to 1 by default in vl.c. So the guest =
boots
> >>>>> with 4 cores, each having 1 thread.
> >>>>
> >>>> Ok.. and what's the problem with that behaviour on powernv?
> >>>
> >>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has the
> >>> default value of 1 in vl.c. In powernv, we were setting nr-cores like
> >>> this:
> >>>
> >>>         object_property_set_int(chip, smp_cores, "nr-cores", &error_f=
atal);
> >>>
> >>> Even when there were multiple cpus (-smp 4), when the guest boots up,=
 we
> >>> just get one core (i.e. smp_cores was 1) with single thread(smp_threa=
ds
> >>> was 1), which is wrong as per the command-line that was provided.
> >>
> >> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
> >> thread.  If you can't supply 4 sockets you should error, but you
> >> shouldn't go and change the number of cores per socket.
> >=20
> > OK, that makes sense now. And I do see that smp_cpus is 4 in the above
> > case. Now looking more into it, i see that powernv has something called
> > "num_chips", isnt this same as sockets ? Do we need num_chips separatel=
y?
>=20
> yes that would do for cpus, but how do we retrieve the number of=20
> sockets ? I don't see a smp_sockets.=20

	# sockets =3D smp_cpus / smp_threads / smp_cores

Or, if you want the maximum possible number of sockets (for a fully
populated system)
	# sockets =3D max_cpus / smp_threads / smp_cores
=09

> If we start looking at such issues, we should also take into account=20
> memory distribution :
>=20
>       -numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]
>=20
> would allow us to define a set of cpus per node, cpus should be evenly=20
> distributed on the nodes though, and also define memory per node, but=20
> some nodes could be without memory.

I don't really see what that has to do with anything.  We already have
ways to assign memory or cpus to specific nodes if we want.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE4TgACgkQbDjKyiDZ
s5KvnxAAyOBAj/+tolBPc3yLMn51kngEf3AUPxG5Apgm7cPOcu7TfsGwaa5wtOqz
ugC3t+FC1PR9pZuB4vaST/bUH1R8CntxVKayN6Z/e224JqP5bRFAPoeqET5Frh71
6RhpL+bjFI3Gr7L5+ZDJZP+enCBuFoDEMZPIp9Y3PmDN7xfacyOAx+25C1H18DYY
u+JSlLwb64eLP96JzHgPeiSr4w/tspxRsdt6myT98Xb+5cj+hO6AmFdm16rCxb15
thHZrjmg4oLj6kOvxlfw31QwLkL1jXx0JZ9W3v6Iqlei5CP9Lu3Wex6N+kBJYDsP
RKf2EyhgP1odrti5JP7obhP79WykFjJrOiTQU6CXenH/2N4bsTB0Dvflgw/FeG5a
V5NEahtpC8RFGvYZ9qirKQje5/bC2HZIPwf87j9T8LowVNl2uTEXvpLgYpqzu8bN
Z2O9pbJgaaxXeSnE60h8Pa1mDBeVJy6WCLeztx4fEEk3K+j9laXexYuHmJwgU/I7
0GCyo7WiuGWEqkQP8b0CtT5BHSPYT3Df5QhBJwZ+J7Dl8hAfzZ540OlN9YMI7NKe
/gMHul4cHhY7YoMjr3YPBeP+3DSi81buozmWNg/Ihvd1ywjbAVW+cpgsjoWDWpCw
he67gLCWcOrDY9AkNooYnJrzoyMbjiwZ48vxFYp1Eml/280dgZ4=
=iZkR
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
