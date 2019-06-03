Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D13AC28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E4D261AF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E4D261AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60466 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjLl-0000gB-0n
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:33:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hXjIP-0007FJ-BI
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hXjIN-0001nB-PS
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:30:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hXjIN-0001lS-Gx
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77D67C1EB1E0
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 09:30:17 +0000 (UTC)
Received: from work-vm (ovpn-117-145.ams2.redhat.com [10.36.117.145])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 20694100164A;
	Mon,  3 Jun 2019 09:30:02 +0000 (UTC)
Date: Mon, 3 Jun 2019 10:30:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190603093000.GC2640@work-vm>
References: <20190603065056.25211-1-peterx@redhat.com>
	<20190603065056.25211-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603065056.25211-5-peterx@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 03 Jun 2019 09:30:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 04/11] bitmap: Add
 bitmap_copy_with_{src|dst}_offset()
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> These helpers copy the source bitmap to destination bitmap with a
> shift either on the src or dst bitmap.
> 
> Meanwhile, we never have bitmap tests but we should.
> 
> This patch also introduces the initial test cases for utils/bitmap.c
> but it only tests the newly introduced functions.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/qemu/bitmap.h  |  9 +++++
>  tests/Makefile.include |  2 +
>  tests/test-bitmap.c    | 72 +++++++++++++++++++++++++++++++++++
>  util/bitmap.c          | 85 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 168 insertions(+)
>  create mode 100644 tests/test-bitmap.c
> 
> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> index 5c313346b9..82a1d2f41f 100644
> --- a/include/qemu/bitmap.h
> +++ b/include/qemu/bitmap.h
> @@ -41,6 +41,10 @@
>   * bitmap_find_next_zero_area(buf, len, pos, n, mask)	Find bit free area
>   * bitmap_to_le(dst, src, nbits)      Convert bitmap to little endian
>   * bitmap_from_le(dst, src, nbits)    Convert bitmap from little endian
> + * bitmap_copy_with_src_offset(dst, src, offset, nbits)
> + *                                    *dst = *src (with an offset into src)
> + * bitmap_copy_with_dst_offset(dst, src, offset, nbits)
> + *                                    *dst = *src (with an offset into dst)
>   */
>  
>  /*
> @@ -271,4 +275,9 @@ void bitmap_to_le(unsigned long *dst, const unsigned long *src,
>  void bitmap_from_le(unsigned long *dst, const unsigned long *src,
>                      long nbits);
>  
> +void bitmap_copy_with_src_offset(unsigned long *dst, const unsigned long *src,
> +                                 unsigned long offset, unsigned long nbits);
> +void bitmap_copy_with_dst_offset(unsigned long *dst, const unsigned long *src,
> +                                 unsigned long shift, unsigned long nbits);
> +
>  #endif /* BITMAP_H */
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 1865f6b322..5e2d7dddff 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -64,6 +64,7 @@ check-unit-y += tests/test-opts-visitor$(EXESUF)
>  check-unit-$(CONFIG_BLOCK) += tests/test-coroutine$(EXESUF)
>  check-unit-y += tests/test-visitor-serialization$(EXESUF)
>  check-unit-y += tests/test-iov$(EXESUF)
> +check-unit-y += tests/test-bitmap$(EXESUF)
>  check-unit-$(CONFIG_BLOCK) += tests/test-aio$(EXESUF)
>  check-unit-$(CONFIG_BLOCK) += tests/test-aio-multithread$(EXESUF)
>  check-unit-$(CONFIG_BLOCK) += tests/test-throttle$(EXESUF)
> @@ -529,6 +530,7 @@ tests/test-image-locking$(EXESUF): tests/test-image-locking.o $(test-block-obj-y
>  tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
>  tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
>  tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
> +tests/test-bitmap$(EXESUF): tests/test-bitmap.o $(test-util-obj-y)
>  tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
>  tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
>  tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> new file mode 100644
> index 0000000000..43f7ba26c5
> --- /dev/null
> +++ b/tests/test-bitmap.c
> @@ -0,0 +1,72 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Bitmap.c unit-tests.
> + *
> + * Copyright (C) 2019, Red Hat, Inc.
> + *
> + * Author: Peter Xu <peterx@redhat.com>
> + */
> +
> +#include <stdlib.h>
> +#include "qemu/osdep.h"
> +#include "qemu/bitmap.h"
> +
> +#define BMAP_SIZE  1024
> +
> +static void check_bitmap_copy_with_offset(void)
> +{
> +    unsigned long *bmap1, *bmap2, *bmap3, total;
> +
> +    bmap1 = bitmap_new(BMAP_SIZE);
> +    bmap2 = bitmap_new(BMAP_SIZE);
> +    bmap3 = bitmap_new(BMAP_SIZE);
> +
> +    bmap1[0] = random();
> +    bmap1[1] = random();
> +    bmap1[2] = random();
> +    bmap1[3] = random();
> +    total = BITS_PER_LONG * 4;
> +
> +    /* Shift 115 bits into bmap2 */
> +    bitmap_copy_with_dst_offset(bmap2, bmap1, 115, total);
> +    /* Shift another 85 bits into bmap3 */
> +    bitmap_copy_with_dst_offset(bmap3, bmap2, 85, total + 115);
> +    /* Shift back 200 bits back */
> +    bitmap_copy_with_src_offset(bmap2, bmap3, 200, total);
> +
> +    g_assert_cmpmem(bmap1, total / sizeof(unsigned long),
> +                    bmap2, total / sizeof(unsigned long));
> +
> +    bitmap_clear(bmap1, 0, BMAP_SIZE);
> +    /* Set bits in bmap1 are 100-245 */
> +    bitmap_set(bmap1, 100, 145);
> +
> +    /* Set bits in bmap2 are 60-205 */
> +    bitmap_copy_with_src_offset(bmap2, bmap1, 40, 250);
> +    g_assert_cmpint(find_first_bit(bmap2, 60), ==, 60);
> +    g_assert_cmpint(find_next_zero_bit(bmap2, 205, 60), ==, 205);
> +    g_assert(test_bit(205, bmap2) == 0);
> +
> +    /* Set bits in bmap3 are 135-280 */
> +    bitmap_copy_with_dst_offset(bmap3, bmap1, 35, 250);
> +    g_assert_cmpint(find_first_bit(bmap3, 135), ==, 135);
> +    g_assert_cmpint(find_next_zero_bit(bmap3, 280, 135), ==, 280);
> +    g_assert(test_bit(280, bmap3) == 0);
> +
> +    g_free(bmap1);
> +    g_free(bmap2);
> +    g_free(bmap3);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    g_test_add_func("/bitmap/bitmap_copy_with_offset",
> +                    check_bitmap_copy_with_offset);
> +
> +    g_test_run();
> +
> +    return 0;
> +}
> diff --git a/util/bitmap.c b/util/bitmap.c
> index cb618c65a5..1753ff7f5b 100644
> --- a/util/bitmap.c
> +++ b/util/bitmap.c
> @@ -402,3 +402,88 @@ void bitmap_to_le(unsigned long *dst, const unsigned long *src,
>  {
>      bitmap_to_from_le(dst, src, nbits);
>  }
> +
> +/*
> + * Copy "src" bitmap with a positive offset and put it into the "dst"
> + * bitmap.  The caller needs to make sure the bitmap size of "src"
> + * is bigger than (shift + nbits).
> + */
> +void bitmap_copy_with_src_offset(unsigned long *dst, const unsigned long *src,
> +                                 unsigned long shift, unsigned long nbits)
> +{
> +    unsigned long left_mask, right_mask, last_mask;
> +
> +    /* Proper shift src pointer to the first word to copy from */
> +    src += BIT_WORD(shift);
> +    shift %= BITS_PER_LONG;
> +
> +    if (!shift) {
> +        /* Fast path */
> +        bitmap_copy(dst, src, nbits);
> +        return;
> +    }
> +
> +    right_mask = (1ul << shift) - 1;
> +    left_mask = ~right_mask;
> +
> +    while (nbits >= BITS_PER_LONG) {
> +        *dst = (*src & left_mask) >> shift;
> +        *dst |= (src[1] & right_mask) << (BITS_PER_LONG - shift);
> +        dst++;
> +        src++;
> +        nbits -= BITS_PER_LONG;
> +    }
> +
> +    if (nbits > BITS_PER_LONG - shift) {
> +        *dst = (*src & left_mask) >> shift;
> +        nbits -= BITS_PER_LONG - shift;
> +        last_mask = (1ul << nbits) - 1;
> +        *dst |= (src[1] & last_mask) << (BITS_PER_LONG - shift);
> +    } else if (nbits) {
> +        last_mask = (1ul << nbits) - 1;
> +        *dst = (*src >> shift) & last_mask;
> +    }
> +}
> +
> +/*
> + * Copy "src" bitmap into the "dst" bitmap with an offset in the
> + * "dst".  The caller needs to make sure the bitmap size of "dst" is
> + * bigger than (shift + nbits).
> + */
> +void bitmap_copy_with_dst_offset(unsigned long *dst, const unsigned long *src,
> +                                 unsigned long shift, unsigned long nbits)
> +{
> +    unsigned long left_mask, right_mask, last_mask;
> +
> +    /* Proper shift dst pointer to the first word to copy from */
> +    dst += BIT_WORD(shift);
> +    shift %= BITS_PER_LONG;
> +
> +    if (!shift) {
> +        /* Fast path */
> +        bitmap_copy(dst, src, nbits);
> +        return;
> +    }
> +
> +    right_mask = (1ul << (BITS_PER_LONG - shift)) - 1;
> +    left_mask = ~right_mask;
> +
> +    *dst &= (1ul << shift) - 1;
> +    while (nbits >= BITS_PER_LONG) {
> +        *dst |= (*src & right_mask) << shift;
> +        dst[1] = (*src & left_mask) >> (BITS_PER_LONG - shift);
> +        dst++;
> +        src++;
> +        nbits -= BITS_PER_LONG;
> +    }
> +
> +    if (nbits > BITS_PER_LONG - shift) {
> +        *dst |= (*src & right_mask) << shift;
> +        nbits -= BITS_PER_LONG - shift;
> +        last_mask = ((1ul << nbits) - 1) << (BITS_PER_LONG - shift);
> +        dst[1] = (*src & last_mask) >> (BITS_PER_LONG - shift);
> +    } else if (nbits) {
> +        last_mask = (1ul << nbits) - 1;
> +        *dst |= (*src & last_mask) << shift;
> +    }
> +}
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

