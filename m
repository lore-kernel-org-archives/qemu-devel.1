Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BA020775
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsXSI8Es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BA020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtakc-00009Q-Cl
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jtajx-0007r0-9B; Thu, 09 Jul 2020 13:53:45 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132]:34072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jtaju-0000Wm-RQ; Thu, 09 Jul 2020 13:53:44 -0400
Received: by mail-il1-x132.google.com with SMTP id t4so2804143iln.1;
 Thu, 09 Jul 2020 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VBa+CT2ownn6zA4E5SPq1BIlem1f0Onm17RTmtQwuPQ=;
 b=HsXSI8Esbi7s8IyHoXgCZUVF7NtHCCeTkW5hd7clTkBmhMsGkC5t2uxkqrWiN2L+Qd
 +nTfrtLeneiu3eeq2/bH8/SYRAp4cBafJUzlW1GnB69BSnAUy+BGvY7BsFzfMd+Y20/S
 xiNRPRF2Bly1JVPfoewrfJl15lrec6gKR6QZNIisfUOy7fdBQZMoCOLtn6inKhb7lswV
 NnSDcJXvInzL2N9YfuedHbXx/zc4CER+H4izbuj1uGllZsYH5QnxT0OtRJ7eoGcD2yAG
 gIuJM8QkZlntTkVjGRDC7z0mqDcoIVNyxLBW3nba/k3HGIGOextfiQJQm/GeBZMmk1d4
 A4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VBa+CT2ownn6zA4E5SPq1BIlem1f0Onm17RTmtQwuPQ=;
 b=os8dXxpEWY/SSD2ykwWDX9dP/VwhuQ0dyLIqCrjSEBQ2BnPOpOB5aiNeKr4rDtcTyM
 H5u4CfYKoo072igAnULZhfdJxT8sFJo5ZQ9p88wrzzdEEiMMK2EkA7+Ei8gIxOXn0QMC
 O0hHTIZHwwW3s/pUe3lRAwE2/gJkJ6BaWpGMNNy5b4OUNKs6xPLMhAkQDPxXgsKXoWoQ
 Yk08yotIx23jpTrLMpLHbhnicChWu0kaSO7dfqhTCrGqwDXrjRi8X7G3MHRxuy6hYF3C
 3iSfsguq+ypUGyCZgontfE9vXiKvh+KtF3hpSSrBrFiyKutsymNve/K2CcyzUlnu+BK/
 cRHA==
X-Gm-Message-State: AOAM532Tu4qyuIhCzmYNFbgTQiUO5R/k7gjZCr8AhqgGAaFPxdiqQHV0
 MMPeCVRXJHx/YrmtmtrAsDH2dv1WKorjNrI9gt4=
X-Google-Smtp-Source: ABdhPJymyfAA5n2B6IrxU1vTRYtBOaqxVVZ1tVCFfqDQ9yDA81CINAADcTYgKp1N8f4Hnib//G/5Y5rLDBhrn6JUknk=
X-Received: by 2002:a92:cc41:: with SMTP id t1mr50723816ilq.132.1594317221058; 
 Thu, 09 Jul 2020 10:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
 <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
 <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
In-Reply-To: <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 9 Jul 2020 19:53:29 +0200
Message-ID: <CAPan3WoqEmTwJ9E2JM87sdLrSFQ+nrV4QS4V=yZ6upW+yM0gTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000009ede9405aa05e7e9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-il1-x132.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

--0000000000009ede9405aa05e7e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2020 at 3:56 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> On 7/7/20 10:29 PM, Niek Linnenbank wrote:
> > Hi Philippe,
> >
> > Just tried out your patch on latest master, and I noticed I couldn't
> > apply it without getting this error:
> >
> > $ git am ~/Downloads/patches/\[PATCH\ 2_2\]\ hw_sd_sdcard\:\ Do\ not\
> > allow\ invalid\ SD\ card\ sizes\ -\ Philippe\ Mathieu-Daud=C3=A9\
> > \<f4bug@amsat.org <mailto:f4bug@amsat.org>\>\ -\ 2020-07-07\ 1521.eml
> > Applying: hw/sd/sdcard: Do not allow invalid SD card sizes
> > error: patch failed: hw/sd/sd.c:2130
> > error: hw/sd/sd.c: patch does not apply
> > Patch failed at 0001 hw/sd/sdcard: Do not allow invalid SD card sizes
> > Use 'git am --show-current-patch' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> >
> > The first patch did go OK. Maybe this one just needs to be rebased, or =
I
> > made a mistake.
>
> Sorry it was not clear on the cover:
>
>   Part 1 is already reviewed:
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg718150.html
>   Based-on: <20200630133912.9428-1-f4bug@amsat.org>
>
> This series is based on the "Part 1".
>
> > So I manually copy & pasted the change into hw/sd/sd.c to test it.
> > It looks like the check works, but my concern is that with this change,
> > we will be getting this error on 'off-the-shelf' images as well.
> > For example, the latest Raspbian image size also isn't a power of two:
> >
> > $ ./arm-softmmu/qemu-system-arm -M raspi2 -sd
> > ~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic
> > WARNING: Image format was not specified for
> > '/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img' and
> > probing guessed raw.
> >          Automatically detecting the format is dangerous for raw images=
,
> > write operations on block 0 will be restricted.
> >          Specify the 'raw' format explicitly to remove the restrictions=
.
> > qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at least 2
> GiB)
> >
> > If we do decide that the change is needed, I would like to propose that
> > we also give the user some instructions
> > on how to fix it, maybe some 'dd' command?
>
> On POSIX we can suggest to use 'truncate -s 2G' from coreutils.
> This is not in the default Darwin packages.
> On Windows I have no clue.
>
> > In my opinion that should
> > also go in some of the documentation file(s),
> > possibly also in the one for the OrangePi PC at
> > docs/system/arm/orangepi.rst (I can also provide a patch for that if yo=
u
> > wish).
>
> Good idea, if you can send that patch that would a precious help,
> and I'd include it with the other patches :)
>

OK Philipe. Then I'll prepare a patch and try send it to the list somewhere
this weekend.


>
> Note that this was your orangepi-pc acceptance test that catched
> this bug!
> See https://travis-ci.org/github/philmd/qemu/jobs/705653532#L5672:
>
>
Oh cool, that is great. Looks like it is working pretty well then. But lets
be fair, I think it was you that contributed that part ;-)


>  CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D50c5387d
>  OF: fdt: Machine model: Xunlong Orange Pi PC
>  Kernel command line: printk.time=3D0 console=3DttyS0,115200
> root=3D/dev/mmcblk0 rootwait rw panic=3D-1 noreboot
>  sunxi-mmc 1c0f000.mmc: Linked as a consumer to regulator.2
>  sunxi-mmc 1c0f000.mmc: Got CD GPIO
>  sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB
>  mmc0: host does not support reading read-only switch, assuming
> write-enable
>  mmc0: Problem switching card into high-speed mode!
>  mmc0: new SD card at address 4567
>  mmcblk0: mmc0:4567 QEMU! 60.0 MiB
>  EXT4-fs (mmcblk0): mounting ext2 file system using the ext4 subsystem
>  EXT4-fs (mmcblk0): mounted filesystem without journal. Opts: (null)
>  VFS: Mounted root (ext2 filesystem) on device 179:0.
>  EXT4-fs (mmcblk0): re-mounted. Opts: block_validity,barrier,user_xattr,a=
cl
>  Populating /dev using udev: udevd[204]: starting version 3.2.7
>  udevadm settle failed
>  done
>  udevd[205]: worker [208]
> /devices/platform/soc/1c0f000.mmc/mmc_host/mmc0/mmc0:4567/block/mmcblk0
> is taking a long time
> Runner error occurred: Timeout reached
> Original status: ERROR
>
> (I'll add that in the commit description too).
>

OK thanks!

>
> Thanks for your testing/review!
>
> > Kind regards,
> >
> > Niek
> >
> >
> > On Tue, Jul 7, 2020 at 6:11 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org
> > <mailto:f4bug@amsat.org>> wrote:
> >
> >     On 7/7/20 6:06 PM, Peter Maydell wrote:
> >     > On Tue, 7 Jul 2020 at 17:04, Alistair Francis
> >     <alistair23@gmail.com <mailto:alistair23@gmail.com>> wrote:
> >     >>
> >     >> On Tue, Jul 7, 2020 at 6:22 AM Philippe Mathieu-Daud=C3=A9
> >     <f4bug@amsat.org <mailto:f4bug@amsat.org>> wrote:
> >     >>>
> >     >>> QEMU allows to create SD card with unrealistic sizes. This coul=
d
> >     work,
> >     >>> but some guests (at least Linux) consider sizes that are not a
> power
> >     >>> of 2 as a firmware bug and fix the card size to the next power
> of 2.
> >     >>>
> >     >>> Before CVE-2020-13253 fix, this would allow OOB read/write
> accesses
> >     >>> past the image size end.
> >     >>>
> >     >>> CVE-2020-13253 has been fixed as:
> >     >>>
> >     >>>     Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERRO=
R
> >     >>>     occurred and no data transfer is performed.
> >     >>>
> >     >>>     Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERR=
OR
> >     >>>     occurred and no data transfer is performed.
> >     >>>
> >     >>>     WP_VIOLATION errors are not modified: the error bit is set,
> we
> >     >>>     stay in receive-data state, wait for a stop command. All
> further
> >     >>>     data transfer is ignored. See the check on sd->card_status
> >     at the
> >     >>>     beginning of sd_read_data() and sd_write_data().
> >     >>>
> >     >>> While this is the correct behavior, in case QEMU create smaller
> SD
> >     >>> cards, guests still try to access past the image size end, and
> QEMU
> >     >>> considers this is an invalid address, thus "all further data
> >     transfer
> >     >>> is ignored". This is wrong and make the guest looping until
> >     >>> eventually timeouts.
> >     >>>
> >     >>> Fix by not allowing invalid SD card sizes.  Suggesting the
> expected
> >     >>> size as a hint:
> >     >>>
> >     >>>   $ qemu-system-arm -M orangepi-pc -drive
> >     file=3Drootfs.ext2,if=3Dsd,format=3Draw
> >     >>>   qemu-system-arm: Invalid SD card size: 60 MiB (expecting at
> >     least 64 MiB)
> >     >>>
> >     >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> >     <mailto:f4bug@amsat.org>>
> >     >>> ---
> >     >>>  hw/sd/sd.c | 16 ++++++++++++++++
> >     >>>  1 file changed, 16 insertions(+)
> >     >>>
> >     >>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> >     >>> index cb81487e5c..c45106b78e 100644
> >     >>> --- a/hw/sd/sd.c
> >     >>> +++ b/hw/sd/sd.c
> >     >>> @@ -32,6 +32,7 @@
> >     >>>
> >     >>>  #include "qemu/osdep.h"
> >     >>>  #include "qemu/units.h"
> >     >>> +#include "qemu/cutils.h"
> >     >>>  #include "hw/irq.h"
> >     >>>  #include "hw/registerfields.h"
> >     >>>  #include "sysemu/block-backend.h"
> >     >>> @@ -2130,11 +2131,26 @@ static void sd_realize(DeviceState *dev=
,
> >     Error **errp)
> >     >>>      }
> >     >>>
> >     >>>      if (sd->blk) {
> >     >>> +        int64_t blk_size;
> >     >>> +
> >     >>>          if (blk_is_read_only(sd->blk)) {
> >     >>>              error_setg(errp, "Cannot use read-only drive as SD
> >     card");
> >     >>>              return;
> >     >>>          }
> >     >>>
> >     >>> +        blk_size =3D blk_getlength(sd->blk);
> >     >>> +        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> >     >>> +            int64_t blk_size_aligned =3D pow2ceil(blk_size);
> >     >>> +            char *blk_size_str =3D size_to_str(blk_size);
> >     >>> +            char *blk_size_aligned_str =3D
> >     size_to_str(blk_size_aligned);
> >     >>> +
> >     >>> +            error_setg(errp, "Invalid SD card size: %s
> >     (expecting at least %s)",
> >     >>> +                       blk_size_str, blk_size_aligned_str);
> >     >>
> >     >> Should we print that we expect a power of 2? This isn't always
> >     obvious
> >     >> from the message.
> >     >
> >     > Mmm, I was thinking that. Perhaps
> >     >  "expecting a power of 2, e.g. %s"
> >     > ?
> >
> >     OK, thanks guys!
> >
> >     >
> >     > thanks
> >     > -- PMM
> >     >
> >
> >
> >
> > --
> > Niek Linnenbank
> >
>


--=20
Niek Linnenbank

--0000000000009ede9405aa05e7e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 9, 2020 at 3:56 PM Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On 7/7/20 10:29 PM, Niek Linnenbank wrote:<br>
&gt; Hi Philippe,<br>
&gt; <br>
&gt; Just tried out your patch on latest master, and I noticed I couldn&#39=
;t<br>
&gt; apply it without getting this error:<br>
&gt; <br>
&gt; $ git am ~/Downloads/patches/\[PATCH\ 2_2\]\ hw_sd_sdcard\:\ Do\ not\<=
br>
&gt; allow\ invalid\ SD\ card\ sizes\ -\ Philippe\ Mathieu-Daud=C3=A9\<br>
&gt; \&lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.=
org</a> &lt;mailto:<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4b=
ug@amsat.org</a>&gt;\&gt;\ -\ 2020-07-07\ 1521.eml<br>
&gt; Applying: hw/sd/sdcard: Do not allow invalid SD card sizes<br>
&gt; error: patch failed: hw/sd/sd.c:2130<br>
&gt; error: hw/sd/sd.c: patch does not apply<br>
&gt; Patch failed at 0001 hw/sd/sdcard: Do not allow invalid SD card sizes<=
br>
&gt; Use &#39;git am --show-current-patch&#39; to see the failed patch<br>
&gt; When you have resolved this problem, run &quot;git am --continue&quot;=
.<br>
&gt; If you prefer to skip this patch, run &quot;git am --skip&quot; instea=
d.<br>
&gt; To restore the original branch and stop patching, run &quot;git am --a=
bort&quot;.<br>
&gt; <br>
&gt; The first patch did go OK. Maybe this one just needs to be rebased, or=
 I<br>
&gt; made a mistake.<br>
<br>
Sorry it was not clear on the cover:<br>
<br>
=C2=A0 Part 1 is already reviewed:<br>
=C2=A0 <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg718=
150.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com=
/qemu-devel@nongnu.org/msg718150.html</a><br>
=C2=A0 Based-on: &lt;<a href=3D"mailto:20200630133912.9428-1-f4bug@amsat.or=
g" target=3D"_blank">20200630133912.9428-1-f4bug@amsat.org</a>&gt;<br>
<br>
This series is based on the &quot;Part 1&quot;.<br>
<br>
&gt; So I manually copy &amp; pasted the change into hw/sd/sd.c to test it.=
<br>
&gt; It looks like the check works, but my concern is that with this change=
,<br>
&gt; we will be getting this error on &#39;off-the-shelf&#39; images as wel=
l.<br>
&gt; For example, the latest Raspbian image size also isn&#39;t a power of =
two:<br>
&gt; <br>
&gt; $ ./arm-softmmu/qemu-system-arm -M raspi2 -sd<br>
&gt; ~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic<br>
&gt; WARNING: Image format was not specified for<br>
&gt; &#39;/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img&#39; =
and<br>
&gt; probing guessed raw.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Automatically detecting the format i=
s dangerous for raw images,<br>
&gt; write operations on block 0 will be restricted.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the &#39;raw&#39; format exp=
licitly to remove the restrictions.<br>
&gt; qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at least 2 =
GiB)<br>
&gt; <br>
&gt; If we do decide that the change is needed, I would like to propose tha=
t<br>
&gt; we also give the user some instructions<br>
&gt; on how to fix it, maybe some &#39;dd&#39; command?<br>
<br>
On POSIX we can suggest to use &#39;truncate -s 2G&#39; from coreutils.<br>
This is not in the default Darwin packages.<br>
On Windows I have no clue.<br>
<br>
&gt; In my opinion that should<br>
&gt; also go in some of the documentation file(s),<br>
&gt; possibly also in the one for the OrangePi PC at<br>
&gt; docs/system/arm/orangepi.rst (I can also provide a patch for that if y=
ou<br>
&gt; wish).<br>
<br>
Good idea, if you can send that patch that would a precious help,<br>
and I&#39;d include it with the other patches :)<br></blockquote><div><br><=
/div><div>OK Philipe. Then I&#39;ll prepare a patch and try send it to the =
list somewhere this weekend.<br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
Note that this was your orangepi-pc acceptance test that catched<br>
this bug!<br>
See <a href=3D"https://travis-ci.org/github/philmd/qemu/jobs/705653532#L567=
2" rel=3D"noreferrer" target=3D"_blank">https://travis-ci.org/github/philmd=
/qemu/jobs/705653532#L5672</a>:<br>
<br></blockquote><div><br></div><div>Oh cool, that is great. Looks like it =
is working pretty well then. But lets be fair, I think it was you that cont=
ributed that part ;-)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
=C2=A0CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D50c5387d<br>
=C2=A0OF: fdt: Machine model: Xunlong Orange Pi PC<br>
=C2=A0Kernel command line: printk.time=3D0 console=3DttyS0,115200<br>
root=3D/dev/mmcblk0 rootwait rw panic=3D-1 noreboot<br>
=C2=A0sunxi-mmc 1c0f000.mmc: Linked as a consumer to regulator.2<br>
=C2=A0sunxi-mmc 1c0f000.mmc: Got CD GPIO<br>
=C2=A0sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB<br>
=C2=A0mmc0: host does not support reading read-only switch, assuming write-=
enable<br>
=C2=A0mmc0: Problem switching card into high-speed mode!<br>
=C2=A0mmc0: new SD card at address 4567<br>
=C2=A0mmcblk0: mmc0:4567 QEMU! 60.0 MiB<br>
=C2=A0EXT4-fs (mmcblk0): mounting ext2 file system using the ext4 subsystem=
<br>
=C2=A0EXT4-fs (mmcblk0): mounted filesystem without journal. Opts: (null)<b=
r>
=C2=A0VFS: Mounted root (ext2 filesystem) on device 179:0.<br>
=C2=A0EXT4-fs (mmcblk0): re-mounted. Opts: block_validity,barrier,user_xatt=
r,acl<br>
=C2=A0Populating /dev using udev: udevd[204]: starting version 3.2.7<br>
=C2=A0udevadm settle failed<br>
=C2=A0done<br>
=C2=A0udevd[205]: worker [208]<br>
/devices/platform/soc/1c0f000.mmc/mmc_host/mmc0/mmc0:4567/block/mmcblk0<br>
is taking a long time<br>
Runner error occurred: Timeout reached<br>
Original status: ERROR<br>
<br>
(I&#39;ll add that in the commit description too).<br></blockquote><div><br=
></div><div>OK thanks! <br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
Thanks for your testing/review!<br>
<br>
&gt; Kind regards,<br>
&gt; <br>
&gt; Niek<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Jul 7, 2020 at 6:11 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@=
amsat.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 7/7/20 6:06 PM, Peter Maydell wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Tue, 7 Jul 2020 at 17:04, Alistair Francis<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:alistair23@gmail.com" target=
=3D"_blank">alistair23@gmail.com</a> &lt;mailto:<a href=3D"mailto:alistair2=
3@gmail.com" target=3D"_blank">alistair23@gmail.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; On Tue, Jul 7, 2020 at 6:22 AM Philippe Ma=
thieu-Daud=C3=A9<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_b=
lank">f4bug@amsat.org</a> &lt;mailto:<a href=3D"mailto:f4bug@amsat.org" tar=
get=3D"_blank">f4bug@amsat.org</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; QEMU allows to create SD card with unr=
ealistic sizes. This could<br>
&gt;=C2=A0 =C2=A0 =C2=A0work,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; but some guests (at least Linux) consi=
der sizes that are not a power<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; of 2 as a firmware bug and fix the car=
d size to the next power of 2.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; Before CVE-2020-13253 fix, this would =
allow OOB read/write accesses<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; past the image size end.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; CVE-2020-13253 has been fixed as:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Read command is rej=
ected if BLOCK_LEN_ERROR or ADDRESS_ERROR<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0occurred and no dat=
a transfer is performed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Write command is re=
jected if BLOCK_LEN_ERROR or ADDRESS_ERROR<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0occurred and no dat=
a transfer is performed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0WP_VIOLATION errors=
 are not modified: the error bit is set, we<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0stay in receive-dat=
a state, wait for a stop command. All further<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0data transfer is ig=
nored. See the check on sd-&gt;card_status<br>
&gt;=C2=A0 =C2=A0 =C2=A0at the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0beginning of sd_rea=
d_data() and sd_write_data().<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; While this is the correct behavior, in=
 case QEMU create smaller SD<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; cards, guests still try to access past=
 the image size end, and QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; considers this is an invalid address, =
thus &quot;all further data<br>
&gt;=C2=A0 =C2=A0 =C2=A0transfer<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; is ignored&quot;. This is wrong and ma=
ke the guest looping until<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; eventually timeouts.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; Fix by not allowing invalid SD card si=
zes.=C2=A0 Suggesting the expected<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; size as a hint:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0$ qemu-system-arm -M orang=
epi-pc -drive<br>
&gt;=C2=A0 =C2=A0 =C2=A0file=3Drootfs.ext2,if=3Dsd,format=3Draw<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0qemu-system-arm: Invalid S=
D card size: 60 MiB (expecting at<br>
&gt;=C2=A0 =C2=A0 =C2=A0least 64 MiB)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; Signed-off-by: Philippe Mathieu-Daud=
=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat=
.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:f4bug@amsat.org" targe=
t=3D"_blank">f4bug@amsat.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 hw/sd/sd.c | 16 ++++++++++++++++=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 1 file changed, 16 insertions(+)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; diff --git a/hw/sd/sd.c b/hw/sd/sd.c<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; index cb81487e5c..c45106b78e 100644<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; --- a/hw/sd/sd.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +++ b/hw/sd/sd.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; @@ -32,6 +32,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 #include &quot;qemu/osdep.h&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 #include &quot;qemu/units.h&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +#include &quot;qemu/cutils.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 #include &quot;hw/irq.h&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 #include &quot;hw/registerfields=
.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 #include &quot;sysemu/block-back=
end.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; @@ -2130,11 +2131,26 @@ static void sd=
_realize(DeviceState *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (sd-&gt;blk) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t b=
lk_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
blk_is_read_only(sd-&gt;blk)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 error_setg(errp, &quot;Cannot use read-only drive as SD<br>
&gt;=C2=A0 =C2=A0 =C2=A0card&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_size =
=3D blk_getlength(sd-&gt;blk);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (blk_s=
ize &gt; 0 &amp;&amp; !is_power_of_2(blk_size)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int64_t blk_size_aligned =3D pow2ceil(blk_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 char *blk_size_str =3D size_to_str(blk_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 char *blk_size_aligned_str =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0size_to_str(blk_size_aligned);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 error_setg(errp, &quot;Invalid SD card size: %s<br>
&gt;=C2=A0 =C2=A0 =C2=A0(expecting at least %s)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_size_str, blk_size_alig=
ned_str);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; Should we print that we expect a power of =
2? This isn&#39;t always<br>
&gt;=C2=A0 =C2=A0 =C2=A0obvious<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; from the message.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Mmm, I was thinking that. Perhaps<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 &quot;expecting a power of 2, e.g. %s&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0OK, thanks guys!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; thanks<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -- PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Niek Linnenbank<br>
&gt; <br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000009ede9405aa05e7e9--

