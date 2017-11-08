Received: from eggs.gnu.org ([2001:4830:134:3::10]:55926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRqn-0000sz-I5
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRqh-0003X7-NY
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:01:09 -0500
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<ad7c1de551fbc497743e4dd60335a75cb5365a15.1508390588.git.alistair.francis@xilinx.com>
	<87efpmccvu.fsf@secure.laptop> <87bmke4cu9.fsf@dusky.pond.sub.org>
	<51d103e9-8d6b-8c83-dd69-effe997d4813@redhat.com>
	<87shdptdf0.fsf@dusky.pond.sub.org>
	<CAKmqyKOhnGrbZ6tnaXgBNzdJ=LdnD9NWuWVV-LHmM3zea8OBvA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <308c6070-e9b8-f40d-2389-96497dbe238d@redhat.com>
Date: Wed, 8 Nov 2017 09:00:23 -0600
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOhnGrbZ6tnaXgBNzdJ=LdnD9NWuWVV-LHmM3zea8OBvA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kF2Ne2kcFoSMjrqnDiSc2XfQb1w9bXXj2"
Subject: Re: [Qemu-devel] [PATCH v3 01/46] Replace all occurances of
 __FUNCTION__ with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Alistair Francis <alistair.francis@xilinx.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kF2Ne2kcFoSMjrqnDiSc2XfQb1w9bXXj2
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair23@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Alistair Francis <alistair.francis@xilinx.com>, John Snow
 <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <308c6070-e9b8-f40d-2389-96497dbe238d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/46] Replace all occurances of
 __FUNCTION__ with __func__
References: <cover.1508390588.git.alistair.francis@xilinx.com>
 <ad7c1de551fbc497743e4dd60335a75cb5365a15.1508390588.git.alistair.francis@xilinx.com>
 <87efpmccvu.fsf@secure.laptop> <87bmke4cu9.fsf@dusky.pond.sub.org>
 <51d103e9-8d6b-8c83-dd69-effe997d4813@redhat.com>
 <87shdptdf0.fsf@dusky.pond.sub.org>
 <CAKmqyKOhnGrbZ6tnaXgBNzdJ=LdnD9NWuWVV-LHmM3zea8OBvA@mail.gmail.com>
In-Reply-To: <CAKmqyKOhnGrbZ6tnaXgBNzdJ=LdnD9NWuWVV-LHmM3zea8OBvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 08:51 AM, Alistair Francis wrote:

>>>> Let me rephrase the question: do we really support compilers that do=
n't
>>>> understand __func__?  The presence of numerous unconditional uses of=

>>>> __func__ in the tree means the answer is no.  Let's replace AUDIO_FU=
NC
>>>> by plain __func__.
>>>
>>> Answered elsewhere in patch 3/46 (where we DO replace AUDIO_FUNC by
>>> __func__).
>>
>> I see.
>>
>> Put 03/46 first, so we don't have to mess with AUDIO_FUNC twice?
>=20
> I would really like to avoid that, as the conflicts will be a bit of a
> mess. The way I see it there will be a lot of churn no matter what,
> so we don't gain much by swapping the order around.
>=20
> I have a new series ready to send today, so I'm going to send that
> through as I would like at least some of these patches to make it in
> 2.11. After that if you think strongly the order should be changed I
> can change it in the next version.

I think the reorder is not that hard.  Put 3/46 first (changing
AUDIO_FUNC to __func__), and then 1/46 doesn't have to touch any of the
files that used to use AUDIO_FUNC, because there is no intermediate
state using __FUNCTION__.

If I'm reading it correctly, the rebase conflict is limited to a slight
rewording of the commit message for 3/46, and one line in 1/46 to the
definition of AUDIO_FUNC (that will no longer be present).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kF2Ne2kcFoSMjrqnDiSc2XfQb1w9bXXj2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDHAcACgkQp6FrSiUn
Q2r23Qf+KWVL6ncuGiLwyij++5Xtg++Irybomd+ICJpYrF5KdV2xX2jl5EZW800/
aeseimOISxuXGTt14SnjzWC2FinRpD/X6ABjyp49CpjlT6ueglDRSXcHPS1CbJ2y
RFjZIN1TFAAk9vI1nafOKYKQhHxiKQ/qFYCF2XNuJmDEZwE2Bf+V5qp20MqejKIQ
0GM/PY3tAX1l921g+L+HrFUVTceyOXdCJCiy4zgzvc3nXfFv2EH2MvLuGj+XfffI
9vcTohI0eyocQb1zbcnpF6oU7kJPEcWV9B5xwhqkb53rjv7Isb9TKf4972doSDdM
vkCJbjm3IMRf5E7B3WwRSStCs8r26g==
=KiGA
-----END PGP SIGNATURE-----

--kF2Ne2kcFoSMjrqnDiSc2XfQb1w9bXXj2--
