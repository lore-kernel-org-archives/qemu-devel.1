Received: from eggs.gnu.org ([2001:4830:134:3::10]:37253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cUdUU-0004jT-3E
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cUdUT-0002Rx-FE
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:00:46 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:55022)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cUdUT-0002Pl-2j
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:00:45 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <442dcfe4-8704-2898-655e-da383a0caf76@virtuozzo.com>
Date: Fri, 20 Jan 2017 18:00:41 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <220990D0-ACB6-4F25-BADF-63898FE71BED@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<442dcfe4-8704-2898-655e-da383a0caf76@virtuozzo.com>
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


> On 20 Jan 2017, at 17:04, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>=20
> About extents: is 32bit length enough? We will have to send 4096 for =
empty 16tb disk..

The nbd protocol uniformly uses 32 bit lengths (for better or for =
worse). This is baked into the specification heavily.

I'm not sure sending 4,096 items for an empty 16TB disk is any great =
hardship to be honest.

--=20
Alex Bligh
