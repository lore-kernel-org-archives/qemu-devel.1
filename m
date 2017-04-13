Received: from eggs.gnu.org ([2001:4830:134:3::10]:55231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyjWJ-0000lW-PA
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyjWI-000811-UY
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:31:03 -0400
Date: Thu, 13 Apr 2017 20:30:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170413183050.GH5095@noname.redhat.com>
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-2-git-send-email-kwolf@redhat.com>
	<a635dc96-283e-3704-59cb-248eb065bf2b@redhat.com>
	<20170413175444.GG5095@noname.redhat.com>
	<35c0f944-0303-5d86-7bf3-93940bd886e5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <35c0f944-0303-5d86-7bf3-93940bd886e5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Call
 blk_resume_after_migration() for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.04.2017 um 20:03 hat Eric Blake geschrieben:
> On 04/13/2017 12:54 PM, Kevin Wolf wrote:
> > Am 13.04.2017 um 19:39 hat Eric Blake geschrieben:
> >> On 04/13/2017 12:23 PM, Kevin Wolf wrote:
> >>> Commit d35ff5e6 ('block: Ignore guest dev permissions during incoming
> >>> migration') added blk_resume_after_migration() to the precopy migrati=
on
> >>> path, but neglected to add it to the duplicated code that is used for
> >>> postcopy migration. This means that the guest device doesn't request =
the
> >>> necessary permissions, which ultimately led to failing assertions.
> >>>
> >>> Add the missing blk_resume_after_migration() to the postcopy path.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  migration/savevm.c | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >>
> >> Are we targetting this for 2.9-rc5, or is it 2.10 material?
> >=20
> > At this point, I think it's clearly 2.10.
>=20
> Okay.  Restating, to make sure I got your reasoning: the removed
> assertions of commit e3e0003 imply that 2.9 is not regressing in
> behavior, and at this point the worst the code can do without this patch
> applied is behave like it's done previously; therefore this patch is not
> fixing an observable 2.9 behavior and therefore not worth holding up the
> release.

Right, basically the new op blockers become ineffective for guest
devices after postcopy migration.

> But for 2.10, it's absolutely essential, as we have another patch
> pending to revert e3e0003 at which point we have a behavior break
> without this patch.

Correct.

Kevin

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY78PaAAoJEH8JsnLIjy/W728P/1nZb5jwN3w+JSBpNmIDExPQ
2lK5O03xPLhcbMdoYIuRsecgZcPQbhvo+02xN7FrJOLwvd26ckFkw1okdHo/6CHN
9MjrGxdwKZEGWQ3XvL+SpoRHNvrA5BG1u16P18zBFCZZitus1J4jAA1C+ZAwawRh
3JUMO/eCnkCksmiaAxqN4wYOKYkKVa6CWOT0mAWdIsuerW3dYqpLUDa9CellAsXG
mOo0H0x5AGq7QZRoCTLaX4dc7xmVU7CuJkIahjgvhLW3pj6nK8aPBRxjyH2xy4vl
YwznC4KnBptVlVP3IMF763LpJdi3B3fchN8ZshJGt6c8aYVNbFG6JklkaLH9Jmy2
PkGJnUTh842Vsfy9dci5ssdBbn+wL+Vy7tbgzRRAU6G7O+kObeEZZkPy2dDH1GQS
yEerpkEKw5+CkRFALysJX7JzvF+7Dfat+L/6QyMt+FGCD+f9NLT6nTjD+JoDsdxz
iPYEJNH+VS+oorfU7GYr/NUfosdGB2I8EIl8fCRE7n3ZniOuShj4NJjp42kOk+5I
4cTjvnn2bscUNxL8ZJ18mYesoS0sYPMlYmbcPDygnh9gT5HoOYf+y+H9ZPU3H8vk
JT+AunkqI/ik2h3ElIOpiqaEttXjf2cSzKTZjFBtK6hqQ6iY5GBN93++8dzucvXl
ZedTmkeWraTKzQ5gtHqy
=lT3q
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
