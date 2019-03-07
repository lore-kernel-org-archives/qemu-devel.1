Received: from eggs.gnu.org ([209.51.188.92]:58040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1wPL-0003gO-VW
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1wPE-0002p7-A6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:02:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1wPC-0002lh-9L
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:02:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E8E3369BC
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 17:02:01 +0000 (UTC)
References: <20190227110812.2185-1-quintela@redhat.com>
	<20190227110812.2185-4-quintela@redhat.com>
	<20190306152812.GF2727@work-vm> <87o96m3m2o.fsf@trasno.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <839c6477-995d-477c-43f5-cde9761233c8@redhat.com>
Date: Thu, 7 Mar 2019 11:01:58 -0600
MIME-Version: 1.0
In-Reply-To: <87o96m3m2o.fsf@trasno.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g3pEbn3J9PhtTLO8vThH3kckyzQSwySzb"
Subject: Re: [Qemu-devel] [PATCH v3 3/8] multifd: Create new
 next_packet_size field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g3pEbn3J9PhtTLO8vThH3kckyzQSwySzb
From: Eric Blake <eblake@redhat.com>
To: quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Message-ID: <839c6477-995d-477c-43f5-cde9761233c8@redhat.com>
Subject: Re: [PATCH v3 3/8] multifd: Create new next_packet_size field
References: <20190227110812.2185-1-quintela@redhat.com>
 <20190227110812.2185-4-quintela@redhat.com> <20190306152812.GF2727@work-vm>
 <87o96m3m2o.fsf@trasno.org>
In-Reply-To: <87o96m3m2o.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 6:28 AM, Juan Quintela wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> * Juan Quintela (quintela@redhat.com) wrote:
>>> We need to send this field when we add compression support.  As we ar=
e
>>> still on x- stage, we can do this kind of changes.
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>
>> OK, so that kind of makes sense - in that what you want to do is read
>> the whole compressed chunk in one go.
>>
>> Consider it might be a good idea to add some spare entries here;
>> say a uint64_t dummy[4] so that if you need any more fields in the
>> future it'll be easy to add them without breaking compatibility.
>=20
> We have a version field, so ... we can handle it relatively gratiously,=

> but I see your point.
>=20
> How many?

What is the current struct size? Is there a nice power-of-2 or
cache-line-size multiple to round it out to?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--g3pEbn3J9PhtTLO8vThH3kckyzQSwySzb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBTocACgkQp6FrSiUn
Q2p/mAf/cd/o4Vl6+D965MX/61Sln//xTxZwzkXhDF3da7AKHU4LLlXHO+GoBUyZ
nAYt6SjPbPuQROdNMQtp4/0aiYOFv8q1rB2lkmXETCARx23lDrX4z1b+CzYA/IFR
1+RwxwASEgp0bXK7mioqBsMgDAjjCHOAOIp52IREDzYFxdeiAuPHlaV4KLZLQTdc
CYMK5F2NJFITcAMyGQOAArpGpZMrBzOTutgIyxNRXmKQkeYehZa68uowzvLVgMSe
pYaqds1nTEoj8Kece8132XORKj8kySP28L52JigxHSdzXn9C2gNgH9WmvhymQrOZ
31uUg8hjkHGiMrc+jrrQDUMGjyu6lw==
=GZjQ
-----END PGP SIGNATURE-----

--g3pEbn3J9PhtTLO8vThH3kckyzQSwySzb--
