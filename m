Received: from eggs.gnu.org ([2001:4830:134:3::10]:53749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dJFMn-0006AA-OS
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dJFMk-0000kr-GR
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:34:01 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dJFMk-0000jJ-9C
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:33:58 -0400
Received: by mail-wm0-x229.google.com with SMTP id 7so151891264wmo.1
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 01:33:56 -0700 (PDT)
Date: Fri, 9 Jun 2017 09:33:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170609083352.GA25859@stefanha-x1.localdomain>
References: <1496957498-17127-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<149697539488.2157.11696332117845784842@84b42461e25a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <149697539488.2157.11696332117845784842@84b42461e25a>
Subject: Re: [Qemu-devel] [PATCH] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: chugh.ishani@research.iiit.ac.in
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2017 at 07:29:55PM -0700, no-reply@patchew.org wrote:
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: Add manpage for QEMU Backup Tool...
> ERROR: trailing whitespace
> #28: FILE: contrib/backup/qemu-backup.texi:1:
> +                   $

Hi Ishani,
In case you are wondering about these errors - please send a new
revision (v2) of this patch with the whitespace issues fixed.

Here are a few Vim tips but I'm sure you can do the same in Emacs or
other editors:

1. Add the following to your .vimrc to highlight trailing whitespace:

   hi WhiteSpaceEOL ctermbg=red guibg=red
   au InsertEnter * match WhiteSpaceEOL /\s\+\%#\@<!$/
   au InsertLeave * match WhiteSpaceEOL /\s\+$/

2. Use this search-and-replace command to get rid of trailing
   whitespace:

   :%s/\s\+$//g

I recommend running scripts/checkpatch.pl yourself before submitting
patches.  You can do it automatically from a git hook (see githooks(5))
by following the instructions here:

http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.html

Stefan

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOl1wAAoJEJykq7OBq3PI0I0H/3rg3AhMqlnmhov2GzHS3YMV
Mfz9M46P3VzgZfX2c2UrXag3LJPXFM0Ct0tpK/Ta2DnjvHZqY7ko2ZnFPJtJQ2rp
hUtYVc3PIUqcQRh78sjzTeZ21cJsY095KQ8fxeEBl9N68fGzsVwRHnIiRvMkF91P
l2fi3gLfBGGvigbBgPIhG/EB1wI6EgQ09+cQePtUYNDNte0LMyZFDwzmYBrICIqw
SvQJ3MfFtNwJom7KjNvckZ9FilZtuyJz2BWX88KvYbdpyllQQ83oOL/hUyMWILnx
iJn3GAjyBd0KkSquZOr4abB7xya0C1lOFwCFa/Qg6CTqmPQc3awxAmW1ciH149g=
=NMpx
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
