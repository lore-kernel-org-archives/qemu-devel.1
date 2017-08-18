Received: from eggs.gnu.org ([2001:4830:134:3::10]:49517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1didGB-0000zL-Ht
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1didGA-0002ay-KY
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:08:07 -0400
Date: Fri, 18 Aug 2017 12:07:22 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170818090722.t4njxb6ubxvl2nsb@postretch>
References: <20170818031019.3723-1-el13635@mail.ntua.gr>
	<20170818031019.3723-6-el13635@mail.ntua.gr>
	<w51wp615loy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2mfrzevwncjfz6j"
Content-Disposition: inline
In-Reply-To: <w51wp615loy.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v5 5/6] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--s2mfrzevwncjfz6j
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 10:23:09AM +0200, Alberto Garcia wrote:
>On Fri 18 Aug 2017 05:10:18 AM CEST, Manos Pitsidianakis wrote:
>> block/throttle.c uses existing I/O throttle infrastructure inside a
>> block filter driver. I/O operations are intercepted in the filter's
>> read/write coroutines, and referred to block/throttle-groups.c
>>
>> The driver can be used with the syntax
>> -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>>         limits.iops-total=3D...,throttle-group=3Dbar
>
>I had understood that we would get rid of the limits.* options in this
>driver, or did I get it wrong?
>
>Other than that, the rest of the code looks perfect to me.
>
>Berto
>

I was going to send a patch after this was merged along with adding=20
ThrottleGroups to the root container, to speed things up. Do you prefer=20
to do this in this patch?

The root container patch probably has to go to the 'remove legacy'=20
series since adding it here means the name collision errors introduce=20
error paths in block/block-backend.c that go away in that series, and=20
that'd be a waste of effort.

--s2mfrzevwncjfz6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmWrkoACgkQc2J8L2kN
9xDS0BAAtvKqOHjyZLMs40Ud/tlkizicb6wxRqcr0qIXfmcabPw4QCh/sL8RVa/g
zvmSOv/ZLRnqoiY3Zzb0fZ4THzjwyvg/Ewp4aD+1hYnx0pNah9o8QSb7GSdbegYt
wJ05L4uqsiJJ42r6Dj4UBLnoyJpAN1TAxA8kc31HQ5WntTVHfq5bDNAZ/Ggc2cCm
vwCOgKrKm11ZkOjO5W6Sh7aWBcqzx4ygl5xMQLxlxOMLfNOcStrVqxEc39s3hoTN
KcmKxpPcsg6wmHvaW8M8LXuyuiptDN/C8fVvA1FnV01gI7LVwY2Fz+M7QwAuQ5v+
Dh88TIkfTl6zqJA2iwoV+w4LinVJUoVlb1+pV/uiBet2q3WEu8aFXkEKWPKnZZX6
yjnAqljbGX8mK7PZ/U0j1D58W7dP2NA4HQBBolIlwot9MBCo6FeInKtMbWJwyq+a
XSIgBhQl8zpkaUDsJPwx2xlyDXRG5JRLM4fMVoOxfh8DJl0jOBvKBpJJiVynH6g6
K0I4+WdtalP24drS+8ez38Zu3VIgTfGONw3cQ+GZvtihJAv9LycD7/goFE0hR8rE
nJcZ8eyvdpCk0GBQFSrRu3o44Tv5Xw+TwjbISIOh0IJwfFuXNSa8xpo+8+164F+5
us+5CzzdEg2pmTcwJjioF6UWEMfvbgr0EM5z37wc5S0eTzmgbKA=
=8aN6
-----END PGP SIGNATURE-----

--s2mfrzevwncjfz6j--
