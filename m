Received: from eggs.gnu.org ([209.51.188.92]:33056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpVl3-0003id-Fs
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpVkz-0003j5-Pf
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:09:11 -0500
Date: Fri, 1 Feb 2019 11:08:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190201110859.7481c5be.cohuck@redhat.com>
In-Reply-To: <9ab3f62f-9011-b4af-2221-075d36d47327@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-6-david@redhat.com>
	<9ab3f62f-9011-b4af-2221-075d36d47327@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] s390x/pci: Drop release timer and
 replace it with a flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>

On Thu, 31 Jan 2019 22:21:01 +0100
David Hildenbrand <david@redhat.com> wrote:

> Thinking out loud:
> 
> We should migrate the flag in the future. This is already a problem
> right now, as the timer is also not migrated.
> 
> If the unplug request is sent and we migrate before the guest can react,
> the unplug would not happen.
> 
> However, looks like migration of zpci devices is not implemented _at all_.

Oh, joy.

> 
> This does not matter for pci passthrough (main use case). But when
> wanting to use e.g. virtio-pci-net, things are shaky after migration.
> 
> So this is future work.
> 

Hopefully folks running s390x guests are rather using virtio-ccw
devices anyway...

I agree that this needs to be taken care of on top of these changes.
Should we mark zpci devices unmigratable, or does it work for some
values of "work"?
