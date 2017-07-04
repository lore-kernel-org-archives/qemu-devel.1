Received: from eggs.gnu.org ([2001:4830:134:3::10]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSNQX-0002ja-VS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSNQT-00034O-6F
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:59:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dSNQS-00033s-UB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:59:33 -0400
References: <20170704111404.28569-1-berrange@redhat.com>
	<20170704111404.28569-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e4f5548d-0da3-ea64-1ffc-fa887b51c947@redhat.com>
Date: Tue, 4 Jul 2017 14:59:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170704111404.28569-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs: document deprecated features
 in appendix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 04.07.2017 13:14, Daniel P. Berrange wrote:
> The deprecation of features in QEMU is totally adhoc currently,
> with no way for the user to get a list of what is deprecated
> in each release. This adds an appendix to the doc that records
> when each deprecation was made and provides text explaining
> what to use instead, if anything.
>=20
> Since there has been no formal policy around removal of deprecated
> features in the past, any deprecations prior to 2.10.0 are to be
> treated as if they had been made at the 2.10.0 release. Thus the
> earliest that existing deprecations will be deleted is the start
> of the 2.12.0 cycle.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-doc.texi | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 167 insertions(+)
>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 27781e4..ba5170c 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -39,6 +39,7 @@
>  * QEMU User space emulator::
>  * Implementation notes::
>  * Support lifetime::
> +* Deprecated features::
>  * License::
>  * Index::
>  @end menu
> @@ -3054,6 +3055,172 @@ support machine types from many previous versio=
ns.
[...]
> +@subsection -monitor default=3Don (since 2.4.0)
> +
> +The ``default'' option to the ``-monitor'' argument is
> +now ignored. When multiple monitors were enabled, it
> +indicated which monitor would receive log messages
> +from the audio subsystem.

The audio subsystem was just the last user. There were other subsystems
using it before, see e.g. commit 027a79c373954920d5 or commit
02d16089802234f.

[...]
> +@subsection -net vlan (since 2.9.0)
> +
> +The ``-net van=3DNN'' argument is partially replaced with the
> +new ``-netdev'' argument. The remaining use cases will no
> +longer be directly supported in QEMU

Add a period after the last sentence?

> +@subsection -drive if=3Dscsi (since 2.9.0)
> +
> +The ``-drive if=3Dscsi'' argument is replaced by the the
> +``-device BUS-TYPE'' argument combined with ``-drive if=3Dnone''.
> +
> +@subsection -net dump (since 2.10.0)
> +
> +The ``--net dump'' argument is now a synonym for setting the
> +``-object filter-dump'' argument instead.

Technically, it's not a synonym, but a replacement ;-)
("-net dump" uses the "vlan" concept, while "-object filter-dump" works
with "-netdev" instead)

> +@subsection -hdachs (since 2.10.0)
> +
> +The ``-hdachs'' argument is now a synonym for setting
> +the ``cyls'', ``heads'', ``secs'', and ``trans'' properties
> +on the ``ide-hd'' device using the ``-device'' argument.
> +The new syntax allows different settings to be provided
> +per disk.
> +
> +@subsection -usbdevice (since 2.10.0)
> +
> +The ``-usbdevice DEV'' argument is now a synonym for setting
> +the ``-device usb-DEV'' argument instead. The deprecated syntax
> +would automatically enable USB support on the machine type.
> +If using the new syntax, USB support must be explicitly
> +enabled via the ``-machine usb=3Don'' argument.
> +
> +@section qemu-img command line arguments
> +
> +@subsection convert -s (since 2.0.0)
> +
> +The ``convert -s snapshot_id_or_name'' argument is obsoleted
> +by the ``convert -l snapshot_param'' argument instead.
> +
> +@section System emulator human monitor commands
> +
> +@subsection usb_add (since 2.10.0)
> +
> +The ``usb_add'' command is replaced by the ``device_add'' command.
> +
> +@subsection usb_del (since 2.10.0)
> +
> +The ``usb_del'' command is replaced by the ``device_del'' command.
> +
> +@section System emulator devices
> +
> +@subsection ivshmem (since 2.6.0)
> +
> +The ``ivshmem'' device type is replaced by either the ``ivshmem-plain'=
'
> +or ``ivshmem-doorbell`` device types.
> +
> +@subsection spapr-pci-vfio-host-bridge (since 2.6.0)
> +
> +The ``spapr-pci-vfio-host-bridge'' device type is replaced by
> +the ``spapr-pci-host-bridge'' device type.
> +
>  @node License
>  @appendix License

 Thomas
