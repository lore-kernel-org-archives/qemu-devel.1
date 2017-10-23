Received: from eggs.gnu.org ([2001:4830:134:3::10]:40314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6fVW-0000jg-TF
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6fVT-0003rP-Pp
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:23:18 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:32911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e6fVT-0003qL-Ha
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:23:15 -0400
Date: Mon, 23 Oct 2017 12:23:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171023162312.GA5089@flamenco>
References: <1487097476-14259-1-git-send-email-nutarojj@ornl.gov>
	<1505857386-23049-1-git-send-email-nutarojj@ornl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505857386-23049-1-git-send-email-nutarojj@ornl.gov>
Subject: Re: [Qemu-devel] [PATCH V8] qqq: module for synchronizing with a
 simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: nutarojj@ornl.gov
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Sep 19, 2017 at 17:43:06 -0400, nutarojj@ornl.gov wrote:
> += Synchronizing the virtual clock with an external source =
> +
> +QEMU has a protocol for synchronizing its virtual clock
> +with the clock of a simulator in which QEMU is embedded
> +as a component. This options is enabled with the -qqq
> +argument, and it should generally be accompanied by the
> +following additional command line arguments:
> +
> +-icount 1,sleep=off -rtc clock=vm
> +  or
> +-enable-kvm -rtc clock=vm
> +
> +The -qqq argument is used to supply a file descriptor
> +for a Unix socket, which is used for synchronization.
> +The procedure for launching QEMU in is synchronization
> +mode has three steps:
> +
> +(1) Create a socket pair with the Linux socketpair function.
> +    The code segment that does this might look like

I thought a little bit about this patch. I think the feature is useful
and should eventually be provided by QEMU.

The part I'm not sure about is the socket interface; for instance,
it isn't cross-platform.

A better alternative might be to expose this functionality to plugins,
and let the plugins deal with the external world--socket or whatever
IPC is appropriate on the platform they're meant to be run.

Of course the plugin interface is still under discussion. I think though
it should be fairly easy to expose this functionality to plugins. I'll take
a look at in the next few weeks, hopefully also supporting MTTCG instances
(with some collaboration/hack from the plugin, I'm afraid).

Thanks,

		Emilio
