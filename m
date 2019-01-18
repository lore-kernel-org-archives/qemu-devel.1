Received: from eggs.gnu.org ([209.51.188.92]:47162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gkRCZ-000777-RX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gkRCZ-0007cs-1v
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:16:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gkRCY-0007bV-SB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:16:38 -0500
Date: Fri, 18 Jan 2019 10:16:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190118101633.GC2146@work-vm>
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
	<20190118100159.GA2483@work-vm>
	<8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
Subject: Re: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2
 hosts, with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Mielke <mark.mielke@gmail.com>, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 18/01/19 11:02, Dr. David Alan Gilbert wrote:
> >>
> >> It fails if the flag is set, rather than if any nested virtualization has
> >> been used before.
> >>
> >> I'm concerned I will end up with a requirement for *all* guests to be
> >> restarted in order to migrate them to the new hosts, rather than just the
> >> ones that would have a problem.
> > I think you should be able to migrate from 2.12->3.1 like this, but
> > you'd hit the problem when you then try and migrate again between your
> > new QEMUs.
> > 
> > I guess we could modify it to wire it to machine type, so that
> > older machine types didn't block.
> 
> That would also be wrong.  The old machine types _could_ be using KVM
> and they have no way to block the live migration.
> 
> The solution is to restart the VM using "-cpu host,-vmx".

The problem as Christian explained in that thread is that it was common
for them to start VMs with vmx enabled but for people not to use it
on most of the VMs, so we break migration for most VMs even though most
don't use it.

It might not be robust, but it worked for a lot of people most of the
time.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
