Received: from eggs.gnu.org ([2001:4830:134:3::10]:44585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d48SR-0007ls-Hb
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d48SM-0000Cl-Rl
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d48SM-0000CI-IE
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:09:18 -0400
Date: Fri, 28 Apr 2017 17:09:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170428160901.GK2085@work-vm>
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-3-eblake@redhat.com>
	<20170428080821.GB2085@work-vm>
	<3a8d9f68-f30c-1191-ca80-a93f0050f011@redhat.com>
	<20170428152729.GI2085@work-vm>
	<550a4e37-c4b3-181d-876c-64d73e96e78c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550a4e37-c4b3-181d-876c-64d73e96e78c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 04/28/2017 10:27 AM, Dr. David Alan Gilbert wrote:
> 
> >>>> +# Enumeration of various causes for shutdown.
> >>>> +#
> >>>> +# @host-qmp: Reaction to a QMP command, such as 'quit'
> >>>> +# @host-signal: Reaction to a signal, such as SIGINT
> >>>> +# @host-ui: Reaction to a UI event, such as closing the window
> >>>> +# @host-replay: The host is replaying an earlier shutdown event
> >>>> +# @host-error: Qemu encountered an error that prevents further use of the guest
> >>>> +# @guest-shutdown: The guest requested a shutdown, such as via ACPI or
> >>>> +#                  other hardware-specific action
> >>>> +# @guest-reset: The guest requested a reset, and the command line
> >>>> +#               response to a reset is to instead trigger a shutdown
> >>>> +# @guest-panic: The guest panicked, and the command line response to
> >>>> +#               a panic is to trigger a shutdown
> >>>
> 
> > At a higher level, using your tags, I'm not sure where a reset triggered
> > by a fault detected by the hypervisor lives - e.g. an x86 triple fault
> > where the guest screws up so badly that it just gets reset.  Is
> > that a guest-reset or a guest-panic or what - neither case
> > was actually asked for by the guest itself.
> 
> Wouldn't that be host-error (qemu detected an error that prevents
> further execution of the guest without a reset - and a triple fault
> seems to fall into the category of the guest getting itself wedged
> rather than actually trying to reset)?  Except patch 3 only used
> SHUTDOWN_TYPE_HOST_ERROR in the xen portion of the patch.
> 
> So if any x86 expert has an opinion on where triple-fault handling is
> emulated, and what category should be used there, I'm welcome to
> tweaking this series.

It's pretty much on the border anyway, I don't think it matters too
much; it sounds perfectly reasonable.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
