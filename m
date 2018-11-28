Received: from eggs.gnu.org ([2001:4830:134:3::10]:54072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8631c8a8c=anthony.perard@citrix.com>)
	id 1gS2M7-0003yk-S7
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8631c8a8c=anthony.perard@citrix.com>)
	id 1gS2M3-0003U6-RH
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:06:27 -0500
Date: Wed, 28 Nov 2018 16:06:16 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181128160616.GB14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-2-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-2-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 01/18] xen: re-name XenDevice to
 XenLegacyDevice...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Nov 21, 2018 at 03:11:54PM +0000, Paul Durrant wrote:
> ...and xen_backend.h to xen-legacy-backend.h
> 
> Rather than attempting to convert the existing backend infrastructure to
> be QOM compliant (which would be hard to do in an incremental fashion),
> subsequent patches will introduce a completely new framework for Xen PV
> backends. Hence it is necessary to re-name parts of existing code to avoid
> name clashes. The re-named 'legacy' infrastructure will be removed once all
> backends have been ported to the new framework.
> 
> This patch is purely cosmetic. No functional change.

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
