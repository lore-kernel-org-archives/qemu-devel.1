Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05EFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67A021D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67A021D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyBF-00020U-C9
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1iNy9g-0000m4-43
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1iNy9e-0005Qy-VK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:53:20 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:33755
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1iNy9e-0005Q1-Lb; Fri, 25 Oct 2019 07:53:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id DFD5181399;
 Fri, 25 Oct 2019 13:53:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JsRiZxGc1kYg; Fri, 25 Oct 2019 13:53:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [109.190.253.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 0E94581392;
 Fri, 25 Oct 2019 13:53:15 +0200 (CEST)
Subject: Re: [PATCH 1/2] hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing
 to PnP registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
References: <20191025110114.27091-1-philmd@redhat.com>
 <20191025110114.27091-2-philmd@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <bcd4a30e-c71b-af1c-1303-e2b421702401@adacore.com>
Date: Fri, 25 Oct 2019 13:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025110114.27091-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.98.77.210
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Jiri Gaisler <jiri@gaisler.se>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

Le 10/25/19 =C3=A0 1:01 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> Guests can crash QEMU when writting to PnP registers:
>=20
>    $ echo 'writeb 0x800ff042 69' | qemu-system-sparc -M leon3_generic -=
S -bios /etc/magic -qtest stdio
>    [I 1571938309.932255] OPENED
>    [R +0.063474] writeb 0x800ff042 69
>    Segmentation fault (core dumped)
>=20
>    (gdb) bt
>    #0  0x0000000000000000 in  ()
>    #1  0x0000555f4bcdf0bc in memory_region_write_with_attrs_accessor (m=
r=3D0x555f4d7be8c0, addr=3D66, value=3D0x7fff07d00f08, size=3D1, shift=3D=
0, mask=3D255, attrs=3D...) at memory.c:503
>    #2  0x0000555f4bcdf185 in access_with_adjusted_size (addr=3D66, valu=
e=3D0x7fff07d00f08, size=3D1, access_size_min=3D1, access_size_max=3D4, a=
ccess_fn=3D0x555f4bcdeff4 <memory_region_write_with_attrs_accessor>, mr=3D=
0x555f4d7be8c0, attrs=3D...) at memory.c:539
>    #3  0x0000555f4bce2243 in memory_region_dispatch_write (mr=3D0x555f4=
d7be8c0, addr=3D66, data=3D69, op=3DMO_8, attrs=3D...) at memory.c:1489
>    #4  0x0000555f4bc80b20 in flatview_write_continue (fv=3D0x555f4d92c4=
00, addr=3D2148528194, attrs=3D..., buf=3D0x7fff07d01120 "E", len=3D1, ad=
dr1=3D66, l=3D1, mr=3D0x555f4d7be8c0) at exec.c:3161
>    #5  0x0000555f4bc80c65 in flatview_write (fv=3D0x555f4d92c400, addr=3D=
2148528194, attrs=3D..., buf=3D0x7fff07d01120 "E", len=3D1) at exec.c:320=
1
>    #6  0x0000555f4bc80fb0 in address_space_write (as=3D0x555f4d7aa460, =
addr=3D2148528194, attrs=3D..., buf=3D0x7fff07d01120 "E", len=3D1) at exe=
c.c:3291
>    #7  0x0000555f4bc8101d in address_space_rw (as=3D0x555f4d7aa460, add=
r=3D2148528194, attrs=3D..., buf=3D0x7fff07d01120 "E", len=3D1, is_write=3D=
true) at exec.c:3301
>    #8  0x0000555f4bcdb388 in qtest_process_command (chr=3D0x555f4c2ed7e=
0 <qtest_chr>, words=3D0x555f4db0c5d0) at qtest.c:432
>=20
> Instead of crashing, log the access as unimplemented.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

oops, thanks for that :).

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

> ---
>   hw/misc/grlib_ahb_apb_pnp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
> index 7338461694..f3c015d2c3 100644
> --- a/hw/misc/grlib_ahb_apb_pnp.c
> +++ b/hw/misc/grlib_ahb_apb_pnp.c
> @@ -22,6 +22,7 @@
>    */
>  =20
>   #include "qemu/osdep.h"
> +#include "qemu/log.h"
>   #include "hw/sysbus.h"
>   #include "hw/misc/grlib_ahb_apb_pnp.h"
>  =20
> @@ -231,8 +232,15 @@ static uint64_t grlib_apb_pnp_read(void *opaque, h=
waddr offset, unsigned size)
>       return apb_pnp->regs[offset >> 2];
>   }
>  =20
> +static void grlib_apb_pnp_write(void *opaque, hwaddr addr,
> +                                uint64_t val, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +}
> +
>   static const MemoryRegionOps grlib_apb_pnp_ops =3D {
>       .read       =3D grlib_apb_pnp_read,
> +    .write      =3D grlib_apb_pnp_write,
>       .endianness =3D DEVICE_BIG_ENDIAN,
>   };
>  =20
>=20

