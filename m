Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD7C10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71FA204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71FA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGyzC-0003lK-MW
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 00:49:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyy1-0003Ec-6n
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyxz-0000Uu-90
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:48:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hGyxv-0000SB-3X; Thu, 18 Apr 2019 00:48:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21E5788AB5;
	Thu, 18 Apr 2019 04:48:02 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-56.ams2.redhat.com [10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEEA25D9CC;
	Thu, 18 Apr 2019 04:47:56 +0000 (UTC)
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
	<20190417220147.67648-2-stephen.checkoway@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <3ffacb2c-2459-fb45-ca9c-7b59b10a1c76@redhat.com>
Date: Thu, 18 Apr 2019 06:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417220147.67648-2-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 18 Apr 2019 04:48:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418044756.YvMgGMJZp9O8vxzmZlc0pJpLWLgVcAnARXGz2PIKlT0@z>

On 18/04/2019 00.01, Stephen Checkoway wrote:
> Test the AMD command set for parallel flash chips. This test uses an
> ARM musicpal board with a pflash drive to test the following list of
> currently-supported commands.
> - Autoselect
> - CFI
> - Sector erase
> - Chip erase
> - Program
> - Unlock bypass
> - Reset
>=20
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  tests/Makefile.include    |   2 +
>  tests/pflash-cfi02-test.c | 227 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 229 insertions(+)
>  create mode 100644 tests/pflash-cfi02-test.c
[...]
> new file mode 100644
> index 0000000000..b113fca5af
> --- /dev/null
> +++ b/tests/pflash-cfi02-test.c
> @@ -0,0 +1,227 @@
> +/*
> + * QTest testcase for parallel flash with AMD command set
> + *
> + * Copyright (c) 2018 Stephen Checkoway

Do you maybe want to update that to 2019?

> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <err.h>

We generally don't use err.h in QEMU ... could you please use the
standard functions from glib instead?

> +#include <unistd.h>

unistd.h is already provided by osdep.h, so you don't need to include it
here again. (and the scripts/clean-includes script will barf at this
later, so better fix it right from the start)

> +#include "libqtest.h"
> +
> +/*
> + * To test the pflash_cfi02 device, we run QEMU with the musicpal mach=
ine with
> + * a pflash drive. This enables us to test some flash configurations, =
but not
> + * all. In particular, we're limited to a 16-bit wide flash device.
> + */
> +
> +#define MP_FLASH_SIZE_MAX (32 * 1024 * 1024)
> +#define BASE_ADDR (0x100000000ULL - MP_FLASH_SIZE_MAX)
> +
> +#define FLASH_WIDTH 2
> +#define CFI_ADDR (FLASH_WIDTH * 0x55)
> +#define UNLOCK0_ADDR (FLASH_WIDTH * 0x5555)
> +#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AAA)
> +
> +#define CFI_CMD 0x98
> +#define UNLOCK0_CMD 0xAA
> +#define UNLOCK1_CMD 0x55
> +#define AUTOSELECT_CMD 0x90
> +#define RESET_CMD 0xF0
> +#define PROGRAM_CMD 0xA0
> +#define SECTOR_ERASE_CMD 0x30
> +#define CHIP_ERASE_CMD 0x10
> +#define UNLOCK_BYPASS_CMD 0x20
> +#define UNLOCK_BYPASS_RESET_CMD 0x00
> +
> +static char image_path[] =3D "/tmp/qtest.XXXXXX";
> +
> +static inline void flash_write(uint64_t byte_addr, uint16_t data)
> +{
> +    qtest_writew(global_qtest, BASE_ADDR + byte_addr, data);
> +}
> +
> +static inline uint16_t flash_read(uint64_t byte_addr)
> +{
> +    return qtest_readw(global_qtest, BASE_ADDR + byte_addr);
> +}
> +
> +static void unlock(void)
> +{
> +    flash_write(UNLOCK0_ADDR, UNLOCK0_CMD);
> +    flash_write(UNLOCK1_ADDR, UNLOCK1_CMD);
> +}
> +
> +static void reset(void)
> +{
> +    flash_write(0, RESET_CMD);
> +}
> +
> +static void sector_erase(uint64_t byte_addr)
> +{
> +    unlock();
> +    flash_write(UNLOCK0_ADDR, 0x80);
> +    unlock();
> +    flash_write(byte_addr, SECTOR_ERASE_CMD);
> +}
> +
> +static void wait_for_completion(uint64_t byte_addr)
> +{
> +    /* If DQ6 is toggling, step the clock and ensure the toggle stops.=
 */
> +    if ((flash_read(byte_addr) & 0x40) ^ (flash_read(byte_addr) & 0x40=
)) {
> +        /* Wait for erase or program to finish. */
> +        clock_step_next();
> +        /* Ensure that DQ6 has stopped toggling. */
> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, flash_read(byte=
_addr));
> +    }
> +}
> +
> +static void bypass_program(uint64_t byte_addr, uint16_t data)
> +{
> +    flash_write(UNLOCK0_ADDR, PROGRAM_CMD);
> +    flash_write(byte_addr, data);
> +    /*
> +     * Data isn't valid until DQ6 stops toggling. We don't model this =
as
> +     * writes are immediate, but if this changes in the future, we can=
 wait
> +     * until the program is complete.
> +     */
> +    wait_for_completion(byte_addr);
> +}
> +
> +static void program(uint64_t byte_addr, uint16_t data)
> +{
> +    unlock();
> +    bypass_program(byte_addr, data);
> +}
> +
> +static void chip_erase(void)
> +{
> +    unlock();
> +    flash_write(UNLOCK0_ADDR, 0x80);
> +    unlock();
> +    flash_write(UNLOCK0_ADDR, SECTOR_ERASE_CMD);
> +}
> +
> +static void test_flash(void)
> +{
> +    global_qtest =3D qtest_initf("-M musicpal,accel=3Dqtest "
> +                               "-drive if=3Dpflash,file=3D%s,format=3D=
raw,copy-on-read",
> +                               image_path);
> +    /* Check the IDs. */
> +    unlock();
> +    flash_write(UNLOCK0_ADDR, AUTOSELECT_CMD);
> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0000), =3D=3D, 0x00BF);
> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0001), =3D=3D, 0x236D);
> +    reset();
> +
> +    /* Check the erase blocks. */
> +    flash_write(CFI_ADDR, CFI_CMD);
> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x10), =3D=3D, 'Q');
> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x11), =3D=3D, 'R');
> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x12), =3D=3D, 'Y');
> +    /* Num erase regions. */
> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x2C), >=3D, 1);
> +    uint32_t nb_sectors =3D flash_read(FLASH_WIDTH * 0x2D) +
> +                          (flash_read(FLASH_WIDTH * 0x2E) << 8) + 1;
> +    uint32_t sector_len =3D (flash_read(FLASH_WIDTH * 0x2F) << 8) +
> +                          (flash_read(FLASH_WIDTH * 0x30) << 16);
> +    reset();
> +
> +    /* Erase and program sector. */
> +    for (uint32_t i =3D 0; i < nb_sectors; ++i) {
> +        uint64_t byte_addr =3D i * sector_len;
> +        sector_erase(byte_addr);
> +        /* Read toggle. */
> +        uint16_t status0 =3D flash_read(byte_addr);
> +        /* DQ7 is 0 during an erase. */
> +        g_assert_cmpint(status0 & 0x80, =3D=3D, 0);
> +        uint16_t status1 =3D flash_read(byte_addr);
> +        /* DQ6 toggles during an erase. */
> +        g_assert_cmpint(status0 & 0x40, !=3D, status1 & 0x40);
> +        /* Wait for erase to complete. */
> +        clock_step_next();
> +        /* Ensure DQ6 has stopped toggling. */
> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, flash_read(byte=
_addr));
> +        /* Now the data should be valid. */
> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, 0xFFFF);
> +
> +        /* Program a bit pattern. */
> +        program(byte_addr, 0x5555);
> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, 0x5555);
> +        program(byte_addr, 0xAA55);
> +        g_assert_cmpint(flash_read(byte_addr), =3D=3D, 0x0055);
> +    }
> +
> +    /* Erase the chip. */
> +    chip_erase();
> +    /* Read toggle. */
> +    uint16_t status0 =3D flash_read(0);
> +    /* DQ7 is 0 during an erase. */
> +    g_assert_cmpint(status0 & 0x80, =3D=3D, 0);
> +    uint16_t status1 =3D flash_read(0);
> +    /* DQ6 toggles during an erase. */
> +    g_assert_cmpint(status0 & 0x40, !=3D, status1 & 0x40);
> +    /* Wait for erase to complete. */
> +    clock_step_next();
> +    /* Ensure DQ6 has stopped toggling. */
> +    g_assert_cmpint(flash_read(0), =3D=3D, flash_read(0));
> +    /* Now the data should be valid. */
> +    g_assert_cmpint(flash_read(0), =3D=3D, 0xFFFF);
> +
> +    /* Unlock bypass */
> +    unlock();
> +    flash_write(UNLOCK0_ADDR, UNLOCK_BYPASS_CMD);
> +    bypass_program(0, 0x0123);
> +    bypass_program(2, 0x4567);
> +    bypass_program(4, 0x89AB);
> +    /*
> +     * Test that bypass programming, unlike normal programming can use=
 any
> +     * address for the PROGRAM_CMD.
> +     */
> +    flash_write(6, PROGRAM_CMD);
> +    flash_write(6, 0xCDEF);
> +    wait_for_completion(6);
> +    flash_write(0, UNLOCK_BYPASS_RESET_CMD);
> +    bypass_program(8, 0x55AA); /* Should fail. */
> +    g_assert_cmpint(flash_read(0), =3D=3D, 0x0123);
> +    g_assert_cmpint(flash_read(2), =3D=3D, 0x4567);
> +    g_assert_cmpint(flash_read(4), =3D=3D, 0x89AB);
> +    g_assert_cmpint(flash_read(6), =3D=3D, 0xCDEF);
> +    g_assert_cmpint(flash_read(8), =3D=3D, 0xFFFF);
> +
> +    qtest_quit(global_qtest);
> +}
> +
> +static void cleanup(void *opaque)
> +{
> +    unlink(image_path);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int fd =3D mkstemp(image_path);
> +    if (fd =3D=3D -1) {
> +        err(1, "Failed to create temporary file %s", image_path);

g_printerr() ?

or maybe simply use a g_assert_cmpint(ret, !=3D, -1) like we do it in a
couple of other places already.

> +    }
> +    if (ftruncate(fd, 8 * 1024 * 1024) < 0) {
> +        int error_code =3D errno;
> +        close(fd);
> +        unlink(image_path);
> +        g_printerr("Failed to truncate file %s to 8 MB: %s\n", image_p=
ath,
> +                   strerror(error_code));
> +        exit(EXIT_FAILURE);
> +    }
> +    close(fd);
> +
> +    qtest_add_abrt_handler(cleanup, NULL);
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("pflash-cfi02", test_flash);
> +    int result =3D g_test_run();
> +    cleanup(NULL);
> +    return result;
> +}
> +
> +/* vim: set sw=3D4 sts=3D4 ts=3D8 et: */

IMHO the vim line should not be necessary (and we hardly do that in any
of the other files).

 Thomas

