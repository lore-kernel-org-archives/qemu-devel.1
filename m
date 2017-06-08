Received: from eggs.gnu.org ([2001:4830:134:3::10]:35278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIzyD-0006IJ-1b
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIzyA-0001Mw-E5
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:07:37 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170608144106.GG25805@umbus.fritz.box> (David Gibson's message
	of "Fri, 9 Jun 2017 00:41:06 +1000")
References: <20170608144106.GG25805@umbus.fritz.box>
Reply-To: quintela@redhat.com
Date: Thu, 08 Jun 2017 18:07:31 +0200
Message-ID: <87o9tya2f0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] unplug_request and migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: dgilbert@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

David Gibson <david@gibson.dropbear.id.au> wrote:
> Hi Dave & Juan,
>
> I'm hoping one of you can answer this.
>
> I'm currently grappling with (amongst other things) a pseries machine
> racing a hot unplug operation with a migrate.  There's various issues
> with what interim state we need, and which bits of it need to be
> migrated that I'm still investigating.  But, there's a more general
> question that I'm guessing must have already been addressed for x86.
>
> For any "soft" unplug device - i.e. using ->unplug_request, rather
> than ->unplug, giving a device_del command will just ask the guest
> nicely to release the device, with the completion of the unplug
> happening only if and when the guest indicates it's ready for the
> device to go away.  AFAICT, the device_del command will return as soon
> as the request is made, but if the guest is busy, the completion of
> the hot unplug could take arbitrarily long.
>
> So, what happens if there's a migration in between the unplug_request
> and the guest completing the unplug?  How does libvirt (or whatever)
> know whether to include the device on the destination machine command
> line?

On upstream, I removed the posibility of doing a hotplug/unplug while we
are migrating.  But if device del has returned, I can't see how that can
be detected.

Later, Juan.
