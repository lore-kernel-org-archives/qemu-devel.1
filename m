Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD90C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE0E2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE0E2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZmS-000074-GO
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jdZjz-0003OL-Lv
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:35:35 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:45693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jdZjw-0006Iq-SP
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:35:34 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5526274633F;
 Tue, 26 May 2020 15:35:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 08AA6746331; Tue, 26 May 2020 15:35:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 07187746335;
 Tue, 26 May 2020 15:35:21 +0200 (CEST)
Date: Tue, 26 May 2020 15:35:21 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 5/7] sm501: Replace hand written implementation with
 pixman where possible
In-Reply-To: <20200526104318.wmsqqtia3h52l454@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.22.395.2005261434540.87757@zero.eik.bme.hu>
References: <cover.1590089984.git.balaton@eik.bme.hu>
 <58666389b6cae256e4e972a32c05cf8aa51bffc0.1590089984.git.balaton@eik.bme.hu>
 <20200526104318.wmsqqtia3h52l454@sirius.home.kraxel.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020, Gerd Hoffmann wrote:
> On Thu, May 21, 2020 at 09:39:44PM +0200, BALATON Zoltan wrote:
>> Besides being faster this should also prevent malicious guests to
>> abuse 2D engine to overwrite data or cause a crash.
>
>>          uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
>> -        uint8_t *src = s->local_mem + src_base;
>
>> -                    val = *(_pixel_type *)&src[index_s];                      \
>
> Well, the advantage of *not* using pixman is that you can easily switch
> the code to use offsets instead of pointers, then apply the mask to the
> *final* offset to avoid oob data access:

The mask applied to src_base is not to prevent overflow but to implement 
register limits. Only these bits are valid if I remember correctly, so 
even if I use offsets I need to check for overflow. This patch basically 
does that by changing parameters to unsigned to prevent them being 
negative, checking values we multiply by to prevent them to be zero and 
then calculating first and last offset and check if they are within vram. 
(Unless of course I've made a mistake somewhere.) This should prevent 
overflow with one check and does not need to apply a mask at every step. 
The vram size can also be different so it's not a fixed mask anyway.

If not using pixman then I'd need to reimplement optimised 2D ops that 
will likely never be as good as pixman and no point in doing it several 
times for every device model so I'd rather try to use pixman where 
possible unless a better library is available.

>    val = *(_pixel_type*)(&s->local_mem[(s->twoD_source_base + index_s) & 0x03FFFFFF]);
>
>> +        if ((rop_mode && rop == 0x5) || (!rop_mode && rop == 0x55)) {
>> +            /* Invert dest, is there a way to do this with pixman? */
>
> PIXMAN_OP_XOR maybe?

Maybe, but looking at the pixman source I couldn't decide if

UN8x4_MUL_UN8_ADD_UN8x4_MUL_UN8 (s, dest_ia, d, src_ia);

seen here:
https://cgit.freedesktop.org/pixman/tree/pixman/pixman-combine32.c#n396
is really the same as s ^ d.

>> +            if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
>> +                /* regions may overlap: copy via temporary */
>
> The usual way for a hardware blitter is to have a direction bit, i.e.
> the guest os can ask to blit in top->bottom or bottom->top scanline
> ordering.  The guest can use that to make sure the blit does not

Yes, this is the rtl above (right to left) and AmigaOS sets this most of 
the time so only relying on that to detect overlaps is not efficient.

> overwrite things.  But note the guest can also intentionally use
> overlapping regions, i.e. memset(0) the first scanline, then use a blit
> with overlap to clear the whole screen.  The later will surely break if
> you blit via temporary image ...

Fortunately no guest code seems to do that so unless we find one needing 
it I don't worry much about such rare cases. It would be best if pixman 
supported this but while I've found patches were submitted they did not 
get merged so far so using a temporary seems to be the simplest way that 
works well enough for now.

>> +                pixman_blt((uint32_t *)&s->local_mem[src_base],
>> +                           (uint32_t *)&s->local_mem[dst_base],
>> +                           src_pitch * (1 << format) / sizeof(uint32_t),
>> +                           dst_pitch * (1 << format) / sizeof(uint32_t),
>> +                           8 * (1 << format), 8 * (1 << format),
>> +                           src_x, src_y, dst_x, dst_y, width, height);
>
> See above, i'm not convinced pixman is the best way here.
> When using pixman I'd suggest:
>
>  (1) src = pixman_image_create_bits_no_clear(...);
>  (2) dst = pixman_image_create_bits_no_clear(...);
>  (3) pixman_image_composite(PIXMAN_OP_SRC, src, NULL, dst, ...);
>  (4) pixman_image_unref(src);
>  (5) pixman_image_unref(dst);
>
> pixman_blt() is probably doing basically the same.

Actually not the same, pixman_blt is faster operating directly on pointers 
while we need all the pixman_image overhead to use pixman_image_composite. 
Blitter is used for a lot of small ops (I've seen AmigaOS even call it 
with 1 pixel regions) so going through pixman_image every time does not 
seem to be efficient. To implement more complex ops this may be needed so 
I may try to figure that out later but I'd need some test cases to test if 
the results are correct. The current patches do the same as before (except 
for some rare overlapping cases as you noted above but we haven't observed 
any yet) and fix the overflows so this was the best I could do in the time 
I had. Maybe I try to improve this later but don't plan to rewrite it now.

>  The advantage of not
> using pixman_blt() is that
>
>  (a) you can also use pixman ops other than PIXMAN_OP_SRC, and
>  (b) you can have a helper function for (1)+(2) which very carefully
>      applies sanity checks to make sure the pixman image created stays
>      completely inside s->local_mem.
>  (c) you have the option to completely rearrange the code flow, for
>      example update the src pixman image whenever the guest touches
>      src_base or src_pitch or format instead of having a
>      create/op/unref cycle on every blitter op.

From traces I think most guest would write bltter related regs on every op 
so probably not worth the hassle to try to update regions on register 
access and we could do it on every op, possibly optimising 1 pixel blits 
and small regions via some special cases but even then simple copy image 
is probably the most common op that might worth doing via pixman_blt as 
it's expected to be frequently used so the less overhead is the better. 
Therefore I'd only use image_composite for more complex ops but that's too 
much effort for a relatively unused device model. Maybe for ati-vga I'll 
try to make it better but first should fix microengine for that so drivers 
can talk to it. I'd rather spend my limited free time on that than further 
improving sm501 unless some bugs show up.

>> +        pixman_fill((uint32_t *)&s->local_mem[dst_base],
>> +                    dst_pitch * (1 << format) / sizeof(uint32_t),
>> +                    8 * (1 << format), dst_x, dst_y, width, height, color);
>
>  (1) src = pixman_image_create_solid(...), otherwise same as above ;)

Same argument as composite_image and for fill we don't even have any 
advantage so while for composite implementing other ops is a reason to not 
use pixman_blt I see no reason to not go the fastest way for fill.

Regards,
BALATON Zoltan

