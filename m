Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEC3C433DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 20:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656102075A
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 20:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=poolhem.se header.i=@poolhem.se header.b="AVOjWivo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656102075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=poolhem.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJjoa-0006m0-Ab
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 16:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc94@poolhem.se>) id 1kJgxc-0004dC-F5
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 13:47:44 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1]:37034
 helo=ns12.inleed.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc94@poolhem.se>) id 1kJgxZ-0003Rd-6K
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 13:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u198mhXbRjsFn2ZOgJPDFzjsb+fgVNw2/BEFi6zEDA4=; b=AVOjWivofzaAAcjgGFCVEYuXV0
 qAKgXoLFrlW7FZUom5KUuh05Q3Cec0Ge9Y8zIlLTWQ4VpdOs7MQxmggmeegi96p63p681oZy4mhio
 VsBEMVvNm35c9EmzcHeRkVX3GAle8fIXYgoe9zxZ8oLgYbKkUu1LpjcujYl+1IMDNyyDgDOW32NAL
 /X9KMBfegLmGcNLJuLGOIzgqdFHUZWTySFp1zc3elrId5mL0j0aFbdjB7X8eJYYF5q0v64u1hlYSO
 KvUM3RI5UDwKm6byKmZizPonyL/7uBunvt9xw8RpyosAxfxDjPKDcdclBZnhdtZZGn3kLIlTWxi4i
 nrjP/74w==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.93.0.4)
 (envelope-from <hc94@poolhem.se>)
 id 1kJgxW-004z9E-W1; Sat, 19 Sep 2020 19:47:39 +0200
Date: Sat, 19 Sep 2020 19:47:12 +0200
From: Henrik Carlqvist <hc94@poolhem.se>
To: Henrik Carlqvist <hc981@poolhem.se>
Subject: Ping2: [PATCH v2] Emulate dip switch language layout settings on
 SUN keyboard
Message-Id: <20200919194712.1ddd62cf.hc94@poolhem.se>
In-Reply-To: <20200803222049.2967aeda.hc981@poolhem.se>
References: <20200803222049.2967aeda.hc981@poolhem.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=2a0b:dc80:cafe:112::1;
 envelope-from=hc94@poolhem.se; helo=ns12.inleed.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_SOFTFAIL=0.732, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Sep 2020 16:48:42 -0400
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just wanted to check that my patch hasn't been forgotten... I was hoping that
it would make it into some branch in git.

Do you want me to do any more changes to the patch or the description?

Best regards Henrik

On Mon, 3 Aug 2020 22:20:49 +0200
Henrik Carlqvist <hc981@poolhem.se> wrote:

> This is my second attempt to contribute a patch which makes the -k switch
> useful for sparc emulation as its value is used to emulate the dip switch
> in a SUN keyboard for language layout setting.
> 
> Unfortunately my glib version is too old to compile later versions of qemu
> so even though this patch is made from latest git I have only been able to
> test it myself with qemu version 4.1.1. I think and hope that this patch
> will compile and work also with the latest version of git as it only affects
> one file and there hasn't been much changes to that file since tested
> version 4.1.1.
> 
> Best regards Henrik
> 
> From e302b02dec32c28297ed20d852c5fba2c1682f5a Mon Sep 17 00:00:00 2001
> From: Henrik Carlqvist <hc1245@poolhem.se>
> Date: Mon, 3 Aug 2020 22:11:55 +0200
> Subject: [PATCH] Emulating sun keyboard language layout dip switches, taking
>  the value for the dip switches from the "-k" option to qemu.
> 
> SUN Type 4, 5 and 5c keyboards have dip switches to choose the language
> layout of the keyboard. Solaris makes an ioctl to query the value of the
> dipswitches and uses that value to select keyboard layout. Also the SUN
> bios like the one in the file ss5.bin uses this value to support at least
> some keyboard layouts. However, the OpenBIOS provided with qemu is
> hardcoded to always use an US keyboard layout.
> 
> Before this patch, qemu allways gave dip switch value 0x21 (US keyboard),
> this patch uses the command line switch "-k" (keyboard layout) to select
> dip switch value. A table is used to lookup values from arguments like:
> 
> -k fr
> -k es
> 
> But the patch also accepts numeric dip switch values directly to the -k
> switch:
> 
> -k 0x2b
> -k 43
> 
> Both values above are the same and select swedish keyboard as explained in
> table 3-15 at
> https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html
> 
> Unless you want to do a full Solaris installation but happen to have
> access to a bios file, the easiest way to test that the patch works is to:
> 
> qemu-system-sparc -k sv -bios /path/to/ss5.bin
> 
> If you already happen to have a Solaris installation in a qemu disk image
> file you can easily try different keyboard layouts after this patch is
> applied.
> 
> Signed-off-by: Henrik Carlqvist <hc1245@poolhem.se>
> ---
>  hw/char/escc.c | 74
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> 73 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 7d16ee8688..7287056b5f 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -30,6 +30,8 @@
>  #include "qemu/module.h"
>  #include "hw/char/escc.h"
>  #include "ui/console.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/cutils.h"
>  #include "trace.h"
>  
>  /*
> @@ -175,6 +177,7 @@
>  #define R_MISC1I 14
>  #define R_EXTINT 15
>  
> +static unsigned char sun_keyboard_layout_dip_switch(void);
>  static void handle_kbd_command(ESCCChannelState *s, int val);
>  static int serial_can_receive(void *opaque);
>  static void serial_receive_byte(ESCCChannelState *s, int ch);
> @@ -730,6 +733,75 @@ static QemuInputHandler sunkbd_handler = {
>      .event = sunkbd_handle_event,
>  };
>  
> +static unsigned char sun_keyboard_layout_dip_switch(void)
> +{
> +    /* Return the value of the dip-switches in a SUN Type 5 keyboard */
> +    static unsigned char ret = 0xff;
> +
> +    if ((ret == 0xff) && keyboard_layout) {
> +        int i;
> +        struct layout_values {
> +            const char *lang;
> +            unsigned char dip;
> +        } languages[] =
> +    /* Dip values from table 3-16 Layouts for Type 4, 5, and 5c Keyboards
> */+            {
> +                {"en-us", 0x21}, /* U.S.A. (US5.kt) */
> +                                 /* 0x22 is some other US (US_UNIX5.kt)*/
> +                {"fr",    0x23}, /* France (France5.kt) */
> +                {"da",    0x24}, /* Denmark (Denmark5.kt) */
> +                {"de",    0x25}, /* Germany (Germany5.kt) */
> +                {"it",    0x26}, /* Italy (Italy5.kt) */
> +                {"nl",    0x27}, /* The Netherlands (Netherland5.kt) */
> +                {"no",    0x28}, /* Norway (Norway.kt) */
> +                {"pt",    0x29}, /* Portugal (Portugal5.kt) */
> +                {"es",    0x2a}, /* Spain (Spain5.kt) */
> +                {"sv",    0x2b}, /* Sweden (Sweden5.kt) */
> +                {"fr-ch", 0x2c}, /* Switzerland/French (Switzer_Fr5.kt) */
> +                {"de-ch", 0x2d}, /* Switzerland/German (Switzer_Ge5.kt) */
> +                {"en-gb", 0x2e}, /* Great Britain (UK5.kt) */
> +                {"ko",    0x2f}, /* Korea (Korea5.kt) */
> +                {"tw",    0x30}, /* Taiwan (Taiwan5.kt) */
> +                {"ja",    0x31}, /* Japan (Japan5.kt) */
> +                {"fr-ca", 0x32}, /* Canada/French (Canada_Fr5.kt) */
> +                {"hu",    0x33}, /* Hungary (Hungary5.kt) */
> +                {"pl",    0x34}, /* Poland (Poland5.kt) */
> +                {"cz",    0x35}, /* Czech (Czech5.kt) */
> +                {"ru",    0x36}, /* Russia (Russia5.kt) */
> +                {"lv",    0x37}, /* Latvia (Latvia5.kt) */
> +                {"tr",    0x38}, /* Turkey-Q5 (TurkeyQ5.kt) */
> +                {"gr",    0x39}, /* Greece (Greece5.kt) */
> +                {"ar",    0x3a}, /* Arabic (Arabic5.kt) */
> +                {"lt",    0x3b}, /* Lithuania (Lithuania5.kt) */
> +                {"nl-be", 0x3c}, /* Belgium (Belgian5.kt) */
> +                {"be",    0x3c}, /* Belgium (Belgian5.kt) */
> +            };
> +
> +        for (i = 0;
> +             i < sizeof(languages) / sizeof(struct layout_values);
> +             i++) {
> +            if (!strcmp(keyboard_layout, languages[i].lang)) {
> +                ret = languages[i].dip;
> +                return ret;
> +            }
> +        }
> +        /* Found no known language code */
> +
> +        if ((keyboard_layout[0] >= '0') && (keyboard_layout[0] <= '9')) {
> +            unsigned int tmp;
> +            /* As a fallback we also accept numeric dip switch value */
> +            if (!qemu_strtoui(keyboard_layout, NULL, 0, &tmp)) {
> +                ret = (unsigned char)tmp;
> +            }
> +        }
> +    }
> +    if (ret == 0xff) {
> +        /* Final fallback if keyboard_layout was not set or recognized */
> +        ret = 0x21; /* en-us layout */
> +    }
> +    return ret;
> +}
> +
>  static void handle_kbd_command(ESCCChannelState *s, int val)
>  {
>      trace_escc_kbd_command(val);
> @@ -751,7 +823,7 @@ static void handle_kbd_command(ESCCChannelState *s, int
> val)     case 0xf:
>          clear_queue(s);
>          put_queue(s, 0xfe);
> -        put_queue(s, 0x21); /*  en-us layout */
> +        put_queue(s, sun_keyboard_layout_dip_switch());
>          break;
>      default:
>          break;
> -- 
> 2.14.5

