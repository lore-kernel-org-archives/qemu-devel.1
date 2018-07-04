Received: from eggs.gnu.org ([2001:4830:134:3::10]:38300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faodN-0007Nx-Fs
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faodK-0006cD-9z
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1faodK-0006bl-1z
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:44:14 -0400
Date: Wed, 4 Jul 2018 17:44:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180704204407.GA22336@localhost.localdomain>
References: <20170901105331.11783-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901105331.11783-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: add firmware.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On Fri, Sep 01, 2017 at 12:53:31PM +0200, Gerd Hoffmann wrote:
> Document how guest firmware is handled in qemu today.
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Is this document still valid?  Should we apply this for QEMU 3.0?

> ---
>  docs/firmware.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 docs/firmware.txt
> 
> diff --git a/docs/firmware.txt b/docs/firmware.txt
> new file mode 100644
> index 0000000000..e242413344
> --- /dev/null
> +++ b/docs/firmware.txt
> @@ -0,0 +1,49 @@
> +
> +prebuilt firmware in qemu
> +=========================
> +
> +The process of building firmware isn't as easy as building qemu
> +itself, for example because you must have cross compilers installed
> +when building firmware for other architectures.  So qemu ships
> +prebuilt firmware binaries for convenience reasons.
> +
> +
> +directories
> +-----------
> +
> +pc-bios/
> +    Firmware binaries.
> +    Also other files like keymaps and logos which are copied to
> +    $prefix/share/qemu by "make install".
> +
> +pc-bios/optionrom/
> +    Firmware sources, part of the qemu project.
> +
> +roms/
> +    Firmware sources, third-party projects, as git submodules.
> +
> +
> +third-party git repos
> +---------------------
> +
> +For third party firmware sources it is recommended to have a git
> +mirror on git.qemu.org.  In case the firmware license is GPL the git
> +mirror is mandatory for GPL compilance reasons:  We ship binaries, so
> +we must provide sources too.
> +
> +
> +building the firmware
> +---------------------
> +
> +Firmware builds should be done using rules in roms/Makefile.  That
> +serves as documentation how the firmware is built, and it also makes
> +firmware updates easier for the maintainer.
> +
> +"make -C roms" prints a list of firmware build targets.
> +"make -C roms $target" kicks a build.
> +
> +
> +notes for specific firmwares
> +----------------------------
> +
> +ipxe: see https://wiki.qemu.org/IpxeDownstreamForQemu
> -- 
> 2.9.3
> 
> 

-- 
Eduardo
