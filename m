Received: from eggs.gnu.org ([2001:4830:134:3::10]:44063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cFLpB-0005qf-FM
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cFLp6-0002yY-0E
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:06:57 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1480535094-23831-3-git-send-email-eblake@redhat.com>
References: <1480535094-23831-1-git-send-email-eblake@redhat.com>
	<1480535094-23831-3-git-send-email-eblake@redhat.com>
Date: Fri, 09 Dec 2016 15:06:48 +0100
Message-ID: <w51inqtw613.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/36] qdict: Add convenience helpers for
 wrapped puts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Chrysostomos Nanakos <chris@include.gr>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "Richard W.M. Jones" <rjones@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:X86" <xen-devel@lists.xensource.com>

On Wed 30 Nov 2016 08:44:20 PM CET, Eric Blake wrote:
> Quite a few users of qdict_put() were manually wrapping a
> non-QObject. We can make such call-sites shorter, by providing
> common macros to do the tedious work.  Also shorten nearby
> qdict_put_obj(,,QOBJECT()) sequences.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, the code looks much better now :)

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
