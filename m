Received: from eggs.gnu.org ([2001:4830:134:3::10]:41395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVT3Y-0001tM-Nl
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 22:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVT3V-0000IW-LF
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 22:41:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVT3V-0000Hv-F3
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 22:41:09 -0400
Date: Wed, 20 Jun 2018 05:41:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620053855-mutt-send-email-mst@kernel.org>
References: <20180615222855.44421-1-mst@redhat.com>
	<20180615222855.44421-2-mst@redhat.com>
	<b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
	<f87772ab-7d59-4ab2-59e3-c1ac77eaf725@redhat.com>
	<20180620030236-mutt-send-email-mst@kernel.org>
	<CANRm+CyZyo49ga=-dM-VES8fTEYiv+FM0WZdsf5F+jhnLbcLtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CyZyo49ga=-dM-VES8fTEYiv+FM0WZdsf5F+jhnLbcLtw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] kvm: support -dedicated
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: eblake@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm <kvm@vger.kernel.org>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 20, 2018 at 08:46:10AM +0800, Wanpeng Li wrote:
> On Wed, 20 Jun 2018 at 08:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 19, 2018 at 05:07:46PM -0500, Eric Blake wrote:
> > > On 06/19/2018 10:17 AM, Paolo Bonzini wrote:
> > > > On 16/06/2018 00:29, Michael S. Tsirkin wrote:
> > > > > +static QemuOptsList qemu_dedicated_opts = {
> > > > > +    .name = "dedicated",
> > > > > +    .head = QTAILQ_HEAD_INITIALIZER(qemu_dedicated_opts.head),
> > > > > +    .desc = {
> > > > > +        {
> > > > > +            .name = "mem-lock",
> > > > > +            .type = QEMU_OPT_BOOL,
> > > > > +        },
> > > > > +        {
> > > > > +            .name = "cpu-pm",
> > > > > +            .type = QEMU_OPT_BOOL,
> > > > > +        },
> > > > > +        { /* end of list */ }
> > > > > +    },
> > > > > +};
> > > > > +
> > > >
> > > > Let the bikeshedding begin!
> > > >
> > > > 1) Should we deprecate -realtime?
> > > >
> > > > 2) Maybe -hostresource?
> > >
> > > What further things might we add in the future?
> > >
> > > -dedicated sounds wrong (it is an adjective, while most of our options are
> > > nouns - thing -machine, -drive, -object, ...)
> > >
> > > -hostresource at least sounds like a noun, but is long to type.  But at
> > > least '-hostresource cpu-pm=on' reads reasonably well.
> >
> > Yes but host resource what? I feel it says nothing at all about what
> > one can expect to find in this flag.
> >
> > > About the only other noun I could think of would be '-feature cpu-pm=on'.
> >
> > If we have nothing at all to say about what is grouping these things,
> > we don't need a new flag. We can make it a machine property.
> >
> > It's user's hint that some host resource is dedicated to a VM.
> 
> The commit 633711e82 (kvm: rename KVM_HINTS_DEDICATED to
> KVM_HINTS_REALTIME) should be reverted according to several threads
> discussion I think.
> 
> Regards,
> Wanpeng Li

IMHO that is unrelated - these KVM hints are hints to *guest*.

In this thread we are talking about hints to QEMU that are only
necessary because QEMU is separate from the host scheduler/memory
management.

-- 
MST
