Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB0B2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn0fIrvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB0B2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxSO-0004K3-I4
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1iMwxD-0008BP-5u
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1iMwxB-0007sS-M5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:24:14 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:44672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>)
 id 1iMwxB-0007s3-EU; Tue, 22 Oct 2019 12:24:13 -0400
Received: by mail-io1-xd36.google.com with SMTP id w12so21135437iol.11;
 Tue, 22 Oct 2019 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IKWy2JNNnML03tcUFencM8Io2YQ0SeSVlmF6S3be4xE=;
 b=Kn0fIrvI3qvN43BGZDC1Z1X7ObqPmJTtsnHoqeNE/hfTFAI5vlupSdAkPyaVBgQXJk
 N3IGOQ9X8oT5Dt2F0E/n+wIYZ1iaq+Ug/8Kxy309ZCGkGqwdJ+uCxaElvOnXyoujDt4b
 wzJJxsig3wlOpqf98k/cXt1eL7IMmfPUCvaYsMZW81cbjUrsJOYSMi343sReIeOUHmR8
 RziDY+khqrQAUnqvbFp3xNQydSnX93CLZOSxc05wpmjul5aG2dN81zZQziNuWqAa+y2s
 3BMRtjZwzSXho97Ut8/nvHu7M2YAGl8981Xi+k8RaF3BzyyEpnneetgHnCVWXMzhjcCy
 7eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IKWy2JNNnML03tcUFencM8Io2YQ0SeSVlmF6S3be4xE=;
 b=plcWC40lkmWpAVegRDniyTo0XCMPFlKRZarrbaiOMMXTbDkHZg0GY8zV7sJI4Y8q3n
 F+L3N+ATNxo4W7kZ5XF6N4N+Lmk4UdNk5TfRHNRwvc/SGwtcwGZZPAJ2/DAATjZ/exL+
 u/g69Li3fOgBz5piWzEr+vjLenMt8fMx7k+L5aFnZmDJBwgcLeBLAwJPl/B/x5HuVqzu
 RzX2dDgAF+hbWSFQJlBfYqBkVE2V07b/z3NQw1ltr4fJFxTIAtlHg1nXDeIKtyoy0HaH
 eeOMsHTm4UVKbIypirrWX3c1X5yL3G2464Lprew0I8DttXsaAKFwjQchzuwoo9YVSv1d
 AYbA==
X-Gm-Message-State: APjAAAW8SpoVEQv5lh7RXtEhMbxS2GsekDAFf64SZU6o8wA5dvwrnWM4
 pUAWoKlgzmZaj4CQI2YV440XE9wEB7izjdr8fNB9o5Nl
X-Google-Smtp-Source: APXvYqzDKT3shDxyj79hHOYMssGEo3/WUR+VEH+lKfurW5K9jsZ1b2T9GFUFplWNFAnoOiuctKEpWxbBZc06k9SAqew=
X-Received: by 2002:a02:741a:: with SMTP id o26mr4674008jac.48.1571761452370; 
 Tue, 22 Oct 2019 09:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2K0np63wni3G7GNWPxTq40Kb1VeTN7Ocn=E=BqSmd+pDsX9A@mail.gmail.com>
 <7e2a821c-ed6b-ccb1-f517-405359358a26@redhat.com>
In-Reply-To: <7e2a821c-ed6b-ccb1-f517-405359358a26@redhat.com>
From: Wayne Li <waynli329@gmail.com>
Date: Tue, 22 Oct 2019 11:24:00 -0500
Message-ID: <CAM2K0nox06JcmjfM20G1-p2Vwq5Xb7hRAX0DVBfdCepnqUiZQg@mail.gmail.com>
Subject: Re: Missing PVR setting capability
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000a52690595823bb5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d36
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000a52690595823bb5
Content-Type: text/plain; charset="UTF-8"

If I run "lsmod | grep kvm" nothing shows up but if I just do a "find .
-name "kvm"" I get the following:

./usr/src/kernel/Documentation/virtual/kvm
./usr/src/kernel/arch/arm/kvm
./usr/src/kernel/arch/arm64/kvm
./usr/src/kernel/arch/mips/kvm
./usr/src/kernel/arch/powerpc/kvm
./usr/src/kernel/arch/s390/kvm
./usr/src/kernel/arch/tile/kvm
./usr/src/kernel/arch/x86/kvm
./usr/src/kernel/drivers/s390/kvm
./usr/src/kernel/include/config/kvm
./usr/src/kernel/include/config/have/kvm
./usr/src/kernel/include/kvm
./usr/src/kernel/virt/kvm
./dev/kvm
./sys/devices/virtual/misc/kvm
./sys/class/misc/kvm
./sys/kernel/debug/kvm
./sys/module/kvm

I guess this shows my OS does have KVM on it?  I added the two flags you
mentioned when running QEMU (the -cpu and the -machine flags) but the -cpu
flag doesn't seem like it's doing anything as even when I put a clearly
wrong argument after the flag no error related to the cpu is thrown.  Also
it says ppce500 is not a machine type and that the supported machines are:

bamboo               bamboo
boeing-machine       Boeing Machine
none                 empty machine
ref405ep             ref405ep
taihu                taihu
virtex-ml507         Xilinx Virtex ML507 reference design

The one being used right now is boeing-machine which is clearly specific to
the project I am working on.  I'm not exactly sure what boeing-machine
refers to but I'll ask the person who wrote the code that specified that
machine,

On Tue, Oct 22, 2019 at 2:04 AM Thomas Huth <thuth@redhat.com> wrote:

> On 21/10/2019 23.06, Wayne Li wrote:
> > Dear Qemu list members,
> >
> > I'm attempting to enable KVM in a Qemu-based project that is running on
> > a T4240RDB board.  After compiling my code with the -enable-kvm option I
> > ran the qemu executable with the -enable-kvm option.  The application
> > exited with the following error message: "kvm error: missing PVR setting
> > capability."  What are some possibilities causing this error?
>
> That's an e6500 bas PPC board, isn't it? ... I guess nobody has been
> running KVM on such a system in a while...
>
> What do you get when running "lsmod | grep kvm" ? How did you run QEMU?
> I think you have to make sure to run with the right CPU model ("-cpu
> e6500") and machine (likely "-M ppce500" ?).
>
>  Thomas
>
>

--0000000000000a52690595823bb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">If I run &quot;lsmod | grep kvm&quot; nothing shows up but=
 if I just do a &quot;find . -name &quot;kvm&quot;&quot; I get the followin=
g:<div><br></div><div>./usr/src/kernel/Documentation/virtual/kvm<br>./usr/s=
rc/kernel/arch/arm/kvm<br>./usr/src/kernel/arch/arm64/kvm<br>./usr/src/kern=
el/arch/mips/kvm<br>./usr/src/kernel/arch/powerpc/kvm<br>./usr/src/kernel/a=
rch/s390/kvm<br>./usr/src/kernel/arch/tile/kvm<br>./usr/src/kernel/arch/x86=
/kvm<br>./usr/src/kernel/drivers/s390/kvm<br>./usr/src/kernel/include/confi=
g/kvm<br>./usr/src/kernel/include/config/have/kvm<br>./usr/src/kernel/inclu=
de/kvm<br>./usr/src/kernel/virt/kvm<br>./dev/kvm</div><div>./sys/devices/vi=
rtual/misc/kvm<br>./sys/class/misc/kvm<br>./sys/kernel/debug/kvm<br>./sys/m=
odule/kvm<br></div><div><br></div><div>I guess this shows my OS does have K=
VM on it?=C2=A0 I added the two flags you mentioned when running QEMU (the =
-cpu and the -machine flags) but the -cpu flag doesn&#39;t seem like it&#39=
;s doing anything as even when I put a clearly wrong argument after the fla=
g no error related to the cpu is thrown.=C2=A0 Also it says ppce500 is not =
a machine type and that the supported machines are:</div><div><br></div><di=
v>bamboo =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bamboo<br>boeing-=
machine =C2=A0 =C2=A0 =C2=A0 Boeing Machine<br>none =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 empty machine<br>ref405ep =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ref405ep<br>taihu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0taihu<br>virtex-ml507 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Xilinx Virtex ML507 reference design<br></div><div><br></div><div>The o=
ne being used right now is boeing-machine which is clearly specific to the =
project I am working on.=C2=A0 I&#39;m not exactly sure what boeing-machine=
 refers to but I&#39;ll ask the person who wrote the code that specified th=
at machine,</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Tue, Oct 22, 2019 at 2:04 AM Thomas Huth &lt;<a href=3D=
"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">On 21/10/2019 23.06, Wayne Li wro=
te:<br>
&gt; Dear Qemu list members,<br>
&gt; <br>
&gt; I&#39;m attempting to enable KVM in a Qemu-based project that is runni=
ng on<br>
&gt; a T4240RDB board.=C2=A0 After compiling my code with the -enable-kvm o=
ption I<br>
&gt; ran the qemu executable with the -enable-kvm option.=C2=A0 The applica=
tion<br>
&gt; exited with the following error message: &quot;kvm error: missing PVR =
setting<br>
&gt; capability.&quot;=C2=A0 What are some possibilities causing this error=
?<br>
<br>
That&#39;s an e6500 bas PPC board, isn&#39;t it? ... I guess nobody has bee=
n<br>
running KVM on such a system in a while...<br>
<br>
What do you get when running &quot;lsmod | grep kvm&quot; ? How did you run=
 QEMU?<br>
I think you have to make sure to run with the right CPU model (&quot;-cpu<b=
r>
e6500&quot;) and machine (likely &quot;-M ppce500&quot; ?).<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div>

--0000000000000a52690595823bb5--

