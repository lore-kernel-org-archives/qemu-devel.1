Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527A7C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0886E214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="eYB9Uq0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0886E214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHDwf-0003jf-BX
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:47:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHDsQ-0000hK-Ur
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHDsP-0007oA-4S
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:43:22 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:34787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hHDsO-0007n0-JO
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:43:21 -0400
Received: by mail-it1-x142.google.com with SMTP id z17so8863444itc.1
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=J2WexM/ib07HVch6XEiP/O/pJC98rVR0ngjNrWLqTEs=;
	b=eYB9Uq0ChZQ+JAKPDmxPNzI9/m1rKBsVJG5ilF3wPg5axues8mEnyKst6CQN1h88rv
	I57TLohw6sIpQjOOH+OJfaE7tgUw9k4Md6+oQtPuHdHXjm5nAO4SvjrcVhdrQaX4DPA9
	PcTFJoloxgLuDpiOcVhlx9uBxiKsXfzI7o7V5VfgqhnzZ4NS+rYNvWxqslsGNrdYwZ1n
	w0sNuwZuz2FJogWgbkadFPuwq9CLynXaTP4bragrceyeMnaCysMX7kGc1u/NYwk0PmRb
	TUqKjfrpVAIXlOaeA6Be62OSdaHq/un6rH58P/MroLfFg6URySll6TyG8DHaW2nriOnY
	GeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=J2WexM/ib07HVch6XEiP/O/pJC98rVR0ngjNrWLqTEs=;
	b=KA0mOMgB/RBUpHPlcTQXVEWWWe4bb8L15dnjl6y0P38MHUOnWSmXRPUuk40Y+RauVH
	EWQrG4d3rvXkBl09TwiSu9CnDqJ2icAYyTuU0ctnU+982qt+yUMe5nKFrpj7/myPckx0
	lt+25tWBKpLJ9CYAwC2Lg3pE1uXSGS6n8ojAPagVbrh5GU5JE6rHJGlyvUYiVtHl1Jzy
	LTZCRGlJzsNkxpD3xDnDivX1opUj5ncSCr4mvd0YNLU8bD159AM1x7JGLL+oIivxo9LG
	Q9R2xjpEI3Y65gRCL2oV2eWumDcvP0wuB8Gufa/pJhzEuUiOC3hQSCbv4sS5Y8oMUqoi
	YR7g==
X-Gm-Message-State: APjAAAVdqFeNYeibDcxpdILVe1efw9g8oKjjr7M9khT5Llh8KKqrHGLb
	8DPYh1A0iKG6paSlGORJbRxXWw==
X-Google-Smtp-Source: APXvYqwvkHf7feVCsFh0YMgYrG4Es/tkBJ96vrHDsh5x6equKZo0oNFRgDK/QBVH3KC8UkgNo9BI/Q==
X-Received: by 2002:a24:605:: with SMTP id 5mr4598007itv.144.1555620198931;
	Thu, 18 Apr 2019 13:43:18 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	o17sm972491ioa.31.2019.04.18.13.43.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 13:43:18 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <3ffacb2c-2459-fb45-ca9c-7b59b10a1c76@redhat.com>
Date: Thu, 18 Apr 2019 16:43:16 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <223E9F59-BF08-4441-B82F-1EC6B9FA8B85@oberlin.edu>
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
	<20190417220147.67648-2-stephen.checkoway@oberlin.edu>
	<3ffacb2c-2459-fb45-ca9c-7b59b10a1c76@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v3 01/10] block/pflash_cfi02: Add test for
 supported commands
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
	=?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418204316.Dg_hdsVfDlsiOpdR_0QEJAU8fv6MafmPFFodllkXEqc@z>



> On Apr 18, 2019, at 00:47, Thomas Huth <thuth@redhat.com> wrote:
>=20
> On 18/04/2019 00.01, Stephen Checkoway wrote:
>> Test the AMD command set for parallel flash chips. This test uses an
>> ARM musicpal board with a pflash drive to test the following list of
>> currently-supported commands.
>> - Autoselect
>> - CFI
>> - Sector erase
>> - Chip erase
>> - Program
>> - Unlock bypass
>> - Reset
>>=20
>> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>> ---
>> tests/Makefile.include    |   2 +
>> tests/pflash-cfi02-test.c | 227 =
++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 229 insertions(+)
>> create mode 100644 tests/pflash-cfi02-test.c
> [...]
>> new file mode 100644
>> index 0000000000..b113fca5af
>> --- /dev/null
>> +++ b/tests/pflash-cfi02-test.c
>> @@ -0,0 +1,227 @@
>> +/*
>> + * QTest testcase for parallel flash with AMD command set
>> + *
>> + * Copyright (c) 2018 Stephen Checkoway
>=20
> Do you maybe want to update that to 2019?

Done.

> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include <err.h>
>=20
> We generally don't use err.h in QEMU ... could you please use the
> standard functions from glib instead?

Done.

> +#include <unistd.h>
>=20
> unistd.h is already provided by osdep.h, so you don't need to include =
it
> here again. (and the scripts/clean-includes script will barf at this
> later, so better fix it right from the start)

Done.

> +#include "libqtest.h"
>> +
>> +/*
>> + * To test the pflash_cfi02 device, we run QEMU with the musicpal =
machine with
>> + * a pflash drive. This enables us to test some flash =
configurations, but not
>> + * all. In particular, we're limited to a 16-bit wide flash device.
>> + */
>> +
>> +#define MP_FLASH_SIZE_MAX (32 * 1024 * 1024)
>> +#define BASE_ADDR (0x100000000ULL - MP_FLASH_SIZE_MAX)
>> +
>> +#define FLASH_WIDTH 2
>> +#define CFI_ADDR (FLASH_WIDTH * 0x55)
>> +#define UNLOCK0_ADDR (FLASH_WIDTH * 0x5555)
>> +#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AAA)
>> +
>> +#define CFI_CMD 0x98
>> +#define UNLOCK0_CMD 0xAA
>> +#define UNLOCK1_CMD 0x55
>> +#define AUTOSELECT_CMD 0x90
>> +#define RESET_CMD 0xF0
>> +#define PROGRAM_CMD 0xA0
>> +#define SECTOR_ERASE_CMD 0x30
>> +#define CHIP_ERASE_CMD 0x10
>> +#define UNLOCK_BYPASS_CMD 0x20
>> +#define UNLOCK_BYPASS_RESET_CMD 0x00
>> +
>> +static char image_path[] =3D "/tmp/qtest.XXXXXX";
>> +
>> +static inline void flash_write(uint64_t byte_addr, uint16_t data)
>> +{
>> +    qtest_writew(global_qtest, BASE_ADDR + byte_addr, data);
>> +}
>> +
>> +static inline uint16_t flash_read(uint64_t byte_addr)
>> +{
>> +    return qtest_readw(global_qtest, BASE_ADDR + byte_addr);
>> +}
>> +
>> +static void unlock(void)
>> +{
>> +    flash_write(UNLOCK0_ADDR, UNLOCK0_CMD);
>> +    flash_write(UNLOCK1_ADDR, UNLOCK1_CMD);
>> +}
>> +
>> +static void reset(void)
>> +{
>> +    flash_write(0, RESET_CMD);
>> +}
>> +
>> +static void sector_erase(uint64_t byte_addr)
>> +{
>> +    unlock();
>> +    flash_write(UNLOCK0_ADDR, 0x80);
>> +    unlock();
>> +    flash_write(byte_addr, SECTOR_ERASE_CMD);
>> +}
>> +
>> +static void wait_for_completion(uint64_t byte_addr)
>> +{
>> +    /* If DQ6 is toggling, step the clock and ensure the toggle =
stops. */
>> +    if ((flash_read(byte_addr) & 0x40) ^ (flash_read(byte_addr) & =
0x40)) {
>> +        /* Wait for erase or program to finish. */
>> +        clock_step_next();
>> +        /* Ensure that DQ6 has stopped toggling. */
>> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, =
flash_read(byte_addr));
>> +    }
>> +}
>> +
>> +static void bypass_program(uint64_t byte_addr, uint16_t data)
>> +{
>> +    flash_write(UNLOCK0_ADDR, PROGRAM_CMD);
>> +    flash_write(byte_addr, data);
>> +    /*
>> +     * Data isn't valid until DQ6 stops toggling. We don't model =
this as
>> +     * writes are immediate, but if this changes in the future, we =
can wait
>> +     * until the program is complete.
>> +     */
>> +    wait_for_completion(byte_addr);
>> +}
>> +
>> +static void program(uint64_t byte_addr, uint16_t data)
>> +{
>> +    unlock();
>> +    bypass_program(byte_addr, data);
>> +}
>> +
>> +static void chip_erase(void)
>> +{
>> +    unlock();
>> +    flash_write(UNLOCK0_ADDR, 0x80);
>> +    unlock();
>> +    flash_write(UNLOCK0_ADDR, SECTOR_ERASE_CMD);
>> +}
>> +
>> +static void test_flash(void)
>> +{
>> +    global_qtest =3D qtest_initf("-M musicpal,accel=3Dqtest "
>> +                               "-drive =
if=3Dpflash,file=3D%s,format=3Draw,copy-on-read",
>> +                               image_path);
>> +    /* Check the IDs. */
>> +    unlock();
>> +    flash_write(UNLOCK0_ADDR, AUTOSELECT_CMD);
>> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0000), =3D=3D, =
0x00BF);
>> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0001), =3D=3D, =
0x236D);
>> +    reset();
>> +
>> +    /* Check the erase blocks. */
>> +    flash_write(CFI_ADDR, CFI_CMD);
>> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x10), =3D=3D, 'Q');
>> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x11), =3D=3D, 'R');
>> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x12), =3D=3D, 'Y');
>> +    /* Num erase regions. */
>> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x2C), >=3D, 1);
>> +    uint32_t nb_sectors =3D flash_read(FLASH_WIDTH * 0x2D) +
>> +                          (flash_read(FLASH_WIDTH * 0x2E) << 8) + 1;
>> +    uint32_t sector_len =3D (flash_read(FLASH_WIDTH * 0x2F) << 8) +
>> +                          (flash_read(FLASH_WIDTH * 0x30) << 16);
>> +    reset();
>> +
>> +    /* Erase and program sector. */
>> +    for (uint32_t i =3D 0; i < nb_sectors; ++i) {
>> +        uint64_t byte_addr =3D i * sector_len;
>> +        sector_erase(byte_addr);
>> +        /* Read toggle. */
>> +        uint16_t status0 =3D flash_read(byte_addr);
>> +        /* DQ7 is 0 during an erase. */
>> +        g_assert_cmpint(status0 & 0x80, =3D=3D, 0);
>> +        uint16_t status1 =3D flash_read(byte_addr);
>> +        /* DQ6 toggles during an erase. */
>> +        g_assert_cmpint(status0 & 0x40, !=3D, status1 & 0x40);
>> +        /* Wait for erase to complete. */
>> +        clock_step_next();
>> +        /* Ensure DQ6 has stopped toggling. */
>> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, =
flash_read(byte_addr));
>> +        /* Now the data should be valid. */
>> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, 0xFFFF);
>> +
>> +        /* Program a bit pattern. */
>> +        program(byte_addr, 0x5555);
>> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, 0x5555);
>> +        program(byte_addr, 0xAA55);
>> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, 0x0055);
>> +    }
>> +
>> +    /* Erase the chip. */
>> +    chip_erase();
>> +    /* Read toggle. */
>> +    uint16_t status0 =3D flash_read(0);
>> +    /* DQ7 is 0 during an erase. */
>> +    g_assert_cmpint(status0 & 0x80, =3D=3D, 0);
>> +    uint16_t status1 =3D flash_read(0);
>> +    /* DQ6 toggles during an erase. */
>> +    g_assert_cmpint(status0 & 0x40, !=3D, status1 & 0x40);
>> +    /* Wait for erase to complete. */
>> +    clock_step_next();
>> +    /* Ensure DQ6 has stopped toggling. */
>> +    g_assert_cmpint(flash_read(0), =3D=3D, flash_read(0));
>> +    /* Now the data should be valid. */
>> +    g_assert_cmpint(flash_read(0), =3D=3D, 0xFFFF);
>> +
>> +    /* Unlock bypass */
>> +    unlock();
>> +    flash_write(UNLOCK0_ADDR, UNLOCK_BYPASS_CMD);
>> +    bypass_program(0, 0x0123);
>> +    bypass_program(2, 0x4567);
>> +    bypass_program(4, 0x89AB);
>> +    /*
>> +     * Test that bypass programming, unlike normal programming can =
use any
>> +     * address for the PROGRAM_CMD.
>> +     */
>> +    flash_write(6, PROGRAM_CMD);
>> +    flash_write(6, 0xCDEF);
>> +    wait_for_completion(6);
>> +    flash_write(0, UNLOCK_BYPASS_RESET_CMD);
>> +    bypass_program(8, 0x55AA); /* Should fail. */
>> +    g_assert_cmpint(flash_read(0), =3D=3D, 0x0123);
>> +    g_assert_cmpint(flash_read(2), =3D=3D, 0x4567);
>> +    g_assert_cmpint(flash_read(4), =3D=3D, 0x89AB);
>> +    g_assert_cmpint(flash_read(6), =3D=3D, 0xCDEF);
>> +    g_assert_cmpint(flash_read(8), =3D=3D, 0xFFFF);
>> +
>> +    qtest_quit(global_qtest);
>> +}
>> +
>> +static void cleanup(void *opaque)
>> +{
>> +    unlink(image_path);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    int fd =3D mkstemp(image_path);
>> +    if (fd =3D=3D -1) {
>> +        err(1, "Failed to create temporary file %s", image_path);
>=20
> g_printerr() ?
>=20
> or maybe simply use a g_assert_cmpint(ret, !=3D, -1) like we do it in =
a
> couple of other places already.

I went with g_printerr() + exit(EXIT_FAILURE) similar to what's just =
below.

>> +    }
>> +    if (ftruncate(fd, 8 * 1024 * 1024) < 0) {
>> +        int error_code =3D errno;
>> +        close(fd);
>> +        unlink(image_path);
>> +        g_printerr("Failed to truncate file %s to 8 MB: %s\n", =
image_path,
>> +                   strerror(error_code));
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    close(fd);
>> +
>> +    qtest_add_abrt_handler(cleanup, NULL);
>> +    g_test_init(&argc, &argv, NULL);
>> +    qtest_add_func("pflash-cfi02", test_flash);
>> +    int result =3D g_test_run();
>> +    cleanup(NULL);
>> +    return result;
>> +}
>> +
>> +/* vim: set sw=3D4 sts=3D4 ts=3D8 et: */
>=20
> IMHO the vim line should not be necessary (and we hardly do that in =
any
> of the other files).

Done.

I also fixed the nit you mentioned in patch 6 as well as an identical =
occurrence earlier.

Thank you for the fast review comments!

I'm new to contributing to QEMU and I have a two procedural questions:

1. When should I send version 4 of this patch series? I don't want to =
bombard everyone with another 11 emails after fixing every review =
comment, but I also don't want to let the patch linger without =
addressing comments.

2. I'm not familiar with the "Acked-by" convention. I read =
<https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html#whe=
n-to-use-acked-by-and-cc>. Am I supposed to add those to the commit =
messages or do those get added by whomever actually includes the patch =
in the main QEMU repo?

--=20
Stephen Checkoway






