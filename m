Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA116C28CC2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 01:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DEB26264
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 01:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DEB26264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWWdN-0000SE-Fk
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 21:47:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWWcK-0008QE-4F
	for qemu-devel@nongnu.org; Thu, 30 May 2019 21:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWWcI-0002XU-Ce
	for qemu-devel@nongnu.org; Thu, 30 May 2019 21:46:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hWWcG-0002Rg-Ga
	for qemu-devel@nongnu.org; Thu, 30 May 2019 21:45:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7330BF74A0
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 01:45:55 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F869F6F0;
	Fri, 31 May 2019 01:45:53 +0000 (UTC)
Date: Fri, 31 May 2019 09:45:50 +0800
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190531014550.GG28587@xz-x1>
References: <20190530092919.26059-1-peterx@redhat.com>
	<20190530092919.26059-6-peterx@redhat.com>
	<20190530110526.GD2823@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190530110526.GD2823@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 31 May 2019 01:45:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 05/12] bitmap: Add
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

On Thu, May 30, 2019 at 12:05:27PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > These helpers copy the source bitmap to destination bitmap with a
> > shift either on the src or dst bitmap.
> > 
> > Meanwhile, we never have bitmap tests but we should.
> > 
> > This patch also introduces the initial test cases for utils/bitmap.c
> > but it only tests the newly introduced functions.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qemu/bitmap.h  |  9 +++++
> >  tests/Makefile.include |  2 ++
> >  tests/test-bitmap.c    | 81 ++++++++++++++++++++++++++++++++++++++++++
> >  util/bitmap.c          | 73 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 165 insertions(+)
> >  create mode 100644 tests/test-bitmap.c
> > 
> > diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> > index 5c313346b9..cdaa953371 100644
> > --- a/include/qemu/bitmap.h
> > +++ b/include/qemu/bitmap.h
> > @@ -41,6 +41,10 @@
> >   * bitmap_find_next_zero_area(buf, len, pos, n, mask)	Find bit free area
> >   * bitmap_to_le(dst, src, nbits)      Convert bitmap to little endian
> >   * bitmap_from_le(dst, src, nbits)    Convert bitmap from little endian
> > + * bitmap_copy_with_src_offset(dst, src, offset, nbits)
> > + *                                    *dst = *src (with an offset upon src)
> 
> 'into' would be better than 'upon'

Ok.

> 
> > + * bitmap_copy_with_dst_offset(dst, src, offset, nbits)
> > + *                                    *dst = *src (with an offset upon dst)
> >   */
> >  
> >  /*
> > @@ -271,4 +275,9 @@ void bitmap_to_le(unsigned long *dst, const unsigned long *src,
> >  void bitmap_from_le(unsigned long *dst, const unsigned long *src,
> >                      long nbits);
> >  
> > +void bitmap_copy_with_src_offset(unsigned long *dst, const unsigned long *src,
> > +                                 long offset, long nbits);
> > +void bitmap_copy_with_dst_offset(unsigned long *dst, const unsigned long *src,
> > +                                 long shift, long nbits);
> > +
> >  #endif /* BITMAP_H */
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 1865f6b322..5e2d7dddff 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -64,6 +64,7 @@ check-unit-y += tests/test-opts-visitor$(EXESUF)
> >  check-unit-$(CONFIG_BLOCK) += tests/test-coroutine$(EXESUF)
> >  check-unit-y += tests/test-visitor-serialization$(EXESUF)
> >  check-unit-y += tests/test-iov$(EXESUF)
> > +check-unit-y += tests/test-bitmap$(EXESUF)
> >  check-unit-$(CONFIG_BLOCK) += tests/test-aio$(EXESUF)
> >  check-unit-$(CONFIG_BLOCK) += tests/test-aio-multithread$(EXESUF)
> >  check-unit-$(CONFIG_BLOCK) += tests/test-throttle$(EXESUF)
> > @@ -529,6 +530,7 @@ tests/test-image-locking$(EXESUF): tests/test-image-locking.o $(test-block-obj-y
> >  tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
> >  tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
> >  tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
> > +tests/test-bitmap$(EXESUF): tests/test-bitmap.o $(test-util-obj-y)
> >  tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
> >  tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
> >  tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-util-obj-y)
> > diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> > new file mode 100644
> > index 0000000000..36b4c07bf2
> > --- /dev/null
> > +++ b/tests/test-bitmap.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> We probably shouldn't use GPL-2.0 for new; most stuff is 2.0-or-later

Ok.

> 
> > +/*
> > + * Bitmap.c unit-tests.
> > + *
> > + * Copyright (C) 2019, Red Hat, Inc.
> > + *
> > + * Author: Peter Xu <peterx@redhat.com>
> > + */
> > +
> > +#include <stdlib.h>
> > +#include "qemu/osdep.h"
> > +#include "qemu/bitmap.h"
> > +
> > +#define BMAP_SIZE  1024
> > +
> > +static void check_bitmap_copy_with_offset(void)
> > +{
> > +    int i;
> > +    unsigned long *bmap1, *bmap2, *bmap3, total;
> > +
> > +    bmap1 = bitmap_new(BMAP_SIZE);
> > +    bmap2 = bitmap_new(BMAP_SIZE);
> > +    bmap3 = bitmap_new(BMAP_SIZE);
> > +
> > +    *bmap1 = random();
> > +    *(bmap1 + 1) = random();
> > +    *(bmap1 + 2) = random();
> > +    *(bmap1 + 3) = random();
> > +    total = BITS_PER_LONG * 4;
> > +
> > +    /* Shift 115 bits into bmap2 */
> > +    bitmap_copy_with_dst_offset(bmap2, bmap1, 115, total);
> > +    /* Shift another 85 bits into bmap3 */
> > +    bitmap_copy_with_dst_offset(bmap3, bmap2, 85, total + 115);
> > +    /* Shift back 200 bits back */
> > +    bitmap_copy_with_src_offset(bmap2, bmap3, 200, total);
> > +
> > +    for (i = 0; i < 3; i++) {
> > +        g_assert(*(bmap1 + i) == *(bmap2 + i));
> > +    }
> 
> can we get rid fo these loops with:
>        g_assert_cmpmem(bmap1, total / 8, bmap2, total / 8) 

Yes.  I'm using BITS_PER_LONG instead of 8 though to suite 32bit.

> 
> > +    bitmap_clear(bmap1, 0, BMAP_SIZE);
> > +    /* Set bits in bmap1 are 100-245 */
> > +    bitmap_set(bmap1, 100, 145);
> > +
> > +    /* Set bits in bmap2 are 60-205 */
> > +    bitmap_copy_with_src_offset(bmap2, bmap1, 40, 250);
> > +    for (i = 0; i < 60; i++) {
> > +        g_assert(test_bit(i, bmap2) == 0);
> > +    }
> 
>        g_assert_cmpint(find_first_bit(bmap2, 60), ==, 60)

Fixed.

> 
> > +    for (i = 60; i < 205; i++) {
> > +        g_assert(test_bit(i, bmap2));
> > +    }
> 
>        g_assert_cmpint(find_next_zero_bit(bmap2, 205, 60), == 205) 

Fixed.

> 
> > +    g_assert(test_bit(205, bmap2) == 0);
> > +
> > +    /* Set bits in bmap3 are 135-280 */
> > +    bitmap_copy_with_dst_offset(bmap3, bmap1, 35, 250);
> > +    for (i = 0; i < 135; i++) {
> > +        g_assert(test_bit(i, bmap3) == 0);
> > +    }
> > +    for (i = 135; i < 280; i++) {
> > +        g_assert(test_bit(i, bmap3));
> > +    }
> > +    g_assert(test_bit(280, bmap3) == 0);
> > +
> > +    g_free(bmap1);
> > +    g_free(bmap2);
> > +    g_free(bmap3);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +
> > +    g_test_add_func("/bitmap/bitmap_copy_with_offset",
> > +                    check_bitmap_copy_with_offset);
> > +
> > +    g_test_run();
> > +
> > +    return 0;
> > +}
> > diff --git a/util/bitmap.c b/util/bitmap.c
> > index cb618c65a5..391a7bb744 100644
> > --- a/util/bitmap.c
> > +++ b/util/bitmap.c
> > @@ -402,3 +402,76 @@ void bitmap_to_le(unsigned long *dst, const unsigned long *src,
> >  {
> >      bitmap_to_from_le(dst, src, nbits);
> >  }
> > +
> > +/*
> > + * Copy "src" bitmap with a positive offset and put it into the "dst"
> > + * bitmap.  The caller needs to make sure the bitmap size of "src"
> > + * is bigger than (shift + nbits).
> > + */
> > +void bitmap_copy_with_src_offset(unsigned long *dst, const unsigned long *src,
> > +                                 long shift, long nbits)
> > +{
> > +    unsigned long left_mask, right_mask, last_mask;
> > +
> > +    assert(shift >= 0);
> 
> Just make shift and nbits unsigned long?
> (Interestingly bitops.h uses unsigned long everywhere where as bitmap
> uses long)

Sure.

> 
> > +    /* Proper shift src pointer to the first word to copy from */
> > +    src += BIT_WORD(shift);
> > +    shift %= BITS_PER_LONG;

[1]

> > +    right_mask = (1ul << shift) - 1;
> > +    left_mask = ~right_mask;
> > +
> > +    while (nbits >= BITS_PER_LONG) {
> > +        *dst = (*src & left_mask) >> shift;
> > +        *dst |= (*(src + 1) & right_mask) << (BITS_PER_LONG - shift);
> 
>   src[1] ?

Sure.

> 
> Also, perhaps you should only do this line if (right_mask), that way
> if the offset is a multiple of BITS_PER_LONG, you don't access the
> word after the end of the bitmap.

Indeed. Normally the real callers in this series won't happen with
that otherwise we don't need to call this function at all.

Instead of checking right_mask every time I think maybe I can just
provide a quick path at [1] above, then if I found shift==0 I'll go to
another memcpy() quick path.

(but that should never be used because if bitmap can be shifted as
 long aligned then we don't even need to copy them in most cases but
 instead we can just use bitmap[N])

> 
> > +        dst++;
> > +        src++;
> > +        nbits -= BITS_PER_LONG;
> > +    }
> > +
> > +    if (nbits > BITS_PER_LONG - shift) {
> > +        *dst = (*src & left_mask) >> shift;
> > +        nbits -= BITS_PER_LONG - shift;
> > +        last_mask = (1 << nbits) - 1;
> 
> 1ul
> 
> > +        *dst |= (*(src + 1) & last_mask) << (BITS_PER_LONG - shift);
> > +    } else if (nbits) {
> > +        last_mask = (1 << nbits) - 1;
> 
> and again
> 
> > +        *dst = (*src >> shift) & last_mask;
> > +    }
> > +}
> > +
> > +/*
> > + * Copy "src" bitmap into the "dst" bitmap with an offset in the
> > + * "dst".  The caller needs to make sure the bitmap size of "dst" is
> > + * bigger than (shift + nbits).
> > + */
> > +void bitmap_copy_with_dst_offset(unsigned long *dst, const unsigned long *src,
> > +                                 long shift, long nbits)
> > +{
> > +    unsigned long left_mask, right_mask, last_mask;
> > +
> > +    assert(shift >= 0);
> > +    /* Proper shift src pointer to the first word to copy from */
>                        ^^^
> 
> dst
> 
> > +    dst += BIT_WORD(shift);
> > +    shift %= BITS_PER_LONG;
> > +    right_mask = (1ul << (BITS_PER_LONG - shift)) - 1;
> > +    left_mask = ~right_mask;
> > +
> > +    *dst &= (1ul << shift) - 1;
> > +    while (nbits >= BITS_PER_LONG) {
> > +        *dst |= (*src & right_mask) << shift;
> > +        *(dst + 1) = (*src & left_mask) >> (BITS_PER_LONG - shift);
> 
> dst[1] ?
> 
> > +        dst++;
> > +        src++;
> > +        nbits -= BITS_PER_LONG;
> > +    }
> > +
> > +    if (nbits > BITS_PER_LONG - shift) {
> > +        *dst |= (*src & right_mask) << shift;
> > +        nbits -= BITS_PER_LONG - shift;
> > +        last_mask = ((1 << nbits) - 1) << (BITS_PER_LONG - shift);
> 
> 1ul

All fixed up for the rest.  Thanks,

-- 
Peter Xu

