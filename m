Received: from eggs.gnu.org ([2001:4830:134:3::10]:58941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dGnmg-00017t-Qk
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dGnmd-0000SM-Dr
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:42:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50943)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dGnmd-0000RS-2X
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:42:35 -0400
Date: Fri, 2 Jun 2017 10:42:33 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170602144233.GA4868@flamenco>
References: <1487097476-14259-1-git-send-email-nutarojj@ornl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487097476-14259-1-git-send-email-nutarojj@ornl.gov>
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
To: "James J. Nutaro" <nutarojj@ornl.gov>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Feb 14, 2017 at 13:37:56 -0500, James J. Nutaro wrote:
> This patch adds an interface for pacing the execution of QEMU to match an external
> simulation clock. Its aim is to permit QEMU to be used as a module within a
> larger simulation system.
(snip)
> +++ b/docs/simulation-sync.txt
> @@ -0,0 +1,59 @@
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

Isn't this a KVM-only feature though? I don't see calls to qqq_sync()
anywhere but from kvm-all.c, but maybe I'm missing something.

Also, a few more comments:

- Why "qqq" as the name for this feature? I fail to see any
  connection between the name and the feature.

- If Windows users ever wanted this feature, would we have to
  change the user-facing API (i.e. the -qqq parameter)?

- As is, isn't the code Unix-only rather than Linux-only?

Thanks,

		Emilio
