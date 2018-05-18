Received: from eggs.gnu.org ([2001:4830:134:3::10]:57009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fJf6i-00039B-6I
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fJf6d-0001xP-8F
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:07:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fJf6d-0001x3-2u
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:07:35 -0400
Date: Fri, 18 May 2018 15:07:29 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180518130729.GF3416@dnr>
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader> <20180518075212.GE3416@dnr>
	<20180518091916.GA22292@vader>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <20180518091916.GA22292@vader>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: Yi Min Zhao <zyimin@linux.ibm.com>, fiuczy@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 11:19:16AM +0200, Eduardo Otubo wrote:
>On 18/05/2018 - 09:52:12, J=E1n Tomko wrote:
>> On Thu, May 17, 2018 at 02:41:09PM +0200, Eduardo Otubo wrote:
>> > On 15/05/2018 - 19:33:48, Yi Min Zhao wrote:
>> > > If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remai=
ns
>> > > compiled. This would make libvirt set the corresponding capability a=
nd
>> > > then trigger the guest startup fails. So this patch excludes the code
>> > > regarding seccomp staff if CONFIG_SECCOMP is undefined.
>> >
>> > Just a sugestion for the next patch you send: If it's a single patch, =
you don't
>> > need to format it with a cover-letter. Just put all the description in=
 the body,
>> > or if you need to add a text that shouldn't be included in the commit =
message,
>> > just add it after the "---" after Signed-off-by.
>> >
>> > >
>> > > Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> > > ---
>> > >  vl.c | 13 ++++++++-----
>> > >  1 file changed, 8 insertions(+), 5 deletions(-)
>> > >
>>

[...]

>> Current libvirt logic assumes the -sandbox option is always present.
>> (IIRC it was introduced in QEMU 1.1 and when we switched from help
>> scraping to capability probing via QMP for QEMU 1.2, there was no
>> way to detect it)
>>
>> This patch fixes the usage of QEMU new enough for seccomp blacklist
>> (where libvirt enables the sandbox by default),
>> but breaks the usage of QEMU with compiled out sandbox and
>> setting
>>  seccomp_sandbox =3D 0
>> in libvirt's qemu.conf:
>>
>> error: internal error: process exited while connecting to monitor:
>> qemu-git: -sandbox off: There is no option group 'sandbox'
>>
>>
>> But now libvirt requires QEMU >=3D 1.5.0 which already supports
>> query-command-line-options, so if you want the option gone completely
>> --without-seccomp, I can add the code that probes for it and
>> make seccomp_sandbox =3D 0 a no-op if it's compiled out.
>
>This looks like a good solution for the libvirt side. Can you add this sup=
port
>so we can merge this fix?
>

Patches proposed:
https://www.redhat.com/archives/libvir-list/2018-May/msg01430.html

Jano

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlr+0AoACgkQyvpdPXT/
AmlolBAAmvaW7cboBwbQB08IKJ4EsjIX7CXdkXqiihsHqnDCRfpwyMaPHateoff0
zVyn6sUazghXh/QM1qNLAAJtmW6cj9xoAqSiaujOrHATpncxZBERxDBp9jOMCmjF
WRVjoRAmW8JEUm1Sb6tEj+UEPmAhl6zSjuct/fsPFBYp1xT4a7P++OIEmM0v1+cw
6NfhZ8soGBlFagbdZcHIf98mTiX/QJ1y//OT62NnzAh+lpxFLcJdHK1+yU7QUbLH
ofomowruz7LjZCzJnXX44iw0o3F5RM+w3QiBALYV3M9GWy7zS3J/tnXfbY/MGSxz
Y6K9PLFZcfEZiRLO2ztCf2RdDCrkGXJyvColzuEsR/K0tqkz/Tut4HT2W7JBolFM
sYpBh2zxGniwNe3lpwp5l2ldzstygmm5DVOG5SNYiWXkJG2oGBonP3VS6Yl6jl6c
sBrmCWVhfbHIDogdkHPO1bjxle5PgKbxHfEh0miSFqKDgKrcqsde7H4zJm06llq2
rOrku5cqohpzuIHVZRCoEQAXOARrEsSXqelsTpM3MSPzDVQl37n7aP4qzihDnKre
PyGswKra3njnnAgvfpI2+Ckj5yWdOPcFprh35NMGkh7zQHed7xtlaablzuY8ayjf
BnqxnMYPKV0zEpWjkNeQc6PedXwIIAAAurK8C8gg/koLOsjPttA=
=mkhG
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
