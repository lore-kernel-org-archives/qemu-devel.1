Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3629C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E56320792
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbDtmUTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E56320792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2f29-0001T1-Uh
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 14:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1k2f1A-0000cC-OG
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:17:00 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:35835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1k2f17-0002Qn-2I
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:17:00 -0400
Received: by mail-io1-xd44.google.com with SMTP id s189so32271605iod.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5R8PzeeIsppxC+a1nFzfnkX23CLMrjXNwXElXidL59Y=;
 b=qbDtmUTuiyr3xJSCpS2tKGrXNwI00N2NVBWjE97fPkfBeGpi9u7l0i2+jwiRfyM1jr
 uEGDUbjXylK24Q0tkoq6027xWEq8JXCbOmJpByRvucOY829Bzq3IEVBWQM1Fv2TnqMM2
 0LTxm+s59+XwBRvIf45IY/vsq3AbvY/Vus+/Ub1SwBDvHvFAbVJFnfknUjII+NnJFUsQ
 c3q6ZRWp1bhCYLwAtCD1HHfkeqm5zsyFTDcKmxz32A3nUtYwGJTuxUYsNyA8S+ukXnwV
 YaaB7CjpFEnrWe0MwgOPz8gq5s2wZGNezhH304iPvfJ1+DOSlcdaqNRGYBexZiO/mawQ
 MSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5R8PzeeIsppxC+a1nFzfnkX23CLMrjXNwXElXidL59Y=;
 b=kvMdesPBu3eP826B12QhDBN9D9bvM7VhawDdJw9WXHowm4le+Q/5/Ji+ra45+UmTbl
 Zry6X9+encn+7ogkDwojctvJOz49weoBolbo/tYyODhB0Sanin9EkNxgnoSnaoMmMzoN
 vyZHL8uLyxDS+Jsffb9gBohDOkrpdoaXpcLZlc7QZefihBkH/N2ErzznKYuOHeh9Z/js
 YsixFC5QmkhigiiyXGFKcErj/mNZQaGQdj1Ig/T1cd2PERbc+ArvEMigPUuuFPHAxXoH
 YmZ0bMXpfi+W+4DaFqgHDR3eTJPDdi1NTtEkYovkLc13N6/0majnFYAP4KmHd2Qg46zQ
 o6Ew==
X-Gm-Message-State: AOAM530T/em+SIpMKqqRfx5y92s7IlW2e+XXsDzJZrXZgLoUxyCW6cfa
 LXN6k9uccTDWMD6GhuoB0OtbQeIMd9sXVt4061k=
X-Google-Smtp-Source: ABdhPJxmQCA65U/zfBZYjzWW3bLEnJsMToFy+9x91butOUAwGV0/GVPvKvDzNATnjN6M12bUzXowEx4KmESSquI8CS8=
X-Received: by 2002:a6b:6508:: with SMTP id z8mr1224815iob.0.1596478614321;
 Mon, 03 Aug 2020 11:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200710201911.3a3e336c.hc981@poolhem.se>
 <20200803192645.48513f57.hc981@poolhem.se>
 <43e05cbb-14aa-80ed-d39a-1456f2a0e480@redhat.com>
In-Reply-To: <43e05cbb-14aa-80ed-d39a-1456f2a0e480@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 3 Aug 2020 20:16:43 +0200
Message-ID: <CACXAS8CkSX1knsStsL1azYQQFrbYV5ZXXOWm9bp_F-CU7ph=7w@mail.gmail.com>
Subject: Re: Ping: [PATCH] Emulate dip switch language layout settings on SUN
 keyboard
To: Henrik Carlqvist <hc981@poolhem.se>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=atar4qemu@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 3, 2020 at 7:52 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/08/20 19:26, Henrik Carlqvist wrote:
> > Would you please consider my patch which implements the honor of the -k switch
> > for sparc as a sun keyboard language dip switch setting instead of a hard
> > coded en-us keyboard layout?
> >
> > The initial patch mail was sent to the mailing list and the listed maintainers
> > of escc.c and is also available at
> > http://patchwork.ozlabs.org/project/qemu-devel/patch/20200710201911.3a3e336c.hc981@poolhem.se/
> >
> > This ping email is also sent to Gerd Hoffmann who many years ago
> > (2014) selected the en-us keyboard layout as a hardcoded value in escc.c with
> > commit 59e7a130054b55fe15cdfdebf284332b04d990ef.
>
> Artyom, can you review?
>
> Paolo
>
> > Best regards Henrik
> >
> > On Fri, 10 Jul 2020 20:19:11 +0200
> > Henrik Carlqvist <hc981@poolhem.se> wrote:
> >
> >> SUN Type 4, 5 and 5c keyboards have dip switches to choose the language
> >> layout of the keyboard. Solaris makes an ioctl to query the value of the
> >> dipswitches and uses that value to select keyboard layout. Also the SUN
> >> bios like the one in the file ss5.bin uses this value to support at least
> >> some keyboard layouts. However, the OpenBIOS provided with qemu is
> >> hardcoded to allways use an US keyboard layout.
> >>
> >> Before this patch, qemu allways gave dip switch value 0x21 (US keyboard),
> >> this patch uses the command line switch "-k" (keyboard layout) to select
> >> dip switch value. A table is used to lookup values from arguments like:
> >>
> >> -k fr
> >> -k es
> >>
> >> But the patch also accepts numeric dip switch values directly to the -k
> >> switch:
> >>
> >> -k 0x2b
> >> -k 43
> >>
> >> Both values above are the same and select swedish keyboard as explained in
> >> table 3-15 at
> >> https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html
> >>
> >> Unless you want to do a full Solaris installation but happen to have
> >> access to a bios file, the easiest way to test that the patch works is to:
> >>
> >> qemu-system-sparc -k sv -bios /path/to/ss5.bin

Can you please move this description to the commit message? (Fixing
typo in "always" ;-) )

> >>
> >> If you already happen to have a Solaris installation in a qemu disk image
> >> file you can easily try different keyboard layouts after this patch is
> >> applied.
> >>
> >> Unfortunately my glib version is too old to compile later versions of qemu
> >> so even though this patch is made from latest git I have only been able to
> >> test it myself with qemu version 4.1.1. I think and hope that this patch
> >> will compile and work also with the latest version of git as it only affects
> >> one file and there hasn't been much changes to that file since tested
> >> version 4.1.1.
> >>
> >> Best regards Henrik
> >>
> >> From 2f86bd60750d44206b9181f76115e77b58dff544 Mon Sep 17 00:00:00 2001
> >> From: Henrik Carlqvist <hc1245@poolhem.se>
> >> Date: Fri, 10 Jul 2020 19:21:08 +0200
> >> Subject: [PATCH] Emulating sun keyboard languate layout dip switches, taking

typo: language

> >>  the value for the dip switches from the "-k" option to qemu.
> >>
> >> Signed-off-by: Henrik Carlqvist <hc1245@poolhem.se>
> >> ---
> >>  hw/char/escc.c | 74
> >> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> >> 73 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/char/escc.c b/hw/char/escc.c
> >> index 7d16ee8688..7287056b5f 100644
> >> --- a/hw/char/escc.c
> >> +++ b/hw/char/escc.c
> >> @@ -30,6 +30,8 @@
> >>  #include "qemu/module.h"
> >>  #include "hw/char/escc.h"
> >>  #include "ui/console.h"
> >> +#include "sysemu/sysemu.h"
> >> +#include "qemu/cutils.h"
> >>  #include "trace.h"
> >>
> >>  /*
> >> @@ -175,6 +177,7 @@
> >>  #define R_MISC1I 14
> >>  #define R_EXTINT 15
> >>
> >> +static unsigned char sun_keyboard_layout_dip_switch(void);
> >>  static void handle_kbd_command(ESCCChannelState *s, int val);
> >>  static int serial_can_receive(void *opaque);
> >>  static void serial_receive_byte(ESCCChannelState *s, int ch);
> >> @@ -730,6 +733,75 @@ static QemuInputHandler sunkbd_handler = {
> >>      .event = sunkbd_handle_event,
> >>  };
> >>
> >> +static unsigned char sun_keyboard_layout_dip_switch(void)
> >> +{
> >> +    /* Return the value of the dip-switches in a SUN Type 5 keyboard */
> >> +    static unsigned char ret = 0xff;
> >> +
> >> +    if ((ret == 0xff) && keyboard_layout) {
> >> +        int i;
> >> +        struct layout_values {
> >> +            const char *lang;
> >> +            unsigned char dip;
> >> +        } languages[] =
> >> +    /* Dip values from table 3-16 Layouts for Type 4, 5, and 5c Keyboards
> >> */+            {
> >> +                {"en-us", 0x21}, /* U.S.A. (US5.kt) */
> >> +                                 /* 0x22 is some other US (US_UNIX5.kt)*/
> >> +                {"fr",    0x23}, /* France (France5.kt) */
> >> +                {"da",    0x24}, /* Denmark (Denmark5.kt) */
> >> +                {"de",    0x25}, /* Germany (Germany5.kt) */
> >> +                {"it",    0x26}, /* Italy (Italy5.kt) */
> >> +                {"nl",    0x27}, /* The Netherlands (Netherland5.kt) */
> >> +                {"no",    0x28}, /* Norway (Norway.kt) */
> >> +                {"pt",    0x29}, /* Portugal (Portugal5.kt) */
> >> +                {"es",    0x2a}, /* Spain (Spain5.kt) */
> >> +                {"sv",    0x2b}, /* Sweden (Sweden5.kt) */
> >> +                {"fr-ch", 0x2c}, /* Switzerland/French (Switzer_Fr5.kt) */
> >> +                {"de-ch", 0x2d}, /* Switzerland/German (Switzer_Ge5.kt) */
> >> +                {"en-gb", 0x2e}, /* Great Britain (UK5.kt) */
> >> +                {"ko",    0x2f}, /* Korea (Korea5.kt) */
> >> +                {"tw",    0x30}, /* Taiwan (Taiwan5.kt) */
> >> +                {"ja",    0x31}, /* Japan (Japan5.kt) */
> >> +                {"fr-ca", 0x32}, /* Canada/French (Canada_Fr5.kt) */
> >> +                {"hu",    0x33}, /* Hungary (Hungary5.kt) */
> >> +                {"pl",    0x34}, /* Poland (Poland5.kt) */
> >> +                {"cz",    0x35}, /* Czech (Czech5.kt) */
> >> +                {"ru",    0x36}, /* Russia (Russia5.kt) */
> >> +                {"lv",    0x37}, /* Latvia (Latvia5.kt) */
> >> +                {"tr",    0x38}, /* Turkey-Q5 (TurkeyQ5.kt) */
> >> +                {"gr",    0x39}, /* Greece (Greece5.kt) */
> >> +                {"ar",    0x3a}, /* Arabic (Arabic5.kt) */
> >> +                {"lt",    0x3b}, /* Lithuania (Lithuania5.kt) */
> >> +                {"nl-be", 0x3c}, /* Belgium (Belgian5.kt) */
> >> +                {"be",    0x3c}, /* Belgium (Belgian5.kt) */
> >> +            };
> >> +
> >> +        for (i = 0;
> >> +             i < sizeof(languages) / sizeof(struct layout_values);
> >> +             i++) {
> >> +            if (!strcmp(keyboard_layout, languages[i].lang)) {
> >> +                ret = languages[i].dip;
> >> +                return ret;
> >> +            }
> >> +        }
> >> +        /* Found no known language code */
> >> +
> >> +        if ((keyboard_layout[0] >= '0') && (keyboard_layout[0] <= '9')) {
> >> +            unsigned int tmp;
> >> +            /* As a fallback we also accept numeric dip switch value */
> >> +            if (!qemu_strtoui(keyboard_layout, NULL, 0, &tmp)) {
> >> +                ret = (unsigned char)tmp;
> >> +            }
> >> +        }
> >> +    }
> >> +    if (ret == 0xff) {
> >> +        /* Final fallback if keyboard_layout was not set or recognized */
> >> +        ret = 0x21; /* en-us layout */
> >> +    }
> >> +    return ret;
> >> +}
> >> +
> >>  static void handle_kbd_command(ESCCChannelState *s, int val)
> >>  {
> >>      trace_escc_kbd_command(val);
> >> @@ -751,7 +823,7 @@ static void handle_kbd_command(ESCCChannelState *s, int
> >> val)     case 0xf:
> >>          clear_queue(s);
> >>          put_queue(s, 0xfe);
> >> -        put_queue(s, 0x21); /*  en-us layout */
> >> +        put_queue(s, sun_keyboard_layout_dip_switch());
> >>          break;
> >>      default:
> >>          break;
> >> --
> >> 2.14.5
> >
Looks good otherwise. For the v2:
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>



--
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

