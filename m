Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2C8C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020F320679
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020F320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoeS-0008AJ-5T
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHod8-0007Wl-VL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHod7-0006CB-Bu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:30:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHod7-00068b-3R
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:30:17 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 84F4E87633
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 12:30:15 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k2so9053231wrn.7
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 05:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SzLsurWUVKEeS1YRLEZjd6KEuIZJX+pbn8SYSUiPZp8=;
 b=Oy4M60KMtKy3BYiUTBoCZHP7HJj7QEuBrbntzcPwByEPr6VoZuDDPzHt/rPgUaDb74
 bhCcAXHeMAm0s381mfxWYVmATVUJeliVCQ1Yce5FBt/hzXuORCamWqmui/BNPAALZxz/
 iIJsp1uHtJ378jZiyUoTRVWgiBWDP1OE7DqpOWX03aLACQLM5hvTp2JMTYMAbuey2olq
 FZlQFxRbr/jY7L6NCO+oLLegd16Aw+RglhfwEHwjT4btk/g9jvU/RDkZN9gekVlqzA0M
 EfS+kcORpAOFDxAmS3qgpoD0/pi8dor1bMehaQ/ObOBb7f0/Ciqtk3IIn4FkqPvuy6jO
 YXzg==
X-Gm-Message-State: APjAAAVo8zElhpYSMxZ8+x4QdzxaQHG5jx4bwcfPUGZi+6gSvAYP866r
 WhZa96Lzd14mkiB0+xy7f7z+PiIJJt23kH4EoIgWd+S2PNMQEW3/hnt+CSSMd5Vd3Mtl6JSq/3Q
 91/amZkqMcVO1i5M=
X-Received: by 2002:a5d:6704:: with SMTP id o4mr27237679wru.365.1570537814329; 
 Tue, 08 Oct 2019 05:30:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzko08ueHBiq/VMdMvb072v0QrB2O1L1OshvRpLgcccs90IMVXWte1FmgSr048CuCL9F1COyw==
X-Received: by 2002:a5d:6704:: with SMTP id o4mr27237665wru.365.1570537814178; 
 Tue, 08 Oct 2019 05:30:14 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o22sm44804952wra.96.2019.10.08.05.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 05:30:13 -0700 (PDT)
Subject: Re: [PATCH 3/3] hppa: drop usage of
 memory_region_allocate_system_memory() for ROM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20191008113318.7012-1-imammedo@redhat.com>
 <20191008113318.7012-4-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9dd334b4-7b9e-e130-fde4-c63a40b742db@redhat.com>
Date: Tue, 8 Oct 2019 14:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008113318.7012-4-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org,
 hpoussin@reactos.org, david@gibson.dropbear.id.au, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:33 PM, Igor Mammedov wrote:
> machine_hppa_init() violates memory_region_allocate_system_memory() con=
tract
> by calling it multiple times which could break with -mem-path. Replace
> the second usage (for 'rom') with memory_region_init_ram() instead.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/hppa/machine.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 7e23675429..953d454f48 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -161,9 +161,8 @@ static void machine_hppa_init(MachineState *machine=
)
>       g_free(firmware_filename);
>  =20
>       rom_region =3D g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(rom_region, OBJECT(machine),
> -                                         "firmware",
> -                                         (FIRMWARE_END - FIRMWARE_STAR=
T));
> +    memory_region_init_ram(rom_region, NULL, "firmware",
> +                           (FIRMWARE_END - FIRMWARE_START), &error_fat=
al);
>       memory_region_add_subregion(addr_space, FIRMWARE_START, rom_regio=
n);
>  =20
>       /* Load kernel */
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

