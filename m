Received: from eggs.gnu.org ([2001:4830:134:3::10]:54106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwtXB-0004fp-DI
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwtXA-0000aP-Ax
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:20:37 -0400
Date: Tue, 26 Sep 2017 19:20:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170926172020.GC14717@localhost.localdomain>
References: <1506442418-26026-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506442418-26026-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: introduce `info virtio' hmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>

Am 26.09.2017 um 18:13 hat Jan Dakinevich geschrieben:
> The command is intended for exposing device specific virtio feature bits
> and their negotiation status. It is convenient and useful for debug
> purpose.
> 
> Names of features are taken from a devices via get_feature_name() within
> VirtioDeviceClass. If certain device doesn't implement it, the command
> will print only hexadecimal value of feature mask.
> 
> Cc: Denis V. Lunev <den@virtuozzo.com>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> ---
> The patch suggests an another approach for this:
> 
> "virtio: show guest features in 'info qtree'"
> http://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg01609.html

Actually, I think the original approach is much nicer because it uses
generic infrastructure rather than introducing a one-off monitor command
that is specific to a certain class of devices.

But at the same time I can see Cornelia's point that this would create a
whole lot of properties and if we did the same thing consistently for
all devices, the output of 'info qtree' would be completely cluttered
up.

Maybe it would make sense to have properties that can be queried with
QOM, but that don't show up in 'info qtree'? If we then add some HMP
'qom-get' command that allows dumping a whole device as a QOM object
instead of having to query property by property, it should be quite
convenient to use.

Kevin
