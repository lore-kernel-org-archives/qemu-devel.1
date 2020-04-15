Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DFAC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973AA2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973AA2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOlxu-0003oD-M7
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 13:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jOlv0-0000hv-IB
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jOluy-0004LW-1M
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:33:45 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:38921)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jOluv-0004Db-Pd; Wed, 15 Apr 2020 13:33:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 67B8574637F;
 Wed, 15 Apr 2020 19:33:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3FF6574637E; Wed, 15 Apr 2020 19:33:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3E97D745953;
 Wed, 15 Apr 2020 19:33:31 +0200 (CEST)
Date: Wed, 15 Apr 2020 19:33:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-5.0 v2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
In-Reply-To: <CAFEAcA8kF1dhR0k2kgEr-KxBspxcqLXxVqWcMadDns3-SYKrAQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2004151923090.92157@zero.eik.bme.hu>
References: <20200413220100.18628-1-f4bug@amsat.org>
 <CAFEAcA8kF1dhR0k2kgEr-KxBspxcqLXxVqWcMadDns3-SYKrAQ@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-716024976-1586972011=:92157"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-716024976-1586972011=:92157
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Apr 2020, Peter Maydell wrote:
> On Mon, 13 Apr 2020 at 23:01, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
>>
>> Zhang Zi Ming reported a heap overflow in the Drawing Engine of
>> the SM501 companion chip model, in particular in the COPY_AREA()
>> macro in sm501_2d_operation().
>>
>> Add a simple check to avoid the heap overflow.
>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index de0ab9d977..902acb3875 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -726,6 +726,12 @@ static void sm501_2d_operation(SM501State *s)
>>      int crt =3D (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : =
0;
>>      int fb_len =3D get_width(s, crt) * get_height(s, crt) * get_bpp(s=
, crt);
>>
>> +    if (rtl && (src_x < operation_width || src_y < operation_height))=
 {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "sm501: Illegal RTL address (%=
i, %i)\n",
>> +                      src_x, src_y);
>> +        return;
>> +    }
>
> This does fix an issue, but I have a feeling that there are
> other possible guest register value combinations that might
> cause us to index off one end or the other of the local_mem.

That's what I've meant by it should be reimplemented eventually to fix al=
l=20
possible problems but could not do that before 5.0. Since this is existin=
g=20
bug ever since this device is first committed not patching it now is=20
probably not a big deal if this is not considered a security problem. (An=
d=20
if it is then all the abort() calls are probably a problem too although=20
less serious.)

> The SM501 datasheet is entirely unhelpful on this question, but
> my suggestion is that we should convert the code so that instead
> of operating directly on pointers into the middle of the local_mem
> buffer all the accesses to local_mem go via functions which mask
> off the high bits of the index. That effectively means that the
> behaviour if we index off the end of the graphics memory is
> that we just wrap round to the start of it. It should be fairly
> easy to be confident that the code isn't accessing off the end
> of the array and it might even be what the hardware actually does
> (since it would correspond to 'use low bits of the address to
> index the ram, ignore high bits')...

Does that make it even slower than it is already? I think it should rathe=
r=20
be changed to do what I've done in ati_2d.c and call optimised functions=20
to do the blit operation instead of implementing it directly. Then we'll=20
need checking parameters to avoid overflows. I may try to do that=20
eventually but don't know when will I have time for that so if there's=20
anyone who submits a patch fixing it some way before that that's OK too.

I also know about these missing ops that could be fixed:

sm501: rop3 mode with rop 99 is not supported.
sm501: rop3 mode with rop ee is not supported.

Regards,
BALATON Zoltan
--3866299591-716024976-1586972011=:92157--

