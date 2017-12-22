Received: from eggs.gnu.org ([2001:4830:134:3::10]:40006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNVD-0000zj-6B
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNVC-0004ID-3o
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:36:43 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:46309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSNVB-0004HU-Sz
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:36:42 -0500
Received: by mail-wm0-x243.google.com with SMTP id r78so21998170wme.5
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 05:36:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171125151610.20547-6-ehabkost@redhat.com>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-6-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 14:36:40 +0100
Message-ID: <CAJ+F1CLrWG-h8ciO0rvLYnTidff7Ba0ixr1cmBYV82gYUfctXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] xen: Add only xen-sysdev to dynamic
 sysbus device list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, jgross@suse.com, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel@redhat.com>, xen-devel@lists.xenproject.org, Laszlo Ersek <lersek@redhat.com>

Hi,

On Sat, Nov 25, 2017 at 4:16 PM, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
> There's no need to make the machine allow every possible sysbus
> device.  We can now just add xen-sysdev to the allowed list.
>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v1 -> v2:
> * New patch added to series
> ---
>  hw/xen/xen_backend.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index 82380ea9ee..7445b506ac 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -564,12 +564,7 @@ static void xen_set_dynamic_sysbus(void)
>      ObjectClass *oc =3D object_get_class(machine);
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>
> -    /*
> -     * Emulate old mc->has_dynamic_sysbus=3Dtrue assignment
> -     *
> -     *TODO: add only Xen devices to the list
> -     */
> -    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_XENSYSDEV);

It looks like it's the last patch in the series without review. It
would be nice if a Xen maintainer could look at it, or test it, as I
dont know how to test it tbh.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  }
>
>  int xen_be_register(const char *type, struct XenDevOps *ops)
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
