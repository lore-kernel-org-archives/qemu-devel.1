Received: from eggs.gnu.org ([2001:4830:134:3::10]:33593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGox-0003By-MK
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGos-0007Pk-W6
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dlGos-0007P3-N3
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:46:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 700AEC056787
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 15:46:49 +0000 (UTC)
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-3-marcandre.lureau@redhat.com>
	<87bmn78wqs.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3de9c26c-dc18-f7e3-0ae9-cafd8202b52d@redhat.com>
Date: Fri, 25 Aug 2017 10:46:45 -0500
MIME-Version: 1.0
In-Reply-To: <87bmn78wqs.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a7vS0Bk61QEBKtETO6oW8Jde0G7AXGmCh"
Subject: Re: [Qemu-devel] [PATCH v2 02/54] qdict: add qdict_put_null() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a7vS0Bk61QEBKtETO6oW8Jde0G7AXGmCh
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <3de9c26c-dc18-f7e3-0ae9-cafd8202b52d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/54] qdict: add qdict_put_null() helper
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
 <20170822132255.23945-3-marcandre.lureau@redhat.com>
 <87bmn78wqs.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmn78wqs.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/22/2017 10:09 AM, Markus Armbruster wrote:

>    #define qdict_put_bool(qdict, key, value) \
>>          qdict_put(qdict, key, qbool_from_bool(value))
>>  #define qdict_put_str(qdict, key, value) \
>>          qdict_put(qdict, key, qstring_from_str(value))
>> +#define qdict_put_null(qdict, key) \
>> +        qdict_put(qdict, key, qnull())
>> =20
>>  /* High level helpers */
>>  double qdict_get_double(const QDict *qdict, const char *key);
>=20
> Marginal.  I can accept it for completeness's sake, or rather a step
> towards completeness.  But please update the "Helpers for ..." comment,=

> and convert existing qdict_put(QD, K, qnull()) to use qdict_put_null().=

> A quick grep finds some in target/i386/cpu.c.  There might be more.

And we already used Coccinelle to find candidates for qdict_put_bool and
friends, so that should be the reasonable approach to use here as well.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--a7vS0Bk61QEBKtETO6oW8Jde0G7AXGmCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgRmUACgkQp6FrSiUn
Q2qzJgf8DdB/3CzD0Qf7BXNEg7rl9YrFvv68aFy2irgiWXW1n0TXZEgavR0wUuzw
c7AI5ql1C3yFXgvTZZRvPQ+V2T1UV+mEsLNKwZAeke09ucNLso++zBrB7sDdrqUL
Fa6gTk/ngYqrPuuGrchnAOrec2PdDix016x9QYmjTzFhojEfNtqM4T9oIhA3dqle
KJ+GuqtmAfY5heNRFQICPGHDYjf8bHXUDp/0SFHc5uuDHt0Yb5crM5e9folOOFW7
kzFV2QFH/08KQuxIB4cZbi2ONJUSwjGrhP6ge6C4R0OnmbiDw9N9nfuJHYvAZru5
BV9VybW1c/Hg/iumJrqz01qQqW2V8Q==
=X7XR
-----END PGP SIGNATURE-----

--a7vS0Bk61QEBKtETO6oW8Jde0G7AXGmCh--
