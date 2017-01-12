Received: from eggs.gnu.org ([2001:4830:134:3::10]:54549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRfAf-0007Ei-6J
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRfAd-0001FR-ES
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:12:01 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:49868)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRfAd-0001FI-7z
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:11:59 -0500
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <dcaf043a-9e76-3be2-1740-e90085928f6a@virtuozzo.com>
Date: Thu, 12 Jan 2017 13:11:57 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CBA6C86-A5CD-4F88-B8B2-29224BF1223D@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<e3c30f7c-8d5b-5cfc-1cc0-5e673a30cd8a@virtuozzo.com>
	<6986E12E-AE0A-4502-BB43-77C4E83C9DC4@alex.org.uk>
	<dcaf043a-9e76-3be2-1740-e90085928f6a@virtuozzo.com>
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
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>


> On 12 Jan 2017, at 07:05, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>=20
> Yes this is better. But is it actually needed to force contexts have =
some safe default? If context wants it may define such default without =
this requirement.. So, should it be requirement at all?

I've changed this to:

    of the file), a server MAY reply with a single block status
    descriptor with *length* matching the requested length, rather than
    reporting the error; in this case the context MAY mandate the
    status returned.


--=20
Alex Bligh
