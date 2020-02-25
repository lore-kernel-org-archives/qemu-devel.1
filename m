Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBBC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF1820726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF1820726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XX5-0000Wf-2d
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1j6XW6-0007zN-EF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1j6XW2-0000hz-Mo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:32:42 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:57691
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1j6XW2-0000h8-Gu
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:32:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 66F8881368;
 Tue, 25 Feb 2020 11:32:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XdWiHA8xGv2g; Tue, 25 Feb 2020 11:32:36 +0100 (CET)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 43DF681348;
 Tue, 25 Feb 2020 11:32:36 +0100 (CET)
Subject: Re: [PATCH RESEND v2 14/32] hw/sparc: Use memory_region_init_rom()
 with read-only regions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20200224205533.23798-1-philmd@redhat.com>
 <20200224205533.23798-15-philmd@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <ed806255-0109-bc52-d26f-0fa5d37c7d17@adacore.com>
Date: Tue, 25 Feb 2020 11:32:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224205533.23798-15-philmd@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 2/24/20 =C3=A0 9:55 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> This commit was produced with the Coccinelle script
> scripts/coccinelle/memory-region-housekeeping.cocci.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Looks good to me.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

Thanks,
Fred

> ---
>   hw/sparc/leon3.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index f5a087dd86..23d0bdbd71 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -256,8 +256,7 @@ static void leon3_generic_hw_init(MachineState *mac=
hine)
>  =20
>       /* Allocate BIOS */
>       prom_size =3D 8 * MiB;
> -    memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error=
_fatal);
> -    memory_region_set_readonly(prom, true);
> +    memory_region_init_rom(prom, NULL, "Leon3.bios", prom_size, &error=
_fatal);
>       memory_region_add_subregion(address_space_mem, LEON3_PROM_OFFSET,=
 prom);
>  =20
>       /* Load boot prom */
>=20

