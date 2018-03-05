Received: from eggs.gnu.org ([2001:4830:134:3::10]:46465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1essOb-0005Qx-PO
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1essOb-0003IT-02
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:51:25 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1essOa-0003I9-OQ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:51:24 -0500
Received: by mail-wm0-x242.google.com with SMTP id t3so16806310wmc.2
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 07:51:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520264575-26506-1-git-send-email-mrezanin@redhat.com>
References: <1520264575-26506-1-git-send-email-mrezanin@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 5 Mar 2018 16:51:22 +0100
Message-ID: <CAJ+F1CJdDFWsogi9x_1xb__X==9VE0kBj7KY1qe5w07rhHfCYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Use CONFIG_VHOST_USER_SCSI to enable
 vhost-scsi-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miroslav Rezanina <mrezanin@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Mon, Mar 5, 2018 at 4:42 PM,  <mrezanin@redhat.com> wrote:
> From: Miroslav Rezanina <mrezanin@redhat.com>
>
> Currently, "defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)"
> is used to enable/disable vhost-scsi-pci build as this condition
> is used to enable/disable CONFIG_VHOST_USER_SCSI too.
>
> However, when CONFIG_VHOST_USER_SCSI is manually disable vhost-scsi-pci
> is still registered although it should be disabled.
>
> Changing condition to use CONFIG_VHOST_USER_SCSI so vhost-scsi-pci
> can be controled by CONFIG_VHOST_USER_SCSI option.
>
> Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/virtio/virtio-pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1e8ab7b..df59d6b 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2163,7 +2163,7 @@ static const TypeInfo vhost_scsi_pci_info =3D {
>  };
>  #endif
>
> -#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
> +#if defined(CONFIG_VHOST_USER_SCSI)
>  /* vhost-user-scsi-pci */
>  static Property vhost_user_scsi_pci_properties[] =3D {
>      DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> @@ -2696,7 +2696,7 @@ static void virtio_pci_register_types(void)
>  #ifdef CONFIG_VHOST_SCSI
>      type_register_static(&vhost_scsi_pci_info);
>  #endif
> -#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
> +#if defined(CONFIG_VHOST_USER_SCSI)
>      type_register_static(&vhost_user_scsi_pci_info);
>  #endif
>  #ifdef CONFIG_VHOST_VSOCK
> --
> 1.8.3.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
