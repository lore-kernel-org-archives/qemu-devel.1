Return-Path: <SRS0=qZCI=SG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C71BC4360F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2019 23:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82DD217D4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2019 23:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IQbf9CoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82DD217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCBoa-0003Qc-NY
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 19:30:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCBnl-00031c-Pq
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCBnj-00039u-AB
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:29:45 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hCBni-00038c-Ql
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:29:43 -0400
Received: by mail-pf1-x442.google.com with SMTP id b3so2177782pfd.1
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=vP3OA7fOnTz5jmeVu8TZ/FpmkBa0rsQI6P2v+o1nyUk=;
	b=IQbf9CoIYBs71zMNsUy18UEQZFI6Pj2co82Zz+FnGUVKGNXmcqPI6rlk8IvmydoFxv
	l2zPTHAnFHP2ehslin+U1BqBs6uBLlkrdpWq0M6zgSfB9WjEpoHhAV4q3oByQvZmdUUc
	NEEPf4nZGhfQ3NtMHcR7PR1X8LYZ2XSEYD365gOOiNzy2AGjc/IAlA50v8LWsQEGuugt
	ocVawHUJy3/9tBJv7oKDX8F84YfFN57fCoA37TTY1l0+vwwvbbEu+C5k6Z8M3/3sZv2W
	dyF6JLDNaSfw56pKOaJOCwvLhpUvGpEdn5Q44241E/mSvaK6GXiKAc7mkJNAGPfxcM4B
	joHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=vP3OA7fOnTz5jmeVu8TZ/FpmkBa0rsQI6P2v+o1nyUk=;
	b=Oo7A7D7qbSYVB7fRU6wVSnpF2rOduL88JilXUvry9N2WaMW29BoC3VPINIKkUacCRF
	Q0zwxdPc2nWFgHT9HCNxFG8M5p3NS/S6KT+9T4xMJtpHFBWMfSzQaV54LOTWoQBW5eth
	4kI3wmf1GKcphXabTlPkdncB/DLd4xcyg7e0xL9F7RRNt0oF2LvVgw/irvB30BXu8Ts2
	Cs551vkwb+rzYJDlPuoYZogLrbyF0aHUj7A2TWkObk8UlxORf/W6l1JiKCNIN9CdzUSG
	KGQFUx3fdOYJ+LYk7HE46RRLqRIhQsDJ5Xu9BPd5s9CBkkyl1doVUsgEaCfScxwT5t6z
	sfUw==
X-Gm-Message-State: APjAAAUo0/bnlHXOlw3cPLEnfyaNdiA5Ry9l+tow8wMKxy+nU+I/Zci4
	tqYhAaVr2jB+WwbCo1431LV9lA==
X-Google-Smtp-Source: APXvYqw16mx5aNvIeNFjtmc30uqRJ+kGFTon7rYVD1H8vMKbOgo+aSomnvA/BxIJR20cid9On28IQg==
X-Received: by 2002:a62:5582:: with SMTP id j124mr8942831pfb.53.1554420581402; 
	Thu, 04 Apr 2019 16:29:41 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	i13sm24100659pgq.17.2019.04.04.16.29.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Apr 2019 16:29:40 -0700 (PDT)
Date: Thu, 04 Apr 2019 16:29:40 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Apr 2019 16:10:25 PDT (-0700)
In-Reply-To: <CAKmqyKNrdJA55m1sZDM=cFXJV1-0KU-52qE40anNDH227bzEaw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-e8730265-3522-4aa0-9197-8402b25b2361@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for 4.0-rc3
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190404232940.liKtmyFsoDGmWeXQxRUlk9_Od9kfjX1P3Kaw4ctYEAc@z>

On Thu, 04 Apr 2019 11:18:52 PDT (-0700), alistair23@gmail.com wrote:
> On Thu, Apr 4, 2019 at 1:45 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 4 Apr 2019 at 08:00, Palmer Dabbelt <palmer@sifive.com> wrote:
>> >
>> > The following changes since commit 49fc899f8d673dd9e73f3db0d9e9ea60b77c331b:
>> >
>> >   Update version for v4.0.0-rc1 release (2019-03-26 17:02:29 +0000)
>> >
>> > are available in the Git repository at:
>> >
>> >   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.0-rc3
>> >
>> > for you to fetch changes up to b84ffcecdb7a6a3e9946d0d6d24703199c4880b3:
>> >
>> >   riscv: plic: Log guest errors (2019-03-27 20:23:03 -0700)
>> >
>> > ----------------------------------------------------------------
>> > RISC-V Patches for 4.0-rc3
>> >
>> > This patch set contains a pair of tightly coupled PLIC bug fixes:
>> >
>> > * We were calculating the PLIC addresses incorrectly.
>> > * We were installing the wrong number of PLIC interrupts.
>> >
>> > The two bugs togther resulted in a mostly-working system, but they're
>> > impossible to seperate because fixing one bug would result in
>> > significant breakage.  As a result they're in the same patch.
>> >
>> > There is also a cleanup to use qemu_log_mask(LOG_GUEST_ERROR,...) for
>> > error reporting.
>> >
>> > As far as I know these are the last outstanding RISC-V patches for 4.0.
>>
>> Hi; I'm afraid this fails 'make check':
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=riscv32-softmmu/qemu-system-riscv32
>> QTEST_QEMU_IMG=qemu-img tests/qom-test -m=quick -k --tap < /dev/null |
>> ./scripts/tap-driver.pl --test-name="qom-test"
>> PASS 1 qom-test /riscv32/qom/virt
>> PASS 2 qom-test /riscv32/qom/none
>> PASS 3 qom-test /riscv32/qom/spike_v1.10
>> Broken pipe
>> /home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:143:
>> kill_qemu() detected QEMU death from signal 11 (Segmentation fault)
>> (core dumped)
>> Aborted (core dumped)
>> ERROR - too few tests run (expected 6, got 3)
>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:903:
>> recipe for target 'check-qtest-riscv32' failed
>
> I managed to reproduce the problem and I have sent a v3 with the fix.
>
> What is strange is that I didn't see this in my make check runs, I'll
> check to see what I'm missing.

Thanks!

> What is also strange is that the SiFive U machine should only be
> 64-bit, it seems odd to run it with 32-bit RISC-V (unless I'm missing
> something). That's probably something we should fix for 4.1.

Ya, we need to go clean this up.  It's all a bit messy right now.

>
> Alistair
>
>>
>> The sifive_u machine seems to dump core on startup:
>>
>> $ gdb --args riscv32-softmmu/qemu-system-riscv32 -M sifive_u -display none
>> [...]
>> (gdb) r
>> Starting program:
>> /home/petmay01/linaro/qemu-for-merges/build/alldbg/riscv32-softmmu/qemu-system-riscv32
>> -M sifive_u -display none
>> [Thread debugging using libthread_db enabled]
>> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
>> [New Thread 0x7fffd7dc4700 (LWP 29908)]
>> [New Thread 0x7fffd526f700 (LWP 29909)]
>>
>> Thread 1 "qemu-system-ris" received signal SIGSEGV, Segmentation fault.
>> 0x0000555555ba1df7 in object_get_canonical_path_component
>> (obj=0x5555559b3018 <qdev_get_hotplug_handler+24>) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1797
>> 1797        g_hash_table_iter_init(&iter, obj->parent->properties);
>> (gdb) bt
>> #0  0x0000555555ba1df7 in object_get_canonical_path_component
>> (obj=0x5555559b3018 <qdev_get_hotplug_handler+24>) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1797
>> #1  0x0000555555ba1ed6 in object_get_canonical_path
>> (obj=0x5555559b3018 <qdev_get_hotplug_handler+24>) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1823
>> #2  0x0000555555ba0b72 in object_property_set_link
>> (obj=0x5555567e2e50, value=0x5555559b3018
>> <qdev_get_hotplug_handler+24>, name=0x555556919b60 "sysbus-irq[0]",
>> errp=0x5555566b6d28 <error_abort>)
>>     at /home/petmay01/linaro/qemu-for-merges/qom/object.c:1302
>> #3  0x00005555559b37f4 in qdev_connect_gpio_out_named
>> (dev=0x5555567e2e50, name=0x555555e52b62 "sysbus-irq", n=0,
>> pin=0x5555559b3018 <qdev_get_hotplug_handler+24>) at
>> /home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:460
>> #4  0x00005555559b9d7b in sysbus_connect_irq (dev=0x5555567e2e50, n=0,
>> irq=0x5555559b3018 <qdev_get_hotplug_handler+24>) at
>> /home/petmay01/linaro/qemu-for-merges/hw/core/sysbus.c:116
>> #5  0x000055555590a9e9 in riscv_sifive_u_soc_realize
>> (dev=0x5555567e2820, errp=0x7fffffffdc80) at
>> /home/petmay01/linaro/qemu-for-merges/hw/riscv/sifive_u.c:393
>> #6  0x00005555559b457e in device_set_realized (obj=0x5555567e2820,
>> value=true, errp=0x5555566b6d28 <error_abort>) at
>> /home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:834
>> #7  0x0000555555ba276a in property_set_bool (obj=0x5555567e2820,
>> v=0x5555567e9360, name=0x555555e28139 "realized",
>> opaque=0x5555567e1220, errp=0x5555566b6d28 <error_abort>) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:2074
>> #8  0x0000555555ba09e6 in object_property_set (obj=0x5555567e2820,
>> v=0x5555567e9360, name=0x555555e28139 "realized", errp=0x5555566b6d28
>> <error_abort>) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1266
>> #9  0x0000555555ba3aac in object_property_set_qobject
>> (obj=0x5555567e2820, value=0x5555567e9340, name=0x555555e28139
>> "realized", errp=0x5555566b6d28 <error_abort>) at
>> /home/petmay01/linaro/qemu-for-merges/qom/qom-qobject.c:27
>> #10 0x0000555555ba0ccb in object_property_set_bool
>> (obj=0x5555567e2820, value=true, name=0x555555e28139 "realized",
>> errp=0x5555566b6d28 <error_abort>) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1332
>> #11 0x000055555590a1f3 in riscv_sifive_u_init (machine=0x55555671b8d0)
>> at /home/petmay01/linaro/qemu-for-merges/hw/riscv/sifive_u.c:270
>> #12 0x00005555559bcfa8 in machine_run_board_init
>> (machine=0x55555671b8d0) at
>> /home/petmay01/linaro/qemu-for-merges/hw/core/machine.c:1030
>> #13 0x00005555559406fd in main (argc=5, argv=0x7fffffffe1d8,
>> envp=0x7fffffffe208) at
>> /home/petmay01/linaro/qemu-for-merges/vl.c:4479
>>
>>
>> Running under valgrind shows use of uninitialised values, invalid reads, etc:
>>
>> ==29912== Conditional jump or move depends on uninitialised value(s)
>> ==29912==    at 0x5677A8: qdev_connect_gpio_out_named (qdev.c:450)
>> ==29912==    by 0x56DD7A: sysbus_connect_irq (sysbus.c:116)
>> ==29912==    by 0x4BE9E8: riscv_sifive_u_soc_realize (sifive_u.c:393)
>> ==29912==    by 0x56857D: device_set_realized (qdev.c:834)
>> ==29912==    by 0x756769: property_set_bool (object.c:2074)
>> ==29912==    by 0x7549E5: object_property_set (object.c:1266)
>> ==29912==    by 0x757AAB: object_property_set_qobject (qom-qobject.c:27)
>> ==29912==    by 0x754CCA: object_property_set_bool (object.c:1332)
>> ==29912==    by 0x4BE1F2: riscv_sifive_u_init (sifive_u.c:270)
>> ==29912==    by 0x570FA7: machine_run_board_init (machine.c:1030)
>> ==29912==    by 0x4F46FC: main (vl.c:4479)
>>
>>
>> thanks
>> -- PMM

