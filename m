Received: from eggs.gnu.org ([2001:4830:134:3::10]:46167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fBqjZ-00012W-4s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 19:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fBqjU-0007i8-4m
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 19:55:29 -0400
Date: Thu, 26 Apr 2018 20:55:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180426235515.GL29865@localhost.localdomain>
References: <1524570294-23058-1-git-send-email-thuth@redhat.com>
	<d2a9fc1a-9696-f2bd-d603-03b23de62004@de.ibm.com>
	<87f6ba73-2ded-06f2-c68f-d8ef4be50edf@redhat.com>
	<20180424160911.22a238bb.cohuck@redhat.com>
	<6d699426-3525-f62a-c4ec-37dd5589654f@redhat.com>
	<64848d8f-071d-e6c8-58a7-d1e74e93e4f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64848d8f-071d-e6c8-58a7-d1e74e93e4f0@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] hw/s390x: Allow to configure the
 consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Tue, Apr 24, 2018 at 06:19:35PM +0200, Paolo Bonzini wrote:
> On 24/04/2018 16:22, Thomas Huth wrote:
> > $ diff -u sclp-qom-tree-before.txt sclp-qom-tree-after.txt
> > --- sclp-qom-tree-before.txt	2018-04-24 16:17:48.462849585 +0200
> > +++ sclp-qom-tree-after.txt	2018-04-24 16:18:02.222820256 +0200
> > @@ -1,13 +1,14 @@
> > -(qemu) info qom-tree
> > +(qemu) info qom-tree
> >  /machine (s390-ccw-virtio-2.12-machine)
> >    /unattached (container)
> > -    /system[0] (qemu:memory-region)
> >      /sysbus (System)
> > -    /device[1] (virtio-net-ccw)
> > +    /device[0] (qemu-s390x-cpu)
> > +    /s390.ram[0] (qemu:memory-region)
> > +    /device[1] (sclpconsole)
> > +    /device[2] (virtio-net-ccw)
> >        /virtio-backend (virtio-net-device)
> >        /virtio-bus (virtio-ccw-bus)
> > -    /s390.ram[0] (qemu:memory-region)
> > -    /device[0] (qemu-s390x-cpu)
> > +    /system[0] (qemu:memory-region)
> >      /io[0] (qemu:memory-region)
> >    /sclp (sclp)
> >      /s390-sclp-event-facility (s390-sclp-event-facility)
> > @@ -17,7 +18,6 @@
> >    /s390-flic-qemu (s390-flic-qemu)
> >    /s390-skeys (s390-skeys-qemu)
> >    /peripheral-anon (container)
> > -    /device[0] (sclpconsole)
> >    /peripheral (container)
> >    /s390-ipl (s390-ipl)
> >    /virtual-css-bridge (virtual-css-bridge)
> > 
> > ... the sclpconsole now shows up under /unattached instead of
> > /peripheral-anon ... does that matter? (I don't have a clue)
> 
> If the devices are created in the same order, before and after the
> patch, it should be okay.

Is there a way to find out if the devices are created in the same
order using only QMP commands?  It would be very useful to
automatically validate compatibility between QEMU versions.

-- 
Eduardo
