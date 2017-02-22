Received: from eggs.gnu.org ([2001:4830:134:3::10]:49114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgKwN-00031c-93
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 19:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgKwJ-0001zE-Q5
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 19:37:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cgKwJ-0001x9-Jr
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 19:37:51 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F33E83F47
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 00:37:51 +0000 (UTC)
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
	<1487715299-21102-9-git-send-email-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6600b955-a474-7dc5-3dc0-5b951d12934a@redhat.com>
Date: Wed, 22 Feb 2017 01:37:48 +0100
MIME-Version: 1.0
In-Reply-To: <1487715299-21102-9-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/9] update -g command line switch
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 02/21/17 23:14, Gerd Hoffmann wrote:
> Bring documentation in line with the recent changes.
> Text suggested by L=C3=A1szl=C3=B3 =C3=89rsek.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  qemu-options.hx | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 4e89610..ae62e0d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1241,7 +1241,18 @@ DEF("g", 1, QEMU_OPTION_g ,
>  STEXI
>  @item -g @var{width}x@var{height}[x@var{depth}]
>  @findex -g
> -Set the initial graphical resolution and depth (PPC, SPARC only).
> +Set the initial graphical resolution and depth.
> +
> +This setting may be masked by guest firmware temporarily.
> +
> +On PPC and SPARC, the guest firmware will configure the display from
> +this setting, and the guest OS will inherit the display resolution
> +and depth.
> +
> +On x86 and ARM, if the guest firmware is an edk2 (UEFI) platform,
> +the firmware may initially configure the display according to its own,
> +persistent, independent settings. The guest OS drivers, once loaded,
> +should adhere to "-g" however, for virtio and qxl adapters.

I think I made a small mistake here in my earlier suggestion; I think I
should have restricted qxl to x86 only, something like:

  ... should adhere to "-g" however, for virtio (x86, ARM) and qxl
  (x86 only) adapters

Lest we appear to suggest that QXL will ever be available in aarch64
guests :)

>  ETEXI
> =20
>  DEF("vnc", HAS_ARG, QEMU_OPTION_vnc ,
>=20

Looks good to me (and thank you for considering my response earlier).
With the above tweak:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Furthermore, once patch #9 becomes a real patch, this documentation
should be updated again, adding "VGA (x86 only)" as well.

Thanks!
Laszlo
