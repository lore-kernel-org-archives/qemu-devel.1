Received: from eggs.gnu.org ([2001:4830:134:3::10]:51421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRsiZ-0005i6-0M
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRsiV-0001mW-4c
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:48:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRsiT-0001lt-3u
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:48:53 -0500
Date: Wed, 28 Nov 2018 06:48:50 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181128054850.exrlih6zqskaw7a7@sirius.home.kraxel.org>
References: <20181126153036.22414-1-fziglio@redhat.com>
	<20181127123502.GZ12172@natto.ory.fergeau.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127123502.GZ12172@natto.ory.fergeau.eu>
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH] spice: Use new
 SpiceImageCompression definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: Frediano Ziglio <fziglio@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Tue, Nov 27, 2018 at 01:35:02PM +0100, Christophe Fergeau wrote:
> hey,
> 
> On Mon, Nov 26, 2018 at 03:30:36PM +0000, Frediano Ziglio wrote:
> > Definitions were updated by spice-server in patch de66161 included
> > in 0.12.6 released on 12th June 2015.
> 
> QEMU's configure only checks for spice-server 0.12.0:

> I don't know how far back QEMU wants to support spice-server.
> Apart from this, the patch looks good to me.

0.12.6 is more than three years old, so this or something newer should
be available in most distros meanwhile.  Raising the bar to that version
looks ok to me (separate patch please, and please also drop #ifdefs we
don't need any more then).

thanks,
  Gerd
