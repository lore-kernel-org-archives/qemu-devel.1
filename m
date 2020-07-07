Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F4EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40EE206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYze88AV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40EE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsuE3-0005tu-3a
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 16:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jsuDR-0005M5-6D; Tue, 07 Jul 2020 16:29:21 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jsuDP-00061w-1w; Tue, 07 Jul 2020 16:29:20 -0400
Received: by mail-io1-xd43.google.com with SMTP id k23so44555009iom.10;
 Tue, 07 Jul 2020 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AOl2jSJcOQ0kIwq+8nPgIxpMNfwpdoGvFiNaax6QucA=;
 b=hYze88AVZjwGWNzvh5bIp1megb7yIo9LbF9HIIcPd4tPmEEZg7lJcbdbtFikSheMYh
 3qjRGHEYz7De7LbKmE5PYAXt6bCUhdxnqgQojtFlJQ8Tk0ZxiGmWLUhcb13Gf7KVFbFa
 KR06VOyfTyNMNQEpPZ76zLsCpiobELOtqsrRjyZhOkUP6B6mGGGnFvKdGMjteoOQKNIX
 CBP8uyAL+8Ixt73Ay+h2k2xTTi7vh0boozHDv0nPP47cSYAOfBqTzEEkMNi1UFJHYM6q
 YYlOSuWr1AiMd8jJbTlHbvVhWCF6jnnyypEjaxCm6z1+R8k/O2Kq+MN4OExk5zt1m2m5
 tcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AOl2jSJcOQ0kIwq+8nPgIxpMNfwpdoGvFiNaax6QucA=;
 b=T56TmReu9cOmAPu2+eNNOYXbDopK2wfb2klypqjRXgk7xlujhBmUMINAnGZaecqdjR
 CG1hcciBuunjWNjFlbVBKte4WYzlWYZmyBxGztDq30qkz/tIjdvt8CP0pG8Skj/ZlOSe
 3ZAeHpacNxkRhXMZUHg4Hmsj7opqKa4KnvzxD6AXgxRsKvzc60OHVuvChiYnObMPyqOH
 +hbjY/pXJTkrJ1W6+ekE9Drmz3B37qaHM1oO58Encv8B5hlhEb6BQstSzAHAxkwDXdMr
 GeZTMZu1eIyCeV4k67yZsZ9Hd5vyVytU76nnpSTvfLSB6zTDVolcky4dOOFpC78jb5oc
 seXA==
X-Gm-Message-State: AOAM532BbqtAtpok00FrsFMKjfj0/5H3dL0uObrW9s9wMwGJSDvEykeH
 7y4GBc9BWAofmJ5EoxCXWyUtqqZIQB6q4idVW64=
X-Google-Smtp-Source: ABdhPJyIAEgrDTI84RcpzE8CRqYIzOB+/77HPVsaWUcohc4hke8zvq61YdCiChSS3erjEL/DIb9aeqd+/NEwcpEerR4=
X-Received: by 2002:a5d:9c44:: with SMTP id 4mr33390474iof.15.1594153756907;
 Tue, 07 Jul 2020 13:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
In-Reply-To: <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 7 Jul 2020 22:29:05 +0200
Message-ID: <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000065db5f05a9dfd84b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 Qemu-block <qemu-block@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000065db5f05a9dfd84b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Just tried out your patch on latest master, and I noticed I couldn't apply
it without getting this error:

$ git am ~/Downloads/patches/\[PATCH\ 2_2\]\ hw_sd_sdcard\:\ Do\ not\
allow\ invalid\ SD\ card\ sizes\ -\ Philippe\ Mathieu-Daud=C3=A9\ \<
f4bug@amsat.org\>\ -\ 2020-07-07\ 1521.eml
Applying: hw/sd/sdcard: Do not allow invalid SD card sizes
error: patch failed: hw/sd/sd.c:2130
error: hw/sd/sd.c: patch does not apply
Patch failed at 0001 hw/sd/sdcard: Do not allow invalid SD card sizes
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

The first patch did go OK. Maybe this one just needs to be rebased, or I
made a mistake.
So I manually copy & pasted the change into hw/sd/sd.c to test it.
It looks like the check works, but my concern is that with this change, we
will be getting this error on 'off-the-shelf' images as well.
For example, the latest Raspbian image size also isn't a power of two:

$ ./arm-softmmu/qemu-system-arm -M raspi2 -sd
~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic
WARNING: Image format was not specified for
'/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img' and probing
guessed raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at least 2 GiB)

If we do decide that the change is needed, I would like to propose that we
also give the user some instructions
on how to fix it, maybe some 'dd' command? In my opinion that should also
go in some of the documentation file(s),
possibly also in the one for the OrangePi PC at
docs/system/arm/orangepi.rst (I can also provide a patch for that if you
wish).

Kind regards,

Niek


On Tue, Jul 7, 2020 at 6:11 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> On 7/7/20 6:06 PM, Peter Maydell wrote:
> > On Tue, 7 Jul 2020 at 17:04, Alistair Francis <alistair23@gmail.com>
> wrote:
> >>
> >> On Tue, Jul 7, 2020 at 6:22 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org>
> wrote:
> >>>
> >>> QEMU allows to create SD card with unrealistic sizes. This could work=
,
> >>> but some guests (at least Linux) consider sizes that are not a power
> >>> of 2 as a firmware bug and fix the card size to the next power of 2.
> >>>
> >>> Before CVE-2020-13253 fix, this would allow OOB read/write accesses
> >>> past the image size end.
> >>>
> >>> CVE-2020-13253 has been fixed as:
> >>>
> >>>     Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
> >>>     occurred and no data transfer is performed.
> >>>
> >>>     Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
> >>>     occurred and no data transfer is performed.
> >>>
> >>>     WP_VIOLATION errors are not modified: the error bit is set, we
> >>>     stay in receive-data state, wait for a stop command. All further
> >>>     data transfer is ignored. See the check on sd->card_status at the
> >>>     beginning of sd_read_data() and sd_write_data().
> >>>
> >>> While this is the correct behavior, in case QEMU create smaller SD
> >>> cards, guests still try to access past the image size end, and QEMU
> >>> considers this is an invalid address, thus "all further data transfer
> >>> is ignored". This is wrong and make the guest looping until
> >>> eventually timeouts.
> >>>
> >>> Fix by not allowing invalid SD card sizes.  Suggesting the expected
> >>> size as a hint:
> >>>
> >>>   $ qemu-system-arm -M orangepi-pc -drive
> file=3Drootfs.ext2,if=3Dsd,format=3Draw
> >>>   qemu-system-arm: Invalid SD card size: 60 MiB (expecting at least 6=
4
> MiB)
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>> ---
> >>>  hw/sd/sd.c | 16 ++++++++++++++++
> >>>  1 file changed, 16 insertions(+)
> >>>
> >>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> >>> index cb81487e5c..c45106b78e 100644
> >>> --- a/hw/sd/sd.c
> >>> +++ b/hw/sd/sd.c
> >>> @@ -32,6 +32,7 @@
> >>>
> >>>  #include "qemu/osdep.h"
> >>>  #include "qemu/units.h"
> >>> +#include "qemu/cutils.h"
> >>>  #include "hw/irq.h"
> >>>  #include "hw/registerfields.h"
> >>>  #include "sysemu/block-backend.h"
> >>> @@ -2130,11 +2131,26 @@ static void sd_realize(DeviceState *dev, Erro=
r
> **errp)
> >>>      }
> >>>
> >>>      if (sd->blk) {
> >>> +        int64_t blk_size;
> >>> +
> >>>          if (blk_is_read_only(sd->blk)) {
> >>>              error_setg(errp, "Cannot use read-only drive as SD card"=
);
> >>>              return;
> >>>          }
> >>>
> >>> +        blk_size =3D blk_getlength(sd->blk);
> >>> +        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> >>> +            int64_t blk_size_aligned =3D pow2ceil(blk_size);
> >>> +            char *blk_size_str =3D size_to_str(blk_size);
> >>> +            char *blk_size_aligned_str =3D
> size_to_str(blk_size_aligned);
> >>> +
> >>> +            error_setg(errp, "Invalid SD card size: %s (expecting at
> least %s)",
> >>> +                       blk_size_str, blk_size_aligned_str);
> >>
> >> Should we print that we expect a power of 2? This isn't always obvious
> >> from the message.
> >
> > Mmm, I was thinking that. Perhaps
> >  "expecting a power of 2, e.g. %s"
> > ?
>
> OK, thanks guys!
>
> >
> > thanks
> > -- PMM
> >
>


--=20
Niek Linnenbank

--00000000000065db5f05a9dfd84b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>Just tried out =
your patch on latest master, and I noticed I couldn&#39;t apply it without =
getting this error:</div><div><br></div><div>$ git am ~/Downloads/patches/\=
[PATCH\ 2_2\]\ hw_sd_sdcard\:\ Do\ not\ allow\ invalid\ SD\ card\ sizes\ -\=
 Philippe\ Mathieu-Daud=C3=A9\ \&lt;<a href=3D"mailto:f4bug@amsat.org">f4bu=
g@amsat.org</a>\&gt;\ -\ 2020-07-07\ 1521.eml<br>Applying: hw/sd/sdcard: Do=
 not allow invalid SD card sizes<br>error: patch failed: hw/sd/sd.c:2130<br=
>error: hw/sd/sd.c: patch does not apply<br>Patch failed at 0001 hw/sd/sdca=
rd: Do not allow invalid SD card sizes<br>Use &#39;git am --show-current-pa=
tch&#39; to see the failed patch<br>When you have resolved this problem, ru=
n &quot;git am --continue&quot;.<br>If you prefer to skip this patch, run &=
quot;git am --skip&quot; instead.<br>To restore the original branch and sto=
p patching, run &quot;git am --abort&quot;.</div><div><br></div><div>The fi=
rst patch did go OK. Maybe this one just needs to be rebased, or I made a m=
istake.<br></div><div>So I manually copy &amp; pasted the change into hw/sd=
/sd.c to test it.</div><div>It looks like the check works, but my concern i=
s that with this change, we will be getting this error on &#39;off-the-shel=
f&#39; images as well.</div><div>For example, the latest Raspbian image siz=
e also isn&#39;t a power of two:<br></div><div><br></div><div>$ ./arm-softm=
mu/qemu-system-arm -M raspi2 -sd ~/Downloads/2020-05-27-raspios-buster-lite=
-armhf.img -nographic<br>WARNING: Image format was not specified for &#39;/=
home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img&#39; and probing=
 guessed raw.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Automatically detecting =
the format is dangerous for raw images, write operations on block 0 will be=
 restricted.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the &#39;raw&#39;=
 format explicitly to remove the restrictions.<br>qemu-system-arm: Invalid =
SD card size: 1.73 GiB (expecting at least 2 GiB)</div><div><br></div><div>=
If we do decide that the change is needed, I would like to propose that we =
also give the user some instructions</div><div>on how to fix it, maybe some=
 &#39;dd&#39; command? In my opinion that should also go in some of the doc=
umentation file(s),</div><div>possibly also in the one for the OrangePi PC =
at docs/system/arm/orangepi.rst (I can also provide a patch for that if you=
 wish).<br></div><div><br></div><div>Kind regards,</div><div><br></div><div=
>Niek<br></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Jul 7, 2020 at 6:11 PM Philippe Mathi=
eu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/7/=
20 6:06 PM, Peter Maydell wrote:<br>
&gt; On Tue, 7 Jul 2020 at 17:04, Alistair Francis &lt;<a href=3D"mailto:al=
istair23@gmail.com" target=3D"_blank">alistair23@gmail.com</a>&gt; wrote:<b=
r>
&gt;&gt;<br>
&gt;&gt; On Tue, Jul 7, 2020 at 6:22 AM Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; w=
rote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; QEMU allows to create SD card with unrealistic sizes. This cou=
ld work,<br>
&gt;&gt;&gt; but some guests (at least Linux) consider sizes that are not a=
 power<br>
&gt;&gt;&gt; of 2 as a firmware bug and fix the card size to the next power=
 of 2.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Before CVE-2020-13253 fix, this would allow OOB read/write acc=
esses<br>
&gt;&gt;&gt; past the image size end.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; CVE-2020-13253 has been fixed as:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Read command is rejected if BLOCK_LEN_ERROR=
 or ADDRESS_ERROR<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0occurred and no data transfer is performed.=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Write command is rejected if BLOCK_LEN_ERRO=
R or ADDRESS_ERROR<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0occurred and no data transfer is performed.=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0WP_VIOLATION errors are not modified: the e=
rror bit is set, we<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0stay in receive-data state, wait for a stop=
 command. All further<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0data transfer is ignored. See the check on =
sd-&gt;card_status at the<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0beginning of sd_read_data() and sd_write_da=
ta().<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; While this is the correct behavior, in case QEMU create smalle=
r SD<br>
&gt;&gt;&gt; cards, guests still try to access past the image size end, and=
 QEMU<br>
&gt;&gt;&gt; considers this is an invalid address, thus &quot;all further d=
ata transfer<br>
&gt;&gt;&gt; is ignored&quot;. This is wrong and make the guest looping unt=
il<br>
&gt;&gt;&gt; eventually timeouts.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Fix by not allowing invalid SD card sizes.=C2=A0 Suggesting th=
e expected<br>
&gt;&gt;&gt; size as a hint:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0$ qemu-system-arm -M orangepi-pc -drive file=3Droo=
tfs.ext2,if=3Dsd,format=3Draw<br>
&gt;&gt;&gt;=C2=A0 =C2=A0qemu-system-arm: Invalid SD card size: 60 MiB (exp=
ecting at least 64 MiB)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mail=
to:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 hw/sd/sd.c | 16 ++++++++++++++++<br>
&gt;&gt;&gt;=C2=A0 1 file changed, 16 insertions(+)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>
&gt;&gt;&gt; index cb81487e5c..c45106b78e 100644<br>
&gt;&gt;&gt; --- a/hw/sd/sd.c<br>
&gt;&gt;&gt; +++ b/hw/sd/sd.c<br>
&gt;&gt;&gt; @@ -32,6 +32,7 @@<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;&gt;=C2=A0 #include &quot;qemu/units.h&quot;<br>
&gt;&gt;&gt; +#include &quot;qemu/cutils.h&quot;<br>
&gt;&gt;&gt;=C2=A0 #include &quot;hw/irq.h&quot;<br>
&gt;&gt;&gt;=C2=A0 #include &quot;hw/registerfields.h&quot;<br>
&gt;&gt;&gt;=C2=A0 #include &quot;sysemu/block-backend.h&quot;<br>
&gt;&gt;&gt; @@ -2130,11 +2131,26 @@ static void sd_realize(DeviceState *de=
v, Error **errp)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (sd-&gt;blk) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t blk_size;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (blk_is_read_only(sd-&gt;=
blk)) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(err=
p, &quot;Cannot use read-only drive as SD card&quot;);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_size =3D blk_getlength(sd-&gt=
;blk);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (blk_size &gt; 0 &amp;&amp; !i=
s_power_of_2(blk_size)) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t blk_size_al=
igned =3D pow2ceil(blk_size);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *blk_size_str =
=3D size_to_str(blk_size);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *blk_size_alig=
ned_str =3D size_to_str(blk_size_aligned);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &q=
uot;Invalid SD card size: %s (expecting at least %s)&quot;,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0blk_size_str, blk_size_aligned_str);<br>
&gt;&gt;<br>
&gt;&gt; Should we print that we expect a power of 2? This isn&#39;t always=
 obvious<br>
&gt;&gt; from the message.<br>
&gt; <br>
&gt; Mmm, I was thinking that. Perhaps<br>
&gt;=C2=A0 &quot;expecting a power of 2, e.g. %s&quot;<br>
&gt; ?<br>
<br>
OK, thanks guys!<br>
<br>
&gt; <br>
&gt; thanks<br>
&gt; -- PMM<br>
&gt; <br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--00000000000065db5f05a9dfd84b--

