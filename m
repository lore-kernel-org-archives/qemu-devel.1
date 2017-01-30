Received: from eggs.gnu.org ([2001:4830:134:3::10]:45656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYELE-0006j8-PA
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYELB-0005CJ-Np
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:58:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cYELB-0005C6-Fk
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:58:01 -0500
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
	<1485436265-12573-2-git-send-email-thuth@redhat.com>
	<20170130141246.GE2118@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7fdeebbe-984a-d536-3d8f-4d6a485439ca@redhat.com>
Date: Mon, 30 Jan 2017 16:57:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170130141246.GE2118@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="06jHRKBOAT1UCmClkPJeJKAhiWqSlx38H"
Subject: Re: [Qemu-devel] [RFC PATCH 1/5] checkpatch: add a check for utf-8
 in commit logs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--06jHRKBOAT1UCmClkPJeJKAhiWqSlx38H
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.01.2017 15:12, Stefan Hajnoczi wrote:
> On Thu, Jan 26, 2017 at 02:11:01PM +0100, Thomas Huth wrote:
>> This patch is a port of the following commit from the Linux kernel:
>>
>> commit 15662b3e8644905032c2e26808401a487d4e90c1
>> Author: Joe Perches <joe@perches.com>
>> Date:   Mon Oct 31 17:13:12 2011 -0700
>>
>>     checkpatch: add a --strict check for utf-8 in commit logs
>>
>>     Some find using utf-8 in commit logs inappropriate.
>>
>>     Some patch commit logs contain unintended utf-8 characters when do=
ing
>>     things like copy/pasting compilation output.
>>
>>     Look for the start of any commit log by skipping initial lines tha=
t look
>>     like email headers and "From: " lines.
>>
>>     Stop looking for utf-8 at the first signature line.
>>
>>     Signed-off-by: Joe Perches <joe@perches.com>
>>     Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>>     Cc: Andy Whitcroft <apw@shadowen.org>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  scripts/checkpatch.pl | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>=20
> This patch prevents including names with non-ASCII characters in the
> commit description.  Some people care about the proper spelling of thei=
r
> names.
>=20
> Allowing UTF-8 in Signed-off-by and other headers isn't enough.

Right, and I guess the folks from the kernel checkpatch noticed this,
too. That's likely why the next patch restricts this check to only
happen if the patch is from a mail with non-UTF-8 content type, but
still contains UTF-8 characters, i.e. there is really something fishy
with the character set of the patch description. Maybe I should squash
the two patches together, so that it is more obvious what is going on her=
e?

 Thomas




--06jHRKBOAT1UCmClkPJeJKAhiWqSlx38H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYj2KGAAoJEC7Z13T+cC21Q1UQAKmI+HPybO1PJ4bP4hXEma9X
lyMuvXLB3KSxEgRpMq5Xl980DBuEzXG/HzGDE/nNCGllWDjSM8eK1SJbOTGNJBb3
aoodLCLxpZd8YwB/VQQQrIpx6GhCkolJSyZka+IG3jAM1P6YFVaZXNcNuPOOExyj
7gPqtUd/t+05Xp2Op47/fI//8a8+fiM15fK+aUclXBmdFxEEjc090Q2e8pWT4B3Q
0DlmBS0xe2I2VUqS5jsfoQlWgHHoxIu4pK0e6sZwsJ/IEksT0Soifhzs1p42hsbA
dBKVlz9tPT0QnztNJXoGbpwJnb3OYG6eN+ZD/JJMFk4vCyDQu2LeFasTnPkoIlWH
VGepkYExW7jV3Ks8eUAhKq87TtJvK6EKeeJfQKXV6UXDiENIYJh1QUH4Zj0CZwF0
rLZNOQg52216m01MjT5hEQMuC1wGsWmNsmUsydpKMHyMO1JDatZBNYw1eBJvjGZm
gCskTfGhbcR+8678NP6ottOfwPXz+7p6FY/RiwOnzbTgUnhGGi7sic+sUH7M1YkX
BmQEx4fxZuCjFgr5gASvG0NO0Q9flJ2cB58149EunSOXS3xyNKxGRkqSOAnmQoaQ
Htgzi5QZFGii0FetHiPH6AsP3V2HDMK2h2wDUfdbqHbAWrDdYv5v6a2ZwvnCj/cY
g2mdJcZmwOikTwZp7rxz
=GCeO
-----END PGP SIGNATURE-----

--06jHRKBOAT1UCmClkPJeJKAhiWqSlx38H--
