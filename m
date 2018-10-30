Received: from eggs.gnu.org ([2001:4830:134:3::10]:51601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHVX2-0008JB-BF
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHVWw-0007tF-VG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:02:10 -0400
Date: Tue, 30 Oct 2018 12:02:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181030150200.GW3902@habkost.net>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030111348.14713-2-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>

On Tue, Oct 30, 2018 at 12:13:45PM +0100, Gerd Hoffmann wrote:
> Indicates support state for somerhing (device, backend, subsystem, ...)
> in qemu.  Modeled roughly after the "S:" states we have in MAINTANERS.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
[...]
> +typedef struct QemuSupportState {
> +    SupportState state;
> +    const char *reason;
> +} QemuSupportState;

I find it weird that we're calling this field "reason", while
this is how the field is being actually used:

* "use a newer machine type instead"
* "use 40p machine type instead"
* "use '-vga std' instead"

These are not reasons for deprecation, they are just suggested
alternatives.

-- 
Eduardo
