Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BC4C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907C9208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfrXh+Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907C9208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVcPB-00025l-Ei
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kVcO2-0001Dv-Id; Thu, 22 Oct 2020 11:20:18 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kVcNz-00032O-Lz; Thu, 22 Oct 2020 11:20:18 -0400
Received: by mail-io1-xd43.google.com with SMTP id k6so2045862ior.2;
 Thu, 22 Oct 2020 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j4wcGv+O3CVKhhtMhUWejxRtOOG+VCmV3MOtkLdUNso=;
 b=AfrXh+SymX82bUN9iZCL4XiOOX42IwlM6V+Cbuvn2Nu6h+IHMp/jlBRMiN0+8u/NDf
 2LNDZGEyTWegiWN7FMfCIzn3RHPFVq38Q4X4aW6txXJUjtaW7IJOhKFmYrs3I/f2Aic9
 vg6AQzAlCX1LIOmsfpl8hGsoCJ0HM6Av2QP1EzA8wlz9jU8ig408xayTPwv7zfOwxTeg
 txOs4urCYRrQG5A/a4ErhmmmESP8B7v5Xn8g5JNCE7dvjohgNblp1qJ4cifZJ4or159r
 OJQYKMRCWfBo+JHbY/owrr5jK0425MdUuSHd/B0I4fzlvKgXcXp9YaZCqPLPC5m9yfhO
 PuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j4wcGv+O3CVKhhtMhUWejxRtOOG+VCmV3MOtkLdUNso=;
 b=rP9EximAveeqbXgxAk/yQgUY5S39bwM7zT97BuKhUrh1U1iTahUObHYWQThGwJ/plr
 EcwzDJjbxv7asIYw015SVKvMaV5QFa9FhCjTCufveN8eI7SEROX/WTD8kJZBIPV0oP4j
 WeQ3r66fmj8UbFSM+bHLJjlb0z2PlBndy5G0dEp1ASB9efL4iJxOyapZGKBf97beBX6K
 xDfNLpU5dUCJMcEPy6OLP7V/QRG4Sd/kubz1/yTXxwkAfxIQR5wLuk2UFvNF9iD/lUiL
 8Sehffo/3GRnrpAe6RzNXK3LXWD6l8jSQqZ1IlDFZ6E3tbWz0ubYZU6+FwIg8KbGAWrJ
 IIBA==
X-Gm-Message-State: AOAM5325f81moznotNdOUhlOOKnNEHJDgtU4GGChypSe7pekvbcifb/n
 PBMT9iZQBjBPgSJiX79g92H4+KAH42MZNo8X6lE=
X-Google-Smtp-Source: ABdhPJy/OAer6mfjRGn5tc54TH5W3RGCKCE5CIhzV+RWsCXq5skgR8uwbYgEmuWAN1+MFTnzuxVln5iTqK9R2RbUikc=
X-Received: by 2002:a05:6638:d49:: with SMTP id
 d9mr2193232jak.85.1603380011700; 
 Thu, 22 Oct 2020 08:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200821172916.1260954-1-f4bug@amsat.org>
 <20200821172916.1260954-23-f4bug@amsat.org>
 <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
 <CAEUhbmVFZ8aWdv48D8acdfFRp6WMYL6n=ENeo4hBZfmqE9TrDA@mail.gmail.com>
 <a0ac3805-ec48-2a0e-6511-b142bfc6f214@amsat.org>
 <CAEUhbmVLFJWND=KHexD12mrCMJSO3mcE6k7_tRE+v8pNZjhN_A@mail.gmail.com>
In-Reply-To: <CAEUhbmVLFJWND=KHexD12mrCMJSO3mcE6k7_tRE+v8pNZjhN_A@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 22 Oct 2020 17:20:00 +0200
Message-ID: <CAPan3Wqx-psi6zgz3NyM1Hu_PHaGq4Nn3_RJf_zueqwXFNKuWg@mail.gmail.com>
Subject: Re: [PULL 22/23] hw/sd: Fix incorrect populated function switch
 status data structure
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000009956405b2440092"
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000009956405b2440092
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bin, Philippe,

If im correct the acceptance tests for orange pi need to be run with a flag
ARMBIAN_ARTIFACTS_CACHED set that explicitly allows them to be run using
the armbian mirror. So if you pass that flag on the same command that
Philippe gave, the rests should run.

I have a follow up question and Im interested to hear your opinion on that
Philippe. Should we perhaps update the orange pi tests (and maybe others)
so they use a reliable mirror that we can control, for example a github
repo? I would be happy to create a repo for that, at least for the orange
pi tests. But maybe there is already something planned as a more general
solution for artifacts of other machines as well?

regards,
Niek

Op do 22 okt. 2020 16:47 schreef Bin Meng <bmeng.cn@gmail.com>:

> Hi Philippe,
>
> On Wed, Oct 21, 2020 at 6:07 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
> wrote:
> >
> > On 10/21/20 11:57 AM, Bin Meng wrote:
> > > Hi Philippe,
> > >
> > > On Tue, Oct 20, 2020 at 11:18 PM Philippe Mathieu-Daud=C3=A9 <
> f4bug@amsat.org> wrote:
> > >>
> > >> Hi Bin,
> > >>
> > >> On 8/21/20 7:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > >>> From: Bin Meng <bin.meng@windriver.com>
> > >>>
> > >>> At present the function switch status data structure bit [399:376]
> > >>> are wrongly pupulated. These 3 bytes encode function switch status
> > >>> for the 6 function groups, with 4 bits per group, starting from
> > >>> function group 6 at bit 399, then followed by function group 5 at
> > >>> bit 395, and so on.
> > >>>
> > >>> However the codes mistakenly fills in the function group 1 status
> > >>> at bit 399. This fixes the code logic.
> > >>>
> > >>> Fixes: a1bb27b1e9 ("SD card emulation (initial implementation)")
> > >>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >>> Tested-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > >>> Message-Id: <1598021136-49525-1-git-send-email-bmeng.cn@gmail.com>
> > >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >>> ---
> > >>>    hw/sd/sd.c | 3 ++-
> > >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > >>> index 7c9d956f113..805e21fc883 100644
> > >>> --- a/hw/sd/sd.c
> > >>> +++ b/hw/sd/sd.c
> > >>> @@ -807,11 +807,12 @@ static void sd_function_switch(SDState *sd,
> uint32_t arg)
> > >>>        sd->data[11] =3D 0x43;
> > >>>        sd->data[12] =3D 0x80;    /* Supported group 1 functions */
> > >>>        sd->data[13] =3D 0x03;
> > >>> +
> > >>>        for (i =3D 0; i < 6; i ++) {
> > >>>            new_func =3D (arg >> (i * 4)) & 0x0f;
> > >>>            if (mode && new_func !=3D 0x0f)
> > >>>                sd->function_group[i] =3D new_func;
> > >>> -        sd->data[14 + (i >> 1)] =3D new_func << ((i * 4) & 4);
> > >>> +        sd->data[16 - (i >> 1)] |=3D new_func << ((i % 2) * 4);
> > >>
> > >> This patch broke the orangepi machine, reproducible running
> > >> test_arm_orangepi_bionic:
> > >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg739449.html
> > >>
> > >> Can you have a look?
> > >
> > > Yes, I can take a look. Could you please send more details on how to
> > > run "test_arm_orangepi_bionic"?
> >
> > Looking at the previous link, I think this should work:
> >
> > $ make check-venv qemu-system-arm
> > $ AVOCADO_ALLOW_LARGE_STORAGE=3D1 \
> >    tests/venv/bin/python -m \
> >      avocado --show=3Dapp,console run \
> >        run -t machine:orangepi-pc tests/acceptance
> >
>
> I tried the above command in my build tree, and got:
>
> avocado run: error: unrecognized arguments: tests/acceptance
> Perhaps a plugin is missing; run 'avocado plugins' to list the installed
> ones
>
> I switched to `make check-acceptance` which seems to work, however not
> for orangepi-pc related tests?
>
>  (09/32)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
:
> SKIP: Test artifacts fetched from unreliable apt.armbian.com
>  (10/32)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_initrd:
> SKIP: Test artifacts fetched from unreliable apt.armbian.com
>  (11/32)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_sd:
> SKIP: Test artifacts fetched from unreliable apt.armbian.com
>  (12/32)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_bionic:
> SKIP: storage limited
>  (13/32)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_uboot_netbsd9:
> SKIP: storage limited
>
> Any ideas?
>
> Regards,
> Bin
>

--00000000000009956405b2440092
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Bin, Philippe,<div dir=3D"auto"><br></div><div dir=3D"=
auto">If im correct the acceptance tests for orange pi need to be run with =
a flag ARMBIAN_ARTIFACTS_CACHED set that explicitly allows them to be run u=
sing the armbian mirror. So if you pass that flag on the same command that =
Philippe gave, the rests should run.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">I have a follow up question and Im interested to hear your opi=
nion on that Philippe. Should we perhaps update the orange pi tests (and ma=
ybe others) so they use a reliable mirror that we can control, for example =
a github repo? I would be happy to create a repo for that, at least for the=
 orange pi tests. But maybe there is already something planned as a more ge=
neral solution for artifacts of other machines as well?</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">regards,</div><div dir=3D"auto">Niek</div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
p do 22 okt. 2020 16:47 schreef Bin Meng &lt;<a href=3D"mailto:bmeng.cn@gma=
il.com">bmeng.cn@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Hi Philippe,<br>
<br>
On Wed, Oct 21, 2020 at 6:07 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"=
mailto:f4bug@amsat.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.or=
g</a>&gt; wrote:<br>
&gt;<br>
&gt; On 10/21/20 11:57 AM, Bin Meng wrote:<br>
&gt; &gt; Hi Philippe,<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Oct 20, 2020 at 11:18 PM Philippe Mathieu-Daud=C3=A9 &lt;=
<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank" rel=3D"noreferrer">f4b=
ug@amsat.org</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi Bin,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 8/21/20 7:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt;&gt;&gt; From: Bin Meng &lt;<a href=3D"mailto:bin.meng@windriver.c=
om" target=3D"_blank" rel=3D"noreferrer">bin.meng@windriver.com</a>&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; At present the function switch status data structure bit =
[399:376]<br>
&gt; &gt;&gt;&gt; are wrongly pupulated. These 3 bytes encode function swit=
ch status<br>
&gt; &gt;&gt;&gt; for the 6 function groups, with 4 bits per group, startin=
g from<br>
&gt; &gt;&gt;&gt; function group 6 at bit 399, then followed by function gr=
oup 5 at<br>
&gt; &gt;&gt;&gt; bit 395, and so on.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; However the codes mistakenly fills in the function group =
1 status<br>
&gt; &gt;&gt;&gt; at bit 399. This fixes the code logic.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Fixes: a1bb27b1e9 (&quot;SD card emulation (initial imple=
mentation)&quot;)<br>
&gt; &gt;&gt;&gt; Signed-off-by: Bin Meng &lt;<a href=3D"mailto:bin.meng@wi=
ndriver.com" target=3D"_blank" rel=3D"noreferrer">bin.meng@windriver.com</a=
>&gt;<br>
&gt; &gt;&gt;&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"m=
ailto:f4bug@amsat.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.org=
</a>&gt;<br>
&gt; &gt;&gt;&gt; Tested-by: Sai Pavan Boddu &lt;<a href=3D"mailto:sai.pava=
n.boddu@xilinx.com" target=3D"_blank" rel=3D"noreferrer">sai.pavan.boddu@xi=
linx.com</a>&gt;<br>
&gt; &gt;&gt;&gt; Message-Id: &lt;<a href=3D"mailto:1598021136-49525-1-git-=
send-email-bmeng.cn@gmail.com" target=3D"_blank" rel=3D"noreferrer">1598021=
136-49525-1-git-send-email-bmeng.cn@gmail.com</a>&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D=
"mailto:f4bug@amsat.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.o=
rg</a>&gt;<br>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 hw/sd/sd.c | 3 ++-<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 1 file changed, 2 insertions(+), 1 deletion(=
-)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>
&gt; &gt;&gt;&gt; index 7c9d956f113..805e21fc883 100644<br>
&gt; &gt;&gt;&gt; --- a/hw/sd/sd.c<br>
&gt; &gt;&gt;&gt; +++ b/hw/sd/sd.c<br>
&gt; &gt;&gt;&gt; @@ -807,11 +807,12 @@ static void sd_function_switch(SDSt=
ate *sd, uint32_t arg)<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 sd-&gt;data[11] =3D 0x43;<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 sd-&gt;data[12] =3D 0x80;=C2=
=A0 =C2=A0 /* Supported group 1 functions */<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 sd-&gt;data[13] =3D 0x03;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 6; i ++) =
{<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_func =3D (ar=
g &gt;&gt; (i * 4)) &amp; 0x0f;<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mode &amp;&a=
mp; new_func !=3D 0x0f)<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sd=
-&gt;function_group[i] =3D new_func;<br>
&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sd-&gt;data[14 + (i &gt;&gt;=
 1)] =3D new_func &lt;&lt; ((i * 4) &amp; 4);<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sd-&gt;data[16 - (i &gt;&gt;=
 1)] |=3D new_func &lt;&lt; ((i % 2) * 4);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This patch broke the orangepi machine, reproducible running<b=
r>
&gt; &gt;&gt; test_arm_orangepi_bionic:<br>
&gt; &gt;&gt; <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org=
/msg739449.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://ww=
w.mail-archive.com/qemu-devel@nongnu.org/msg739449.html</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Can you have a look?<br>
&gt; &gt;<br>
&gt; &gt; Yes, I can take a look. Could you please send more details on how=
 to<br>
&gt; &gt; run &quot;test_arm_orangepi_bionic&quot;?<br>
&gt;<br>
&gt; Looking at the previous link, I think this should work:<br>
&gt;<br>
&gt; $ make check-venv qemu-system-arm<br>
&gt; $ AVOCADO_ALLOW_LARGE_STORAGE=3D1 \<br>
&gt;=C2=A0 =C2=A0 tests/venv/bin/python -m \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 avocado --show=3Dapp,console run \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 run -t machine:orangepi-pc tests/acceptance=
<br>
&gt;<br>
<br>
I tried the above command in my build tree, and got:<br>
<br>
avocado run: error: unrecognized arguments: tests/acceptance<br>
Perhaps a plugin is missing; run &#39;avocado plugins&#39; to list the inst=
alled ones<br>
<br>
I switched to `make check-acceptance` which seems to work, however not<br>
for orangepi-pc related tests?<br>
<br>
=C2=A0(09/32) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_=
arm_orangepi:<br>
SKIP: Test artifacts fetched from unreliable <a href=3D"http://apt.armbian.=
com" rel=3D"noreferrer noreferrer" target=3D"_blank">apt.armbian.com</a><br=
>
=C2=A0(10/32) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_=
arm_orangepi_initrd:<br>
SKIP: Test artifacts fetched from unreliable <a href=3D"http://apt.armbian.=
com" rel=3D"noreferrer noreferrer" target=3D"_blank">apt.armbian.com</a><br=
>
=C2=A0(11/32) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_=
arm_orangepi_sd:<br>
SKIP: Test artifacts fetched from unreliable <a href=3D"http://apt.armbian.=
com" rel=3D"noreferrer noreferrer" target=3D"_blank">apt.armbian.com</a><br=
>
=C2=A0(12/32) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_=
arm_orangepi_bionic:<br>
SKIP: storage limited<br>
=C2=A0(13/32) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_=
arm_orangepi_uboot_netbsd9:<br>
SKIP: storage limited<br>
<br>
Any ideas?<br>
<br>
Regards,<br>
Bin<br>
</blockquote></div>

--00000000000009956405b2440092--

