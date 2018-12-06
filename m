Received: from eggs.gnu.org ([2001:4830:134:3::10]:57415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUt5R-0005DX-7h
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUt5Q-0001WF-FZ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:49:01 -0500
Date: Thu, 6 Dec 2018 10:48:51 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181206124851.GV18284@habkost.net>
References: <20181205205827.19387-1-ehabkost@redhat.com>
	<20181205205827.19387-5-ehabkost@redhat.com>
	<20181205223035.GH768@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205223035.GH768@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH for-4.0 4/5] spapr: Delete instance_options
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Dec 06, 2018 at 09:30:35AM +1100, David Gibson wrote:
> On Wed, Dec 05, 2018 at 06:58:26PM -0200, Eduardo Habkost wrote:
> > Now that all instance_options functions for spapr are empty,
> > delete them.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Thanks!

> 
> Do you want me to stage the ppc patches in my ppc-for-4.0 tree, or
> would you prefer to keep your series together to go in via your tree?

I wouldn't mind to get this queued through the ppc tree, but
maybe it will be easier to get them through the machine tree
because of the dependency on the 4.0 machine-type patch.

-- 
Eduardo
