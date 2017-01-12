Received: from eggs.gnu.org ([2001:4830:134:3::10]:55973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRfFA-00061R-Bq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRfF5-0003OA-So
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:16:40 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:50100)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRfF5-0003NA-N2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:16:35 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <ac0cc1e5-dea5-ba2d-2789-7dd0672ad561@virtuozzo.com>
Date: Thu, 12 Jan 2017 13:16:35 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <C834A65C-57A2-4863-ACE7-2009BD3C4B02@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<ac0cc1e5-dea5-ba2d-2789-7dd0672ad561@virtuozzo.com>
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


> On 12 Jan 2017, at 11:43, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>=20
> =46rom "NBD_OPT_LIST_META_CONTEXT (9)":
>> The server MUST either reply with an error (for instance EINVAL if =
the option is not supported), or reply with a list of =
NBD_REP_META_CONTEXT replies followed by NBD_REP_ACK.:
> NBD_REP_ERR_UNSUP for the case in braces? Should it be normal option =
reply packet?

Thanks, fixed.

--=20
Alex Bligh
