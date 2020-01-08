Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A04C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 21:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3912C20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 21:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NyPTTcAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3912C20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipJ6Z-00083B-0p
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 16:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1ipJ2p-0006cS-EF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 16:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1ipJ2o-0007ZO-5g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 16:39:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:50915)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1ipJ2n-0007Xr-OE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 16:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578519543;
 bh=rTcHkZBYQrSG2TnSNDI5ffT33HqkQgm4YI4ihjaLd3w=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=NyPTTcAonAVIq8hXck3ukhUtcHwDYR+3f4wDUExWO2mQOgX7jsCStqL+Ic3LrlyPJ
 eHfHzBloe2yUkWg/z0opaq4ZsGdQIBcHZ6iB3aVjhhekhjwdz0hznzaXVDEMahxESs
 9l31meso2+80EJwFL04C93tMpx/3pSxJZN8EFrUQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.128.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1jV0N33P5v-00pfA3; Wed, 08
 Jan 2020 22:39:02 +0100
Subject: Re: [PATCH 2/3] hw/hppa/machine: Do not limit the RAM to 3840MB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
References: <20200108181425.21485-1-f4bug@amsat.org>
 <20200108181425.21485-3-f4bug@amsat.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <6997ceed-9a68-796c-f03d-02bfd7d76803@gmx.de>
Date: Wed, 8 Jan 2020 22:39:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108181425.21485-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zA1YZeAXdYA6tdXF/IQh0SBBT0u/Mz3pzxYyTxKQKIUNnkiobmn
 BtPWZCCNf1krLSImpAdGBWkp7a1ArSduBZg93F4ZhMYLRXDLh5PCd1SdABXtJswyOo4dJmr
 +WdLdqeuUVJZB+yw5yvwF1V5xXVTG9XAWOon57XaIU8KvKVsR75Ya2V42TtcUavTyDcWeVW
 vEI+jAqTSFyQGCjKMxMWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5iCwhSNB11g=:MvvA+FQyHMB6B4fp2uJ23t
 hZ8xR6F6BmzuhJwqMKVjTRko72NkJPyY+8r52DFRkD/hTqtj+MyUsy5ogYIDWZdRp58Lnbdeo
 MLdbiJdgdzmne62O95W79VJjeRya8sUaxRzUWgxc4bGYYMEHQ+/qY63Q0C+nRMDgqKcP8xFpz
 sBY3orlVmsTlp5IFFIHWGI4EhBSrwkpchU3MMi/6hjBsgEdq7Lb3szuFYQXO+n7ACvtLh7mnI
 A8S0uUByJR/Nj2PiEEnoGjTlzS+UMJXoB5P2APoKvJtAzL+wbWoFHUDkGwJM6zyKcqYkn0tt+
 OzMqOhHHazZjVjGnhmS5/l8Yzgx5SqW3hwXj5UuY1rkQ5z3fAlN9cVnGKPAL7uK5qI8Y2uKO3
 etVqijJr9ACNq5PgCRUT5aAELbxFlMT8VNL5eTCl2HR60Km/J3i6RYbJUEZcSgTdb2lu3CAlS
 isyGYwEvtT543fQb9Xtj98SMwS/vtVnNEtFGZ2LgXOfS5gklbtv5gURlWhfvBZZNwcWfuIgL3
 ZMr3338ZxM9Z+uSbgFGEIEge1RHu09ar3n3SisVxLi29g0q0UiXvnEMFxgtAJ/V2Eq7FhnHCt
 w3b2/V+rLLsA64d0PTkI0VdJlzy2z3V54iprCxe5zxkLnOBYiCadrDLBi5n9ddWL81RsJnrUz
 mQo9oCquLbfo4ZCRW/EOQwI3J/xy+jKoQKFaFM6+DGZ8F/5h8tQbkZwio4Q+WarL+pg/EV1+O
 0yrAp9RGbHUlhpkolI9Y5FBiNBZR6b6YQgjXA545tyEt6em78rY2njTkeH59AgYoig3m6hdK7
 z2I72WfPg5VESSSe0XnlPdcezb8PNnb5J3l6MWVmiicu9aTLocU/Z5pTvGejF4eAUOZwXUyit
 c8r254imXdczmcV9li2BkqVWAOHDIVSw5VKF1h/+WtLoFVeejHsacDVUztfTDV2NHHI8G/PhE
 2Qg0iMarR6HU0iQVJQv5S64TKjPmDV4bcYHUdNlA+CRF9ZGjBsLMFUr6i9OACArm3c9AwXUsv
 jLqTWeUu8f55TJ3MAIhNGcPkDeyo7LTQUZeYluAwIDrpYR6lRUZ73DkVMJtEVSnt28B1C6tq+
 NhN2ShtM/9AGSq3eghbLjCCvg7DouCviRTZv8GUqwBC6S7nQZG/K7wLoa1XqJleAZIuiWMDsD
 KUqgue1t2ySnwC5QA5i4Pg2VSIAiYQWWVhNoQJcaSo02WqsSbCNxAkK+XVcaEEF8blSnAjYvm
 Lh6NHjCM2T52KLJhdB2ngoeOpZ9nel5x4YCSzig==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.22
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.01.20 19:14, Philippe Mathieu-Daud=C3=A9 wrote:
> The hardware expects DIMM slots of 1 or 2 GB, allowing up to
> 4 GB of memory. Accept the same amount of memory the hardware
> can deal with.
>
> The CPU doesn't have access to the RAM mapped in the
> [0xf0000000 - 0xf1000000] range because this is the PDC area
> (Processor Dependent Code) where the firmware is loaded.
> To keep this region with higher priority than the RAM, lower
> the RAM priority. The PDC will overlap it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/hppa/machine.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 6775d879f8..d10c967d06 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -90,16 +90,15 @@ static void machine_hppa_init(MachineState *machine)
>          g_free(name);
>      }
>
> -    /* Limit main memory. */
> -    if (ram_size > FIRMWARE_START) {
> -        machine->ram_size =3D ram_size =3D FIRMWARE_START;
> -    }
> -
>      /* Main memory region. */
> +    if (machine->ram_size > 4 * GiB) {
> +        error_report("RAM size of 4GB or more is not supported");
> +        exit(EXIT_FAILURE);
> +    }

My suggestion is to initially then limit it to max. 3GB, e.g.
> +    if (machine->ram_size > 3 * GiB) {
> +        error_report("RAM size of 3GB or more is not supported");
> +        exit(EXIT_FAILURE);

That way you don't need to work around the 4GB SeaBIOS limitation
in your other RFC patch.
So, people can start it with:
qemu-system-hppa -m 3g -serial stdio

Later then we can fix SeaBIOS, at least if 64bit support gets added later =
on.

>      ram_region =3D g_new(MemoryRegion, 1);
>      memory_region_allocate_system_memory(ram_region, OBJECT(machine),
>                                           "ram", ram_size);

^^^ here is still "ram_size". Do you need to change it?

> -    memory_region_add_subregion(addr_space, 0, ram_region);
> +    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
>
>      /* Init Dino (PCI host bus chip).  */
>      pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
>

Helge

