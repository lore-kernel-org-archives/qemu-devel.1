Received: from eggs.gnu.org ([2001:4830:134:3::10]:58756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZqI-0002zV-2R
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZqG-00053H-Rp
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:55:18 -0400
References: <20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606121624.GD2661@work-vm>
	<2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
	<20180606140233.GF2660@work-vm>
	<66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
	<20180606144140.GH2660@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cea4f615-c768-7a2f-3849-5dd00c37b537@redhat.com>
Date: Wed, 6 Jun 2018 16:55:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180606144140.GH2660@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e9EtiaIvp6GHycqX7x9qLQZAwJkwbBm8Y"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e9EtiaIvp6GHycqX7x9qLQZAwJkwbBm8Y
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Message-ID: <cea4f615-c768-7a2f-3849-5dd00c37b537@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606113720.GA2661@work-vm>
 <2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
 <20180606121624.GD2661@work-vm>
 <2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
 <20180606140233.GF2660@work-vm>
 <66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
 <20180606144140.GH2660@work-vm>
In-Reply-To: <20180606144140.GH2660@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 16:41, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:

[...]

>> So why is it so dangerous to connect a disk you just downloaded to e.g=
=2E
>> the wrong machine type?  I assumed it just wouldn't work and you'd try=

>> again, until you realized that maybe you should read the download
>> description and do as it says ("download this config file, pass it").
>=20
> That's bad!  Stuff should just-work;

That's how it always should be.  Life's tough, though.

>                                      it currently just works,

Due to sheer blind luck, I'd say.

>                                                               things
> should get better and easier for our users.

Users using a whole VM stack plus management, but then handling two
files instead of one is too much to ask?

>                                              And anyway, not working fo=
r
> EFI for exmaple can be just a blank screen.  Seriously - keep it easy
> for the user!

Thinking this through makes you end up with appliances.

> And with 'pc' type VMs being all that's around it does just-work.
>=20

[...]

>>>>>> [1] Yes, I concede that there are probably no other users of qcow2=
=2E  But
>>>>>> please forgive me for assuming that qcow2 was in a sense designed =
to be
>>>>>> a rather general image format that not only qemu could use.
>>>>>
>>>>> What makes it QEMU specific?  It's basically just the same key/valu=
e
>>>>> setup as OVA, except putting them inside the qcow2.
>>>>
>>>> Well, not necessarily qemu-specific, but
>>>> ${management_software}-specific, which comes down to the same.  Or,
>>>> well, I'd think that, but hold on.
>>>>
>>>>> We could use the same keys/value definitions as OVA in the blob,
>>>>> although their definitions aren't very portable either.
>>>>
>>>> So you're proposing that we only add options that seem portable for =
any VM?
>>>
>>> Hmm.  We should probably split them, so there should be general optio=
ns
>>> (e.g. minimum-ram) but also hypervisor specifics
>>> (qemu.machine-class=3Dq35); but that doesn't mean you can't add keys
>>> for multiple hypervisors into the one blob.  I mean
>>> something like:
>>>     minimum-ram =3D 1G
>>>     qemu.machine-class =3D q35
>>>     anothervm.machine-class =3D ....
>>
>> Well, and that's my issue.  Once you have application-specific info, y=
ou
>> can go wild.  And I would go wild, without a reasonable and strict
>> requirement that the information we want to store has to fulfill.
>>
>> For the record, I would've liked it if you'd said "only portable
>> options".  But I would have replied that I would fear we'd still end u=
p
>> with someone saying "I'd like to store X and Y, let's just put them in=
to
>> the specification, then they are portable [even if only this stack
>> supports them]" and we wouldn't really have won anything.
>=20
> I couldn't second guess every other hypervisor on the planet to know
> whether specifying a machine class would work for them.

If they support the config format...

Max


--e9EtiaIvp6GHycqX7x9qLQZAwJkwbBm8Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsX9cwACgkQ9AfbAGHV
z0CP/Af6Az9Rkw3eovRd9HRFLA8xcNp4l39wkUaX2TtOKiAhwPYXJ8hufzqor4/0
OX/gQ1yvIr1yQ/wbJVeXy2hsICeM0oeYJflhnY8th2NZ7m/l9rsG4RB336EuP7Yh
mu9IjAXIOMUu2cwQ9RK9cxSbLzgHlo/vwXPPj+5362a6W1TzPkKL1NIAicA3BeRu
av4tmWSHtEEiKkAzmVtqGp0ECj3285S+2IYIMTG16kxRxF9DMItTWURmC1353gY9
9dWXrilOefxu1cRw6ixoh8wBv4DpX1XdVdAWd6lfpfgOMyxifSwDVTptNqipFt0h
kDRH6ZyoYExMKb1fpgDahe3RzYAjNw==
=O3ie
-----END PGP SIGNATURE-----

--e9EtiaIvp6GHycqX7x9qLQZAwJkwbBm8Y--
