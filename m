Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA1FCA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 21:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19005218BA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 21:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19005218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMJ5w-0005EQ-7N
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 17:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMJ4q-0004gO-Rk
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 17:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMJ4o-0003Da-6p
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 17:49:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMJ4n-0003CY-Ua
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 17:49:26 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C78F83F3D
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 21:49:23 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z205so5076181wmb.7
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 14:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HU3iiwiTu0JOyf97iOvGDIJvOnse/UXfG0kN4ZYQzLM=;
 b=nYKFgFKosyqK40KqhV74/+z+tUqjnGJj8aIyEKmDes7v1pWpZmYUQoB/kSueX6XPwp
 A2/zcVJATGkwL3plvPjWGD0BU9NT3nD3GUPxz87i7EmdMzgshsCSx5HaFfPJuLzUEiki
 n9Vbw7FaY4AfVAkTCJL8cbRSN7aoT0CtYekqaBrOFHIhA8wZ36dozZvW8WgaQXHFtToL
 Oh41EBIIcdwO91rOA7W9UvmnUlwRhZyDOlzSVtzZI//zPuT+tctR9LwV1Yh+uyfQ4a9Z
 6FeHmGIHb21fQfjO2z2tHmnIz4hnZnioZm8RS3FSPPwHKV4Jr1FGDPvKTiFcUScfP1X1
 VvJQ==
X-Gm-Message-State: APjAAAWsYauMopD1qKhGUddv1FmX/KPgzdblGT9vZol79lWq8e5AUU4Z
 OUNB5vQ4MMTrfraPOWF+6hFEt4wkARIxxlHKawMx8rlDz348fhc7xdVDy76NTkM1/7dzHob3Bmo
 3QG0Ipf+uuJ6YgwE=
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr15996213wmj.85.1571608162337; 
 Sun, 20 Oct 2019 14:49:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQtBlYav6m5TX9XFE+qABb5YWF/WKhYEQaOGB0jns2KmeiASS9ecUHUoomQse0yTh4s+p5yA==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr15996200wmj.85.1571608162042; 
 Sun, 20 Oct 2019 14:49:22 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id q22sm11210661wmj.5.2019.10.20.14.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2019 14:49:21 -0700 (PDT)
Subject: Re: [PATCH 3/3] hppa: drop usage of
 memory_region_allocate_system_memory() for ROM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20191008113318.7012-1-imammedo@redhat.com>
 <20191008113318.7012-4-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5ee6df98-6bdb-793d-ef28-f2c68a245f51@redhat.com>
Date: Sun, 20 Oct 2019 23:49:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
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

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

