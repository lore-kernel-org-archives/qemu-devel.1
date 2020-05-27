Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2429FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11AA207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11AA207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtss-0005lp-59
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jdts5-0004rF-Hk
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:05:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:45185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jdts2-0005WX-Oh
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:05:16 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9D97C74633E;
 Wed, 27 May 2020 13:05:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 59DD4746331; Wed, 27 May 2020 13:05:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 58C5D74632C;
 Wed, 27 May 2020 13:05:09 +0200 (CEST)
Date: Wed, 27 May 2020 13:05:09 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 5/7] sm501: Replace hand written implementation with
 pixman where possible
In-Reply-To: <20200527091544.j6uvyyxsbhin5viy@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.22.395.2005271218410.17986@zero.eik.bme.hu>
References: <cover.1590089984.git.balaton@eik.bme.hu>
 <58666389b6cae256e4e972a32c05cf8aa51bffc0.1590089984.git.balaton@eik.bme.hu>
 <20200526104318.wmsqqtia3h52l454@sirius.home.kraxel.org>
 <alpine.BSF.2.22.395.2005261434540.87757@zero.eik.bme.hu>
 <20200527091544.j6uvyyxsbhin5viy@sirius.home.kraxel.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 07:05:10
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Hello,

On Wed, 27 May 2020, Gerd Hoffmann wrote:
>>> Well, the advantage of *not* using pixman is that you can easily switch
>>> the code to use offsets instead of pointers, then apply the mask to the
>>> *final* offset to avoid oob data access:
>>
>> The mask applied to src_base is not to prevent overflow but to implement
>> register limits.
>
> Yea, that was just a quick sketch to outline the idea without checking
> all details.
>
>> This patch basically does
>> that by changing parameters to unsigned to prevent them being negative,
>> checking values we multiply by to prevent them to be zero and then
>> calculating first and last offset and check if they are within vram.
>
> Well.  With cirrus this proved to be fragile.  The checks missed corner
> cases and we've got a series of CVEs in the blitter code.  Switching to
> offsets + masking every vram access (see commit ffaf85777828) stopped
> that.
>
>> (Unless
>> of course I've made a mistake somewhere.)
>
> Exactly ...

Hopefully we can make the checks correct eventually. I think for sm501 it 
should already be OK, I'll need to check ati-vga again because I think 
there may be still a mistake in that. (It does not help that every device 
encode these values differently in registers.)

>> This should prevent overflow with
>> one check and does not need to apply a mask at every step. The vram size can
>> also be different so it's not a fixed mask anyway.
>>
>> If not using pixman then I'd need to reimplement optimised 2D ops that will
>> likely never be as good as pixman and no point in doing it several times for
>> every device model so I'd rather try to use pixman where possible unless a
>> better library is available.
>
> Yes, performance-wise pixman is clearly the better choice.  At the end
> of the day it is a security vs performance trade off.

I prefer performance here if security can be achieved without loss of 
performance with correct checks so rather fix the checks until they are 
correct than do additional things in a loop.

>>>> +            if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
>>>> +                /* regions may overlap: copy via temporary */
>>>
>>> The usual way for a hardware blitter is to have a direction bit, i.e.
>>> the guest os can ask to blit in top->bottom or bottom->top scanline
>>> ordering.  The guest can use that to make sure the blit does not
>>
>> Yes, this is the rtl above (right to left) and AmigaOS sets this most of the
>> time so only relying on that to detect overlaps is not efficient.
>
> Hmm, checking rtl like that doesn't look correct to me then.  When using
> the blitter to move a window you have to set/clear rtl depending on
> whenever you move the window up or down on the screen, and src+dst
> regions can overlap in both cases ...

Pixman does left to right, top to bottom so we don't need special handling 
for such blits, they will work even for overlapping areas. Doing non 
overlapping blits should also work with whatever direction (but AmigaOS 
seems to use rtl as default even for non overlapping, maybe hardware 
prefers that or was easier to code somehow). The only case where pixman 
does not work is reverse direction overlapping areas which is checked 
here, although becuase of different strides and offsets it's hard to check 
exactly so we only do a crude check to see if the memory areas are 
overlapping at all. This should catch all bad cases and maybe some good 
ones but checking for those is probably as expensive as doing the blit 
instead. As you said this may not work in some cases but until we come 
across such cases I'd go with this simpler solution because otherwise we 
likely need to implement our own optimised blit routine.

Unlike ati-vga, sm501 does not have independent direction bits so rtl 
seems to mean both right to left and bottom to top. Ati-vga has different 
bit for bottom to top so those with left to right could still use 
pixman_blt calling it in a reverse counting loop for every line but I did 
not go for that optimisation yet. For sm501 there's no such option. 
Possible furher optimisation could be handling 1 pixel and small regions 
directly where the overhead of calling pixman may be bigger than the gain 
from its optimised routines but I would need to measure that for which I 
have no time.

>>> overwrite things.  But note the guest can also intentionally use
>>> overlapping regions, i.e. memset(0) the first scanline, then use a blit
>>> with overlap to clear the whole screen.  The later will surely break if
>>> you blit via temporary image ...
>>
>> Fortunately no guest code seems to do that so unless we find one needing it
>> I don't worry much about such rare cases.
>
> Ok.
>
>>>> +                pixman_blt((uint32_t *)&s->local_mem[src_base],
>>>> +                           (uint32_t *)&s->local_mem[dst_base],
>>>> +                           src_pitch * (1 << format) / sizeof(uint32_t),
>>>> +                           dst_pitch * (1 << format) / sizeof(uint32_t),
>>>> +                           8 * (1 << format), 8 * (1 << format),
>>>> +                           src_x, src_y, dst_x, dst_y, width, height);
>>>
>>> See above, i'm not convinced pixman is the best way here.
>>> When using pixman I'd suggest:
>>>
>>>  (1) src = pixman_image_create_bits_no_clear(...);
>>>  (2) dst = pixman_image_create_bits_no_clear(...);
>>>  (3) pixman_image_composite(PIXMAN_OP_SRC, src, NULL, dst, ...);
>>>  (4) pixman_image_unref(src);
>>>  (5) pixman_image_unref(dst);
>>>
>>> pixman_blt() is probably doing basically the same.
>>
>> Actually not the same, pixman_blt is faster operating directly on pointers
>> while we need all the pixman_image overhead to use pixman_image_composite.
>
> Ok (I didn't check the pixman code).

You should. It's seriously undocumented and using it seems to need digging 
the code or maybe I've missed all the wonderful documentation?

> Given the use case (run a computer museum ;) I think we can live with
> the flaws of the pixman approach.  Security shouldn't be that much of an
> issue here.  The behavior and blitter use pattern of the guests is known
> too and unlikely to change.

To my knowledge the sm501 is only used on an SH4 machine, the sam460ex and 
to run MorphOS on mac99 but ati-vga is already better for the latter so 
these are not security critical in my opinion.

Regards,
BALATON Zoltan

