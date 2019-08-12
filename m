Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5EFC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EFB20842
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EFB20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx7a4-0005q6-Jj
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 06:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53338)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hx7ZU-0005Q5-HL
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hx7ZT-0002zT-Im
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:29:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:58211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hx7ZT-0002wi-Bz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:28:59 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4B2D07456D6;
 Mon, 12 Aug 2019 12:28:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A808274B821; Mon, 12 Aug 2019 12:28:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A28257456CB;
 Mon, 12 Aug 2019 12:28:53 +0200 (CEST)
Date: Mon, 12 Aug 2019 12:28:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
In-Reply-To: <55657720-8636-6997-932d-1aa88688d184@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1908121218430.68551@zero.eik.bme.hu>
References: <cover.1565558093.git.balaton@eik.bme.hu>
 <d99f9e07923a74932dbb15e93dd50aa8d2816b19.1565558093.git.balaton@eik.bme.hu>
 <55657720-8636-6997-932d-1aa88688d184@redhat.com>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 4/7] ati-vga: Fix cursor color with
 guest_hwcursor=true
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/11/19 11:14 PM, BALATON Zoltan wrote:
>> Fixes: a38127414bd007c5b6ae64c664d9e8839393277e
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/ati.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index 699f38223b..b849f5d510 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -207,7 +207,7 @@ static void ati_cursor_draw_line(VGACommonState *v=
ga, uint8_t *d, int scr_y)
>>                  }
>>              } else {
>>                  color =3D (xbits & BIT(7) ? s->regs.cur_color1 :
>> -                                          s->regs.cur_color0) << 8 | =
0xff;
>> +                                          s->regs.cur_color0) | 0xff0=
00000;
>>              }
>>              if (vga->hw_cursor_x + i * 8 + j >=3D h) {
>>                  return; /* end of screen, don't span to next line */
>>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks. I've noticed that cursor color may still be wrong with MacOS that=
=20
uses big endian frame buffer so maybe this will also need to take frame=20
buffer endianness into account somehow but this patch corrects a=20
difference between guest_hwcursor true and false values, reproducible wit=
h=20
some Linux versions (as far as I remember). While the wrong cursor color=20
with MacOS is now consistent after this patch with both guest_hwcursor=20
true or false so that likely needs a different fix that should be applied=
=20
both to this place and to ati_cursor_define. (MacOS does not yet boot=20
fully, it needs patches to OpenBIOS to be able to run an FCode ROM and=20
will probably need the VBlank interrupt implemented in ati-vga without=20
which it displays a desktop but freezes there).

Regards,
BALATON Zoltan
