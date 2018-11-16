Received: from eggs.gnu.org ([2001:4830:134:3::10]:53836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNhjg-0008K0-GF
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNhjf-0007ES-Jj
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:16:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1d65ed3f-7353-002f-9000-3b824d5892ce@redhat.com>
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
	<w51in0xuksv.fsf@maestria.local.igalia.com>
	<20181116151834.GA5066@localhost.localdomain>
	<001ec125-35f3-e1fb-56a7-1ed4a1974cc6@redhat.com>
	<20181116155106.GD5066@localhost.localdomain>
	<1d65ed3f-7353-002f-9000-3b824d5892ce@redhat.com>
Date: Fri, 16 Nov 2018 18:16:27 +0100
Message-ID: <w51d0r554es.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

(I just wanted to reply quickly to this point, I'll read the rest of the
e-mail later)

On Fri 16 Nov 2018 05:34:08 PM CET, Max Reitz <mreitz@redhat.com> wrote:
> > GRAPH_MOD with the meaning that Berto suggested isn't weird or
> > complicated to understand. It's only the wrong tool because it
> > blocks more than we want to block. But if we didn't care about that,
> > it could be just another permission like any other.

That's the way that I understood it. Or, more precisely, I'm basing my
current code on those assumptions because it's a simple starting point
to have something working with the current permission system. But I'm of
course open to trying a different approach.

> The meaning Berto has suggested (AFAIU) is never taking the permission
> at all but just querying whether it is shared by all current parents
> before doing a graph change.

That would be a quick way to test it, and I agree that it's unorthodox,
but it's useful to explain how I understood the meaning of GRAPH_MOD.

But you could for example make BDRVReopenState a parent of the BDS (and
replace BDRVReopenState.bs with a BdrvChild).

Berto
