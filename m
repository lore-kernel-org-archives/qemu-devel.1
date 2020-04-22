Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64060C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371762082E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371762082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGGJ-0005wU-B0
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRGFB-0004lK-Lw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jRGF9-00061c-Sw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:20:52 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:58948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jRGF9-0005xu-DN; Wed, 22 Apr 2020 10:20:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7677E746331;
 Wed, 22 Apr 2020 16:20:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 58D71746324; Wed, 22 Apr 2020 16:20:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 57819746333;
 Wed, 22 Apr 2020 16:20:47 +0200 (CEST)
Date: Wed, 22 Apr 2020 16:20:47 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 3/4] bamboo, sam460ex: Tidy up error message for
 unsupported RAM size
In-Reply-To: <20200422134815.1584-4-armbru@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2004221620020.19234@zero.eik.bme.hu>
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-4-armbru@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2001:738:2001:2001::2001
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
Cc: philmd@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Apr 2020, Markus Armbruster wrote:
> Improve
>
>    $ ppc-softmmu/qemu-system-ppc -M sam460ex -m 4096
>    qemu-system-ppc: Max 1 banks of 2048 ,1024 ,512 ,256 ,128 ,64 ,32 MB DIMM/bank supported
>    qemu-system-ppc: Possible valid RAM size: 2048
>
> to
>
>    qemu-system-ppc: at most 1 bank of 2048, 1024, 512, 256, 128, 64, 32 MiB each supported
>    Possible valid RAM size: 1024 MiB
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/ppc/ppc4xx_devs.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 3376c43ff5..f1651e04d9 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -716,11 +716,11 @@ void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
>         for (i = 0; sdram_bank_sizes[i]; i++) {
>             g_string_append_printf(s, "%" PRIi64 "%s",
>                                    sdram_bank_sizes[i] / MiB,
> -                                   sdram_bank_sizes[i + 1] ? " ," : "");
> +                                   sdram_bank_sizes[i + 1] ? ", " : "");
>         }
> -        error_report("Max %d banks of %s MB DIMM/bank supported",
> -            nr_banks, s->str);
> -        error_report("Possible valid RAM size: %" PRIi64,
> +        error_report("at most %d bank%s of %s MiB each supported",
> +                     nr_banks, nr_banks == 1 ? "" : "s", s->str);
> +        error_printf("Possible valid RAM size: %" PRIi64 " MiB \n",
>             used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB);
>
>         g_string_free(s, true);
>

