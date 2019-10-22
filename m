Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A3ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31562084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khu5mRZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31562084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxhi-0006UJ-T4
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1iMx11-0005Vn-QL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1iMx0z-0000zW-W4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:28:11 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:43840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>)
 id 1iMx0z-0000zO-Qw; Tue, 22 Oct 2019 12:28:09 -0400
Received: by mail-io1-xd33.google.com with SMTP id c11so12090250iom.10;
 Tue, 22 Oct 2019 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L5P1GvfwZvWXeVc9gT7XM9XjwTFzNjPpDh72su7n6fs=;
 b=khu5mRZ3JSOi7fHrQ6MT6cxKHIShDvfK5modgvPzQ7W9kHe+2vs710QGw/lwHyvifP
 9pDpvBELuFiPTrtnZ1ibMB75Pn+40ypGUZPn9UDQ+wxI3gwfAKXNz/QPc1lwcVZ3nYgM
 7vLYLCXjTFad+vI9Mf5+oNelrVrPvY7j5u7M3YO/pLe44hU7qYYFFFEsNwxQMf1zyDh3
 IxQjzZT0q0OA88y/l3Ssnc9aVe5HVpf56koEqMRWKcIg7+YEItFiotLyC4ANnFG/O8Bk
 PMVPgLKtEJSrSAZdLtwY5zzPbCV/XTn0+wfWYBi7bB7G3iu7mzUWFhYbtdKDNxMeqZBv
 +HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L5P1GvfwZvWXeVc9gT7XM9XjwTFzNjPpDh72su7n6fs=;
 b=l7XAeb55uSsh0kbvuWNc1X3jzJcmoxEzokFn2QNz/7DC18dz1ycrecpon00OCaytIZ
 hKfAkxFP+FUgw2ASMgoWm0Q9Da/PvZcEPviHQw0lyY9Xj/M5PFFJPNamhCwy+3LdoR4K
 +h+MWQDHcbgA76pGWfkm3WBbRYyy8REQrgg/W1zIz8xkTjStwbaZ074afxDIlFEfvUzd
 nStc+2B/XkdzK8F9lH3DcaVN5QI46SPPAH8Sx+YQrz4PKZd3JnDPcMjT083e9y8YxiJ9
 MzZ4YKTfCJ9MzIZpk8CarWScWtZvYEEKCa6hplwwfe08ezyj/2LRUsfa0vBxJL2T1nk6
 uPCg==
X-Gm-Message-State: APjAAAUrW/molEnspxFsedUB1tINbjMNabxrYXMHIHX6zqts455hKiwp
 XTJSimgv7bJTmQjoX48YMIyWQGqSRUBkbPQuJQ8=
X-Google-Smtp-Source: APXvYqzQrgZA9qBqJ4av4QFEucVuPNy4dY2aHIWdmyFWx8WAq/6PuMDiKz8Mch45lycn9nk6d02j0nuW1gqofsCvNvY=
X-Received: by 2002:a05:6638:392:: with SMTP id
 y18mr4568527jap.98.1571761688926; 
 Tue, 22 Oct 2019 09:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2K0np63wni3G7GNWPxTq40Kb1VeTN7Ocn=E=BqSmd+pDsX9A@mail.gmail.com>
 <7e2a821c-ed6b-ccb1-f517-405359358a26@redhat.com>
 <CAM2K0nox06JcmjfM20G1-p2Vwq5Xb7hRAX0DVBfdCepnqUiZQg@mail.gmail.com>
In-Reply-To: <CAM2K0nox06JcmjfM20G1-p2Vwq5Xb7hRAX0DVBfdCepnqUiZQg@mail.gmail.com>
From: Wayne Li <waynli329@gmail.com>
Date: Tue, 22 Oct 2019 11:27:57 -0500
Message-ID: <CAM2K0nqQ3kDQBm-fgGxSEzTWVfQnkKyw4y2zceY_PHSN8Go_DQ@mail.gmail.com>
Subject: Re: Missing PVR setting capability
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000023e31c0595824964"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d33
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

--00000000000023e31c0595824964
Content-Type: text/plain; charset="UTF-8"

And yes that is correct it has the e6500 core using PowerPC.

On Tue, Oct 22, 2019 at 11:24 AM Wayne Li <waynli329@gmail.com> wrote:

> If I run "lsmod | grep kvm" nothing shows up but if I just do a "find .
> -name "kvm"" I get the following:
>
> ./usr/src/kernel/Documentation/virtual/kvm
> ./usr/src/kernel/arch/arm/kvm
> ./usr/src/kernel/arch/arm64/kvm
> ./usr/src/kernel/arch/mips/kvm
> ./usr/src/kernel/arch/powerpc/kvm
> ./usr/src/kernel/arch/s390/kvm
> ./usr/src/kernel/arch/tile/kvm
> ./usr/src/kernel/arch/x86/kvm
> ./usr/src/kernel/drivers/s390/kvm
> ./usr/src/kernel/include/config/kvm
> ./usr/src/kernel/include/config/have/kvm
> ./usr/src/kernel/include/kvm
> ./usr/src/kernel/virt/kvm
> ./dev/kvm
> ./sys/devices/virtual/misc/kvm
> ./sys/class/misc/kvm
> ./sys/kernel/debug/kvm
> ./sys/module/kvm
>
> I guess this shows my OS does have KVM on it?  I added the two flags you
> mentioned when running QEMU (the -cpu and the -machine flags) but the -cpu
> flag doesn't seem like it's doing anything as even when I put a clearly
> wrong argument after the flag no error related to the cpu is thrown.  Also
> it says ppce500 is not a machine type and that the supported machines are:
>
> bamboo               bamboo
> boeing-machine       Boeing Machine
> none                 empty machine
> ref405ep             ref405ep
> taihu                taihu
> virtex-ml507         Xilinx Virtex ML507 reference design
>
> The one being used right now is boeing-machine which is clearly specific
> to the project I am working on.  I'm not exactly sure what boeing-machine
> refers to but I'll ask the person who wrote the code that specified that
> machine,
>
> On Tue, Oct 22, 2019 at 2:04 AM Thomas Huth <thuth@redhat.com> wrote:
>
>> On 21/10/2019 23.06, Wayne Li wrote:
>> > Dear Qemu list members,
>> >
>> > I'm attempting to enable KVM in a Qemu-based project that is running on
>> > a T4240RDB board.  After compiling my code with the -enable-kvm option I
>> > ran the qemu executable with the -enable-kvm option.  The application
>> > exited with the following error message: "kvm error: missing PVR setting
>> > capability."  What are some possibilities causing this error?
>>
>> That's an e6500 bas PPC board, isn't it? ... I guess nobody has been
>> running KVM on such a system in a while...
>>
>> What do you get when running "lsmod | grep kvm" ? How did you run QEMU?
>> I think you have to make sure to run with the right CPU model ("-cpu
>> e6500") and machine (likely "-M ppce500" ?).
>>
>>  Thomas
>>
>>

--00000000000023e31c0595824964
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">And yes that is correct it has the e6500 core using PowerP=
C.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Oct 22, 2019 at 11:24 AM Wayne Li &lt;<a href=3D"mailto:waynli329=
@gmail.com">waynli329@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr">If I run &quot;lsmod | gr=
ep kvm&quot; nothing shows up but if I just do a &quot;find . -name &quot;k=
vm&quot;&quot; I get the following:<div><br></div><div>./usr/src/kernel/Doc=
umentation/virtual/kvm<br>./usr/src/kernel/arch/arm/kvm<br>./usr/src/kernel=
/arch/arm64/kvm<br>./usr/src/kernel/arch/mips/kvm<br>./usr/src/kernel/arch/=
powerpc/kvm<br>./usr/src/kernel/arch/s390/kvm<br>./usr/src/kernel/arch/tile=
/kvm<br>./usr/src/kernel/arch/x86/kvm<br>./usr/src/kernel/drivers/s390/kvm<=
br>./usr/src/kernel/include/config/kvm<br>./usr/src/kernel/include/config/h=
ave/kvm<br>./usr/src/kernel/include/kvm<br>./usr/src/kernel/virt/kvm<br>./d=
ev/kvm</div><div>./sys/devices/virtual/misc/kvm<br>./sys/class/misc/kvm<br>=
./sys/kernel/debug/kvm<br>./sys/module/kvm<br></div><div><br></div><div>I g=
uess this shows my OS does have KVM on it?=C2=A0 I added the two flags you =
mentioned when running QEMU (the -cpu and the -machine flags) but the -cpu =
flag doesn&#39;t seem like it&#39;s doing anything as even when I put a cle=
arly wrong argument after the flag no error related to the cpu is thrown.=
=C2=A0 Also it says ppce500 is not a machine type and that the supported ma=
chines are:</div><div><br></div><div>bamboo =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bamboo<br>boeing-machine =C2=A0 =C2=A0 =C2=A0 Boeing Mach=
ine<br>none =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 empty m=
achine<br>ref405ep =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref405ep<br>ta=
ihu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0taihu<br>virtex-=
ml507 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Xilinx Virtex ML507 reference design<br><=
/div><div><br></div><div>The one being used right now is boeing-machine whi=
ch is clearly specific to the project I am working on.=C2=A0 I&#39;m not ex=
actly sure what boeing-machine refers to but I&#39;ll ask the person who wr=
ote the code that specified that machine,</div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 22, 2019 at 2:04=
 AM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">t=
huth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On 21/10/2019 23.06, Wayne Li wrote:<br>
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
</blockquote></div>

--00000000000023e31c0595824964--

