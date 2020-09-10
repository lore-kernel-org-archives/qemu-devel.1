Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 23:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3833420575
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 23:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMHkZG4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3833420575
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGWND-0002Ut-6l
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 19:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kGWMd-0001yZ-Q4
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 19:52:27 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:37390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kGWMa-0005Ay-LE
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 19:52:27 -0400
Received: by mail-vk1-xa41.google.com with SMTP id h23so1990216vkn.4
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 16:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yIOTfsure3msuKXwPAVb2H7BrCPQYzZ1Pzv0Rbq7S3k=;
 b=nMHkZG4L41inxZ1a9huMiZDgTqXrJdZi1a5Hphy30s5K2VjkdFdQiHAJS1DSBqytXo
 PH61rTYn77iOPCeDYJOaooeYLXjiKSeWeV1hztyy7gkK00Jg5OctQOjiIYM8SRrFaJqn
 MB9nDZcRNea5/JswFpZpLxaTHRf7Akvj4ExEzrx95/6DPIDWvY+HSWyJ6xcCRpNUc930
 j1Tv04BtUZkTiVJmdNjXUWx6eufeNIG/TNrnDgENtstM9KZvir0vut0hGMsAtkWGEkc1
 k9Z2iyjK+ttuki4O/uvhATk7uWRrI543PaL9Mkj+jZMoxq0QgtjVu9Iqa1dzgdBXyB7D
 Yp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yIOTfsure3msuKXwPAVb2H7BrCPQYzZ1Pzv0Rbq7S3k=;
 b=ijc6VTqyZ559sHSdlRXRc2anpwK2Ii1QFtb34tnK0ZRr/p0qUhhTtLvys3zbC4/sRV
 +Hu0bX/ugVIERrXi/c4M1790GCzVW+lEKJBInpD6gvKv2tNjb21CB3aoElJtpUdep47u
 gogECkmJvtqHx3ZnkD1IwH+eAAO2zrTbLY4kobm+9sYButPt9A0I4kVVoCLWmjYEbkzs
 txCE+u3ACK3Yp97PBcRmmlI9aHHUHRWq8Fz6RcdKKiAdgloyVouJM9YRD+RQHLUxDf8Q
 0HkQwp7v6zVCSSFYmobvL1TscA34UpHVaTAH8mX+IA93S8V1nFj/05Aax333ajwnXmhY
 aXXA==
X-Gm-Message-State: AOAM531K48du1RznN7JMlweADSxd0CoVG7ShfXLa4tihwo0ZNWncbDQu
 QO0lf1N7l+YUiVTm9W3i4kOm1eUq04TNd5t3YcpxPA==
X-Google-Smtp-Source: ABdhPJxlJ1rB/d+T2aQkqhzoYSLoRVUBg+ZlG46R+qsW8p9DSXbGVSxKpIdF8/gKt/oLdMkJDpywQPaMi45JmSrm4Ug=
X-Received: by 2002:a1f:ad94:: with SMTP id w142mr3091347vke.8.1599781942111; 
 Thu, 10 Sep 2020 16:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200825001711.1340443-8-hskinnemoen@google.com>
 <af0b3d23-41d8-4c46-1156-973d653d8064@amsat.org>
In-Reply-To: <af0b3d23-41d8-4c46-1156-973d653d8064@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Thu, 10 Sep 2020 16:52:10 -0700
Message-ID: <CAFQmdRY00+izZSRfV_pbO3xvFrQqrgaCMaSHdmmSapJM6fv-fQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/14] hw/arm: Load -bios image as a boot ROM for
 npcm7xx
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: multipart/alternative; boundary="00000000000061343a05aefe424e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a41;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000061343a05aefe424e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 11:59 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> On 8/25/20 2:17 AM, Havard Skinnemoen via wrote:
> > If a -bios option is specified on the command line, load the image into
> > the internal ROM memory region, which contains the first instructions
> > run by the CPU after reset.
> >
> > If -bios is not specified, the vbootrom included with qemu is loaded by
> > default.
> >
> > Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > ---
> >  hw/arm/npcm7xx_boards.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> > index 0b9dce2b35..b67e45e913 100644
> > --- a/hw/arm/npcm7xx_boards.c
> > +++ b/hw/arm/npcm7xx_boards.c
> > @@ -18,12 +18,43 @@
> >
> >  #include "hw/arm/npcm7xx.h"
> >  #include "hw/core/cpu.h"
> > +#include "hw/loader.h"
> >  #include "qapi/error.h"
> > +#include "qemu-common.h"
> >  #include "qemu/units.h"
> > +#include "sysemu/sysemu.h"
> >
> >  #define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
> >  #define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
> >
> > +static const char npcm7xx_default_bootrom[] =3D "npcm7xx_bootrom.bin";
> > +
> > +static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState
> *soc)
> > +{
> > +    g_autofree char *filename =3D NULL;
> > +    int ret;
> > +
> > +    if (machine->kernel_filename) {
> > +        /* Don't load the bootrom if user requested direct kernel boot=
.
> */
> > +        return;
>
> Wondering why not load it always if available, and what would
> happen if booting from a kernel (without bootrom) and running
> "reboot" (via SysRq) in the guest I got:
>
> # echo b > /proc/sysrq-trigger
> sysrq: Resetting
> CPU0: stopping
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.32-7dc9442-dirty-8978043 #1
> Hardware name: NPCM7XX Chip family
> Backtrace:
> [<b0107c4c>] (dump_backtrace) from [<b010823c>] (show_stack+0x20/0x24)
>  r7:00000000 r6:600f0193 r5:00000000 r4:b0b5b1b8
> [<b010821c>] (show_stack) from [<b077b230>] (dump_stack+0x94/0xa8)
> [<b077b19c>] (dump_stack) from [<b010a20c>] (handle_IPI+0x1f0/0x38c)
>  r7:00000000 r6:00000004 r5:b0b5eb64 r4:b0b729e0
> [<b010a01c>] (handle_IPI) from [<b0102264>] (gic_handle_irq+0x9c/0xa0)
>  r10:10c5387d r9:b0b01ef8 r8:d0803100 r7:d0802100 r6:d080210c r5:b0b37db4
>  r4:b0b04504
> [<b01021c8>] (gic_handle_irq) from [<b0101a8c>] (__irq_svc+0x6c/0x90)
> Exception stack(0xb0b01ef8 to 0xb0b01f40)
> 1ee0:                                                       00000000
> 00012f74
> 1f00: cfbc1774 b01112e0 b0b00000 00000000 b0b03e28 b0b03e6c b0b5e72c
> b08e5ea8
> 1f20: 10c5387d b0b01f54 b0b01f58 b0b01f48 b0104114 b0104118 600f0013
> ffffffff
>  r9:b0b00000 r8:b0b5e72c r7:b0b01f2c r6:ffffffff r5:600f0013 r4:b0104118
> [<b01040d4>] (arch_cpu_idle) from [<b014b240>] (do_idle+0xec/0x140)
> [<b014b154>] (do_idle) from [<b014b56c>] (cpu_startup_entry+0x28/0x2c)
>  r9:410fc090 r8:0810c000 r7:00000000 r6:b0a53a40 r5:00000001 r4:000000ce
> [<b014b544>] (cpu_startup_entry) from [<b0794f6c>] (rest_init+0xb4/0xbc)
> [<b0794eb8>] (rest_init) from [<b0a00c50>] (arch_call_rest_init+0x18/0x1c=
)
>  r5:00000001 r4:b0b72754
> [<b0a00c38>] (arch_call_rest_init) from [<b0a010f4>]
> (start_kernel+0x428/0x458)
> [<b0a00ccc>] (start_kernel) from [<00000000>] (0x0)
> Reboot failed -- System halted
>
> So not a problem so far...
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> But still I'd keep loading the bootrom regardless -kernel.
>

So you mean something like this?

@@ -35,11 +35,6 @@ static void npcm7xx_load_bootrom(MachineState *machine,
NPCM7xxState *soc)
     g_autofree char *filename =3D NULL;
     int ret;

-    if (machine->kernel_filename) {
-        /* Don't load the bootrom if user requested direct kernel boot. */
-        return;
-    }
-
     if (!bios_name) {
         bios_name =3D npcm7xx_default_bootrom;
     }
@@ -47,7 +42,11 @@ static void npcm7xx_load_bootrom(MachineState *machine,
NPCM7xxState *soc)
     filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (!filename) {
         error_report("Could not find ROM image '%s'", bios_name);
-        exit(1);
+        if (!machine->kernel_filename) {
+            /* We can't boot without a bootrom or a kernel image. */
+            exit(1);
+        }
+        return;
     }
     ret =3D load_image_mr(filename, &soc->irom);
     if (ret < 0) {

I'm not sure if it will make much of a difference, as (IIUC)
arm_load_kernel installs a reset hook to jump directly into the kernel,
bypassing the bootrom entirely. I'm assuming a watchdog or SW reset would
trigger the same reset hook and jump right back into the kernel, though I
could be wrong.

Anyway, I can make the above change in any case.

Havard

--00000000000061343a05aefe424e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Sep 3, 2020 at 11:59 AM Philippe =
Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</=
a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/25/20 2:17 AM, Havard Skinnemoen via wrote:<b=
r>
&gt; If a -bios option is specified on the command line, load the image int=
o<br>
&gt; the internal ROM memory region, which contains the first instructions<=
br>
&gt; run by the CPU after reset.<br>
&gt; <br>
&gt; If -bios is not specified, the vbootrom included with qemu is loaded b=
y<br>
&gt; default.<br>
&gt; <br>
&gt; Reviewed-by: Tyrone Ting &lt;<a href=3D"mailto:kfting@nuvoton.com" tar=
get=3D"_blank" class=3D"cremed">kfting@nuvoton.com</a>&gt;<br>
&gt; Reviewed-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org"=
 target=3D"_blank" class=3D"cremed">clg@kaod.org</a>&gt;<br>
&gt; Signed-off-by: Havard Skinnemoen &lt;<a href=3D"mailto:hskinnemoen@goo=
gle.com" target=3D"_blank" class=3D"cremed">hskinnemoen@google.com</a>&gt;<=
br>
&gt; ---<br>
&gt;=C2=A0 hw/arm/npcm7xx_boards.c | 33 +++++++++++++++++++++++++++++++++<b=
r>
&gt;=C2=A0 1 file changed, 33 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c<br>
&gt; index 0b9dce2b35..b67e45e913 100644<br>
&gt; --- a/hw/arm/npcm7xx_boards.c<br>
&gt; +++ b/hw/arm/npcm7xx_boards.c<br>
&gt; @@ -18,12 +18,43 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;hw/arm/npcm7xx.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt; +#include &quot;hw/loader.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu-common.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7<br>
&gt;=C2=A0 #define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff<br>
&gt;=C2=A0 <br>
&gt; +static const char npcm7xx_default_bootrom[] =3D &quot;npcm7xx_bootrom=
.bin&quot;;<br>
&gt; +<br>
&gt; +static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState =
*soc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *filename =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (machine-&gt;kernel_filename) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don&#39;t load the bootrom if user req=
uested direct kernel boot. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
Wondering why not load it always if available, and what would<br>
happen if booting from a kernel (without bootrom) and running<br>
&quot;reboot&quot; (via SysRq) in the guest I got:<br>
<br>
# echo b &gt; /proc/sysrq-trigger<br>
sysrq: Resetting<br>
CPU0: stopping<br>
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.32-7dc9442-dirty-8978043 #1<b=
r>
Hardware name: NPCM7XX Chip family<br>
Backtrace:<br>
[&lt;b0107c4c&gt;] (dump_backtrace) from [&lt;b010823c&gt;] (show_stack+0x2=
0/0x24)<br>
=C2=A0r7:00000000 r6:600f0193 r5:00000000 r4:b0b5b1b8<br>
[&lt;b010821c&gt;] (show_stack) from [&lt;b077b230&gt;] (dump_stack+0x94/0x=
a8)<br>
[&lt;b077b19c&gt;] (dump_stack) from [&lt;b010a20c&gt;] (handle_IPI+0x1f0/0=
x38c)<br>
=C2=A0r7:00000000 r6:00000004 r5:b0b5eb64 r4:b0b729e0<br>
[&lt;b010a01c&gt;] (handle_IPI) from [&lt;b0102264&gt;] (gic_handle_irq+0x9=
c/0xa0)<br>
=C2=A0r10:10c5387d r9:b0b01ef8 r8:d0803100 r7:d0802100 r6:d080210c r5:b0b37=
db4<br>
=C2=A0r4:b0b04504<br>
[&lt;b01021c8&gt;] (gic_handle_irq) from [&lt;b0101a8c&gt;] (__irq_svc+0x6c=
/0x90)<br>
Exception stack(0xb0b01ef8 to 0xb0b01f40)<br>
1ee0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A000000000<br>
00012f74<br>
1f00: cfbc1774 b01112e0 b0b00000 00000000 b0b03e28 b0b03e6c b0b5e72c<br>
b08e5ea8<br>
1f20: 10c5387d b0b01f54 b0b01f58 b0b01f48 b0104114 b0104118 600f0013<br>
ffffffff<br>
=C2=A0r9:b0b00000 r8:b0b5e72c r7:b0b01f2c r6:ffffffff r5:600f0013 r4:b01041=
18<br>
[&lt;b01040d4&gt;] (arch_cpu_idle) from [&lt;b014b240&gt;] (do_idle+0xec/0x=
140)<br>
[&lt;b014b154&gt;] (do_idle) from [&lt;b014b56c&gt;] (cpu_startup_entry+0x2=
8/0x2c)<br>
=C2=A0r9:410fc090 r8:0810c000 r7:00000000 r6:b0a53a40 r5:00000001 r4:000000=
ce<br>
[&lt;b014b544&gt;] (cpu_startup_entry) from [&lt;b0794f6c&gt;] (rest_init+0=
xb4/0xbc)<br>
[&lt;b0794eb8&gt;] (rest_init) from [&lt;b0a00c50&gt;] (arch_call_rest_init=
+0x18/0x1c)<br>
=C2=A0r5:00000001 r4:b0b72754<br>
[&lt;b0a00c38&gt;] (arch_call_rest_init) from [&lt;b0a010f4&gt;]<br>
(start_kernel+0x428/0x458)<br>
[&lt;b0a00ccc&gt;] (start_kernel) from [&lt;00000000&gt;] (0x0)<br>
Reboot failed -- System halted<br>
<br>
So not a problem so far...<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.=
org" target=3D"_blank" class=3D"cremed">f4bug@amsat.org</a>&gt;<br>
<br>
But still I&#39;d keep loading the bootrom regardless -kernel.<br></blockqu=
ote><div><br></div><div>So you mean something like this?</div><div><br></di=
v><div>@@ -35,11 +35,6 @@ static void npcm7xx_load_bootrom(MachineState *ma=
chine, NPCM7xxState *soc)<br>=C2=A0 =C2=A0 =C2=A0g_autofree char *filename =
=3D NULL;<br>=C2=A0 =C2=A0 =C2=A0int ret;<br>=C2=A0<br>- =C2=A0 =C2=A0if (m=
achine-&gt;kernel_filename) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Don&#39;t =
load the bootrom if user requested direct kernel boot. */<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return;<br>- =C2=A0 =C2=A0}<br>-<br>=C2=A0 =C2=A0 =C2=A0if=
 (!bios_name) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_name =3D npcm7xx_=
default_bootrom;<br>=C2=A0 =C2=A0 =C2=A0}<br></div><div>@@ -47,7 +42,11 @@ =
static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState *soc)<=
br>=C2=A0 =C2=A0 =C2=A0filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bio=
s_name);<br>=C2=A0 =C2=A0 =C2=A0if (!filename) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0error_report(&quot;Could not find ROM image &#39;%s&#39;&quot;=
, bios_name);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!machine-&gt;kernel_filename) {<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* We can&#39;t boot without a bootrom or a kernel imag=
e. */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0ret =3D load_image_mr(filename, &amp;soc=
-&gt;irom);<br>=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br></div><div>=C2=A0</=
div><div>I&#39;m not sure if it will make much of a difference, as (IIUC) a=
rm_load_kernel installs a reset hook to jump directly into the kernel, bypa=
ssing the bootrom entirely. I&#39;m assuming a watchdog or SW reset would t=
rigger the same reset hook and jump right back into the kernel, though I co=
uld be wrong.</div><div><br></div><div>Anyway, I can make the above change =
in any case.</div><div><br></div><div>Havard=C2=A0</div></div></div>

--00000000000061343a05aefe424e--

