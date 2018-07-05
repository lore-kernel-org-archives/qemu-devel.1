Received: from eggs.gnu.org ([2001:4830:134:3::10]:36540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fawyw-0008MC-J9
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fawyv-0000Vy-P1
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fawyv-0000UU-KU
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-5-f4bug@amsat.org>
Date: Thu, 05 Jul 2018 07:39:03 +0200
In-Reply-To: <20180704153919.12432-5-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Jul 2018 12:39:15
	-0300")
Message-ID: <87y3eqckco.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/8] xen: Remove useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Patch created mechanically by rerunning:
>
>   $  spatch --sp-file scripts/coccinelle/typecast.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/xen/xen_pt_config_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
> index aee31c62bb..55a83333f2 100644
> --- a/hw/xen/xen_pt_config_init.c
> +++ b/hw/xen/xen_pt_config_init.c
> @@ -543,7 +543,7 @@ static int xen_pt_exp_rom_bar_reg_write(XenPCIPassthr=
oughState *s,
>  {
>      XenPTRegInfo *reg =3D cfg_entry->reg;
>      XenPTRegion *base =3D NULL;
> -    PCIDevice *d =3D (PCIDevice *)&s->dev;
> +    PCIDevice *d =3D &s->dev;
>      uint32_t writable_mask =3D 0;
>      uint32_t throughable_mask =3D get_throughable_mask(s, reg, valid_mas=
k);
>      pcibus_t r_size =3D 0;

Reviewed-by: Markus Armbruster <armbru@redhat.com>
