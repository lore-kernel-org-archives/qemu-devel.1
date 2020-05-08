Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653DDC35280
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316FF206B9
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBwsvIql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316FF206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWsUO-0007EL-Bz
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 22:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jWsTj-0006La-TB
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:11:07 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jWsTi-0005Li-Q6
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:11:07 -0400
Received: by mail-lf1-x141.google.com with SMTP id t11so188877lfe.4
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 19:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GdPk+Y7sXr+rpKHx8JS3zG6W4GNtP+tDm32LRQa9mqc=;
 b=oBwsvIqlNwkosWuX3pk89UiabGOSFtmgYbpQYZBBc1quJNhw1cR5FJpHP6OhgAfmRq
 Rz5j0d49/Ss9haR0VI1+DEVTtv4X/hTZwL9GTsDLGLwP4SU6PoG0hqCZhloWx7bpLWl4
 i2ZaRchC7j1rUnKlsTguwq54paMwUGoSk2qwX5dVHN2o45ZL/FiN2RnRU5xCYd22eCfh
 AViJ767TRhI+69+EV8uy9SO44YxkgZAq6N6nmklJa0BQmxu9SCZI7kXi/pndBOCviBIy
 uc5LjmKdRgYXYmiscvTFDVaeBE0zYN0IgeZrlNB2Ixf903t9rMsv+HNs1YKDfoQt2eZX
 n5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GdPk+Y7sXr+rpKHx8JS3zG6W4GNtP+tDm32LRQa9mqc=;
 b=Oh9ihyvET+SwI5Xz3Zjf50TvjCnc2rxoh4FI259/WdqEW5p7EYHzRi7cLlx4aLDf/7
 snHvc72kluZizt0f4uTdBQ+qi+F3IjdmMtg4k809x04fATkm4R+NxFG884HxGekV15fL
 i1mNREnLSUAC7RbvbQv/aujLwX2HUxQjvJ+30her1LizRmZ+Cd/gRBMeJcOCNOR5rjiL
 wmCXLFa3gJJSJTDCZarR6evQW2ep1VXW5vVzM7DPM3op5h2LVlalwgLJkyADRirQbCo+
 hxzDIRc5kNIqWkv1F+YJ5alAqNOkSeC0q6IXEXPDj8B2MTR8oRQJ2MQF7fwTFjQLchgr
 s+BQ==
X-Gm-Message-State: AOAM530gKKrz5PuQ6oF/UlL358dOy8YTkMhrNttNp3OQVLQtuKs/iiNj
 FG1PebZcZi4iK2BD+PTYgLfEDm6WJLz/oWj4TbQ=
X-Google-Smtp-Source: ABdhPJxK6GngJAcxNeBW85vJ6YzL6+kbmRh0nnS93oluHUe+g1xLIcebLDbbqeVOM+JQumqE9sduQr4+LQIeDfiBSCw=
X-Received: by 2002:a19:4f02:: with SMTP id d2mr272229lfb.180.1588903865094;
 Thu, 07 May 2020 19:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPV47zdeH0+G85De2nOeD-dw91PKqPZh0U4SZuwuFmdqRyhXjQ@mail.gmail.com>
 <d418f253-1749-8d29-c228-0c69c2cec3a7@redhat.com>
In-Reply-To: <d418f253-1749-8d29-c228-0c69c2cec3a7@redhat.com>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Fri, 8 May 2020 07:40:53 +0530
Message-ID: <CAPV47zdA3YR7Dn6h27Lsu1Hm9nkaZ44+zDZtX98eAU_T7enT9g@mail.gmail.com>
Subject: Re: Parameter 'driver' expects pluggable device type
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000076151c05a51982da"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=priyamvad.agnisys@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000076151c05a51982da
Content-Type: text/plain; charset="UTF-8"

 Hi,
Thanks for providing relevant information.
FYI
I am using Qemu version *4.2.94 (v5.0.0-rc4-dirty).*
I am using *virt* board.

Where we need to set *user creatable *to true?
Any other modification is needed to allow sysbus device support?

Below is the script which I am using  to boot linux image with pl061 device
on virt board.

#!/bin/bash
>
> KERNEL="/lhome/priyamvad/debian_qemu_arm32/vmlinuz-3.16.0-6-armmp-lpae"
>
> INIT_IMAGE="/lhome/priyamvad/debian_qemu_arm32/initrd.img-3.16.0-6-armmp-lpae"
> DISK="/lhome/priyamvad/debian_qemu_arm32/hda30.qcow2"
>
> ./qemu-system-arm \
> -M virt \
> -m 1024 \
> -smp 4 \
> -kernel $KERNEL \
> -object rng-random,filename=/dev/urandom,id=rng0 \
> -device virtio-rng-device,rng=rng0 \
> -initrd $INIT_IMAGE \
> -append 'root=/dev/vda2' \
> -drive if=none,file=$DISK,format=qcow2,id=hd \
> -device pl061 \
> -device virtio-blk-device,drive=hd \
> -device virtio-net-device,netdev=usernet \
> -netdev user,id=usernet,hostfwd=tcp::2222-:22 \
> -nographic
>

Is the above script  correct  to boot linux image with pl061 device on virt
board?

On Fri, 8 May 2020 at 02:32, John Snow <jsnow@redhat.com> wrote:

>
>
> On 5/6/20 8:56 AM, Priyamvad Acharya wrote:
> >
> > Hello developer community,
> > I want to allow a *sysbus *type device to boot with kernel image(arm
> > architecture) via Qemu command line .
> >
> > When I run qemu arm system executable with *-device *option via qemu
> > command line,I get following error message
> >
> >> qemu-system-arm: -device pl061: Parameter 'driver' expects pluggable
> > device type
> >
> > So, how to allow a sysbus device via command line?
> > Is there any working patch?
>
> Hi, it looks like the pl061 device is not declared "user creatable" so
> it is unavailable from the CLI. As a sysbus device, QEMU is not aware,
> in the abstract, of how to "connect" the device to other devices.
>
> See the sysbus class initialization code for more detail:
> https://github.com/qemu/qemu/blob/master/hw/core/sysbus.c#L301
>
>
> However, It looks like these boards/devices create such a device:
>
> hw/arm/highbank
> hw/arm/realview
> hw/arm/sbsa-ref
> hw/arm/stellaris
> hw/arm/versatilepb
> hw/arm/virt
>
> If you want one on some other kind of machine, you'll need to write it
> up yourself in the machine board code, but you didn't tell us what
> version of QEMU you're using, what machine type you are trying to use, etc.
>
> --js
>
>

--00000000000076151c05a51982da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<div>Hi,</div><div>Thanks for providing relevant information.</div><div>FYI=
</div><div>I am using Qemu version <b>4.2.94 (v5.0.0-rc4-dirty).</b></div><=
div>I am using <b>virt</b> board.</div><div><br></div><div>Where we need to=
 set <b>user creatable </b>to true?</div><div>Any other modification is nee=
ded to allow sysbus device support?</div><div><br></div><div>Below is the s=
cript which I am using=C2=A0 to boot linux image with pl061 device on virt =
board.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div>#!/bin/bash<br><br>KERNEL=3D&quot;/lhome/priyamvad/debian_qemu_arm32=
/vmlinuz-3.16.0-6-armmp-lpae&quot;<br>INIT_IMAGE=3D&quot;/lhome/priyamvad/d=
ebian_qemu_arm32/initrd.img-3.16.0-6-armmp-lpae&quot;<br>DISK=3D&quot;/lhom=
e/priyamvad/debian_qemu_arm32/hda30.qcow2&quot;<br><br>./qemu-system-arm \<=
br>	-M virt \<br>	-m 1024 \<br>	-smp 4 \<br>	-kernel $KERNEL \<br>	-object =
rng-random,filename=3D/dev/urandom,id=3Drng0 \<br>	-device virtio-rng-devic=
e,rng=3Drng0 \<br>	-initrd $INIT_IMAGE \<br>	-append &#39;root=3D/dev/vda2&=
#39; \<br>	-drive if=3Dnone,file=3D$DISK,format=3Dqcow2,id=3Dhd \<br>	-devi=
ce pl061 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>	-device virtio-blk-device,drive=3Dh=
d \<br>	-device virtio-net-device,netdev=3Dusernet \<br>	-netdev user,id=3D=
usernet,hostfwd=3Dtcp::2222-:22 \<br>	-nographic<br></div></blockquote><div=
><br></div><div>Is the above script=C2=A0=20
correct=C2=A0 to boot linux image with pl061 device on virt board?

</div><div class=3D"gmail-yj6qo gmail-ajU"><div id=3D"gmail-:1xb" class=3D"=
gmail-ajR" tabindex=3D"0"><img class=3D"gmail-ajT" src=3D"https://ssl.gstat=
ic.com/ui/v1/icons/mail/images/cleardot.gif"></div></div>

</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Fri, 8 May 2020 at 02:32, John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om">jsnow@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><br>
<br>
On 5/6/20 8:56 AM, Priyamvad Acharya wrote:<br>
&gt; <br>
&gt; Hello developer community,<br>
&gt; I want to allow a *sysbus *type device to boot with kernel image(arm<b=
r>
&gt; architecture) via Qemu command line .<br>
&gt; <br>
&gt; When I run qemu arm system executable with *-device *option via qemu<b=
r>
&gt; command line,I get following error message<br>
&gt; <br>
&gt;&gt; qemu-system-arm: -device pl061: Parameter &#39;driver&#39; expects=
 pluggable<br>
&gt; device type<br>
&gt; <br>
&gt; So, how to allow a sysbus device via command line?<br>
&gt; Is there any working patch?<br>
<br>
Hi, it looks like the pl061 device is not declared &quot;user creatable&quo=
t; so<br>
it is unavailable from the CLI. As a sysbus device, QEMU is not aware,<br>
in the abstract, of how to &quot;connect&quot; the device to other devices.=
<br>
<br>
See the sysbus class initialization code for more detail:<br>
<a href=3D"https://github.com/qemu/qemu/blob/master/hw/core/sysbus.c#L301" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/qemu/qemu/blob/mast=
er/hw/core/sysbus.c#L301</a><br>
<br>
<br>
However, It looks like these boards/devices create such a device:<br>
<br>
hw/arm/highbank<br>
hw/arm/realview<br>
hw/arm/sbsa-ref<br>
hw/arm/stellaris<br>
hw/arm/versatilepb<br>
hw/arm/virt<br>
<br>
If you want one on some other kind of machine, you&#39;ll need to write it<=
br>
up yourself in the machine board code, but you didn&#39;t tell us what<br>
version of QEMU you&#39;re using, what machine type you are trying to use, =
etc.<br>
<br>
--js<br>
<br>
</blockquote></div>

--00000000000076151c05a51982da--

