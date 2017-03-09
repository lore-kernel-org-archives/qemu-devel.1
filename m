Received: from eggs.gnu.org ([2001:4830:134:3::10]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clob7-0005pD-Gw
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clob6-000186-2M
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:18:37 -0500
Date: Thu, 9 Mar 2017 11:18:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170309031827.GA21082@lemon.lan>
References: <20170308200216.5931-1-eblake@redhat.com>
	<c25bd323-1324-511b-57c0-d417312b6252@redhat.com>
	<0eac6b1c-2dc0-b0aa-7392-3b7f344cae48@redhat.com>
	<995ef14c-4a0d-0b9b-db21-743c4cc3d584@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995ef14c-4a0d-0b9b-db21-743c4cc3d584@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Drop unmaintained
 'archipelago' driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, chris@include.gr, Markus Armbruster <armbru@redhat.com>

On Wed, 03/08 21:18, Max Reitz wrote:
> On 08.03.2017 21:09, Eric Blake wrote:
> > On 03/08/2017 02:05 PM, Max Reitz wrote:
> >> On 08.03.2017 21:02, Eric Blake wrote:
> >>> The driver has failed to build since commit da34e65, in qemu 2.6,
> >>> due to a missing include of qapi/error.h for error_setg().
> >>> Since no one has complained in three releases, it is easier to
> >>> remove the dead code than to keep it around, especially since it
> >>> is not being built by default and therefore prone to bitrot.
> >>>
> >>> Signed-off-by: Eric Blake <eblake@redhat.com>
> >>> ---
> >>>
> >>> My proposed alternative for Max's "block/archipelago: Make it compile"
> >>>
> >>>  qapi/block-core.json             |   33 +-
> >>>  block/archipelago.c              | 1079 --------------------------------------
> >>>  MAINTAINERS                      |    8 -
> >>>  block/Makefile.objs              |    2 -
> >>>  configure                        |   43 --
> >>>  tests/qemu-iotests/025           |    2 +-
> >>>  tests/qemu-iotests/common        |    6 -
> >>>  tests/qemu-iotests/common.filter |    4 +-
> >>>  tests/qemu-iotests/common.rc     |    8 -
> >>>  9 files changed, 4 insertions(+), 1181 deletions(-)
> >>>  delete mode 100644 block/archipelago.c
> >>
> >> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>
> >> But I'd like someone to confirm that I'm not the only one who can't
> >> compile archipelago. ;-)
> > 
> > With my proposed patch not installed, I tried:
> > 
> > ./config.status --enable-archipelago
> > 
> > but got the error:
> > 
> > ERROR: User requested feature Archipelago backend support
> >        configure was not able to find it.
> >        Install libxseg devel
> > 
> > 
> > I don't see libxseg-devel available for Fedora; where does one get it to
> > even attempt compilation?
> 
> I got it from https://github.com/grnet/libxseg, and got it to compile by
> removing all "python" instances from CMakeLists.txt (including the
> find_program() blocks).

Well, if a dependent library is not found in any mainstream repo (including user
contributed repos such as AUR and copr), I'm all for not maintaining it in QEMU.

Reviewed-by: Fam Zheng <famz@redhat.com>
