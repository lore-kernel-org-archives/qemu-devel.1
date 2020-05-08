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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A27C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC76206B9
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNAOYMSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC76206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWsSK-0004gf-WB
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 22:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jWsRn-0004I5-4M
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:09:07 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:34279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jWsRl-0007HJ-Tn
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:09:06 -0400
Received: by mail-lj1-x243.google.com with SMTP id f11so25050ljp.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 19:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4JX2CguDDJl9WQNK9lPvg2yUGcHHhh1EKNvF+1dss3A=;
 b=XNAOYMSHzwOmmXQR6E1oID7mFO1UICndjqZ1Z4U7zj+XloGWLUQUNJyYc1qKO2vv3W
 av2lneWIaWv5Z30PN3V2YKBQS86x+480LbJWxLD2jW+RzKYKnCr6NnbdMzU8W1IY/lvq
 thK6CrXlSMhKV/DdYDKbqV+wyleE2TOIrihswbsxbuthy4yRg42IhYsZEeMxfaxwHGBH
 DiwuQA9RpjG4N4xST3ta4h1ysa98C1hY78gP77G5Eey6yJEW4yTXSaIylDK6/cHB6zgl
 99een0tonrRRf7xPDTh48XTeS8/3MH4OS/0shMolvsVQbcYvmL2/+7ygPaKyE4BpFlGR
 hLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4JX2CguDDJl9WQNK9lPvg2yUGcHHhh1EKNvF+1dss3A=;
 b=tqnYCVxPXgaPY7WzXyCFVYF6ccqZiPDzxqiyZFneu04/h4XqyEKhdxMFzI5yAVgpLL
 zw1FR6EVuWlxvkBhom53/HvSvmpCVYeHjTBMMVYRCQ2ucWUlbeBF5Aak7g2FvoyqmyXb
 xthVJ0gtz0wimjMu/WcrUAbNP3Wa2lKwMRcMdQZFU1D8Lx+WwlipLnnBVXFnO6XWeDTc
 pqNzhCm49if3/Gx0OUiLeZzAYbehGOkTdcy+W8S7sFHPgD6H4hq3SFwSUTggvJOVS+PH
 xPEnFdFmHxSkp5Nc4ApA73Z0fPILYKFkTvBuLNqKQA8JsOLpKcP0j4Ag/PRnuaWGagmT
 Xvyw==
X-Gm-Message-State: AOAM533xnjRibJoh9v9kabMOdkFnbVs7LHDvLBsXqLUpUdzRxCfWzwsm
 1QMsx57omCWLQmBFXfKgRZr5K85MTZJlsPsozTg=
X-Google-Smtp-Source: ABdhPJxsRIZD/1Q+DD3EtOWnmt/MriXqsV9vuPUl3urGPkDsQP2bBs4Gcd8EgjJD89zz7rBVY7O5PPAQ5rjq2J62BVI=
X-Received: by 2002:a2e:a556:: with SMTP id e22mr90162ljn.130.1588903742930;
 Thu, 07 May 2020 19:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAPV47zdeH0+G85De2nOeD-dw91PKqPZh0U4SZuwuFmdqRyhXjQ@mail.gmail.com>
 <d418f253-1749-8d29-c228-0c69c2cec3a7@redhat.com>
In-Reply-To: <d418f253-1749-8d29-c228-0c69c2cec3a7@redhat.com>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Fri, 8 May 2020 07:38:51 +0530
Message-ID: <CAPV47zfy84NGNo-Zy=XB62p2jFpNGziHXJ9qK78UYoB5hHgD7g@mail.gmail.com>
Subject: Re: Parameter 'driver' expects pluggable device type
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002e027005a5197bf8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=priyamvad.agnisys@gmail.com; helo=mail-lj1-x243.google.com
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

--0000000000002e027005a5197bf8
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

Is this script  to boot linux image with pl061 device on virt board?


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

--0000000000002e027005a5197bf8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>Thanks for providing relevant informati=
on.</div><div>FYI</div><div>I am using Qemu version <b>4.2.94 (v5.0.0-rc4-d=
irty).</b></div><div>I am using <b>virt</b> board.</div><div><br></div><div=
>Where we need to set <b>user creatable </b>to true?</div><div>Any other mo=
dification is needed to allow sysbus device support?</div><div><br></div><d=
iv>Below is the script which I am using=C2=A0 to boot linux image with pl06=
1 device on virt board.</div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div>#!/bin/bash<br><br>KERNEL=3D&quot;/lhome/priyamvad/=
debian_qemu_arm32/vmlinuz-3.16.0-6-armmp-lpae&quot;<br>INIT_IMAGE=3D&quot;/=
lhome/priyamvad/debian_qemu_arm32/initrd.img-3.16.0-6-armmp-lpae&quot;<br>D=
ISK=3D&quot;/lhome/priyamvad/debian_qemu_arm32/hda30.qcow2&quot;<br><br>./q=
emu-system-arm \<br>	-M virt \<br>	-m 1024 \<br>	-smp 4 \<br>	-kernel $KERN=
EL \<br>	-object rng-random,filename=3D/dev/urandom,id=3Drng0 \<br>	-device=
 virtio-rng-device,rng=3Drng0 \<br>	-initrd $INIT_IMAGE \<br>	-append &#39;=
root=3D/dev/vda2&#39; \<br>	-drive if=3Dnone,file=3D$DISK,format=3Dqcow2,id=
=3Dhd \<br>	-device pl061 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>	-device virtio-bl=
k-device,drive=3Dhd \<br>	-device virtio-net-device,netdev=3Dusernet \<br>	=
-netdev user,id=3Dusernet,hostfwd=3Dtcp::2222-:22 \<br>	-nographic<br></div=
></blockquote><div><br></div><div>Is this script=C2=A0=20
 to boot linux image with pl061 device on virt board?

</div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, 8 May 2020 at 02:32, John Snow &lt;<a href=3D"=
mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
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

--0000000000002e027005a5197bf8--

