Received: from eggs.gnu.org ([2001:4830:134:3::10]:50063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVCkd-0007yB-Q7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVCkc-0001A8-Oa
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:12:03 -0400
Date: Wed, 12 Jul 2017 11:10:22 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170712081022.fcvchnilcfcyt23j@postretch>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<87tw2iaydb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stryz4gynwckxzcc"
Content-Disposition: inline
In-Reply-To: <87tw2iaydb.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] block: Block driver callbacks fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--stryz4gynwckxzcc
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 09:49:20AM +0200, Markus Armbruster wrote:
>Manos Pitsidianakis <el13635@mail.ntua.gr> writes:
>
>> This series makes implementing some of the bdrv_* callbacks easier for b=
lock
>> filters by passing requests to bs->file if bs->drv doesn't implement it =
instead
>> of failing, and adding default bdrv_co_get_block_status() implementation=
s.
>>
>> This is based against Kevin Wolf's block branch, commit
>> da4bd74d2450ab72a7c26bbabb10c6a287dd043e
>
>Haven't seen BlockDriver member is_filter before.  Interesting.  It's
>documentation
>
>    /* set to true if the BlockDriver is a block filter */
>    bool is_filter;
>
>is seriously lacking.  What does it *mean* to be a block filter?  Which
>block layer facilities are affected, and how?

Currently it is only used in bdrv_recurse_is_first_non_filter.=20

>Observation: driver "raw" is filter-like in the sense that all it does
>is pass along method arguments and results.  Can't say whether that
>makes it a filter in the sense of is_filter, because "the sense of
>is_filter" is nebulous to me :)

I'm not very acquainted with raw, so I can't really comment. But the=20
drivers I'm working on, throttle and before write notifier have that=20
exact semantic, ie they do something when IO is intercepted and pass=20
everything to the BDSes below. There was a mini discussion about raw and=20
filters in the previous version's thread.

I might add documentation to block_int.h in the future. When I first=20
read it it felt nebulous to me too.

--stryz4gynwckxzcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlll2W4ACgkQc2J8L2kN
9xAS6w/9GMKpC7KoKaxRxUZmxEUaSKIwPPmRQOKHKV3pnHqFfn8MlNLAN+w4FFQX
pZojjzFHK8Ucbss+JKxcjV0PpjZwIa9a7IaHBP+hqhrQEKogyYbaCjYR6kUPMLRc
wDZiEbXm8mItn1phbsdfoCjGWe/U1BQKmT/RGL3eSB9B0Lq+GjNl+UJC5m5kRUTn
O0oh/u5IzMOyp+wAyGdH/FKZsO9mEvmoSs0Rxq4TMLFqKwd3w6+lugk5XuOL1hsw
uxC+cicwJRmjTGM+1G63bwmpFxyqQVxPz15nA4UOw1MBos/n2KSMk0S93npFAty2
GDQX4sEE4uqtKGWCoaWRPMVIvo18sR1AEFgToRGEukEFvVu6+iQLUb6GJucRUvhh
p/U3Ysv/6uBWP8ir4HOlo8QTkzb7pzP+CZyO/YS2IpYa1a3r9QQxP5Ii6J5iMhQS
vlyuB7PBz8gKTllBLCiLGZH8ZUcyDyh9eppxQWyXQTpg7LjdUX+iFiF9GldWsENW
J1jougO8iGCOlmg2mP6wkVOi7tSLeipeYwLWI9enQht2YDFYFUZ7DkmtfKBsftbQ
bgsYoiF+4c4n9f5ZYM/7Hvv4J+VIGYQ70nys4EZPadf1uhToh8PJx1EZhFulP6NB
6Q7pPNzPBTuFtV8ZxOwJku6jE2ipQaEx7SitG08yQ6fvqMObmdM=
=Ig63
-----END PGP SIGNATURE-----

--stryz4gynwckxzcc--
