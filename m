Received: from eggs.gnu.org ([209.51.188.92]:57978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2D0D-0004BG-MO
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2D0B-0004MN-O7
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:45:21 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:46336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h2D0B-0004Kj-BD
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:45:19 -0500
Received: by mail-ed1-x544.google.com with SMTP id f2so16004870edy.13
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 02:45:19 -0800 (PST)
References: <20190308094610.21210-1-armbru@redhat.com>
	<20190308094610.21210-8-armbru@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190308094610.21210-8-armbru@redhat.com>
Date: Fri, 08 Mar 2019 10:45:16 +0000
Message-ID: <87a7i5fxvn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/15] ppc405_boards: Delete stale,
 disabled DEBUG_BOARD_INIT code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu


Markus Armbruster <armbru@redhat.com> writes:

> The disabled DEBUG_BOARD_INIT code goes back to the initial commit
> 1a6c0886203, and has since seen only mechanical updates.  It sure
> feels like useless clutter now.  Delete it.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/ppc/ppc405_boards.c | 60 ------------------------------------------
>  1 file changed, 60 deletions(-)
>
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index f47b15f10e..bb73d6d848 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -48,8 +48,6 @@
>
>  #define USE_FLASH_BIOS
>
> -//#define DEBUG_BOARD_INIT
> -
>  /***********************************************************************=
******/
>  /* PPC405EP reference board (IBM) */
>  /* Standalone board with:
> @@ -171,9 +169,6 @@ static void ref405ep_init(MachineState *machine)
>      ram_bases[1] =3D 0x00000000;
>      ram_sizes[1] =3D 0x00000000;
>      ram_size =3D 128 * MiB;
> -#ifdef DEBUG_BOARD_INIT
> -    printf("%s: register cpu\n", __func__);
> -#endif
>      env =3D ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
>                          33333333, &pic, kernel_filename =3D=3D NULL ? 0 =
: 1);
>      /* allocate SRAM */
> @@ -182,9 +177,6 @@ static void ref405ep_init(MachineState *machine)
>                             &error_fatal);
>      memory_region_add_subregion(sysmem, 0xFFF00000, sram);
>      /* allocate and load BIOS */
> -#ifdef DEBUG_BOARD_INIT
> -    printf("%s: register BIOS\n", __func__);
> -#endif
>      fl_idx =3D 0;
>  #ifdef USE_FLASH_BIOS
>      dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
> @@ -193,12 +185,6 @@ static void ref405ep_init(MachineState *machine)
>
>          bios_size =3D blk_getlength(blk);
>          fl_sectors =3D (bios_size + 65535) >> 16;
> -#ifdef DEBUG_BOARD_INIT
> -        printf("Register parallel flash %d size %lx"
> -               " at addr %lx '%s' %d\n",
> -               fl_idx, bios_size, -bios_size,
> -               blk_name(blk), fl_sectors);
> -#endif
>          pflash_cfi02_register((uint32_t)(-bios_size),
>                                NULL, "ef405ep.bios", bios_size,
>                                blk, 65536, fl_sectors, 1,
> @@ -208,9 +194,6 @@ static void ref405ep_init(MachineState *machine)
>      } else
>  #endif
>      {
> -#ifdef DEBUG_BOARD_INIT
> -        printf("Load BIOS from file\n");
> -#endif
>          bios =3D g_new(MemoryRegion, 1);
>          memory_region_init_ram(bios, NULL, "ef405ep.bios", BIOS_SIZE,
>                                 &error_fatal);
> @@ -239,21 +222,12 @@ static void ref405ep_init(MachineState *machine)
>          memory_region_set_readonly(bios, true);
>      }
>      /* Register FPGA */
> -#ifdef DEBUG_BOARD_INIT
> -    printf("%s: register FPGA\n", __func__);
> -#endif
>      ref405ep_fpga_init(sysmem, 0xF0300000);
>      /* Register NVRAM */
> -#ifdef DEBUG_BOARD_INIT
> -    printf("%s: register NVRAM\n", __func__);
> -#endif
>      m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
>      /* Load kernel */
>      linux_boot =3D (kernel_filename !=3D NULL);
>      if (linux_boot) {
> -#ifdef DEBUG_BOARD_INIT
> -        printf("%s: load kernel\n", __func__);
> -#endif
>          memset(&bd, 0, sizeof(bd));
>          bd.bi_memstart =3D 0x00000000;
>          bd.bi_memsize =3D ram_size;
> @@ -325,10 +299,6 @@ static void ref405ep_init(MachineState *machine)
>          initrd_size =3D 0;
>          bdloc =3D 0;
>      }
> -#ifdef DEBUG_BOARD_INIT
> -    printf("bdloc " RAM_ADDR_FMT "\n", bdloc);
> -    printf("%s: Done\n", __func__);
> -#endif
>  }
>
>  static void ref405ep_class_init(ObjectClass *oc, void *data)
> @@ -473,15 +443,9 @@ static void taihu_405ep_init(MachineState *machine)
>      memory_region_init_alias(&ram_memories[1], NULL,
>                               "taihu_405ep.ram-1", ram, ram_bases[1],
>                               ram_sizes[1]);
> -#ifdef DEBUG_BOARD_INIT
> -    printf("%s: register cpu\n", __func__);
> -#endif
>      ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
>                    33333333, &pic, kernel_filename =3D=3D NULL ? 0 : 1);
>      /* allocate and load BIOS */
> -#ifdef DEBUG_BOARD_INIT
> -    printf("%s: register BIOS\n", __func__);
> -#endif
>      fl_idx =3D 0;
>  #if defined(USE_FLASH_BIOS)
>      dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
> @@ -492,12 +456,6 @@ static void taihu_405ep_init(MachineState *machine)
>          /* XXX: should check that size is 2MB */
>          //        bios_size =3D 2 * 1024 * 1024;
>          fl_sectors =3D (bios_size + 65535) >> 16;
> -#ifdef DEBUG_BOARD_INIT
> -        printf("Register parallel flash %d size %lx"
> -               " at addr %lx '%s' %d\n",
> -               fl_idx, bios_size, -bios_size,
> -               blk_name(blk), fl_sectors);
> -#endif
>          pflash_cfi02_register((uint32_t)(-bios_size),
>                                NULL, "taihu_405ep.bios", bios_size,
>                                blk, 65536, fl_sectors, 1,
> @@ -507,9 +465,6 @@ static void taihu_405ep_init(MachineState *machine)
>      } else
>  #endif
>      {
> -#ifdef DEBUG_BOARD_INIT
> -        printf("Load BIOS from file\n");
> -#endif
>          if (bios_name =3D=3D NULL)
>              bios_name =3D BIOS_FILENAME;
>          bios =3D g_new(MemoryRegion, 1);
> @@ -542,12 +497,6 @@ static void taihu_405ep_init(MachineState *machine)
>          /* XXX: should check that size is 32MB */
>          bios_size =3D 32 * MiB;
>          fl_sectors =3D (bios_size + 65535) >> 16;
> -#ifdef DEBUG_BOARD_INIT
> -        printf("Register parallel flash %d size %lx"
> -               " at addr " TARGET_FMT_lx " '%s'\n",
> -               fl_idx, bios_size, (target_ulong)0xfc000000,
> -               blk_name(blk));
> -#endif
>          pflash_cfi02_register(0xfc000000, NULL, "taihu_405ep.flash", bio=
s_size,
>                                blk, 65536, fl_sectors, 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
> @@ -555,16 +504,10 @@ static void taihu_405ep_init(MachineState *machine)
>          fl_idx++;
>      }
>      /* Register CLPD & LCD display */
> -#ifdef DEBUG_BOARD_INIT
> -    printf("%s: register CPLD\n", __func__);
> -#endif
>      taihu_cpld_init(sysmem, 0x50100000);
>      /* Load kernel */
>      linux_boot =3D (kernel_filename !=3D NULL);
>      if (linux_boot) {
> -#ifdef DEBUG_BOARD_INIT
> -        printf("%s: load kernel\n", __func__);
> -#endif
>          kernel_base =3D KERNEL_LOAD_ADDR;
>          /* now we can load the kernel */
>          kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
> @@ -593,9 +536,6 @@ static void taihu_405ep_init(MachineState *machine)
>          initrd_base =3D 0;
>          initrd_size =3D 0;
>      }
> -#ifdef DEBUG_BOARD_INIT
> -    printf("%s: Done\n", __func__);
> -#endif
>  }
>
>  static void taihu_class_init(ObjectClass *oc, void *data)


--
Alex Benn=C3=A9e
