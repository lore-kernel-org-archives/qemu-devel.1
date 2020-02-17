Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFB0C76199
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B17206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWlpJmP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B17206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3V2B-0008Dt-SW
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 20:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j3V1c-0007c4-6E
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j3V1b-0000A7-0b
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:16:40 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:37075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j3V1Y-00005R-9D; Sun, 16 Feb 2020 20:16:36 -0500
Received: by mail-yw1-xc43.google.com with SMTP id l5so7201181ywd.4;
 Sun, 16 Feb 2020 17:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=AoYBpwdDRiLhbrtv499hlDneS5m0RniiewaVYxtqEgQ=;
 b=GWlpJmP97JItdiXASMP16D+0gzR/DFP220EiRuGwxtVTbTV8qVpH4ytW9pL3+KnAmc
 rM/deGL/596d0fFkqx56sBQgB0784w1ESqZtGIMNEl1Z9AIHaLoc2uTR0daXZ3Zy8DkF
 NOUR5exXOlHR7zB5HSGRaOoeMhf4ryN7Z2pJPyTKfXIpeCj/WoBPgV7FPgE9dHBHiIib
 4Ay8gNXQWgOo24g03+uBzCLpR2f9QCtPvGjxaBJDFIklOsCvAsBQ+6YZpD1jkJBvGMig
 trx4CX0e3C/lacRFqrQLGNANjh5MryTqSROtZ9vAYFV9mWbV2ax5ww4cPSKvbZZTMc9s
 tjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=AoYBpwdDRiLhbrtv499hlDneS5m0RniiewaVYxtqEgQ=;
 b=TELaRolRdZ/sexmrRenO0ADazuloPNOAdSmVIOG/FxHZ/a4nuJ13EvOtsHyDhJQMdv
 8wcvxWkzgebOemQRxIY6eLk38bg1lvgfbiQu/7sL/Nw6YIDnLrqSorehv9UbfnaoTh5t
 R82Orm2SMu+gbzG2hMvh6RRklkag5iMJHuM7PIV+1s05LeoN6LcCOPjsTQtD5Cy1hXUi
 rnibHO4oW84wNb4tfJzbtTsLAFUTyzbNbPBRc+sQ/nFdnRZ2UIyygPVe7oT/GQ6BcHOk
 4PrWuzPZVkMrcp2K64zn32IGeb2yuV/J8kGoTZYu7agaYQtbVGiml0mMkKvQ48UU14uL
 I8AQ==
X-Gm-Message-State: APjAAAW8jWT7jYtr3jgReVTYo2pad0jLHwstsfrq50H4q0tmVuPY0tr+
 Uu2iRY2fXD0pzOx3yFcrgww=
X-Google-Smtp-Source: APXvYqyWSdefDta+N3d7FIJ/o11lH7h1W1fFNAn1l6VvRU8su3Tn/DCXyQRuKniHW2QaX20vML2Ing==
X-Received: by 2002:a81:a503:: with SMTP id u3mr11704679ywg.476.1581902195115; 
 Sun, 16 Feb 2020 17:16:35 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id k135sm5650188ywe.2.2020.02.16.17.16.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Feb 2020 17:16:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] Implement the Screamer sound chip for the mac99
 machine type
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <alpine.BSF.2.22.395.2002162243190.98139@zero.eik.bme.hu>
Date: Sun, 16 Feb 2020 20:16:31 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <2611424A-CC6C-4C5A-95FE-F005D3ECB147@gmail.com>
References: <20200216163216.10745-1-programmingkidx@gmail.com>
 <CABLmASF=9Qj0_Hh2SWO6K=Sou3mVeyLL+XXTn9WGc670KRn2AA@mail.gmail.com>
 <alpine.BSF.2.22.395.2002162243190.98139@zero.eik.bme.hu>
To: BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Feb 16, 2020, at 4:59 PM, BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>=20
> On Sun, 16 Feb 2020, Howard Spoelstra wrote:
>> On Sun, Feb 16, 2020 at 5:32 PM John Arbuckle =
<programmingkidx@gmail.com>
>> wrote:
>>> diff --git a/hw/audio/screamer.c b/hw/audio/screamer.c
>>> new file mode 100644
>>> index 0000000000..ad4aba12eb
>>> --- /dev/null
>>> +++ b/hw/audio/screamer.c
>>> @@ -0,0 +1,983 @@
>>> +/*
>>> + * File: Screamer.c
>>> + * Description: Implement the Screamer sound chip used in Apple
>>> Macintoshes.
>>> + * It works by filling a buffer, then playing the buffer.
>>> + */
>=20
> Do you need a copyright and license header here? Especially if this is =
not all your original work but based on previous code (don't know if it =
is just saying in case as I know Mark also had some similar patches =
before but not sure how are those related if at all). If this contains =
code from somewhere else then license and author of that code may need =
to be included too.

That is a good question. According to this page =
https://wiki.qemu.org/License, files that don't have licensing =
information default under the GNU GPL v2. I'm fine with that.

>=20
>>> +/* Called when the CPU writes to the memory addresses assigned to
>>> Screamer */
>>> +static void screamer_mmio_write(void *opaque, hwaddr addr, uint64_t
>>> raw_value,
>>> +                                unsigned size)
>>> +{
>>> +    DPRINTF("screamer_mmio_write() called - size: %d\n", size);
>>> +    ScreamerState *state =3D opaque;
>>> +    uint32_t value =3D raw_value & 0xffffffff;
>>> +    addr =3D addr >> 4;
>>> +
>>> +    switch (addr) {
>>> +    case SOUND_CONTROL_REG:
>>> +        set_sound_control_reg(state, value);
>>> +        break;
>>> +    case CODEC_CONTROL_REG:
>>> +        set_codec_control_reg(state, value);
>>> +        break;
>>> +    case CODEC_STATUS_REG:
>>> +        set_codec_status_reg(state, value);
>>> +        break;
>>> +    case CLIP_COUNT_REG:
>>> +        set_clip_count_reg(state, value);
>>> +        break;
>>> +    case BYTE_SWAP_REG:
>>> +        set_byte_swap_reg(state, value);
>>> +        break;
>>> +    case FRAME_COUNT_REG:
>>> +        set_frame_count_reg(state, value);
>>> +        break;
>>> +    default:
>>> +        DPRINTF("Unknown register write - addr:%llu\tvalue:%d\n", =
addr,
>>> value);
>>> +    }
>>> +}
>>>=20
>>> Hi,
>>=20
>> This patch will not compile without errors. Host is Fedora 31.
>> The compiler suggests changing lines 839, 842 and 878 in screamer.c =
so the
>> DPRINTF arguments use %lu instead of %llu.
>> With that fixed, compiling completes succesfully.
>=20
> Replacing with %lu may fix 32bit build but would break 64bit one. Use =
HWADDR_PRIx format string instead to print hwaddr but others will =
probably tell to remove DPRINTFs alltogether when they are not needed =
any more and replace the remaining few useful ones with traces if =
debugging is still needed. I don't mind DPRINTFs that much at least =
until things are stable enough but once the code is stable most DPRINTFs =
may not be needed any more.
>=20
> I can't really review the actual patch because I don't know audio in =
QEMU.
>=20
> Regards,
> BALATON Zoltan

Your HWADDR_PRIx suggestion was great. I am making a small patch to test =
out your suggestion.

Thank you.


