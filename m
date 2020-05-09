Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE61FC28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 20:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EDE20731
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 20:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EDE20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXVgI-0003RB-ML
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 16:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXVfP-0001kA-05; Sat, 09 May 2020 16:01:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXVfN-0006h4-N4; Sat, 09 May 2020 16:01:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id b91so85187edf.3;
 Sat, 09 May 2020 13:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OxfL0UPSJno+2EUjjhpNsjBaPYzXLE/oZ40gfSPjXpE=;
 b=sbmoARaFK+15ma8wI2YerdXQTChXYZZmFwd7nul4b8rs+I2qOlcGF9WsgA2DBoc6wE
 w89GBO3xkVR/j3UuiWmZqvVJAz1S89OFaTg6bGbSaEBoTQqn8PnJAVfQIw/4wzVmw9Lk
 CT5hOhqvc17vhaT4ZzEmYnQXOPhCl3o0NQ1IIzucUn2LDQlyA1cwJYrhOhtChKzE37hS
 2BXVV1sqxcBJQ1RMrjgfPsnjivqoBtk01wEhOEj/FJ8Q5Z6O2UFT63QwE1I4Wg2N0eX3
 IjGYxmwZNrhaq6sWxTyVPvRJ0aItY0QGHT59lwfSfBfHRynrTQxhdSObbfCHnvWS/gmj
 0qMQ==
X-Gm-Message-State: AGi0Pubq6MQ8j5a/Om+i9uOhS6RwVRbHp2p1COEL+PzTYQXIopyRLTkd
 mD+AvQMN2ozcWHhxpkGZRzUBpUm22VNoMLLe0ht3C0quWvs=
X-Google-Smtp-Source: APiQypJmeQftIJvvC+BxNCOoNrPcjZ7VoK69GaJv7Xj8mt5c1GYVfjptAJTsW9Qjjj70Cf+t1v5R70xJENcn/VmWzyA=
X-Received: by 2002:a50:c3c2:: with SMTP id i2mr7108561edf.93.1589054502343;
 Sat, 09 May 2020 13:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-10-f4bug@amsat.org>
 <ba3d3ba1-09bf-17a0-2116-549fa92e1ed6@amsat.org>
In-Reply-To: <ba3d3ba1-09bf-17a0-2116-549fa92e1ed6@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 9 May 2020 22:01:30 +0200
Message-ID: <CAAdtpL5KT0H3+yVRgzCwVaLYUUSCBW8vK4X3cHX_N91NPkUFBg@mail.gmail.com>
Subject: Re: [PATCH 09/11] target/cpu: Restrict handlers using hwaddr type to
 system-mode
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 16:01:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "open list:vfio-ccw" <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 9, 2020 at 6:08 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> On 5/9/20 3:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Restrict the following handlers to system-mode:
> > - do_unaligned_access
> > - do_transaction_failed
> > - get_phys_page_debug
> > - get_phys_page_attrs_debug
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >   include/hw/core/cpu.h           |  8 +++++---
> >   target/alpha/cpu.h              |  4 +++-
> >   target/arm/cpu.h                |  6 +++---
> >   target/arm/internals.h          |  4 ++++
> >   target/cris/cpu.h               |  2 ++
> >   target/hppa/cpu.h               |  2 +-
> >   target/i386/cpu.h               |  2 ++
> >   target/m68k/cpu.h               |  7 ++++++-
> >   target/microblaze/cpu.h         |  5 ++++-
> >   target/mips/internal.h          |  2 +-
> >   target/nios2/cpu.h              |  5 ++++-
> >   target/openrisc/cpu.h           |  3 ++-
> >   target/ppc/cpu.h                |  2 +-
> >   target/riscv/cpu.h              | 20 ++++++++++----------
> >   target/sh4/cpu.h                |  2 +-
> >   target/sparc/cpu.h              |  2 ++
> >   target/xtensa/cpu.h             | 12 +++++++-----
> >   target/hppa/cpu.c               |  4 +++-
> >   target/ppc/translate_init.inc.c |  2 +-
> >   19 files changed, 62 insertions(+), 32 deletions(-)
> >
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 5bf94d28cf..ed09d056d1 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -167,6 +167,7 @@ typedef struct CPUClass {
> >       int reset_dump_flags;
> >       bool (*has_work)(CPUState *cpu);
> >       void (*do_interrupt)(CPUState *cpu);
> > +#ifndef CONFIG_USER_ONLY
>
> I forgot once Peter Maydell told me we can't do that for some reason I
> don't remember.
>
> At least this changes the sizeof(CPUClass), so we get:
>
> qom/object.c:315:type_initialize: assertion failed: (parent->class_size
> <=3D ti->class_size)
>
> So we can't poison the hwaddr type? (final patch of this series).

Well, this works...:

-- >8 --
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -167,6 +167,7 @@ typedef struct CPUClass {
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
+#ifndef CONFIG_USER_ONLY
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
                                 MMUAccessType access_type,
                                 int mmu_idx, uintptr_t retaddr);
@@ -174,6 +175,12 @@ typedef struct CPUClass {
                                   unsigned size, MMUAccessType access_type=
,
                                   int mmu_idx, MemTxAttrs attrs,
                                   MemTxResult response, uintptr_t retaddr)=
;
+    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
+    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
+                                        MemTxAttrs *attrs);
+#else
+    void (*reserved[4])(CPUState *cpu, ...);
+#endif /* CONFIG_USER_ONLY */
     bool (*virtio_is_big_endian)(CPUState *cpu);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
@@ -189,9 +196,6 @@ typedef struct CPUClass {
     bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
-    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
-    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
-                                        MemTxAttrs *attrs);
     int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
     int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
     int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
---

Ugly?

>
> >       void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
> >                                   MMUAccessType access_type,
> >                                   int mmu_idx, uintptr_t retaddr);
> > @@ -174,6 +175,10 @@ typedef struct CPUClass {
> >                                     unsigned size, MMUAccessType access=
_type,
> >                                     int mmu_idx, MemTxAttrs attrs,
> >                                     MemTxResult response, uintptr_t ret=
addr);
> > +    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> > +    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> > +                                        MemTxAttrs *attrs);
> > +#endif /* CONFIG_USER_ONLY */
> >       bool (*virtio_is_big_endian)(CPUState *cpu);
> >       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
> >                              uint8_t *buf, int len, bool is_write);
> > @@ -189,9 +194,6 @@ typedef struct CPUClass {
> >       bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
> >                        MMUAccessType access_type, int mmu_idx,
> >                        bool probe, uintptr_t retaddr);
> > -    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> > -    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> > -                                        MemTxAttrs *attrs);
> >       int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
> >       int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg)=
;
> >       int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
> [...]

