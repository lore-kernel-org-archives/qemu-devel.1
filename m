Received: from eggs.gnu.org ([2001:4830:134:3::10]:35784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fb7Du-0008Oq-Ha
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fb7Dq-0005rh-Is
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:35:14 -0400
Date: Thu, 5 Jul 2018 13:35:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180705163501.GN7451@localhost.localdomain>
References: <20180705064348.3162-1-kraxel@redhat.com>
	<20180705064348.3162-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705064348.3162-3-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vga: don't pick cirrus by default
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

On Thu, Jul 05, 2018 at 08:43:48AM +0200, Gerd Hoffmann wrote:
> Now that all machines which need cirrus explicitly select it qemu
> doesn't need to consider it as default display any more.  Drop it.
> 
> With this patch applied all ppc machine types will use "std" as default
> display, no matter whenever cirrus-vga is compiled in or not.
> 
> Fixes: 29f9cef39e ppc: Include vga cirrus card into the compiling process
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Do we have a list of all machine-types with default_display==NULL
that would be affected by this?  For reference, this will affect
the machines in the following binaries:

default-configs/alpha-softmmu.mak:CONFIG_VGA_CIRRUS=y
default-configs/i386-softmmu.mak:CONFIG_VGA_CIRRUS=y
default-configs/mips-softmmu-common.mak:CONFIG_VGA_CIRRUS=y
default-configs/ppc-softmmu.mak:CONFIG_VGA_CIRRUS=y
default-configs/x86_64-softmmu.mak:CONFIG_VGA_CIRRUS=y


> ---
>  vl.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 16b913f9d5..117e4e6879 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4475,8 +4475,6 @@ int main(int argc, char **argv, char **envp)
>      if (default_vga) {
>          if (machine_class->default_display) {
>              vga_model = machine_class->default_display;
> -        } else if (vga_interface_available(VGA_CIRRUS)) {
> -            vga_model = "cirrus";
>          } else if (vga_interface_available(VGA_STD)) {
>              vga_model = "std";
>          }
> -- 
> 2.9.3
> 

-- 
Eduardo
