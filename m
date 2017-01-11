Received: from eggs.gnu.org ([2001:4830:134:3::10]:52338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRPEB-0004Jt-Re
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRPE7-0004q7-BG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:10:35 -0500
Received: from mail.avalus.com ([89.16.176.221]:52889)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRPE7-0004pJ-3d
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:10:31 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <e3c30f7c-8d5b-5cfc-1cc0-5e673a30cd8a@virtuozzo.com>
Date: Wed, 11 Jan 2017 19:00:00 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <6986E12E-AE0A-4502-BB43-77C4E83C9DC4@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<e3c30f7c-8d5b-5cfc-1cc0-5e673a30cd8a@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V . Lunev" <den@openvz.org>


> On 11 Jan 2017, at 15:31, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>=20
> >>> If an error occurs, the server SHOULD set the appropriate error =
code in the error field of an error chunk. However, if the error does =
not involve invalid usage (such as a request beyond the bounds of the =
file), a server MAY reply with a single block status descriptor with =
length matching the requested length, and status of 0 rather than =
reporting the error.
> - single block status descriptor for each context? Isn't it =
implementation defined? Or we finally decided to force 0 status to be =
safe default for all contexts? If it is so, it would be better to =
describe this separately. However, personally, I'd prefer to not define =
contexts internal semantics at all.

I think this is Wouter's wording, but I think 'a status appropriate to =
the context' would be better. Each context then needs to define what =
that is. Either that or 'the context's default status' and that should =
be in the definition of the context.

--=20
Alex Bligh
