Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4ABC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 23:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4D420717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 23:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4D420717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36381 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJnTm-0004AF-8h
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 19:08:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hJnQJ-0000sW-L3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hJnE6-0006Di-30
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:52:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:20735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hJnE5-00068u-Pw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:52:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
	by localhost (Postfix) with SMTP id 869D57456B8;
	Fri, 26 Apr 2019 00:51:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id E685B7456B7; Fri, 26 Apr 2019 00:51:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id DECD174569A;
	Fri, 26 Apr 2019 00:51:54 +0200 (CEST)
Date: Fri, 26 Apr 2019 00:51:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <alpine.BSF.2.21.9999.1904142227580.56442@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1904260048210.88235@zero.eik.bme.hu>
References: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
	<08d40ec6-be36-f2e1-d216-6dd9deb5c1e0@redhat.com>
	<alpine.BSF.2.21.9999.1904142227580.56442@zero.eik.bme.hu>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] ati-vga: Fix check for blt outside vram
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
Cc: Andrew Randrianasulu <randrianasulu@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425225154.Kvmotvn1W736l68o6wdvoKgCMI7Uml6midNujk1bilU@z>

On Sun, 14 Apr 2019, BALATON Zoltan wrote:
> On Tue, 9 Apr 2019, Philippe Mathieu-Daud=C3=A9 wrote:
>> This patch looks 4.0 worthwhile.
>
> Now that it seems we'll have another rc, will this get in? Gerd, I thin=
k you=20
> have to send a pull request with it for that.

Ping? This has missed two rc-s. This prevents a crash so you might want t=
o=20
queue it for stable as well now.

Regards,
BALATON Zoltan

>
>> On 4/9/19 12:56 PM, BALATON Zoltan wrote:
>>> Fix the check preventing calling pixman functions that would access
>>> memory outside allocated vram. The r128 X driver sometimes seem to tr=
y
>>> blits that span outside vram, this check prevents crashing QEMU in
>>> that case. (The r128 X driver may have problems even on real hardware
>>> so I'm not sure if it's a client bug or emulation problem but at leas=
t
>>> QEMU should survive.)
>>>=20
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
>>> ---
>>>  hw/display/ati_2d.c | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
>>> index bc98ba6eeb..fe3ae14864 100644
>>> --- a/hw/display/ati_2d.c
>>> +++ b/hw/display/ati_2d.c
>>> @@ -79,10 +79,10 @@ void ati_2d_blt(ATIVGAState *s)
>>>                  s->regs.dst_width, s->regs.dst_height);
>>>          end =3D s->vga.vram_ptr + s->vga.vram_size;
>>>          if (src_bits >=3D end || dst_bits >=3D end ||
>>> -            src_bits + (s->regs.src_y + s->regs.dst_height) * src_st=
ride=20
>>> +
>>> -            s->regs.src_x >=3D end ||
>>> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_st=
ride=20
>>> +
>>> -            s->regs.dst_x >=3D end) {
>>> +            src_bits + s->regs.src_x + (s->regs.src_y +=20
>>> s->regs.dst_height) *
>>> +            src_stride * sizeof(uint32_t) >=3D end ||
>>> +            dst_bits + s->regs.dst_x + (s->regs.dst_y +=20
>>> s->regs.dst_height) *
>>> +            dst_stride * sizeof(uint32_t) >=3D end) {
>>>              qemu_log_mask(LOG_UNIMP, "blt outside vram not=20
>>> implemented\n");
>>>              return;
>>>          }
>>> @@ -140,8 +140,8 @@ void ati_2d_blt(ATIVGAState *s)
>>>                  filler);
>>>          end =3D s->vga.vram_ptr + s->vga.vram_size;
>>>          if (dst_bits >=3D end ||
>>> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_st=
ride=20
>>> +
>>> -            s->regs.dst_x >=3D end) {
>>> +            dst_bits + s->regs.dst_x + (s->regs.dst_y +=20
>>> s->regs.dst_height) *
>>> +            dst_stride * sizeof(uint32_t) >=3D end) {
>>>              qemu_log_mask(LOG_UNIMP, "blt outside vram not=20
>>> implemented\n");
>>>              return;
>>>          }
>>>=20
>>=20
>>=20
>
>
