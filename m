Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2461CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731D42067B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731D42067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTRN-0004W5-Ks
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMTQR-0003Pb-Me
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMTQQ-0005mB-An
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:52:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMTQQ-0005lf-38
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:52:26 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09D813B70E
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:52:25 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k65so1998346wma.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 01:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oV4ge5qxJiVtfmz8+Jt95uPQU/0vGeF4cLF7Tfjen+Q=;
 b=rXzb76DUFFFgcWuZbEHt6noQcdO9B6PTeEfTgzHWnqHSwee91kNatPRWluFSFM6Qc9
 Dccyx0DuHxyPoJYNocV3CWicxpgHsIaCt3eR4u2dnxd1RZNEn3MrKFpP9BOanCfwEFK7
 uO4KEuYGaCyFll7zvnApufwO2vLGgCu6rbvv4ORmpfL3FApNG4D24TI1x4Mtg+Dkf+P+
 LNDPAziom6mBcDgFOwTww6doUUtaF+rS1AlNFMqgT6E7iUlaUgKLpP9XTZNthCxN7Yun
 YNfYGHzyJEInE7V2+4/8SSw2aWKKmFDIlRQoE4JtOwp5BNZJXd3HbEfE/XK7+0Zgr5w5
 dKzg==
X-Gm-Message-State: APjAAAXdw+fqNCzT/YZ97poMsfw6y6BApBQmqjEc+Qx9zQTIlY87M4eg
 kl4sDQ9x4/+X//8fD/UjXD6pmRXvp5kMkdQObC28gSMJRuhGYgGdfY3zy9zFWn9uTmAxMHzxbPH
 lp2bN2fZHITXxqo8=
X-Received: by 2002:adf:e512:: with SMTP id j18mr8443537wrm.291.1571647943634; 
 Mon, 21 Oct 2019 01:52:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxL0jYglI7EAYJk47HpS+dvaOsHHrRDOfdUpZbtLUDXpk+wQrmCFCK+nurhB4pCj1rJxTwHTw==
X-Received: by 2002:adf:e512:: with SMTP id j18mr8443496wrm.291.1571647943407; 
 Mon, 21 Oct 2019 01:52:23 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id z125sm20278358wme.37.2019.10.21.01.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 01:52:22 -0700 (PDT)
Subject: Re: [PATCH 00/21] hw: Let the machine be the owner of the system
 memory
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aad956d5-986c-bb9f-7735-cf18796b986e@redhat.com>
Date: Mon, 21 Oct 2019 10:52:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-1-philmd@redhat.com>
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 12:56 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> This series is based on Igor's "eliminate remaining places that
> abuse memory_region_allocate_system_memory()":
> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01601.html
>=20
> It is quite simple, we enforce all machines to be the QOM owner
> of the system memory.
>=20
> This changes the memory tree from:
>=20
>    (qemu) info mtree -o
>    memory-region: pc.ram
>      0000000000000000-0000000007ffffff (prio 0, ram): pc.ram parent:{ob=
j path=3D/machine/unattached}
>=20
> to:
>=20
>    (qemu) info mtree -o
>    memory-region: pc.ram
>      0000000000000000-0000000007ffffff (prio 0, ram): pc.ram owner:{obj=
 path=3D/machine}
>=20
> Few patches are required to clean the codebase first, to unify the
> creation of the system memory in the board/machine code. Mostly some
> old ARM machines (pre-QOM) were affected.
>=20
> Please review (as a generic codebase cleanup).
>=20
> Regards,
>=20
> Phil.
>=20
> Based-on: <20191008113318.7012-1-imammedo@redhat.com>
>=20
> Philippe Mathieu-Daud=C3=A9 (21):
>    hw/arm/xilinx_zynq: Use the IEC binary prefix definitions
>    hw/arm/mps2: Use the IEC binary prefix definitions
>    hw/arm/collie: Create the RAM in the board
>    hw/arm/omap2: Create the RAM in the board
>    hw/arm/omap1: Create the RAM in the board
>    hw/arm/digic4: Inline digic4_board_setup_ram() function
>    hw: Drop QOM ownership on memory_region_allocate_system_memory() cal=
ls
>    hw/alpha/dp264: Create the RAM in the board
>    hw: Let memory_region_allocate_system_memory take MachineState
>      argument
>    hw/core: Let the machine be the owner of the system memory
>    hw/alpha: Let the machine be the owner of the system memory
>    hw/arm: Let the machine be the owner of the system memory
>    hw/cris: Let the machine be the owner of the system memory
>    hw/hppa: Let the machine be the owner of the system memory
>    hw/i386: Let the machine be the owner of the system memory
>    hw/lm32: Let the machine be the owner of the system memory
>    hw/m68k: Let the machine be the owner of the system memory
>    hw/mips: Let the machine be the owner of the system memory
>    hw/ppc: Let the machine be the owner of the system memory
>    hw/sparc: Let the machine be the owner of the system memory
>    hw/core: Assert memory_region_allocate_system_memory has machine own=
er

I forgot 4 other calls:

hw/ppc/ppc4xx_devs.c:708:    memory_region_allocate_system_memory(ram,=20
NULL, "ppc4xx.sdram", ram_size);
hw/s390x/s390-virtio-ccw.c:164:=20
memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
hw/sparc/sun4m.c:791:    memory_region_allocate_system_memory(&d->ram,=20
NULL, "sun4m.ram",
hw/sparc64/niagara.c:114:=20
memory_region_allocate_system_memory(&s->partition_ram, NULL,

