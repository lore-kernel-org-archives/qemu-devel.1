Received: from eggs.gnu.org ([2001:4830:134:3::10]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtxes-0005bZ-Sc
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtxer-0005uE-Ea
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:08:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dtxer-0005t6-5j
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:08:25 -0400
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
	<20170914185314.GA3280@work-vm>
	<20170915044622.GO3617@pxdev.xzpeter.org>
	<CAJ+F1CKGsYbK5M6WKGSCioFCFY79WjFCtEQGqudiuA-QZTfOCA@mail.gmail.com>
	<20170918083737.GD3617@pxdev.xzpeter.org>
	<CAJ+F1C+ZE2xDVK8Ni7CaVbH6NHEz0-xXh_1gqwF-jf6T0iA16Q@mail.gmail.com>
	<20170918105516.GD2581@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e0abb57-0c5b-50b1-38ea-6b699bc21205@redhat.com>
Date: Mon, 18 Sep 2017 10:08:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170918105516.GD2581@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mRo2qTqWhXD2PdLMnhQuPQDTbpOFLSHxh"
Subject: Re: [Qemu-devel] [RFC 00/15] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mRo2qTqWhXD2PdLMnhQuPQDTbpOFLSHxh
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Michael Roth
 <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <5e0abb57-0c5b-50b1-38ea-6b699bc21205@redhat.com>
Subject: Re: [RFC 00/15] QMP: out-of-band (OOB) execution support
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
 <CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
 <20170914185314.GA3280@work-vm> <20170915044622.GO3617@pxdev.xzpeter.org>
 <CAJ+F1CKGsYbK5M6WKGSCioFCFY79WjFCtEQGqudiuA-QZTfOCA@mail.gmail.com>
 <20170918083737.GD3617@pxdev.xzpeter.org>
 <CAJ+F1C+ZE2xDVK8Ni7CaVbH6NHEz0-xXh_1gqwF-jf6T0iA16Q@mail.gmail.com>
 <20170918105516.GD2581@work-vm>
In-Reply-To: <20170918105516.GD2581@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 05:55 AM, Dr. David Alan Gilbert wrote:

>>> I think we have other quite simple ways to solve the "unexpected
>>> reply" and "per-client-id duplication" issues you have mentioned.
>>>
>>> Firstly, when client gets unexpected replies ("id" field not in its
>>> own request queue), the client should just ignore that reply, which
>>> seems natural to me.

That's probably reasonable, if we document it.

>>
>> The trouble is that it may legitimately use the same "id" value for
>> new requests. And I don't see a simple way to handle that without
>> races.
>=20
> Under what circumstances can it reuse the same ID for new requests?

Libvirt uses distinct id's for every message on a single connection, but
there is always the possibility that it will use id 'libvirt-0' on one
connection, then restart libvirtd, then use id 'libvirt-0' on the second
connection (there's nothing that I saw in libvirt code that saves the
current 'mon->nextSerial' value in XML to survive libvirtd restarts).

> Can't we simply tell it not to?

Since use of OOB handling will require client opt-in, yes, we can make
part of the opt-in process be a contract that the client has to do a
better job of avoiding duplicate id's across reconnects, if we think
that is easier to maintain.

>>>
>>> Then, if client disconnected and reconnected, it should not have the
>>> problem to generate duplicated id for request, since it should know
>>> what requests it has sent already.  A simplest case I can think of is=
,
>>> the ID should contains the following tuple:
>>
>> If you assume the "same" client will recover its state, yes.
>>
>>>
>>>   (client name, client unique ID, request ID)
>>>
>>> Here "client name" can be something like "libvirt", which is the name=

>>> of client application;
>>>
>>> "client unique ID" can be anything generated when client starts, it
>>> identifies a single client session, maybe a UUID.
>>>
>>> "request ID" can be a unsigned integer starts from zero, and increase=
s
>>> each time the client sends one request.
>>
>> This is introducing  session handling, and can be done in server side
>> only without changes in the protocol I believe.

The 'id' field can be _any_ JSON object - libvirt currently sends a
string, but could just as easily send a dict, and then libvirt could
supply whatever it wanted in the dict, including uuids, to ensure that
future reconnects don't reuse the id of a previous connection.  But
right now, 'id' is opaque to qemu (and should stay that way) - if qemu
is going to do any work to ensure that it doesn't send a stale reply to
a new connection, then that has to be tracked externally from whatever
'id' is passed in; or we just document that clients wanting to use OOB
handling have to be careful of their choice of 'id' (and leave it up to
the client to avoid confusion, because qemu doesn't care about it).

I'm also fine with requiring that clients that opt-in to OOB handling be
documented as having to ignore unknown 'id' responses, since we already
document that clients must be able to ignore unknown 'event' messages.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mRo2qTqWhXD2PdLMnhQuPQDTbpOFLSHxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/4WMACgkQp6FrSiUn
Q2qbzwgArAWBDZMXIE3Off/l7N1kATrlOOqHvtGeeUw1XQ9kSI8YVJD4AnZFFmO+
Ie8vcy8mMSIpD/wQhosk+OnetmhH6xcjGoe9t8Gffi70fWwhDs+jhVPJZSVmLbtX
bl6EA42S0xnK53vhhqZ3OP5HZylFcgRQTBhLMxfVNj31Y/EVou1VLSY7GBMB+SEk
ItHdLDj6s7IWXEXJjXG6q9NG8ywbzEliuEq4WAsRkL1kt2+ZJOJRYZipm85MvpN1
szXalBOnot9QfeUlDY/Eic8DMN/tqbummQ0Amdnl84k4xovgTNLDBAZuzMxpRvnw
yWCBwFlaHcsFr8HB98+6Jn7h35TVRw==
=mdDF
-----END PGP SIGNATURE-----

--mRo2qTqWhXD2PdLMnhQuPQDTbpOFLSHxh--
