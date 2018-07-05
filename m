Received: from eggs.gnu.org ([2001:4830:134:3::10]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fb7Ef-0000R8-Du
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fb7Ec-0006cf-8T
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:36:01 -0400
Date: Thu, 5 Jul 2018 13:35:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180705163549.GO7451@localhost.localdomain>
References: <20180705064348.3162-1-kraxel@redhat.com>
	<20180705064348.3162-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705064348.3162-2-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vga: set default_display for all
 machines using cirrus.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Sebastian Bauer <mail@sebastianbauer.info>

On Thu, Jul 05, 2018 at 08:43:47AM +0200, Gerd Hoffmann wrote:
> Explicitly set MachineClass->default_display to "cirrus" for all machine
> types (alpha, mips, old i386 versions) which use cirrus today, so they
> don't depend on cirrus being the default display device.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
