Received: from eggs.gnu.org ([2001:4830:134:3::10]:54050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZt8-0002hJ-Eh
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZt0-000270-LR
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:30:41 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYZt0-00026n-Eg
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:30:38 -0400
Received: by mail-wm0-x22e.google.com with SMTP id l81so4419215wmg.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:30:38 -0700 (PDT)
Date: Fri, 21 Jul 2017 16:30:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721153035.GK18014@stefanha-x1.localdomain>
References: <1500151401-30863-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170717071835.GD22872@lemon>
	<1805860107.204084.1500320230836.JavaMail.zimbra@research.iiit.ac.in>
	<8e003313-8651-1f92-3a0b-d465ab1d1cf7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uuKVzAmB+c+zQlhu"
Content-Disposition: inline
In-Reply-To: <8e003313-8651-1f92-3a0b-d465ab1d1cf7@redhat.com>
Subject: Re: [Qemu-devel] [RFC] RFC on Backup tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Ishani <chugh.ishani@research.iiit.ac.in>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, stefanha <stefanha@redhat.com>


--uuKVzAmB+c+zQlhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 05:29:11PM -0400, John Snow wrote:
>=20
>=20
> On 07/17/2017 03:37 PM, Ishani wrote:
> > ----- On Jul 17, 2017, at 12:48 PM, Fam Zheng famz@redhat.com wrote:
> >> On Sun, 07/16 02:13, Ishani Chugh wrote:
>=20
> [...]
>=20
> >> Only full backup is implemented in this patch, is the plan to add incr=
emental
> >> backup on top?  I'm curious because you have target file path set duri=
ng drive
> >> add, but in the incremental case, it should be possible that each back=
up creates
> >> a new target file that chains up with earlier ones, so I think the tar=
get file
> >> should be an option for "backup" command as well.
> >=20
> > Yes. Incremental backup is to be added. I am still in learning phase wi=
th
> > respect to incremental backups. I will modify the arguments and workflo=
w accordingly.
> >=20
>=20
> You may consider solidifying the backup target *pattern* during drive
> add as an alternative, such as:
>=20
> .../path/to/backup/%VM%/%DRIVE%/%yyyy%-%mm%-%dd%.qcow2
>=20
> Or some such scheme. Simple numerals work well, too:
>=20
> myvm/sda/incr.0.qcow2
> myvm/sda/incr.1.qcow2
>=20
> Simple numerals offer the benefit that it is easier to reconstruct the
> chain if you lose your metadata in the python script.
>=20
> Also consider that even for non-incremental backups, we want full
> backups made subsequently to not, in general, overwrite the previous
> full backup, so the TARGET is more of a "living entity" than a fixed
> thing, even in the simple case.

Patterns would be nice.  You may find string.Template() useful:
https://docs.python.org/2.7/library/string.html#template-strings
https://docs.python.org/3/library/string.html#template-strings

--uuKVzAmB+c+zQlhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZch4bAAoJEJykq7OBq3PIEPYH/iIrtSkGpPW9fson2LNINxPn
JjS5kI2qUvhOVPeaOU18IIrQWYVeLVuMyxBqyOSwcRQuGPvOMvjm+FfLsOvMNWJg
olwNdZQ+yrrnZh9rscz2V0OTwt7bNhPdiTrIpRsOTDdzGW0OujaapEIIZKjc5bwD
cHaTmDaV84F5qZDy19GpRJPmmv9Kmv7z4wNR/xcNqCZp+uyzzeHiQp+sUJdJbGG+
rlN6MByPvokQuCInWDAG+0Xr4GtukwvuPkyQm5A0fYRxh0/cHey2slmEGi0zj7LP
XEmiIRarE9vm3Jk7NY2mAqlngV8wUGjzbrJ84IU33YUEeA85fZzdFrloErWypDs=
=rV+i
-----END PGP SIGNATURE-----

--uuKVzAmB+c+zQlhu--
