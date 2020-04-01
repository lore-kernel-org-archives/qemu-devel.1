Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5C4C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 10:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CB92078B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 10:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CB92078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJb55-0005IP-1v
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 06:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJb4T-0004qp-S3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJb4S-0006GK-Jy
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:58:09 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:54508
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1jJb4S-00068G-Aq
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:58:08 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id E9A428137C;
 Wed,  1 Apr 2020 12:58:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 88gO_xLdbcwI; Wed,  1 Apr 2020 12:58:05 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 00E3C8137F;
 Wed,  1 Apr 2020 12:58:04 +0200 (CEST)
Subject: Re: [PATCH-for-5.0 2/7] hw/misc/grlib_ahb_apb_pnp: Avoid crash when
 writing to AHB PnP registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-3-f4bug@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <b5d5f8b3-6950-9463-b901-b31ba640525c@adacore.com>
Date: Wed, 1 Apr 2020 12:58:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331105048.27989-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiri Gaisler <jiri@gaisler.se>, Fabien Chouteau <chouteau@adacore.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 3/31/20 =C3=A0 12:50 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> Similarly to commit 158b659451 with the APB PnP registers, guests
> can crash QEMU when writting to the AHB PnP registers:
>=20
>    $ echo 'writeb 0xfffff042 69' | qemu-system-sparc -M leon3_generic -=
S -bios /etc/magic -qtest stdio
>    [I 1571938309.932255] OPENED
>    [R +0.063474] writeb 0xfffff042 69
>    Segmentation fault (core dumped)
>=20
>    (gdb) bt
>    #0  0x0000000000000000 in  ()
>    #1  0x0000562999110df4 in memory_region_write_with_attrs_accessor
>        (mr=3Dmr@entry=3D0x56299aa28ea0, addr=3D66, value=3Dvalue@entry=3D=
0x7fff6abe13b8, size=3Dsize@entry=3D1, shift=3D<optimized out>, mask=3Dma=
sk@entry=3D255, attrs=3D...) at memory.c:503
>    #2  0x000056299911095e in access_with_adjusted_size
>        (addr=3Daddr@entry=3D66, value=3Dvalue@entry=3D0x7fff6abe13b8, s=
ize=3Dsize@entry=3D1, access_size_min=3D<optimized out>, access_size_max=3D=
<optimized out>, access_fn=3Daccess_fn@entry=3D
>        0x562999110d70 <memory_region_write_with_attrs_accessor>, mr=3D0=
x56299aa28ea0, attrs=3D...) at memory.c:539
>    #3  0x0000562999114fba in memory_region_dispatch_write (mr=3Dmr@entr=
y=3D0x56299aa28ea0, addr=3D66, data=3D<optimized out>, op=3D<optimized ou=
t>, attrs=3Dattrs@entry=3D...) at memory.c:1482
>    #4  0x00005629990c0860 in flatview_write_continue
>        (fv=3Dfv@entry=3D0x56299aa7d8a0, addr=3Daddr@entry=3D4294963266,=
 attrs=3D..., ptr=3Dptr@entry=3D0x7fff6abe1540, len=3Dlen@entry=3D1, addr=
1=3D<optimized out>, l=3D<optimized out>, mr=3D0x56299aa28ea0)
>        at include/qemu/host-utils.h:164
>    #5  0x00005629990c0a76 in flatview_write (fv=3D0x56299aa7d8a0, addr=3D=
4294963266, attrs=3D..., buf=3D0x7fff6abe1540, len=3D1) at exec.c:3165
>    #6  0x00005629990c4c1b in address_space_write (as=3D<optimized out>,=
 addr=3D<optimized out>, attrs=3D..., attrs@entry=3D..., buf=3Dbuf@entry=3D=
0x7fff6abe1540, len=3Dlen@entry=3D1) at exec.c:3256
>    #7  0x000056299910f807 in qtest_process_command (chr=3Dchr@entry=3D0=
x5629995ee920 <qtest_chr>, words=3Dwords@entry=3D0x56299acfcfa0) at qtest=
.c:437
>=20
> Instead of crashing, log the access as unimplemented.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/misc/grlib_ahb_apb_pnp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
> index e230e25363..72a8764776 100644
> --- a/hw/misc/grlib_ahb_apb_pnp.c
> +++ b/hw/misc/grlib_ahb_apb_pnp.c
> @@ -136,8 +136,15 @@ static uint64_t grlib_ahb_pnp_read(void *opaque, h=
waddr offset, unsigned size)
>       return ahb_pnp->regs[offset >> 2];
>   }
>  =20
> +static void grlib_ahb_pnp_write(void *opaque, hwaddr addr,
> +                                uint64_t val, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +}
> +
>   static const MemoryRegionOps grlib_ahb_pnp_ops =3D {
>       .read       =3D grlib_ahb_pnp_read,
> +    .write      =3D grlib_ahb_pnp_write,
>       .endianness =3D DEVICE_BIG_ENDIAN,
>   };
>  =20
>=20

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

