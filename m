Received: from eggs.gnu.org ([2001:4830:134:3::10]:41511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVLtS-0004tW-5j
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVLtQ-0003Al-LO
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:57:46 -0400
Received: from smtp1.ntua.gr ([147.102.222.183]:44085)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVLtQ-00038h-2a
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:57:44 -0400
Date: Wed, 12 Jul 2017 20:56:14 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170712175614.ujhw5gckj7nlrmu3@postretch>
References: <20170710193047.z2t6eww7nhckgg3z@postretch>
	<87d197mm0f.fsf@dusky.pond.sub.org>
	<87wp7fghi9.fsf@dusky.pond.sub.org>
	<20170711144950.GS7116@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dqcegzkizcvs233i"
Content-Disposition: inline
In-Reply-To: <20170711144950.GS7116@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 15/21] qom: support non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, afaerber@suse.de, Kevin Wolf <kwolf@redhat.com>


--dqcegzkizcvs233i
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 03:49:50PM +0100, Daniel P. Berrange wrote:
>On Tue, Jul 11, 2017 at 04:44:46PM +0200, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> > Manos Pitsidianakis <el13635@mail.ntua.gr> writes:
>> >
>> >> Is there a specific reason this patch wasn't finished? If I'm not
>> >> wrong using non-scalar properties with -object is still not possible,
>> >> yet would be a very useful feature for drivers with UserCreatable
>> >> objects.
>> >>
>> >> Archive link since this is an old patch:
>> >> https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg08252.html
>> >
>> > Yes, we want non-scalar properties with -object.
>> >
>> > This series attempts to provide them by extending QemuOpts.  The troub=
le
>> > is that we've already pushed QemuOpts beyond its design limits, and th=
is
>> > series pushes it some more.  We need to stop working around the design
>> > limits of QemuOpts and start replacing them by something that serves o=
ur
>> > current needs, as I explained in:
>> >
>> >     Subject: Re: [PATCH v14 00/19] QAPI/QOM work for non-scalar object=
 properties
>> >     Message-ID: <87vawnnjpi.fsf@dusky.pond.sub.org>
>> >     https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04895.html
>> >
>> > I started the replacement work (merge commit 8746709).  It provides
>> > non-scalar properties for -blockdev.  I stole Dan's PATCH 07 for it,
>> > which became commit cbd8acf.  See also the design thread
>> >
>> >     Subject: Non-flat command line option argument syntax
>> >     Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
>> >     https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>> >
>> > PATCH 02-06 have been merged separately (merge commit ede0cbe).
>> >
>> > More work is needed to apply the solution for -blockdev to -object, and
>> > I intend to work on it.  A main difficulty is backwards compatibility =
to
>> > all the ill-designed / accidental QemuOpts warts.  We may have to acce=
pt
>> > some incompatibility to make progress.
>>
>> Waiting for that work to be completed may be less than ideal for you.
>> Perhaps we can crack the simple part of the problem quickly, so you can
>> play with it while I still work on the harder parts.
>>
>> Simple part: -object argument in JSON syntax, exactly as in QMP.
>> Example:
>>
>>     -object '{ "qom-type": "memory-backend-ram", "id": "mem1", "props": =
{ "size": 4096 } }'
>>
>> Non-scalar members of "props" should just work there.
>>
>> Hard part: non-scalar properties in the traditional KEY=3DVALUE syntax,
>> using dotted key convention.
>>
>> Sketch appended.  If this would be useful for you, I can prepare proper
>> patches.
>
>Seems reasonable to enable the JSON syntax right now, as long as we are
>confident it'll not need changes once we do the key/val syntax change too.
>
>Regards,
>Daniel

This would be useful indeed. If you end up sending the json patch, CC=20
me.

Thanks a lot!

--dqcegzkizcvs233i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllmYr0ACgkQc2J8L2kN
9xCwyQ//R3qrfsvCSVTdJqkf99pV+l/G5V4cvd1DPA373kGEWBW1NwtRKjb6uSAR
dvyRZxP7gcXfY/oeBNB0yRy3OmhOvI0UgqNBLTnluANfoQLqlHcqrwJwcCtuuIuL
Y/3Cs+/TAjLZPBvfvzbbjZpRrt8PzXxcACcD2bjVUKfWbo0N+nA0liZZjxwW8FCh
XAD3r02xGNfEcgen1Y/ItlsyFoRXi9ArZAccTsMaYZOOPrK/oTxsmUOqbA89F7BZ
3aXGTzKe56o8ZzLAQkU55Vjr/1hDI91Vonap6ld10c+E6qBliiPBCB1GStPLM1Ue
KgE5+FNHzXXt8EkGCsY3BlTJ4nO8BWaz5YypZrW8gggH4a97FgDEXQ+Z2V/8zzSw
4XHOvAnxH021rIWUzwSyonNzhvwPb7/2hELlewBpqtJAVMQVlUYuNwXw6fne1K0M
VmiMEoE90tphDSNOFOfRclzvsQ2IIiQo58nbMNaZGJ0wofx8odGc1DJCQ2x+nrWB
8dTjN0eIl9zUDoaN9hFDioSl20vO3YsWRHclAFXHy2xl7DkHpELvg+lk07hSzN39
KurE6vo6EahrKyibmlZIL9RfsykSbTpmELiyGMU5kVx6esRRJQd93p/18rq6kSmi
hKXJ4DvMfomZlNHUlYaPOTDDoujDFXXz9Vn+1D7Myr5UWJx8/os=
=j17U
-----END PGP SIGNATURE-----

--dqcegzkizcvs233i--
