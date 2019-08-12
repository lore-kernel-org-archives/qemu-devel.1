Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE63C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F44A2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F44A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx7hX-0007W4-Ec
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 06:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54302)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hx7h6-00074P-9i
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hx7h5-0007DZ-85
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:36:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hx7h5-0007D2-2b
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:36:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so104152363wrm.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 03:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fC/sN4VVKwtdSfRNeaO4CxBQzEEcNoNsmDmGG1fHeqI=;
 b=PO+dbR6xuQLZX3kklaL3S9btHG9nDPZFDpPkGbZO4/X2fRF3KxV1bKIKNt4k+pkn+Q
 0PzK3z/GlvkA8F0BBS9HpLPbbPZ/nBYgbVeMBhoSHUn+3W9qN/L8Qs11mFTzOjW0DEw4
 uk0CGyMU3EFOGPZX1edtYz4ZCLG+TacFzQgDFYJy8mtMEr09N7EWplWgZzEvW4u7spbB
 0LXzK2ajMm2u/p7sFJhDVq7kpsPrLG/bDwc7Ib6FL413Zn39EbChgQlTquMPqyW2UFIH
 eBFxomZWoB87je8CYFXchArq/7RsXfVpfLU+Z/QE/YvZffBjhND2NC8Hswa/2Fc17dcV
 ZPSg==
X-Gm-Message-State: APjAAAWZ7hA5vARxJnjW3BQaEHGCaiAtJ1PUUBkrMRcr7YL2i9CrG4X6
 YyQSSiN2MvCqo1qaP0gakmVvCw==
X-Google-Smtp-Source: APXvYqw/eO73SdQ7Un1bJx8k9vUih2I6eCzp5o7PhVKykp74XC0/NCf/5H0u3MOE7qisqewMAjFwtQ==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr30229815wrt.249.1565606209779; 
 Mon, 12 Aug 2019 03:36:49 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id o126sm14157631wmo.1.2019.08.12.03.36.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 03:36:49 -0700 (PDT)
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <cover.1565558093.git.balaton@eik.bme.hu>
 <d99f9e07923a74932dbb15e93dd50aa8d2816b19.1565558093.git.balaton@eik.bme.hu>
 <55657720-8636-6997-932d-1aa88688d184@redhat.com>
 <alpine.BSF.2.21.9999.1908121218430.68551@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8942e49f-493f-70c4-b2a1-10b97f2a7c6d@redhat.com>
Date: Mon, 12 Aug 2019 12:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1908121218430.68551@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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

On 8/12/19 12:28 PM, BALATON Zoltan wrote:
> On Mon, 12 Aug 2019, Philippe Mathieu-Daudé wrote:
>> On 8/11/19 11:14 PM, BALATON Zoltan wrote:
>>> Fixes: a38127414bd007c5b6ae64c664d9e8839393277e
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>  hw/display/ati.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>>> index 699f38223b..b849f5d510 100644
>>> --- a/hw/display/ati.c
>>> +++ b/hw/display/ati.c
>>> @@ -207,7 +207,7 @@ static void ati_cursor_draw_line(VGACommonState
>>> *vga, uint8_t *d, int scr_y)
>>>                  }
>>>              } else {
>>>                  color = (xbits & BIT(7) ? s->regs.cur_color1 :
>>> -                                          s->regs.cur_color0) << 8 |
>>> 0xff;
>>> +                                          s->regs.cur_color0) |
>>> 0xff000000;
>>>              }
>>>              if (vga->hw_cursor_x + i * 8 + j >= h) {
>>>                  return; /* end of screen, don't span to next line */
>>>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks. I've noticed that cursor color may still be wrong with MacOS
> that uses big endian frame buffer so maybe this will also need to take
> frame buffer endianness into account somehow but this patch corrects a
> difference between guest_hwcursor true and false values, reproducible
> with some Linux versions (as far as I remember). While the wrong cursor
> color with MacOS is now consistent after this patch with both
> guest_hwcursor true or false so that likely needs a different fix that
> should be applied both to this place and to ati_cursor_define. (MacOS
> does not yet boot fully, it needs patches to OpenBIOS to be able to run
> an FCode ROM and will probably need the VBlank interrupt implemented in
> ati-vga without which it displays a desktop but freezes there).

If you remember which Linux version had this problem, or you can link to
roms that behave incorrectly, please share, so we can add display
regression tests.

Thanks,

Phil.

