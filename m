Received: from eggs.gnu.org ([2001:4830:134:3::10]:43083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxVoR-0005u9-2W
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxVoQ-0003RS-8j
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:12:59 -0400
Date: Thu, 28 Sep 2017 12:12:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170928121243.56aced1f.cohuck@redhat.com>
In-Reply-To: <20170928100235.GA5826@localhost.localdomain>
References: <1506524982-4053-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<20170927224308-mutt-send-email-mst@kernel.org>
	<0aa2a34c-c97e-36ea-8d9d-317483a6944f@virtuozzo.com>
	<20170928100235.GA5826@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] virtio: introduce `info virtio' hmp
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Jan Dakinevich <jan.dakinevich@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>

On Thu, 28 Sep 2017 12:02:35 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> Am 28.09.2017 um 01:05 hat Jan Dakinevich geschrieben:
> > > OK but if it's useful as an hmp command, why not as a qmp command?  
> > 
> > The command is designed for debugging and produces quite sightly output. For
> > respective qmp command most of `info virtio' output would excessive and
> > unneccesary.  
> 
> The general policy is that HMP commands should only call QMP command
> implementations internally rather than doing things themselves, to make
> sure that a management tool can achieve everything the monitor provides
> with QMP and doesn't have to fall back to parsing HMP output.
> 
> If we are certain that this feature is useless for automated use and
> nobody will ever want to use it in scripts (sounds like a bold claim to
> me), maybe an exception can be justified. I think this is up to the
> monitor maintainers.

Having a way to get at things like virtio status might be useful (for
example, noticing if a device has NEEDS_RESET set).
