Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47668C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131EB20722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV7jDCFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131EB20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4p4W-00088v-9H
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1j4p3o-0007fr-Vz
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1j4p3n-0002Ns-EE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:52:24 -0500
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:37176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1j4p3n-0002Ne-0I
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:52:23 -0500
Received: by mail-io1-xd36.google.com with SMTP id k24so5437486ioc.4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tVLgbzHeasbFUDtOJGhYe/XLG1cQC5s5dwRZ14ycfAA=;
 b=lV7jDCFZOxITHf6zfQlesoU+JfKJvw2jdxDSesOj98vie9fi0ZN1KpEUesiMkW9Kgg
 N0gNwAKYkYSNRmD6gSQIhPsm8nHMhWnhV8xtcocOc+aBNx0qcktcwIZ4EIIADS2HoeCb
 wVHsd8VUDTRddCSwbvFI1BK5p55d8hu3VCy0h8uK40cBRQDJgj6BwFE81XLz6NOctBY6
 Gn+GrOCNH9NsYs65o2WY+KyUiwp42S7WcSpPnfvQA5Fa49gfVvxtr6aBU2a042+dm7JF
 EXjM+Qrn0ApJYQWESIG9GWoq81MPlmcHZDHy5rcbkeZZmE0PgPdG0upMzMMPBAqsrWJa
 ykNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tVLgbzHeasbFUDtOJGhYe/XLG1cQC5s5dwRZ14ycfAA=;
 b=TG4SJdd83iUj7oVEub+qejUIUiNBlHNYZzGQ1VBxrDv5FGar02PSxBRdzJBqL4PJNJ
 OBQeuUHOAaAyLw7EazPvnA3iiug2YR9e6AOZat1Mc5iuzbldLvMb35RKQb+cDcQa8sxt
 kHayD6FGbEhrNSOppYRA42Fo8r6iPpqWOUiqvWDyGOBUDQEuj3xme8S5sb3quxZs0AMT
 6PfMiY24oXCMJj+d+liRJ7Ld7O0nCp/VpjCCrH22W5+/oBEvEq9qOMrljNsuuoQt+31/
 K0XSojQFe8Y7najVbg2+vNqd9cHUm+J5upUhxJ7g+1Xl7nz5je7cPT9khjdbzWHS+si0
 mXvA==
X-Gm-Message-State: APjAAAWb1k8S0ZKKLUsdrZ6j1oCifIXWogdSSdhcgn4aGQnAnYF9iOh3
 UbSuOBOEIzOk5892clm2DujlMDtXIS43qQncbufKfw==
X-Google-Smtp-Source: APXvYqxBDm0cOoOdODGzhN59eS06a++lP7gPh3bKuuD4i2kKVDaO+ZH4BI7YAssaDdg0rNR+1G2YCXkDItOpSPSQoAE=
X-Received: by 2002:a6b:17c4:: with SMTP id 187mr19966384iox.143.1582217541980; 
 Thu, 20 Feb 2020 08:52:21 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0npCdHfCeMCKO9TX_ifQGDZFFNyMEKH2qByYL9SnXnaPmw@mail.gmail.com>
 <CAFEAcA_A5J-j2cZN98j_9G49PAMauHGF47QBoeMK8y_RbMp5FA@mail.gmail.com>
In-Reply-To: <CAFEAcA_A5J-j2cZN98j_9G49PAMauHGF47QBoeMK8y_RbMp5FA@mail.gmail.com>
From: Wayne Li <waynli329@gmail.com>
Date: Thu, 20 Feb 2020 10:52:10 -0600
Message-ID: <CAM2K0npAa50r=_Kf9u3PRbw=E5WhMxO7z9fKw5zvhUgbVtxXsQ@mail.gmail.com>
Subject: Re:
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008c1517059f04ba30"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008c1517059f04ba30
Content-Type: text/plain; charset="UTF-8"

Thanks for the KVM_RUN explanation, that makes a lot of sense.  Though I'm
pretty sure I'm getting the live program counter value because I use the
"info registers" command in QEMU monitor and that calls
kvm_cpu_synchronize_state().  And also to be more sure, I added a few
assembly instructions into the kernel code that stored a value that
constantly incremented and the program counter into two general purpose
registers.  I was able to see both of these in QEMU monitor so the program
counter must actually be stuck at 0xfffffffc.

On Thu, Feb 20, 2020 at 3:57 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 20 Feb 2020 at 05:41, Wayne Li <waynli329@gmail.com> wrote:
> > Also, I do have another side question.  When running with KVM enabled, I
> >see the kernel-level ioctl call KVM_RUN running and then returning over
> >and over again (by the way before the VM kinda grinds to a halt I only see
> >QEMU make the KVM_RUN call twice, but the kernel-level ioctl function
> >is being called over and over again for some reason).  And each time the
> >KVM_RUN call returns, the return-from-interrupt takes the VM to the
> >address 0xFFFFFFFC.  What is the KVM_RUN ioctl call used for?  Why
> >is it being called over and over again?  Maybe if I understood this better
> >I'd be able to figure out what's stopping my program counter from
> incrementing.
>
> KVM_RUN is the ioctl which QEMU uses to tell the kernel "hey, please
> start running the guest". The kernel will not return control to QEMU
> (ie the syscall will not return) until something happens that needs
> QEMU's intervention, of which the main one is "guest made a device
> access that QEMU must handle". (You can see this run loop in
> accel/kvm/kvm-all.c:kvm_cpu_exec()). So in normal operation,
> QEMU will do a bunch of setup, and then call KVM_RUN, which
> will cause the guest to run, probably for quite a long time. The
> ioctl will return when the guest does some IO a QEMU-provided
> device, and QEMU will then do that device emulation, set up the
> kvm_run struct fields to hold the results of the device access,
> and call KVM_RUN again. The cycle continues like this until the
> VM is shut down. If the guest goes into an infinite loop, you
> should expect that KVM_RUN will never return, as there's never
> any need for the kernel to ask QEMU to do anything.
>
> Also important to note: before we call KVM_RUN we push
> the CPU register state up to the kernel (using various arch-specific
> ioctls), and after that the 'live copy' of the data is in the kernel,
> and values in the CPU state struct in QEMU are stale. We only
> get the up to date data out of the kernel when we need it, by
> calling kvm_cpu_synchronize_state(). So if your 0xfffffffc value
> comes from the CPU state struct and you're reading it at a
> point before the state has been synchronized back from the
> kernel it's not going to be the actual PC value.
>
> The KVM kernel API is comparatively well documented at
> https://www.kernel.org/doc/html/latest/virt/kvm/api.html
> though the section on KVM_RUN is pretty weak.
>
> thanks
> -- PMM
>

--0000000000008c1517059f04ba30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for the KVM_RUN explanation, that makes a lot =
of sense.=C2=A0 Though I&#39;m pretty sure I&#39;m getting the live program=
 counter value because I use the &quot;info registers&quot; command in QEMU=
 monitor and that calls kvm_cpu_synchronize_state().=C2=A0 And also to be m=
ore sure, I added a few assembly instructions into the kernel code that sto=
red a value that constantly incremented and the program counter into two ge=
neral purpose registers.=C2=A0 I was able to see both of these in QEMU moni=
tor so the program counter must actually be stuck at 0xfffffffc.<br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Thu, Feb 20, 2020 at 3:57 AM Peter Maydell &lt;<a href=3D"mailto:peter.ma=
ydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">On Thu, 20 Feb 2020 at 05:41, Way=
ne Li &lt;<a href=3D"mailto:waynli329@gmail.com" target=3D"_blank">waynli32=
9@gmail.com</a>&gt; wrote:<br>
&gt; Also, I do have another side question.=C2=A0 When running with KVM ena=
bled, I<br>
&gt;see the kernel-level ioctl call KVM_RUN running and then returning over=
<br>
&gt;and over again (by the way before the VM kinda grinds to a halt I only =
see<br>
&gt;QEMU make the KVM_RUN call twice, but the kernel-level ioctl function<b=
r>
&gt;is being called over and over again for some reason).=C2=A0 And each ti=
me the<br>
&gt;KVM_RUN call returns, the return-from-interrupt takes the VM to the<br>
&gt;address 0xFFFFFFFC.=C2=A0 What is the KVM_RUN ioctl call used for?=C2=
=A0 Why<br>
&gt;is it being called over and over again?=C2=A0 Maybe if I understood thi=
s better<br>
&gt;I&#39;d be able to figure out what&#39;s stopping my program counter fr=
om incrementing.<br>
<br>
KVM_RUN is the ioctl which QEMU uses to tell the kernel &quot;hey, please<b=
r>
start running the guest&quot;. The kernel will not return control to QEMU<b=
r>
(ie the syscall will not return) until something happens that needs<br>
QEMU&#39;s intervention, of which the main one is &quot;guest made a device=
<br>
access that QEMU must handle&quot;. (You can see this run loop in<br>
accel/kvm/kvm-all.c:kvm_cpu_exec()). So in normal operation,<br>
QEMU will do a bunch of setup, and then call KVM_RUN, which<br>
will cause the guest to run, probably for quite a long time. The<br>
ioctl will return when the guest does some IO a QEMU-provided<br>
device, and QEMU will then do that device emulation, set up the<br>
kvm_run struct fields to hold the results of the device access,<br>
and call KVM_RUN again. The cycle continues like this until the<br>
VM is shut down. If the guest goes into an infinite loop, you<br>
should expect that KVM_RUN will never return, as there&#39;s never<br>
any need for the kernel to ask QEMU to do anything.<br>
<br>
Also important to note: before we call KVM_RUN we push<br>
the CPU register state up to the kernel (using various arch-specific<br>
ioctls), and after that the &#39;live copy&#39; of the data is in the kerne=
l,<br>
and values in the CPU state struct in QEMU are stale. We only<br>
get the up to date data out of the kernel when we need it, by<br>
calling kvm_cpu_synchronize_state(). So if your 0xfffffffc value<br>
comes from the CPU state struct and you&#39;re reading it at a<br>
point before the state has been synchronized back from the<br>
kernel it&#39;s not going to be the actual PC value.<br>
<br>
The KVM kernel API is comparatively well documented at<br>
<a href=3D"https://www.kernel.org/doc/html/latest/virt/kvm/api.html" rel=3D=
"noreferrer" target=3D"_blank">https://www.kernel.org/doc/html/latest/virt/=
kvm/api.html</a><br>
though the section on KVM_RUN is pretty weak.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000008c1517059f04ba30--

