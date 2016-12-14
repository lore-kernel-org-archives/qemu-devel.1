Received: from eggs.gnu.org ([2001:4830:134:3::10]:51785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHCa1-0004pu-8r
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHCZx-0006Xe-CQ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:38:57 -0500
Received: from mail.avalus.com ([89.16.176.221]:41488)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHCZx-0006XR-5R
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:38:53 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
Date: Wed, 14 Dec 2016 16:38:50 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
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

Vladimir,

>> +non-zero number of metadata contexts during negotiation. Servers =
SHOULD
>> +reply to clients sending `NBD_CMD_BLOCK_STATUS without
>=20
> backquote

Fixed

>> +    If zero queries are sent, then the server MUST return all
>> +    the metadata contexts it knows about.
>=20
> I think that 'all .. it knows about' is too much. What about 'return =
all available ..'? Anyway 'all ... it knows about' actually equals to =
'all ... it wants'. There may be some private, or unrelated contexts, =
for example..

This was not my wording, but I've changed it anyway to:

    If zero queries are sent, then the server MUST return all
    the metadata contexts that are available to	the client to select
    on the given export with `NBD_OPT_SET_META_CONTEXT`.

I think if they are available to select, we should list them. Thanks
also for reminding me to document why I put the export name into the
_LIST_ data (as it is for _SET_).

However, this raises another question. Wouter deliberately made the
query format freeform so that you could e.g. set a context like:

   backup:modtime>201612081034

which might (in theory) return a list of blocks which are newer than
the given timestamp. It would clearly be impossible to return all such
contexts. I wonder if we should carve out an exception here.

--=20
Alex Bligh
