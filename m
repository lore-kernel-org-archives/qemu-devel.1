Received: from eggs.gnu.org ([2001:4830:134:3::10]:50366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cMdFO-00071o-QN
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cMdFL-0002Mc-GC
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:08:06 -0500
Received: from mail.avalus.com ([89.16.176.221]:55852)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cMdFL-0002MU-AT
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:08:03 -0500
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <d7e58b6e-815c-ffb6-ac68-ef52b0082c50@virtuozzo.com>
Date: Thu, 29 Dec 2016 16:08:02 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D5EAC18-B7BE-46AF-85CE-8488AB6C9448@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<20161214184937.uv5gwkijaofhjfd7@grep.be>
	<95CEC42B-486F-45F2-8879-ACF48C2380FD@alex.org.uk>
	<d7e58b6e-815c-ffb6-ac68-ef52b0082c50@virtuozzo.com>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

Vladimir,

> On 26 Dec 2016, at 15:57, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>=20
>> OK, so first of all, one of the changes I made earlier was that now
>> each of the commands carries a list of queries, the way you list
>> everything is not 'having a query that doesn't contain a namespace'
>> but rather doing a _LIST_ with no queries at all. But that's =
semantics
>> and orthogonal to the main point.
>>=20
>> What I've proposed (and pushed - but feel free to alter it) is that
>=20
> I think, an overview in "## Metadata querying" should be updated too.

Sorry, which bit needs updating?

The only bit in that more general section that mentions _LIST_ is:

> First, during negotiation, if the client wishes to query metadata
> during transmission, the client MUST select one or more metadata
> contexts with the NBD_OPT_SET_META_CONTEXT command. If needed, the
> client can use NBD_OPT_LIST_META_CONTEXT to list contexts that the
> server supports.

That still seems correct.

--=20
Alex Bligh
