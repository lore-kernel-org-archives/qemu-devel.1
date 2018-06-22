Received: from eggs.gnu.org ([2001:4830:134:3::10]:38790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWR1A-0002l5-Cj
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWR17-0004vE-Ar
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:42:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51620 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWR17-0004uh-65
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:42:41 -0400
Date: Fri, 22 Jun 2018 21:42:39 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180622214216-mutt-send-email-mst@kernel.org>
References: <20180622003140.164613-1-mst@redhat.com>
	<20180622003140.164613-2-mst@redhat.com>
	<20180622182236.GA7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622182236.GA7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] kvm: support -overcommit
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On Fri, Jun 22, 2018 at 03:22:36PM -0300, Eduardo Habkost wrote:
> On Fri, Jun 22, 2018 at 03:31:48AM +0300, Michael S. Tsirkin wrote:
> > With this flag, kvm allows guest to control host CPU power state.  This
> > increases latency for other processes using same host CPU in an
> > unpredictable way, but if decreases idle entry/exit times for the
> > running VCPU, so to use it QEMU needs a hint about whether host CPU is
> > overcommitted, hence the flag name.
> 
> The flag name in the code below is still "-dedicated".

Weird, somehow got the wrong patch sent.
Will repost the fixed one now

> [...]
> > +static QemuOptsList qemu_dedicated_opts = {
> > +    .name = "dedicated",
> [...]
> > +            case QEMU_OPTION_dedicated:
> > +                opts = qemu_opts_parse_noisily(qemu_find_opts("dedicated"),
> > +                                               optarg, false);
> [...]
> > +DEF("dedicated", HAS_ARG, QEMU_OPTION_dedicated,
> > +    "-dedicated [mem-lock=on|off][cpu-pm=on|off]\n"
> > +    "                run qemu with realtime features\n"
> > +    "                mem-lock=on|off controls memory lock support (default: off)\n"
> > +    "                cpu-pm=on|off controls cpu power management (default: off)\n",
> > +    QEMU_ARCH_ALL)
> > +STEXI
> > +@item -dedicated mem-lock=on|off
> > +@item -dedicated cpu-pm=on|off
> > +@findex -dedicated
> > +Run qemu using dedicated host resources.
> > +Locking qemu and guest memory can be enabled via @option{mem-lock=on}
> > +(disabled by default). This is equivalent to @option{realtime}.
> > +Guest ability to manage power state of host cpus (increasing latency for other
> > +processes on the same host cpu, but decreasing latency for guest)
> > +can be enabled via @option{cpu-pm=on} (disabled by default).
> > +ETEXI
> [...]
> 
> -- 
> Eduardo
