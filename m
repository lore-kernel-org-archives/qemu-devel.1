Received: from eggs.gnu.org ([209.51.188.92]:49583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghGz3-0005Ox-SN
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghGz1-0007fs-Dy
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:45:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghGyz-0007ea-Hj
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:45:33 -0500
Date: Wed, 9 Jan 2019 17:45:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109164529.GH4867@localhost.localdomain>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<20190109142140.GC4867@localhost.localdomain>
	<095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
	<20190109144818.GE4867@localhost.localdomain>
	<756f6997-cb66-a82b-ae13-babb0e5fa827@redhat.com>
	<20190109151348.GG4867@localhost.localdomain>
	<a6f406c1-6154-bc25-bde3-68e7ff62c527@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <a6f406c1-6154-bc25-bde3-68e7ff62c527@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.01.2019 um 17:27 hat Max Reitz geschrieben:
> On 09.01.19 16:13, Kevin Wolf wrote:
> > Am 09.01.2019 um 15:54 hat Max Reitz geschrieben:
> >> On 09.01.19 15:48, Kevin Wolf wrote:
> >>> Am 09.01.2019 um 15:27 hat Max Reitz geschrieben:
> >>>> On 09.01.19 15:21, Kevin Wolf wrote:
> >>>>> Am 09.01.2019 um 15:10 hat Max Reitz geschrieben:
> >>>>>> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
> >>>>>>> changes in v2:
> >>>>>>> - removed the "RFC" marker;
> >>>>>>> - added a new patch (patch 2) that removes
> >>>>>>> bdrv_snapshot_delete_by_id_or_name from the code;
> >>>>>>> - made changes in patch 1 as suggested by Murilo;
> >>>>>>> - previous patch set link:
> >>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.ht=
ml
> >>>>>>>
> >>>>>>>
> >>>>>>> It is not uncommon to see bugs being opened by testers that attem=
pt to
> >>>>>>> create VM snapshots using HMP. It turns out that "0" and "1" are =
quite
> >>>>>>> common snapshot names and they trigger a lot of bugs. I gave an e=
xample
> >>>>>>> in the commit message of patch 1, but to sum up here: QEMU treats=
 the
> >>>>>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'nam=
e'. It
> >>>>>>> is documented as such, but this can lead to strange situations.
> >>>>>>>
> >>>>>>> Given that it is strange for an API to consider a parameter to be=
 2 fields
> >>>>>>> at the same time, and inadvently treating them as one or the othe=
r, and
> >>>>>>> that removing the ID field is too drastic, my idea here is to kee=
p the
> >>>>>>> ID field for internal control, but do not let the user set it.
> >>>>>>>
> >>>>>>> I guess there's room for discussion about considering this change=
 an API
> >>>>>>> change or not. It doesn't affect users of HMP and it doesn't affe=
ct Libvirt,
> >>>>>>> but simplifying the meaning of the parameters of savevm/loadvm/de=
lvm.
> >>>>>>
> >>>>>> (Yes, very late reply, I'm sorry...)
> >>>>>>
> >>>>>> I do think it affects users of HMP, because right now you can dele=
te
> >>>>>> snapshots with their ID, and after this series you cannot.
> >>>>>
> >>>>> Can there be snapshots that can't be identified by a snapshot name,=
 but
> >>>>> only by their ID?
> >>>>
> >>>> I don't know, but what I meant is that if you have scripts to do all
> >>>> this, you might have to adjust them with this change.
> >>>
> >>> That's what the H in HMP means.
> >>>
> >>>>>> I think we had a short discussion about just disallowing numeric
> >>>>>> snapshot names.  How bad would that be?
> >>>>>
> >>>>> It would be incompatible with existing images and result in a more
> >>>>> complex snapshot identifier resolution. Why would it be any better?
> >>>>
> >>>> It wouldn't be incompatible with existing images if we'd just disall=
ow
> >>>> creating such snapshots.  I don't see how the identifier resolution
> >>>> would be more complex.
> >>>>
> >>>> I don't know if it'd be better.  I'd just find it simpler (for us, t=
hat
> >>>> is -- for users, I'm not sure).
> >>>
> >>> Identifier resolution A:
> >>> - Find a snapshot that has the given identifier as a name
> >>> - If no such snapshot exists, it is an error
> >>>
> >>> Identifier resolution B:
> >>> - If the identifier is a number, find a snapshot that has the given
> >>>   identifier as its ID
> >>> - If the identifier is not a number, find a snapshot that has the giv=
en
> >>>   identifier as a name
> >>> - If no such snapshot exists, it is an error
> >>
> >> No, my idea was to keep the resolution the same as it is; just to forb=
id
> >> creating new snapshots with numeric names.  This would prevent users
> >> from getting into the whole situation.
> >=20
> > That's the version with an even more complex resolution method C. :-)
>=20
> How so if the resolution method stays the same?  Because it already is
> too complex?
>=20
> If so, yes, that is an argument.  I was arguing for the simplest patch
> instead of the simplest code, true.

Yes, because it already is too complex. Not even necessarily the code
(even though that's true as well), but most importantly the interface.

> > I actually think the current behaviour is more confusing than helpful.
> > Without looking into the code or trying it out, I couldn't even tell
> > whether ID or name takes precedence if there is a matching snapshot for
> > both. Considering your proposal, it's probably the ID, but how should a
> > user know that? (If against all expectations documentation exists, it
> > doesn't count because nobody reads that.)
>=20
> It isn't more confusing than it is right now.  With my proposal, all
> current images are simply as confusing as they are right now (I think ID
> takes precedence, yes), but if you create new snapshots, it's clear,
> since you simply cannot create names that could be IDs.

I agree. But wasn't the goal of the patch to make it less confusing than
it is right now?

Kevin

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcNiUpAAoJEH8JsnLIjy/W/vUP/115RH+n0aqi7XYVlHuumuDz
kVKlpFMtGEB9aRvLgHZzAMJkCuzid6yAsFcAaTKhv5owGiBGIWSO0ysV1KZyCsZ7
YU4nhev3OAtZygXaoUSQp1bBHyk6Prihymf+VEGWYpPHnva0WoAJFWwWjI4tft3W
cktVZrLdCSMcNPCXT8XB/vce1yW+w0A6iaKJfC+kQR0Kb9z9e7WS5eOBty0IhGLL
+BbDhCNmk+/5Nxn30nYcpBSp0D8lWrRwmAqmJcPRuXkV92KMIRfiLPuyG5wL5ndW
nURee1jJU6WNTahnrCEjDvmqQDlsBMkIvdvx5E6nx2Tp8JywYIBYDBGOCv3ynmBC
xLSFnYAtHf90Ot2i9vxpxm7KKUe/J8uClwbBSCJLz8/jSJHv6iiD/jLUTvRCztuY
uk6402uk5lohBgwDs6O2sbr6EQBUF5cgokb2sVBTgpDg7j69ux3Ah/k7oGLhJDSX
a8ouwLt3ZE34mMgBfRWEtf2jmx3JUBKsOfqtXCxw3GzZKtpmDcr45NczUsfsMgC6
5Z/SsuZAGatLf29prwd45KGnEvxw2zoawxOEvEOgzRHG4up8LA9pBQmRPJLVzby/
Wq5zU4X+QcWdVDuT4g51wW6SpAA6FQmwo6n1uhxVqmbqTM/E92T7RCn/EgsW47jL
t3cQ6sBHcdxe41BzzEoB
=9yem
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
