Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A0C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDF3217D4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGW16S/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDF3217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguAp-0006s5-AI
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44354)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtzy-00079j-TF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtzv-0003Ta-12
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:45:18 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtzt-0003J8-82; Fri, 28 Jun 2019 12:45:14 -0400
Received: by mail-lf1-x143.google.com with SMTP id r15so4368595lfm.11;
 Fri, 28 Jun 2019 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FiVxb2pOJfybubAFv9x0+poY6MN5spN78Rt4EaXrzRI=;
 b=sGW16S/y76AjFe4FTuEEUM2mZ76ZjEA1+cyHx+AphABhMFR06+6IF3qyeK+SgcfyUR
 eFTScZnllD+/W6ZxN2+PBanJcsBTXddgKorapm0gy74YGKKtPKsBr7b5EO1nd7/wwdS/
 qqHal1su/YE8D2zYikIVSndrpDCw/kLiXvMJJcNvxZQlj9NptsLx/7rvKD6dBqpVQb/O
 BganvY51jWy5H4cMnNBxpSFZs4xe7kvZwLYlnh6/lUr109AzNj0WC9fpwYKmovFLdSLJ
 wfpNPYGfzM4UuwHgYVeOyoZfizKtdTDRrQAT7FFyukgN71rxIU/WPYCt4WwDMrLK9UvN
 KShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FiVxb2pOJfybubAFv9x0+poY6MN5spN78Rt4EaXrzRI=;
 b=sq0ka49QoMiVKqsdzZ1POZly+X1b0lf1/LbXg5THTPmTk+DVAPRS0vYSH9KLvZT9GC
 QINNBDkj4BiqtMoYFqdXll4XK6tpWZ/hLAHWsPmIas2g3zSJR1JNURPru0Tkbc0QZtOu
 suqpznJrwYgeNOztJEeyTWD7w8NoiUQeU/9KA5SE0puOY6k0jbmvgWX5jjAWXw3Ynmkj
 93s5ge5Pb/ffhzdRZKI5BUWF5dBmqWJ1JZs2i7Q914Cc0g7M4sIJLYxUoKu9Hx7ZW8Zu
 h5eickqVpOLcMZMm58dd3uXkwB5dnAGYQ8m/C1uWEJUl1/RY6NUkBDtn6YT3TN0duIrT
 s8tg==
X-Gm-Message-State: APjAAAUN94O4m9Ntf46qTVRuol2WdxirDFZV/TKifYeGY2wqkpPSlaSK
 XtefT1AlNi6chYIzUVfsV18H9KITfvFIEXE7oxE=
X-Google-Smtp-Source: APXvYqwSj9eyTu/lY/5xlPIBMmOQ7mKCJA8b1zFJG+9ZZ3JigOzsHkFNgNtG3dOOxViYMGEOJIyCx+X8ayQcauqov2k=
X-Received: by 2002:a19:bec1:: with SMTP id o184mr5180053lff.86.1561740299849; 
 Fri, 28 Jun 2019 09:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-14-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-14-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:41:58 -0700
Message-ID: <CAKmqyKNx3ZPctFS4vzhWTsxUkj9qn7SyLc5DcjcVhu6cmoLmtw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v5 13/28] tests/pflash-cfi02: Refactor to
 support testing multiple configurations
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:50 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Introduce the FlashConfig structure, to be able to run the same set
> of tests on different flash models/configurations.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-6-stephen.checkoway@oberlin.edu>
> [PMD: Extracted from bigger patch]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/pflash-cfi02-test.c | 386 +++++++++++++++++++++++++++-----------
>  1 file changed, 277 insertions(+), 109 deletions(-)
>
> diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
> index e090b2e3a0..b00f5ca2e7 100644
> --- a/tests/pflash-cfi02-test.c
> +++ b/tests/pflash-cfi02-test.c
> @@ -17,12 +17,18 @@
>   */
>
>  #define MP_FLASH_SIZE_MAX (32 * 1024 * 1024)
> +#define FLASH_SIZE (8 * 1024 * 1024)
>  #define BASE_ADDR (0x100000000ULL - MP_FLASH_SIZE_MAX)
>
> -#define FLASH_WIDTH 2
> -#define CFI_ADDR (FLASH_WIDTH * 0x55)
> -#define UNLOCK0_ADDR (FLASH_WIDTH * 0x555)
> -#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AA)
> +/* Use a newtype to keep flash addresses separate from byte addresses. *=
/
> +typedef struct {
> +    uint64_t addr;
> +} faddr;
> +#define FLASH_ADDR(x) ((faddr) { .addr =3D (x) })
> +
> +#define CFI_ADDR FLASH_ADDR(0x55)
> +#define UNLOCK0_ADDR FLASH_ADDR(0x555)
> +#define UNLOCK1_ADDR FLASH_ADDR(0x2AA)
>
>  #define CFI_CMD 0x98
>  #define UNLOCK0_CMD 0xAA
> @@ -35,170 +41,313 @@
>  #define UNLOCK_BYPASS_CMD 0x20
>  #define UNLOCK_BYPASS_RESET_CMD 0x00
>
> +typedef struct {
> +    int bank_width;
> +
> +    QTestState *qtest;
> +} FlashConfig;
> +
>  static char image_path[] =3D "/tmp/qtest.XXXXXX";
>
> -static inline void flash_write(uint64_t byte_addr, uint16_t data)
> +/*
> + * The pflash implementation allows some parameters to be unspecified. W=
e want
> + * to test those configurations but we also need to know the real values=
 in
> + * our testing code. So after we launch qemu, we'll need a new FlashConf=
ig
> + * with the correct values filled in.
> + */
> +static FlashConfig expand_config_defaults(const FlashConfig *c)
>  {
> -    qtest_writew(global_qtest, BASE_ADDR + byte_addr, data);
> +    FlashConfig ret =3D *c;
> +
> +    if (ret.bank_width =3D=3D 0) {
> +        ret.bank_width =3D 2;
> +    }
> +
> +    /* XXX: Limitations of test harness. */
> +    assert(ret.bank_width =3D=3D 2);
> +    return ret;
>  }
>
> -static inline uint16_t flash_read(uint64_t byte_addr)
> +/*
> + * Return a bit mask suitable for extracting the least significant
> + * status/query response from an interleaved response.
> + */
> +static inline uint64_t device_mask(const FlashConfig *c)
>  {
> -    return qtest_readw(global_qtest, BASE_ADDR + byte_addr);
> +    return (uint64_t)-1;
>  }
>
> -static void unlock(void)
> +/*
> + * Return a bit mask exactly as long as the bank_width.
> + */
> +static inline uint64_t bank_mask(const FlashConfig *c)
>  {
> -    flash_write(UNLOCK0_ADDR, UNLOCK0_CMD);
> -    flash_write(UNLOCK1_ADDR, UNLOCK1_CMD);
> +    if (c->bank_width =3D=3D 8) {
> +        return (uint64_t)-1;
> +    }
> +    return (1ULL << (c->bank_width * 8)) - 1ULL;
>  }
>
> -static void reset(void)
> +static inline void flash_write(const FlashConfig *c, uint64_t byte_addr,
> +                               uint64_t data)
>  {
> -    flash_write(0, RESET_CMD);
> -}
> -
> -static void sector_erase(uint64_t byte_addr)
> -{
> -    unlock();
> -    flash_write(UNLOCK0_ADDR, 0x80);
> -    unlock();
> -    flash_write(byte_addr, SECTOR_ERASE_CMD);
> -}
> -
> -static void wait_for_completion(uint64_t byte_addr)
> -{
> -    /* If DQ6 is toggling, step the clock and ensure the toggle stops. *=
/
> -    if ((flash_read(byte_addr) & 0x40) ^ (flash_read(byte_addr) & 0x40))=
 {
> -        /* Wait for erase or program to finish. */
> -        clock_step_next();
> -        /* Ensure that DQ6 has stopped toggling. */
> -        g_assert_cmphex(flash_read(byte_addr), =3D=3D, flash_read(byte_a=
ddr));
> +    /* Sanity check our tests. */
> +    assert((data & ~bank_mask(c)) =3D=3D 0);
> +    uint64_t addr =3D BASE_ADDR + byte_addr;
> +    switch (c->bank_width) {
> +    case 1:
> +        qtest_writeb(c->qtest, addr, data);
> +        break;
> +    case 2:
> +        qtest_writew(c->qtest, addr, data);
> +        break;
> +    case 4:
> +        qtest_writel(c->qtest, addr, data);
> +        break;
> +    case 8:
> +        qtest_writeq(c->qtest, addr, data);
> +        break;
> +    default:
> +        abort();
>      }
>  }
>
> -static void bypass_program(uint64_t byte_addr, uint16_t data)
> +static inline uint64_t flash_read(const FlashConfig *c, uint64_t byte_ad=
dr)
>  {
> -    flash_write(UNLOCK0_ADDR, PROGRAM_CMD);
> -    flash_write(byte_addr, data);
> +    uint64_t addr =3D BASE_ADDR + byte_addr;
> +    switch (c->bank_width) {
> +    case 1:
> +        return qtest_readb(c->qtest, addr);
> +    case 2:
> +        return qtest_readw(c->qtest, addr);
> +    case 4:
> +        return qtest_readl(c->qtest, addr);
> +    case 8:
> +        return qtest_readq(c->qtest, addr);
> +    default:
> +        abort();
> +    }
> +}
> +
> +/*
> + * Convert a flash address expressed in the maximum width of the device =
as a
> + * byte address.
> + */
> +static inline uint64_t as_byte_addr(const FlashConfig *c, faddr flash_ad=
dr)
> +{
> +    /*
> +     * Command addresses are always given as addresses in the maximum
> +     * supported bus size for the flash chip. So an x8/x16 chip in x8 mo=
de
> +     * uses addresses 0xAAA and 0x555 to unlock because the least signif=
icant
> +     * bit is ignored. (0x555 rather than 0x554 is traditional.)
> +     *
> +     * In general we need to multiply by the maximum device width.
> +     */
> +    return flash_addr.addr * c->bank_width;
> +}
> +
> +/*
> + * Return the command value or expected status replicated across all dev=
ices.
> + */
> +static inline uint64_t replicate(const FlashConfig *c, uint64_t data)
> +{
> +    /* Sanity check our tests. */
> +    assert((data & ~device_mask(c)) =3D=3D 0);
> +    return data;
> +}
> +
> +static inline void flash_cmd(const FlashConfig *c, faddr cmd_addr,
> +                             uint8_t cmd)
> +{
> +    flash_write(c, as_byte_addr(c, cmd_addr), replicate(c, cmd));
> +}
> +
> +static inline uint64_t flash_query(const FlashConfig *c, faddr query_add=
r)
> +{
> +    return flash_read(c, as_byte_addr(c, query_addr));
> +}
> +
> +static inline uint64_t flash_query_1(const FlashConfig *c, faddr query_a=
ddr)
> +{
> +    return flash_query(c, query_addr) & device_mask(c);
> +}
> +
> +static void unlock(const FlashConfig *c)
> +{
> +    flash_cmd(c, UNLOCK0_ADDR, UNLOCK0_CMD);
> +    flash_cmd(c, UNLOCK1_ADDR, UNLOCK1_CMD);
> +}
> +
> +static void reset(const FlashConfig *c)
> +{
> +    flash_cmd(c, FLASH_ADDR(0), RESET_CMD);
> +}
> +
> +static void sector_erase(const FlashConfig *c, uint64_t byte_addr)
> +{
> +    unlock(c);
> +    flash_cmd(c, UNLOCK0_ADDR, 0x80);
> +    unlock(c);
> +    flash_write(c, byte_addr, replicate(c, SECTOR_ERASE_CMD));
> +}
> +
> +static void wait_for_completion(const FlashConfig *c, uint64_t byte_addr=
)
> +{
> +    /* If DQ6 is toggling, step the clock and ensure the toggle stops. *=
/
> +    const uint64_t dq6 =3D replicate(c, 0x40);
> +    if ((flash_read(c, byte_addr) & dq6) ^ (flash_read(c, byte_addr) & d=
q6)) {
> +        /* Wait for erase or program to finish. */
> +        qtest_clock_step_next(c->qtest);
> +        /* Ensure that DQ6 has stopped toggling. */
> +        g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, flash_read(c, =
byte_addr));
> +    }
> +}
> +
> +static void bypass_program(const FlashConfig *c, uint64_t byte_addr,
> +                           uint16_t data)
> +{
> +    flash_cmd(c, UNLOCK0_ADDR, PROGRAM_CMD);
> +    flash_write(c, byte_addr, data);
>      /*
>       * Data isn't valid until DQ6 stops toggling. We don't model this as
>       * writes are immediate, but if this changes in the future, we can w=
ait
>       * until the program is complete.
>       */
> -    wait_for_completion(byte_addr);
> +    wait_for_completion(c, byte_addr);
>  }
>
> -static void program(uint64_t byte_addr, uint16_t data)
> +static void program(const FlashConfig *c, uint64_t byte_addr, uint16_t d=
ata)
>  {
> -    unlock();
> -    bypass_program(byte_addr, data);
> +    unlock(c);
> +    bypass_program(c, byte_addr, data);
>  }
>
> -static void chip_erase(void)
> +static void chip_erase(const FlashConfig *c)
>  {
> -    unlock();
> -    flash_write(UNLOCK0_ADDR, 0x80);
> -    unlock();
> -    flash_write(UNLOCK0_ADDR, SECTOR_ERASE_CMD);
> +    unlock(c);
> +    flash_cmd(c, UNLOCK0_ADDR, 0x80);
> +    unlock(c);
> +    flash_cmd(c, UNLOCK0_ADDR, CHIP_ERASE_CMD);
>  }
>
> -static void test_flash(void)
> +static void test_flash(const void *opaque)
>  {
> -    global_qtest =3D qtest_initf("-M musicpal,accel=3Dqtest "
> -                               "-drive if=3Dpflash,file=3D%s,format=3Dra=
w,copy-on-read",
> -                               image_path);
> +    const FlashConfig *config =3D opaque;
> +    QTestState *qtest;
> +    qtest =3D qtest_initf("-M musicpal,accel=3Dqtest"
> +                        " -drive if=3Dpflash,file=3D%s,format=3Draw,copy=
-on-read",
> +                        image_path);
> +    FlashConfig explicit_config =3D expand_config_defaults(config);
> +    explicit_config.qtest =3D qtest;
> +    const FlashConfig *c =3D &explicit_config;
> +
>      /* Check the IDs. */
> -    unlock();
> -    flash_write(UNLOCK0_ADDR, AUTOSELECT_CMD);
> -    g_assert_cmphex(flash_read(FLASH_WIDTH * 0x0000), =3D=3D, 0x00BF);
> -    g_assert_cmphex(flash_read(FLASH_WIDTH * 0x0001), =3D=3D, 0x236D);
> -    reset();
> +    unlock(c);
> +    flash_cmd(c, UNLOCK0_ADDR, AUTOSELECT_CMD);
> +    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), =3D=3D, replicate(c, =
0xBF));
> +    if (c->bank_width >=3D 2) {
> +        /*
> +         * XXX: The ID returned by the musicpal flash chip is 16 bits wh=
ich
> +         * wouldn't happen with an 8-bit device. It would probably be be=
st to
> +         * prohibit addresses larger than the device width in pflash_cfi=
02.c,
> +         * but then we couldn't test smaller device widths at all.
> +         */
> +        g_assert_cmphex(flash_query(c, FLASH_ADDR(1)), =3D=3D,
> +                        replicate(c, 0x236D));
> +    }
> +    reset(c);
>
>      /* Check the erase blocks. */
> -    flash_write(CFI_ADDR, CFI_CMD);
> -    g_assert_cmphex(flash_read(FLASH_WIDTH * 0x10), =3D=3D, 'Q');
> -    g_assert_cmphex(flash_read(FLASH_WIDTH * 0x11), =3D=3D, 'R');
> -    g_assert_cmphex(flash_read(FLASH_WIDTH * 0x12), =3D=3D, 'Y');
> -    /* Num erase regions. */
> -    g_assert_cmphex(flash_read(FLASH_WIDTH * 0x2C), >=3D, 1);
> -    uint32_t nb_sectors =3D flash_read(FLASH_WIDTH * 0x2D) +
> -                          (flash_read(FLASH_WIDTH * 0x2E) << 8) + 1;
> -    uint32_t sector_len =3D (flash_read(FLASH_WIDTH * 0x2F) << 8) +
> -                          (flash_read(FLASH_WIDTH * 0x30) << 16);
> -    reset();
> +    flash_cmd(c, CFI_ADDR, CFI_CMD);
> +    g_assert_cmphex(flash_query(c, FLASH_ADDR(0x10)), =3D=3D, replicate(=
c, 'Q'));
> +    g_assert_cmphex(flash_query(c, FLASH_ADDR(0x11)), =3D=3D, replicate(=
c, 'R'));
> +    g_assert_cmphex(flash_query(c, FLASH_ADDR(0x12)), =3D=3D, replicate(=
c, 'Y'));
>
> +    /* Num erase regions. */
> +    g_assert_cmphex(flash_query_1(c, FLASH_ADDR(0x2C)), >=3D, 1);
> +
> +    uint32_t nb_sectors =3D flash_query_1(c, FLASH_ADDR(0x2D)) +
> +                          (flash_query_1(c, FLASH_ADDR(0x2E)) << 8) + 1;
> +    uint32_t sector_len =3D (flash_query_1(c, FLASH_ADDR(0x2F)) << 8) +
> +                          (flash_query_1(c, FLASH_ADDR(0x30)) << 16);
> +    reset(c);
> +
> +    const uint64_t dq7 =3D replicate(c, 0x80);
> +    const uint64_t dq6 =3D replicate(c, 0x40);
>      /* Erase and program sector. */
>      for (uint32_t i =3D 0; i < nb_sectors; ++i) {
>          uint64_t byte_addr =3D i * sector_len;
> -        sector_erase(byte_addr);
> +        sector_erase(c, byte_addr);
>          /* Read toggle. */
> -        uint16_t status0 =3D flash_read(byte_addr);
> +        uint64_t status0 =3D flash_read(c, byte_addr);
>          /* DQ7 is 0 during an erase. */
> -        g_assert_cmphex(status0 & 0x80, =3D=3D, 0);
> -        uint16_t status1 =3D flash_read(byte_addr);
> +        g_assert_cmphex(status0 & dq7, =3D=3D, 0);
> +        uint64_t status1 =3D flash_read(c, byte_addr);
>          /* DQ6 toggles during an erase. */
> -        g_assert_cmphex(status0 & 0x40, !=3D, status1 & 0x40);
> +        g_assert_cmphex(status0 & dq6, =3D=3D, ~status1 & dq6);
>          /* Wait for erase to complete. */
> -        clock_step_next();
> +        qtest_clock_step_next(c->qtest);
>          /* Ensure DQ6 has stopped toggling. */
> -        g_assert_cmphex(flash_read(byte_addr), =3D=3D, flash_read(byte_a=
ddr));
> +        g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, flash_read(c, =
byte_addr));
>          /* Now the data should be valid. */
> -        g_assert_cmphex(flash_read(byte_addr), =3D=3D, 0xFFFF);
> +        g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, bank_mask(c));
>
>          /* Program a bit pattern. */
> -        program(byte_addr, 0x5555);
> -        g_assert_cmphex(flash_read(byte_addr), =3D=3D, 0x5555);
> -        program(byte_addr, 0xAA55);
> -        g_assert_cmphex(flash_read(byte_addr), =3D=3D, 0x0055);
> +        program(c, byte_addr, 0x55);
> +        g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, =3D=3D, 0x55);
> +        program(c, byte_addr, 0xA5);
> +        g_assert_cmphex(flash_read(c, byte_addr) & 0xFF, =3D=3D, 0x05);
>      }
>
>      /* Erase the chip. */
> -    chip_erase();
> +    chip_erase(c);
>      /* Read toggle. */
> -    uint16_t status0 =3D flash_read(0);
> +    uint64_t status0 =3D flash_read(c, 0);
>      /* DQ7 is 0 during an erase. */
> -    g_assert_cmphex(status0 & 0x80, =3D=3D, 0);
> -    uint16_t status1 =3D flash_read(0);
> +    g_assert_cmphex(status0 & dq7, =3D=3D, 0);
> +    uint64_t status1 =3D flash_read(c, 0);
>      /* DQ6 toggles during an erase. */
> -    g_assert_cmphex(status0 & 0x40, !=3D, status1 & 0x40);
> +    g_assert_cmphex(status0 & dq6, =3D=3D, ~status1 & dq6);
>      /* Wait for erase to complete. */
> -    clock_step_next();
> +    qtest_clock_step_next(c->qtest);
>      /* Ensure DQ6 has stopped toggling. */
> -    g_assert_cmphex(flash_read(0), =3D=3D, flash_read(0));
> +    g_assert_cmphex(flash_read(c, 0), =3D=3D, flash_read(c, 0));
>      /* Now the data should be valid. */
> -    g_assert_cmphex(flash_read(0), =3D=3D, 0xFFFF);
> +
> +    for (uint32_t i =3D 0; i < nb_sectors; ++i) {
> +        uint64_t byte_addr =3D i * sector_len;
> +        g_assert_cmphex(flash_read(c, byte_addr), =3D=3D, bank_mask(c));
> +    }
>
>      /* Unlock bypass */
> -    unlock();
> -    flash_write(UNLOCK0_ADDR, UNLOCK_BYPASS_CMD);
> -    bypass_program(0, 0x0123);
> -    bypass_program(2, 0x4567);
> -    bypass_program(4, 0x89AB);
> +    unlock(c);
> +    flash_cmd(c, UNLOCK0_ADDR, UNLOCK_BYPASS_CMD);
> +    bypass_program(c, 0 * c->bank_width, 0x01);
> +    bypass_program(c, 1 * c->bank_width, 0x23);
> +    bypass_program(c, 2 * c->bank_width, 0x45);
>      /*
>       * Test that bypass programming, unlike normal programming can use a=
ny
>       * address for the PROGRAM_CMD.
>       */
> -    flash_write(6, PROGRAM_CMD);
> -    flash_write(6, 0xCDEF);
> -    wait_for_completion(6);
> -    flash_write(0, UNLOCK_BYPASS_RESET_CMD);
> -    bypass_program(8, 0x55AA); /* Should fail. */
> -    g_assert_cmphex(flash_read(0), =3D=3D, 0x0123);
> -    g_assert_cmphex(flash_read(2), =3D=3D, 0x4567);
> -    g_assert_cmphex(flash_read(4), =3D=3D, 0x89AB);
> -    g_assert_cmphex(flash_read(6), =3D=3D, 0xCDEF);
> -    g_assert_cmphex(flash_read(8), =3D=3D, 0xFFFF);
> +    flash_cmd(c, FLASH_ADDR(3 * c->bank_width), PROGRAM_CMD);
> +    flash_write(c, 3 * c->bank_width, 0x67);
> +    wait_for_completion(c, 3 * c->bank_width);
> +    flash_cmd(c, FLASH_ADDR(0), UNLOCK_BYPASS_RESET_CMD);
> +    bypass_program(c, 4 * c->bank_width, 0x89); /* Should fail. */
> +    g_assert_cmphex(flash_read(c, 0 * c->bank_width), =3D=3D, 0x01);
> +    g_assert_cmphex(flash_read(c, 1 * c->bank_width), =3D=3D, 0x23);
> +    g_assert_cmphex(flash_read(c, 2 * c->bank_width), =3D=3D, 0x45);
> +    g_assert_cmphex(flash_read(c, 3 * c->bank_width), =3D=3D, 0x67);
> +    g_assert_cmphex(flash_read(c, 4 * c->bank_width), =3D=3D, bank_mask(=
c));
>
>      /* Test ignored high order bits of address. */
> -    flash_write(FLASH_WIDTH * 0x5555, UNLOCK0_CMD);
> -    flash_write(FLASH_WIDTH * 0x2AAA, UNLOCK1_CMD);
> -    flash_write(FLASH_WIDTH * 0x5555, AUTOSELECT_CMD);
> -    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0000), =3D=3D, 0x00BF);
> -    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0001), =3D=3D, 0x236D);
> -    reset();
> +    flash_cmd(c, FLASH_ADDR(0x5555), UNLOCK0_CMD);
> +    flash_cmd(c, FLASH_ADDR(0x2AAA), UNLOCK1_CMD);
> +    flash_cmd(c, FLASH_ADDR(0x5555), AUTOSELECT_CMD);
> +    g_assert_cmphex(flash_query(c, FLASH_ADDR(0)), =3D=3D, replicate(c, =
0xBF));
> +    reset(c);
>
> -    qtest_quit(global_qtest);
> +    qtest_quit(qtest);
>  }
>
>  static void cleanup(void *opaque)
> @@ -206,6 +355,17 @@ static void cleanup(void *opaque)
>      unlink(image_path);
>  }
>
> +/*
> + * XXX: Tests are limited to bank_width =3D 2 for now because that's wha=
t
> + * hw/arm/musicpal.c has.
> + */
> +static const FlashConfig configuration[] =3D {
> +    /* One x16 device. */
> +    {
> +        .bank_width =3D 2,
> +    },
> +};
> +
>  int main(int argc, char **argv)
>  {
>      int fd =3D mkstemp(image_path);
> @@ -214,19 +374,27 @@ int main(int argc, char **argv)
>                     strerror(errno));
>          exit(EXIT_FAILURE);
>      }
> -    if (ftruncate(fd, 8 * 1024 * 1024) < 0) {
> +    if (ftruncate(fd, FLASH_SIZE) < 0) {
>          int error_code =3D errno;
>          close(fd);
>          unlink(image_path);
> -        g_printerr("Failed to truncate file %s to 8 MB: %s\n", image_pat=
h,
> -                   strerror(error_code));
> +        g_printerr("Failed to truncate file %s to %u MB: %s\n", image_pa=
th,
> +                   FLASH_SIZE, strerror(error_code));
>          exit(EXIT_FAILURE);
>      }
>      close(fd);
>
>      qtest_add_abrt_handler(cleanup, NULL);
>      g_test_init(&argc, &argv, NULL);
> -    qtest_add_func("pflash-cfi02", test_flash);
> +
> +    size_t nb_configurations =3D sizeof configuration / sizeof configura=
tion[0];
> +    for (size_t i =3D 0; i < nb_configurations; ++i) {
> +        const FlashConfig *config =3D &configuration[i];
> +        char *path =3D g_strdup_printf("pflash-cfi02/%d",
> +                                     config->bank_width);
> +        qtest_add_data_func(path, config, test_flash);
> +        g_free(path);
> +    }
>      int result =3D g_test_run();
>      cleanup(NULL);
>      return result;
> --
> 2.20.1
>
>

