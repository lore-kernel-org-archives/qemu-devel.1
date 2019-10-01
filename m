Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F46C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648FB20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648FB20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIix-0005g0-S2
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFIh5-0004TJ-UE
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFIh4-0004ee-6A
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFIh3-0004eD-Ub
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:59:58 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09C30BCFE2
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 13:59:57 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k67so960357wmf.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qD1al40mA4X7MPZltqif5xayszV7Finf/pVJ3uD4ZNY=;
 b=jdIhDfwrCwpfnW2vmjlkPK0UDGb2/oC3H4xm9rQFi6a2PZKJlRbRNj9Go4rqn0MsKf
 fqf2qGgsCU9U95TMOHRBikgg7L24aF2szZNkeBKpDzWpetfiQifpIO2yBt92xgUDRkl4
 mgvWpBp790Bh5tppe+ipvO8Lb5bJb/cudXEOHJ2BGj338vJ1cZBlShsrZVQdMADa/PuA
 rlNyC0aJ4NYklkbElKeiyc2jiQ9co/ftBfGRt1EtfqLSwZpXD0th2sxD0DJQQ/Xm8TaV
 EWbpYshmk/1Agtx2bstsGkgu7Siu9Ct1KXsw7seint9zl8yiI6lC48emjiKob6FQnPDf
 BKKA==
X-Gm-Message-State: APjAAAX+o5E/vvJX3b1yx2cRqi6twJszJhnf7zefETSwDuP2Z8OBbfCA
 Mw6g2Ul2fkAVCpnRgeLA5txSyLcHPJGhDy/7rTwvdVzmXf8Yjdo98Y/J7Wj9M6sKjAMqynW5IgF
 M3NTY+6NdR0MZ9bc=
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr19447863wrg.74.1569938395639; 
 Tue, 01 Oct 2019 06:59:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5gaQt5jQ3zEIlcALf88NCPS09b1Q8IOfyop0qiRotEBZ+fAWF9Osj2VpIRzhCPRPoShCRpg==
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr19447851wrg.74.1569938395491; 
 Tue, 01 Oct 2019 06:59:55 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b7sm13605450wrj.28.2019.10.01.06.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:59:54 -0700 (PDT)
Subject: Re: [PATCH 4/8] hppa: fix leak from g_strdup_printf
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
 <1569936988-635-5-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3640fc5b-3bd7-4d6f-9c98-ef7ecae14844@redhat.com>
Date: Tue, 1 Oct 2019 15:59:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569936988-635-5-git-send-email-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 3:36 PM, Paolo Bonzini wrote:
> memory_region_init_* takes care of copying the name into memory it owns=
.
> Free it in the caller.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/hppa/dino.c    | 1 +
>   hw/hppa/machine.c | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
> index e0466ee..ab6969b 100644
> --- a/hw/hppa/dino.c
> +++ b/hw/hppa/dino.c
> @@ -485,6 +485,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
>           memory_region_init_alias(&s->pci_mem_alias[i], OBJECT(s),
>                                    name, &s->pci_mem, addr,
>                                    DINO_MEM_CHUNK_SIZE);
> +        g_free(name);
>       }
>  =20
>       /* Set up PCI view of memory: Bus master address space.  */
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 2736ce8..7e23675 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -78,13 +78,15 @@ static void machine_hppa_init(MachineState *machine=
)
>  =20
>       /* Create CPUs.  */
>       for (i =3D 0; i < smp_cpus; i++) {
> +        char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
>           cpu[i] =3D HPPA_CPU(cpu_create(machine->cpu_type));
>  =20
>           cpu_region =3D g_new(MemoryRegion, 1);
>           memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_ei=
r_ops,
> -                              cpu[i], g_strdup_printf("cpu%ld-io-eir",=
 i), 4);
> +                              cpu[i], name, 4);
>           memory_region_add_subregion(addr_space, CPU_HPA + i * 0x1000,
>                                       cpu_region);
> +        g_free(name);
>       }
>  =20
>       /* Limit main memory. */
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

