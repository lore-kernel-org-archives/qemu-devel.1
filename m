Received: from eggs.gnu.org ([2001:4830:134:3::10]:44830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dyUqD-0000hz-KW
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 23:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dyUqC-0007JK-VE
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 23:22:53 -0400
Date: Sun, 1 Oct 2017 06:22:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171001062230-mutt-send-email-mst@kernel.org>
References: <1506535289-14430-1-git-send-email-jan.dakinevich@virtuozzo.com>
	<20170929222852-mutt-send-email-mst@kernel.org>
	<4910b4f1-bd11-79b5-4b08-4313d2f95846@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4910b4f1-bd11-79b5-4b08-4313d2f95846@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3] virtio: introduce `info virtio' hmp
 command
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Sat, Sep 30, 2017 at 03:52:25AM +0300, Jan Dakinevich wrote:
> > Same question as before - why not a QMP counterpart as well?
> >
> 
> What do you mean? Implement something like `query-virtio' backed by
> respective qmp_query_virtio() and then use this routine for `virtio
> info', right?

Exactly.
