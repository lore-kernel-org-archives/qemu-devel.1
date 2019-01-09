Received: from eggs.gnu.org ([209.51.188.92]:58900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghJDS-0000Rh-Dd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghJ62-0006Bj-RA
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:00:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghJ62-0006Ai-J6
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:00:58 -0500
Date: Wed, 9 Jan 2019 20:00:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109190053.GM4867@localhost.localdomain>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<b8cc5195-d8f7-d971-f449-fa62e434437b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
In-Reply-To: <b8cc5195-d8f7-d971-f449-fa62e434437b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.01.2019 um 18:52 hat Eric Blake geschrieben:
> On 1/9/19 11:38 AM, Max Reitz wrote:
>=20
> >=20
> > <general whining>
> > Actually, to me what you're saying sounds more like "Our deprecation
> > policy is useless" to which I wholeheartedly agree.

If you restrict it to "Our deprecation policy is useless for user-facing
changes", I might agree. I think the policy is fine for stuff like QMP
where only the management layer needs to be aware of the change. We
still have problems there, but these are not problems of the policy.

> > I think we should only remove things in major releases, and only if
> > it was deprecated in the previous major release already.  (So if you
> > deprecate something in 4.0, you can remove it in 5.0; but if you
> > deprecate it in 4.1, you can remove it only in 6.0.)  From a user
> > standpoint I really think we deprecate stuff too irregularly.
> > </general whining>
>=20
> That's actually incorrect. Our current version numbering scheme is that
> the major version number is NOT synonymous with major releases: we just
> bump the major version number once per year, and ALL releases are on
> equal footing with no one release being more major than others.  Thus, a
> policy that (at least) 2 releases is needed for a deprecation is
> consistent, where one that requires waiting for a bump in the major
> version number (which is as short as one release and as long as 3, given
> that we bump every year with about 3 releases per year) is the one that
> is less predictable and less meaningful (why is waiting for January
> better than waiting for 2 releases?).

As someone who usually skips distro versions because he wants to have
the change and necessary adaption only once instead of two or three
times in the same timeframe, I can see some value for users in breaking
stable APIs only in defined versions.

At the same time, I can also see the value in being able to break stable
APIs without waiting for almost two years with Max' policy and bad
timing.

For software I develop I prefer the latter, for software that I use I
prefer the former. ;-)

Kevin

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcNkTlAAoJEH8JsnLIjy/W8SEQAI1NstBiUvXPWSsr96Ceyumm
wlSewwrZpMpMg7/R4/h4Aq8nHc/TClk1KGY7nvVisKNl851v2fXZLNDKwJHtT914
/hQC28IHEdLDI3lWD3xjDwOhS/XPPkIBa8kIGeiGr+UHWVBcuKMY2CQC+gPZfbPO
8WoeeRNyjvreg/aPrPnT8qGvhEowcN2GXtLmJP8vsyjz4gHW1LH3L7m+ZIkn8hmh
fxX9UlU2xwikZ1jy+2BwXf13IbQ2uG1M+ttTQIzftVzUm4LEhgZHJbZBaOS48E77
HZGR7h7FSMs5azaLVZ7gnHc5bCXeTJ/1t2zevTQSXNsGTrlfE0awmuuLo4/3pWxR
5BKZ2/WraPl4gEMv20UY02TAoG9vdqg2SqEZ/6BTofOKtN/aV6l584sIulXovuN9
3kxIdmbHGTBCDDqHi5rWf+gIws3kH8NavuIT0RzFgYU54D+6BDwgZPje9YLwBrYT
Xz99FZa+mwehpmLTUzNDyriBVvAqEdn3QmoN4wd2OmWfl54HOyPn3R/g5ZYUcEFn
qp2kGS8viGS6ij30z5qaVrIwv+9M64P5P+311MRKvuNWipZYp/6FWEizcyxgCciV
7DvB/m34iotwjMKqEKLVSSvf5JMKTXPFRTAw+uY0qASxyGyXjJoAlW7Gmz0VYrBQ
OJZ8UQuRI6CIbDEZFlpN
=8OrU
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
