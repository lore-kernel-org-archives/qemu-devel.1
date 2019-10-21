Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD2FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7731520873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="vm9HarLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7731520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMdJS-0006eC-IA
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 15:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1iMdI1-0004rV-8U
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1iMdHz-0001ec-Sc
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:24:25 -0400
Received: from mail-eopbgr790129.outbound.protection.outlook.com
 ([40.107.79.129]:51055 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1iMdHz-0001dy-FZ; Mon, 21 Oct 2019 15:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3WsG0hXi5IHWWtXmhr+La3bme+guKPu6nHewO5tU/1DVPDvWlgjeIsF63YOdp6KaE/SDZhapdQeRulVAPVfWvw2GtELXke2/yyl5JF1f8eiSUIQGoegubQr2oMM9cS9NtDiqnVUISWYCF3R/t1C19f+iPL1X/QpJhia+D4hp0BmKXVlP/+7nkcMVQia0s+Ihc5SxOHS5/8+8LisR02h8j6mYFjRYx7wARzvVkIpek1KW9mx118elbauz6SkSZDdIxwe7FBxV8DGUH17+tZxAhcxRFq01YDUcAGR9O0UM5kzkt57aOJIY88zOIpzBw4kUKdWGlsCWQWeULl64vw97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73H29hOaq20Z0USTOfWYxLEfqab4x4mR7l1SWJ7ADtA=;
 b=hViqvG0DdKEGJXk5JKgdob4rCtx644T2otbOT3WV4DJSs75Ilk9Sn1f77BG6ksbNrqAE5cKHB/3hhP6+cMsRw6OVi7Z14NaUT4o3GpTt9IwSoRS2jr+J42FZcT/gYL3IgazSsSVoS8IrFOA9oTRDHxqsBqWCtAhFJrKPMg32bTwV8RkujfK5BRp4CznH9niLkZ0uk6jY3nvaEnB3SK+sqJE/ZYioLCu1gAqZqjgDoGL2NWCiR2JUUj/Rgy33KJ4ODCp88ORPKWoS/mpaYLMXiJDoYjxntUXtUB8e0CsToZQgw7XaWkg5oML7RyLjnzhAwsk0llKUkPeLc9zGy9pZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73H29hOaq20Z0USTOfWYxLEfqab4x4mR7l1SWJ7ADtA=;
 b=vm9HarLw4KI6XmGqMOp7rwglOZ80pVjmGnSYoXfPhxGHvT8qXaR1rAWt2sSRcCCC6DKMxU1SRoVk0/vwBcCoSbflTju7O9WFo8sy38Ibfwl/dCwB+vuIsaH6fHU06E/YhonJ8BlRwTRqBfBDFAkN9Jz7+jOLmEFdZNoXDKR4wdc=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1442.namprd22.prod.outlook.com (10.174.91.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 21 Oct 2019 19:24:11 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::850f:a4cc:f2f8:364a]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::850f:a4cc:f2f8:364a%11]) with mapi id 15.20.2347.029; Mon, 21 Oct
 2019 19:24:11 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [EXTERNAL][PATCH 18/21] hw/mips: Let the machine be the owner of
 the system memory
Thread-Topic: [EXTERNAL][PATCH 18/21] hw/mips: Let the machine be the owner of
 the system memory
Thread-Index: AQHVh5qMTYYCsmPPxUOCxUGGTGsiZ6dleo5T
Date: Mon, 21 Oct 2019 19:24:11 +0000
Message-ID: <BN6PR2201MB12510A0641A2D00A823312B8C6690@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20191020225650.3671-1-philmd@redhat.com>,
 <20191020225650.3671-19-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-19-philmd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 994070a8-3dcf-47ab-d111-08d7565c407a
x-ms-traffictypediagnostic: BN6PR2201MB1442:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR2201MB144262DEC457862B9E0DA909C6690@BN6PR2201MB1442.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:113;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(39840400004)(376002)(346002)(189003)(199004)(7736002)(305945005)(6246003)(2906002)(6436002)(86362001)(4326008)(7406005)(7416002)(74316002)(229853002)(478600001)(256004)(14454004)(53546011)(64756008)(66556008)(66476007)(66446008)(91956017)(186003)(476003)(71200400001)(54906003)(66946007)(71190400001)(486006)(99286004)(11346002)(52536014)(33656002)(446003)(316002)(102836004)(2501003)(76116006)(81156014)(55016002)(66066001)(81166006)(9686003)(25786009)(3846002)(6116002)(8936002)(110136005)(55236004)(76176011)(7696005)(8676002)(5660300002)(6506007)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1442;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHmP45t8iJ/Z2hWAHdaiQG0fw7/wQJHUtt3KCbKy1sYhfCpYPaVXuCxVMl31l3RQBUUIFpd99byQUp/eyFAf7uIlR66VA7pqOaJbhdWQOw91f0Dliw3QEDZLrTEYHd7xuT/WGj+k27JC9p03joddkGJoErrw03h2UgxLrsQqzJTdtjg5iSoHNOWznlaTUzuJcUpre8c+FVF3t1VqmvcbnmI9p6PMIV6QLe/TAfR22ayuSsGvr3jbYLBl7y1BMPPDaPtVqY56yAgkSig7zb+HMqPy04ZVOgzGloFrNLZqTZh7cGi1RwgO2GLNaGaL0FVVohU2Kfnxrr5ssl50nYhJ1Mf0hZWw61RYZTMlcFhFa7RCGPMKyD4JOxhnWmOZMAdkwEnC9amoEpy1rkzoqFHEr7ky1hqeIMi2AJwuJrDH891YsyOg6U0XDJala0HahH4l
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994070a8-3dcf-47ab-d111-08d7565c407a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 19:24:11.0807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiY4zIta3YoXAYsj+AF0/bGakAC2uBWSbKXm0637OZxcdI2ZYKQwCF3UH9NkQYyFasvQlgRMxdN9qqzcFNGBoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1442
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.129
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
 =?iso-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/mips/boston.c        | 2 +-
>  hw/mips/mips_fulong2e.c | 3 ++-
>  hw/mips/mips_jazz.c     | 2 +-
>  hw/mips/mips_malta.c    | 2 +-
>  hw/mips/mips_mipssim.c  | 2 +-
>  hw/mips/mips_r4k.c      | 3 ++-
>  6 files changed, 8 insertions(+), 6 deletions(-)

When the commit message is completed:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

________________________________________
From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Sent: Monday, October 21, 2019 12:56 AM
To: Paolo Bonzini; Igor Mammedov; qemu-devel@nongnu.org; Markus Armbruster;=
 Eduardo Habkost
Cc: Thomas Huth; Antony Pavlov; Michael Walle; David Gibson; qemu-arm@nongn=
u.org; KONRAD Frederic; C=E9dric Le Goater; Fabien Chouteau; Andrey Smirnov=
; Joel Stanley; Peter Chubb; Andrew Jeffery; Helge Deller; Aurelien Jarno; =
Jean-Christophe Dubois; Jan Kiszka; Paul Burton; qemu-ppc@nongnu.org; Herv=
=E9 Poussineau; Andrew Baumann; Mark Cave-Ayland; Beniamino Galvani; Artyom=
 Tarasenko; Edgar E. Iglesias; Leif Lindholm; Aleksandar Markovic; Michael =
S. Tsirkin; Radoslaw Biernacki; Rob Herring; Richard Henderson; Alistair Fr=
ancis; Andrzej Zaborowski; Marcel Apfelbaum; Philippe Mathieu-Daud=E9; Alek=
sandar Rikalo; Peter Maydell
Subject: [EXTERNAL][PATCH 18/21] hw/mips: Let the machine be the owner of t=
he system memory

Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
---
 hw/mips/boston.c        | 2 +-
 hw/mips/mips_fulong2e.c | 3 ++-
 hw/mips/mips_jazz.c     | 2 +-
 hw/mips/mips_malta.c    | 2 +-
 hw/mips/mips_mipssim.c  | 2 +-
 hw/mips/mips_r4k.c      | 3 ++-
 6 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index ca7d813a52..8445fee0f1 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -474,7 +474,7 @@ static void boston_mach_init(MachineState *machine)
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);

     ddr =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ddr, NULL, "boston.ddr",
+    memory_region_allocate_system_memory(ddr, machine, "boston.ddr",
                                          machine->ram_size);
     memory_region_add_subregion_overlap(sys_mem, 0x80000000, ddr, 0);

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index cf537dd7e6..d5a5cef619 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -318,7 +318,8 @@ static void mips_fulong2e_init(MachineState *machine)
     ram_size =3D 256 * MiB;

     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_si=
ze);
+    memory_region_allocate_system_memory(ram, machine,
+                                         "fulong2e.ram", ram_size);
     memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(bios, true);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 8d010a0b6e..88b125855f 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -188,7 +188,7 @@ static void mips_jazz_init(MachineState *machine,
     cc->do_transaction_failed =3D mips_jazz_do_transaction_failed;

     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
+    memory_region_allocate_system_memory(ram, machine, "mips_jazz.ram",
                                          machine->ram_size);
     memory_region_add_subregion(address_space, 0, ram);

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 4d9c64b36a..af56a29ccb 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1267,7 +1267,7 @@ void mips_malta_init(MachineState *machine)
     }

     /* register RAM at high address where it is undisturbed by IO */
-    memory_region_allocate_system_memory(ram_high, NULL, "mips_malta.ram",
+    memory_region_allocate_system_memory(ram_high, machine, "mips_malta.ra=
m",
                                          ram_size);
     memory_region_add_subregion(system_memory, 0x80000000, ram_high);

diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 282bbecb24..c1933231e2 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -166,7 +166,7 @@ mips_mipssim_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);

     /* Allocate RAM. */
-    memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
+    memory_region_allocate_system_memory(ram, machine, "mips_mipssim.ram",
                                          ram_size);
     memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
                            &error_fatal);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index bc0be26544..59f8cacfb6 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -203,7 +203,8 @@ void mips_r4k_init(MachineState *machine)
                      " maximum 256MB", ram_size / MiB);
         exit(1);
     }
-    memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram", ram_si=
ze);
+    memory_region_allocate_system_memory(ram, machine, "mips_r4k.ram",
+                                         ram_size);

     memory_region_add_subregion(address_space_mem, 0, ram);

--
2.21.0


