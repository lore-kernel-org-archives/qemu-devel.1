Received: from eggs.gnu.org ([2001:4830:134:3::10]:49293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTOPr-0001D4-VF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTOPq-0002Xc-SN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:19:39 -0400
Date: Thu, 14 Jun 2018 11:19:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180614091926.GC8564@localhost.localdomain>
References: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
	<20180613154711.12977-3-dplotnikov@virtuozzo.com>
	<ebef7765-3ea7-b575-69ec-29ae66be561f@redhat.com>
	<b78d2918-9ba8-5f4d-0953-bf2420aabae0@redhat.com>
	<20180614090055.GB8564@localhost.localdomain>
	<w51o9gdpwo5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51o9gdpwo5.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v0 2/2] qmp: add block-set-copy-on-read
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-block@nongnu.org, armbru@redhat.com, famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, den@virtuozzo.com, rkagan@virtuozzo.com

Am 14.06.2018 um 11:03 hat Alberto Garcia geschrieben:
> On Thu 14 Jun 2018 11:00:55 AM CEST, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 13.06.2018 um 18:41 hat Max Reitz geschrieben:
> >> On 2018-06-13 18:02, Eric Blake wrote:
> >> > On 06/13/2018 10:47 AM, Denis Plotnikov wrote:
> >> >> The command enables/disables copy-on-read mode for VM's disk while
> >> >> VM is running.
> >> >>
> >> >> This is needed when using external disk readers to shape access pattern
> >> >> to the disk backend.
> >> >>
> >> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >> >> ---
> >> > 
> >> > Deferring thoughts on the actual design for later;
> >> 
> >> But why? ;-)
> >> 
> >> This patch would definitely be superseded by a block reconfiguration
> >> command (i.e. presumably one that makes reopen accessible over QMP).
> >> With such a command, you could insert or remove a copy-on-read filter
> >> node at any point in time.
> >> 
> >> Since we definitely want block graph configuration, I don't think we
> >> want to add special commands now.
> >
> > I agree, and it seems that we get more and more use cases for a block
> > reconfiguration commands. Only yesterday we talked about the "true"
> > blockdev way for libvirt to implement I/O throttling. The result was
> > that without reopen, we still need to use the old QMP command to set
> > BlockBackend-based I/O throttling instead of using a filter node.
> >
> > So I'm eagerly awaiting Berto's promised patches for it.
> 
> They're coming, it's just a bit tricker than I initially though. I'll
> probably send the first series as an RFC if I don't manage to fix all
> problems, so we can discuss them a bit.

Sounds good to me. It's not completely surprising that there are some
tricky spots there, we've been postponing this for a reason...

Kevin
