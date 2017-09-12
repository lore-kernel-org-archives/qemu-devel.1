Received: from eggs.gnu.org ([2001:4830:134:3::10]:46500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drlLk-0000hV-UD
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drlLj-0003x4-Mn
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:35:36 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-32-eblake@redhat.com>
	<1a629362-ebc5-7d28-463c-f6ec4639d29b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2bd66aa2-6052-bf14-4f7d-c30fdcaff07d@redhat.com>
Date: Tue, 12 Sep 2017 08:35:21 -0500
MIME-Version: 1.0
In-Reply-To: <1a629362-ebc5-7d28-463c-f6ec4639d29b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QGK3iQNGj2j9K6FRKd9MssJo4qpEPBgUs"
Subject: Re: [Qemu-devel] [PATCH v7 31/38] libqtest: Merge qtest_clock_*()
 with clock_*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QGK3iQNGj2j9K6FRKd9MssJo4qpEPBgUs
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>,
 "open list:Floppy" <qemu-block@nongnu.org>
Message-ID: <2bd66aa2-6052-bf14-4f7d-c30fdcaff07d@redhat.com>
Subject: Re: [PATCH v7 31/38] libqtest: Merge qtest_clock_*() with clock_*()
References: <20170911172022.4738-1-eblake@redhat.com>
 <20170911172022.4738-32-eblake@redhat.com>
 <1a629362-ebc5-7d28-463c-f6ec4639d29b@redhat.com>
In-Reply-To: <1a629362-ebc5-7d28-463c-f6ec4639d29b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 05:45 AM, Thomas Huth wrote:
> On 11.09.2017 19:20, Eric Blake wrote:
>> Maintaining two layers of libqtest APIs, one that takes an explicit
>> QTestState object, and the other that uses the implicit global_qtest,
>> is annoying.  In the interest of getting rid of global implicit
>> state and having less code to maintain, merge:
>>  qtest_clock_set()
>>  qtest_clock_step()
>>  qtest_clock_step_next()
>> with their short counterparts.  All callers that previously
>> used the short form now make it explicit that they are relying on
>> global_qtest, and later patches can then clean things up to remove
>> the global variable.
>>

>> @@ -446,7 +446,7 @@ int64_t qtest_clock_step(QTestState *s, int64_t st=
ep);
>>   *
>>   * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanosecond=
s.
>>   */
>> -int64_t qtest_clock_set(QTestState *s, int64_t val);
>> +int64_t clock_set(QTestState *s, int64_t val);
>  Could we please keep the "qtest" prefix here and rather get rid of the=

> other ones? Even if it's more to type, I prefer to have a proper prefix=

> here so that it is clear at the first sight that the functions belong t=
o
> the qtest framework.

I suppose we can, although it makes more lines that are likely to bump
up against 80 columns, and thus slightly more churn to reformat things
to keep checkpatch happy.  I like the shorter name, because less typing
is easier to remember.  I'd prefer a second opinion on naming before
doing anything about it though - Markus or Paolo, do you have any
preference?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QGK3iQNGj2j9K6FRKd9MssJo4qpEPBgUs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm34pkACgkQp6FrSiUn
Q2pbqAf+PB+2XfclPnX+va6eBtPtUqsjel7rlfW7emQHUK9ei4nSq4W4rsdj7CTs
/78W9NC3KNO6KTfnHHR6yOJ6wXHGnSGvPJAcBUFx4WQmEX0VvEHrEcXOQnibnERE
KFnoHKWz81DELZNkc9g4cjBbF0DWAp8TsruE+i0bo6GAQcjrUxii4E+lY1zwQEHZ
64j+qpCVvgXil/fFrg80Nmbwjo98dURd5qn6hZ2VSsJuoq8Z305/D8HLZLNg2s9f
n2dkGe5lFhfKUqBlDuiXZQOHWwMEfjiEBpoKMG46VQTwYDmxelNV46ZahJWRP8As
b/PEazN63a8YTfkWUnaN+WqAeW9c+g==
=FslS
-----END PGP SIGNATURE-----

--QGK3iQNGj2j9K6FRKd9MssJo4qpEPBgUs--
