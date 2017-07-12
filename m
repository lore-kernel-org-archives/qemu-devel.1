Received: from eggs.gnu.org ([2001:4830:134:3::10]:53679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVJem-00019U-G6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVJel-0004ri-Ld
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:34:28 -0400
Date: Wed, 12 Jul 2017 18:32:58 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170712153258.ilcy44wq2onbu5ks@postretch>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-3-el13635@mail.ntua.gr>
	<b8bcff15-2d6c-bca9-cd44-b03ddf7d7812@redhat.com>
	<87y3ruaypm.fsf@dusky.pond.sub.org>
	<20170712151501.GG4917@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b7bmxef45lqsd36e"
Content-Disposition: inline
In-Reply-To: <20170712151501.GG4917@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/4] block: remove bdrv_media_changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--b7bmxef45lqsd36e
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Wed, Jul 12, 2017 at 05:15:01PM +0200, Kevin Wolf wrote:
>Am 12.07.2017 um 09:41 hat Markus Armbruster geschrieben:
>> Eric Blake <eblake@redhat.com> writes:
>>
>> > On 07/11/2017 11:37 AM, Manos Pitsidianakis wrote:
>> >> This function is not used anywhere, so remove it.
>> >>
>> >
>> > Might be interesting to figure out when it WAS last used.
>>
>> Yes.  When I see "remove X because it's unused" during patch review, I
>> immediately ask "why is it unused now, and what was it used for
>> previously?"  Ideally, the commit message answers these questions
>> preemptively.
>>
>> >                                                            If I grepped
>> > correctly, it was commit 21fcf360 back in May 2012?
>>
>> Yes.  "fdc: simplify media change handling".  I suspect that commit
>> broke media change for passed-through host floppy.
>>
>> Its only implementation went away in commit f709623 "block: Remove host
>> floppy support".
>>
>> Suggest
>>
>>     block: bdrv_media_changed() is unused, remove
>>
>>     The i82078 floppy device model used to call bdrv_media_changed() to
>>     implement its media change bit when backed by a host floppy.  This
>>     went away in 21fcf36 "fdc: simplify media change handling".
>>     Probably broke host floppy media change.  Host floppy pass-through
>>     was dropped in commit f709623.  bdrv_media_changed() has never been
>>     used for anything else.  Remove it.
>
>Manos, if you're happy with this, I can update the commit message while
>applying the series.

Of course, no problem.
Thanks!

--b7bmxef45lqsd36e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllmQSoACgkQc2J8L2kN
9xA70A//QmHe7995XDYOQzmygwtmf1AltEtwa8EdNH7+EUIrYTWaKP1WBvpeZj4g
TGOfC0nxrd94OmYQmGOMjr31tFJ2gY1AdqizyqNWviKcafJNlCAkui3wEI201WSL
34EKbz+TgYKwgD7NxAlxqnIQYoiUZ6HTwTICvDIuq/BDbONlslJUcmyG7TFTbg6I
S+dSWpZrokg30f5DEFIiu13lT3bcO+eVyZoyvi3W8/GskqfqgQT5vMzztqpc2f7+
Vqc9EKCYVtsAiIWlLJ1pZQJf7Y3MJ/fiYnfXgehGl6VMDyllkSMHtID4g7YnGVeN
XUY97boXtlQO+A6oopAupWvnAdUL+KuXYtAgsUFbyjKgaXq1PMaeYFuCemcpOGB6
0mHjZkTjSBCF2AiYysrtdA8749pKtlCYW2LMkzZ+BmvW//VQ5/cmOUryzR3J9Qbc
8UFcDlx0ug2Z7EwSoT9MrIsMKbVK+kogFYLcXhPlOo4dud2USdRIpezVt5d5u3oe
8auTyiL6r1FXlEgffct8jKiuuDpP2NCFRE4IfuXHe10lPQ+FxozRSVS9cIXDjk2Y
cP3kfbjeDADWwqvwcy/Y/dKCozSOoqesuwD1KKXq9dZSNsGco99WsgoX92Xe/jJZ
55T2SB8jB4v38i9CPRE5CdK4VMpByaG4OVP7bD/nHIgy3lxAcGA=
=Mivj
-----END PGP SIGNATURE-----

--b7bmxef45lqsd36e--
