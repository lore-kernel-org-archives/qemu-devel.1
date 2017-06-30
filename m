Received: from eggs.gnu.org ([2001:4830:134:3::10]:40160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQxJS-0007XQ-IG
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQxJP-0001mp-Eg
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:54:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQxJP-0001mj-5D
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:54:23 -0400
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-2-pasic@linux.vnet.ibm.com>
	<20170607095127.GB2099@work-vm>
	<8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
	<f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
	<00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
	<2791f136-d531-464c-8c44-7006ff7a658f@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c28ab7f2-4541-4657-0387-b988e8040e3f@redhat.com>
Date: Fri, 30 Jun 2017 09:54:19 -0500
MIME-Version: 1.0
In-Reply-To: <2791f136-d531-464c-8c44-7006ff7a658f@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P1c3gHIvpVLuEwBNkn0mCqRqP98FWDkWX"
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed
 equal checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P1c3gHIvpVLuEwBNkn0mCqRqP98FWDkWX
From: Eric Blake <eblake@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Jason J . Herne" <jjherne@linux.vnet.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Message-ID: <c28ab7f2-4541-4657-0387-b988e8040e3f@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed equal
 checks
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
 <20170606165510.33057-2-pasic@linux.vnet.ibm.com>
 <20170607095127.GB2099@work-vm>
 <8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
 <f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
 <00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
 <2791f136-d531-464c-8c44-7006ff7a658f@linux.vnet.ibm.com>
In-Reply-To: <2791f136-d531-464c-8c44-7006ff7a658f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/30/2017 09:41 AM, Halil Pasic wrote:
>>> 'This' basically boils down to the question and
>>> 'Why aren't hints reported in QMP context?'
>>
>> QMP is supposed to be machine-parseable.  Hints are supposed to be
>> human-readable. If you have a machine managing the monitor, the hint
>> adds nothing but bandwidth consumption, because machine should not be
>> parsing the human portion of the error message in the first place (as =
it
>> is, libvirt already just logs the human-readable portion of a message,=

>> and bases its actions solely on the machine-stable portions of an erro=
r
>> reply: namely, whether an error was sent at all, and occasionally, wha=
t
>> error class was used for that error - there's no guarantee a human wil=
l
>> be reading the log, though).
>=20
>=20
> Seems I've made wrong assumptions about error messages (in QEMU) up unt=
il
> now. If I understand you correctly, in QEMU error messages are part of
> the API (but hints are not). Thus if one changes a typo in an error
> message (like here
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06732.html) th=
e
> one is strictly speaking breaking API backward compatibility.  Is that
> really the way we want to have things?

Quite the opposite. In QMP, the EXISTENCE of an error message is part of
the API, but the CONTENTS of the message are not (machines are not
supposed to further parse the message) - anything that the machine would
want to differentiate between two different possible error messages
should instead be conveyed via a second field in the same returned
dictionary (the error class), and not by parsing the message.  Most
often, there is not a strong case for having differentiation, so most
errors are lumped in the generic class (error_setg() makes this easy to
do by default).  An example where differentiation matters: look at the
"Important Note" in blockdev.c:qmp_block_commit().

>=20
> From prior experiences I'm more used to think about error messages as
> something meant for human consumption, and expressing things expected t=
o
> be relevant for some kind of client code in a different way (optimized
> for machine consumption).
>=20
> If however the error message ain't part of the machine relevant portion=
,
> then the same argument applies as to the 'hint', and I don't see the
> reason for handling hints differently. Do you agree with my
> argumentation?

Indeed, it may not hurt to start passing the hints over the wire (errors
would then consume more bandwidth, but errors are not the hot path).
And I'm not necessarily opposed to that change, so much as trying to
document why it is not currently the case.  At the same time, I probably
won't be the one writing a path to populate the hint information into
the QMP error, as I don't have any reason to use the hint when
controlling libvirt (except maybe for logging, but there, the hint is
not going to help the end user, because it's not the end-user's fault
that libvirt used the API wrong to get a hint in the first place).


>> If something absolutely must be reported, then it is not a hint, and
>> shouldn't be using the hint mechanism.
>>
>=20
> I find it hard to formulate criteria for 'must be reported'. I'm afraid=

> this is backwards logic: since the hint may not be reported everything
> that needs to be reported is not a hint. This is a valid approach of
> course, but then I think some modifications to the comments in error.h
> would not hurt. And maybe something with verbose would be more
> expressive name.
>=20
> I hope all this makes some sense and ain't pure waste of time...

No, it never hurts to question whether the design is optimal, and it's
better to question first to know whether it is even worth patching
things to behave differently, rather than spending time patching it only
to have a maintainer clarify that the patch can't be accepted because of
some design constraint.  So I still hope Markus will chime in.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--P1c3gHIvpVLuEwBNkn0mCqRqP98FWDkWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVmYbAAoJEKeha0olJ0NqkKMH/3ggy6Cvr3BUtVtwH++Wid/9
egAPleIorUmHSMUmnTTgzMTi8WtLn8/QhvYp98PzM4hLOpQ11ZqFRQpnBbJDjm4n
cb/FKvkJEe9BO5XrnzEzEebHkdRVw08PwwBtbkf51tHKicxQ8Y7m4TFtTkDJhG5r
N3Zxmwcc3mUVIu8mYaHNfvZYlbY13yrMgskT3Nllh6oEDm4HNcdtpIKUAZsfeYT9
uBpO6sSqXgo57TpznjDohUS7hGt+jrsMZZM1+7azM19IA8qNVbloUzMgAiG1glv6
ePHLlQnbJghjjteooI8xOehiimjIbbowgmTNqGAoOX2/bQhjekQvU1i/gY2oHMY=
=VIin
-----END PGP SIGNATURE-----

--P1c3gHIvpVLuEwBNkn0mCqRqP98FWDkWX--
