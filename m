Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6253BC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2919D20656
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkBEefn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2919D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3jzZ-0000Zu-BH
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1j3jyX-0008Cf-4A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1j3jyV-0003Nj-A0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:14:28 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32]:40328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1j3jyV-0003NJ-3p
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:14:27 -0500
Received: by mail-io1-xd32.google.com with SMTP id x1so7766988iop.7
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 09:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=0R1rdZy0XMpKUprpj8+UF8D/9azDIy+dnA831txcyBY=;
 b=OkBEefn5AZ6YMsvp1Ym+rpIH7LSc0pQCROGhM7r5FUlcfx/fRsvasHNol6YDyf6HuF
 Q12Vjb1VVtYGDN2w5kPPHb7woQw3Nks9PtXtthCsq71h6nVTw6Pid9XvapzAgqHlGam3
 ZAdryGQ5vXGrTDBVX7wfX28NPENKeKVgvO5laXBoEiaHE34xZIGRqtqG2Y8vmBsbKxQW
 ofIEKaXTNRScAFXK5BgKvKV+f+GulrVYbWwlORw7cRz/gKwQRyMe5cb3ofEIhTOC4CzR
 h2aFp0sDoIOSvhXNSG73HmNJgSLEDm1Kt1cqGlWhosW4Bes4YfpgM4WnaX+4z8vXO6Pq
 WLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0R1rdZy0XMpKUprpj8+UF8D/9azDIy+dnA831txcyBY=;
 b=pTaSJZRyTIi6D/2axYeWCR9EjI7O9mxgUL5tHcKstp2Ksfh1h+cVX3CCa5gpdSngyo
 5ZuiEUZMZ73gWDZsPXjLmIEgI+CCSsp7UCdCUAgkQeGELErK9DQuXiEH8MSaCxSpSE5X
 Sq2km85ndJ6wCGYoj8mC5PPigIy6+t8a/a2LIochq/wPvBv2pMcfY3AIxrQepmMSG7d0
 Cm6b6BnLFO4TOQdNuckP8AURtk0u3q30TlFNN7RaQCTyQK3MCou+imaCLuDIalE9E1z3
 XU5dE+WQV2Eu8kAxG8KQH1eCLnVWsqseWjf1vsJ6WeHO7dmftvv45Aflb6D3hwBlVKzp
 0meA==
X-Gm-Message-State: APjAAAXFdAaNCHTl7XyffAl9tnf7yWtV//md3096PrGkEF9cl3UUTg9s
 3mWg7cipSYYtQfyy1y3z9ypHBJgetH2T6ZNjCRbpfik+
X-Google-Smtp-Source: APXvYqynwtzH7gqhZme/D+/GWrBOMiseocRo8mp2z/rQvlsi5b3XDckgpXE+4lL1TwCsIo4XHT3i8801O+trTHH0GY8=
X-Received: by 2002:a5d:9c4e:: with SMTP id 14mr13040380iof.166.1581959665413; 
 Mon, 17 Feb 2020 09:14:25 -0800 (PST)
MIME-Version: 1.0
From: Wayne Li <waynli329@gmail.com>
Date: Mon, 17 Feb 2020 11:14:14 -0600
Message-ID: <CAM2K0nq1gz2iGQnaxrcA2Zq1F13k1s+vTv4sKPggXFUe-GkAkQ@mail.gmail.com>
Subject: QEMU VM hangs on ioctl call when running with KVM enabled and nothing
 else happens.
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e7f36a059ec8af30"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d32
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

--000000000000e7f36a059ec8af30
Content-Type: text/plain; charset="UTF-8"

Dear QEMU list members,

We developed a virtual machine using the QEMU code.  This virtual machine
emulates a certain custom-made computer that runs on a certain military
platform.  All I can tell you about this virtual machine is that it
emulates a computer that has an e5500 processor.  Currently I am running
this virtual machine on a T4240-RDB which has a PowerPC e6500 processor (if
anyone remembers me posting about this same project earlier, we fixed the
TCG problem thanks to you guys!).

Anyway, right now I'm trying to get this virtual machine working with KVM
enabled.  It should work given that the virtual machine is emulating an
e5500 processor and it's running on a board with an e6500 processor.  We're
also using a kernel I built using Yocto and I'm pretty sure KVM is all good
and working in this kernel (this was a whole story in it of itself, but if
you're curious you can see my post history concerning getting KVM in the
kernel).  But for some reason the VM hangs on an ioctl call when KVM is
enabled and nothing else happens.  Now I don't think this hanging is
necessarily the problem.  I think what might be the case is that after the
VM makes the ioctl call, the VM should start running the operating system.
But this doesn't seem to be happening; when I look at "info registers" I
see that the NIP has the address of the start instruction of the operating
system but nothing changes and the NIP doesn't progress from that point.
Let me give some further detail on the subject.

With some investigation using print statements/breakpoints I see that the
VM enters into the following function call in the code (I included the call
stack):

qemu_kvm_cpu_thread_fn -> kvm_cpu_exec(cpu) -> kvm_vcpu_ioctl(cpu, KVM_RUN,
0) -> ioctl(cpu->kvm_fd,  KVM_RUN, arg)

So the VM enters into a kernel level ioctl call of type KVM_RUN.  And after
putting some print statements into the Yocto kernel itself I see that the
VM enters into a function in the kernel code called kvmppc_vcpu_run(struct
kvm_run *kvm_run, struct kvm_vcpu *vcpu) and then enters a function calling
assembly code like so: ret = __kvmppc_vcpu_run(kvm_run, vcpu).  At this
point since __kvmppc_vcpu_run() is a function calling assembly code in the
kernel, I have not been able to follow this call any further.  But looking
over the assembly code of this function I see some swapping of vCPU and
host registers as well as a return-from-interrupt instruction at the end.
See assembly code taken from bookehv_interrupts.S:

https://gist.github.com/WayneZhenLi/137a748dad3eebc9be6e9b7b1a49268e

At this point I have two theories on what is happening:

1.  __kvmppc_vcpu_run is hitting the return from interrupt and the NIP of
the VM is set to the start address of the operating system.  But for some
KVM-related reason, the operating system isn't able to progress and we see
the NIP stuck at the starting address.
2. The return from interrupt is either not being reached or is sending me
to some unknown address and thus the operating system is never run.
Perhaps I see the NIP in "info registers" pointed at the starting address
because of some startup thing QEMU does.  But maybe this doesn't reflect
the actual position of the VM?

One more symptom of something not being quite right is this all describes
the second KVM_RUN ioctl call being run.  Before this ioctl call, there is
actually another KVM_RUN ioctl call that runs and completes, but fails with
an error saying "kvm_run failed Interrupted system call".  I'm not sure how
relevant that is but I just wanted to mention it in case it's important.

Anyway, I'm really not sure what the problem is.  This is everything I know
at the moment but I really don't a have a good idea on why the operating
system code isn't being run.  Please let me know your thoughts.

-Thanks!, Wayne Li

--000000000000e7f36a059ec8af30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear QEMU list members,</div><div><br></div><div>We d=
eveloped a virtual machine using the QEMU code.=C2=A0=20
This virtual machine emulates a certain custom-made computer that runs on a=
 certain military platform.=C2=A0 All I can tell you about this virtual mac=
hine is that it emulates a computer that has an e5500 processor.=C2=A0 Curr=
ently I am running this virtual machine on a=20
T4240-RDB which has a PowerPC e6500 processor (if anyone remembers me posti=
ng about this same project earlier, we fixed the TCG problem thanks to you =
guys!).</div><div><br></div><div>Anyway, right now I&#39;m trying to get th=
is virtual machine working with KVM enabled.=C2=A0 It should work given tha=
t the virtual machine is emulating an e5500 processor and it&#39;s running =
on a board with an e6500 processor.=C2=A0 We&#39;re also using a kernel I b=
uilt using Yocto and I&#39;m pretty sure KVM is all good and working in thi=
s kernel (this was a whole story in it of itself, but if you&#39;re curious=
 you can see my post history concerning getting KVM in the kernel).=C2=A0 B=
ut for some reason the VM hangs on an ioctl call when KVM is enabled and no=
thing else happens.=C2=A0 Now I don&#39;t think this hanging is necessarily=
 the problem.=C2=A0 I think what might be the case is that after the VM mak=
es the ioctl call, the VM should start running the operating system.=C2=A0 =
But this doesn&#39;t seem to be happening; when I look at &quot;info regist=
ers&quot; I see that the NIP has the address of the start instruction of th=
e operating system but nothing changes and the NIP doesn&#39;t progress fro=
m that point.=C2=A0 Let me give some further detail on the subject.<br></di=
v><div><br></div><div>With some investigation using print statements/breakp=
oints I see that the VM enters into the following function call in the code=
 (I included the call stack):</div><div><br></div><div>qemu_kvm_cpu_thread_=
fn -&gt; kvm_cpu_exec(cpu) -&gt; kvm_vcpu_ioctl(cpu, KVM_RUN, 0) -&gt; ioct=
l(cpu-&gt;kvm_fd,=C2=A0
KVM_RUN, arg)</div><div><br></div><div>So the VM enters into a kernel level=
 ioctl call of type KVM_RUN.=C2=A0 And after putting some print statements =
into the Yocto kernel itself I see that the VM enters into a function in th=
e kernel code called kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vc=
pu *vcpu) and then enters a function calling assembly code like so: ret =3D=
 __kvmppc_vcpu_run(kvm_run, vcpu).=C2=A0 At this point since=20
__kvmppc_vcpu_run() is a function calling assembly code in the kernel, I ha=
ve not been able to follow this call any further.=C2=A0 But looking over th=
e assembly code of this function I see some swapping of vCPU and host regis=
ters as well as a return-from-interrupt instruction at the end.=C2=A0 See a=
ssembly code taken from bookehv_interrupts.S:</div><div><br></div><div><a h=
ref=3D"https://gist.github.com/WayneZhenLi/137a748dad3eebc9be6e9b7b1a49268e=
">https://gist.github.com/WayneZhenLi/137a748dad3eebc9be6e9b7b1a49268e</a><=
/div><div><br></div><div>At this point I have two theories on what is happe=
ning:</div><div><br></div><div>1.=C2=A0=20
__kvmppc_vcpu_run is hitting the return from interrupt and the NIP of the V=
M is set to the start address of the operating system.=C2=A0 But for some K=
VM-related reason, the operating system isn&#39;t able to progress and we s=
ee the NIP stuck at the starting address.</div><div>2. The return from inte=
rrupt is either not being reached or is sending me to some unknown address =
and thus the operating system is never run.=C2=A0 Perhaps I see the NIP in =
&quot;info registers&quot; pointed at the starting address because of some =
startup thing QEMU does.=C2=A0 But maybe this doesn&#39;t reflect the actua=
l position of the VM?<br></div><div><br></div><div>One more symptom of some=
thing not being quite right is this all describes the second KVM_RUN ioctl =
call being run.=C2=A0 Before this ioctl call, there is actually another KVM=
_RUN ioctl call that runs and completes, but fails with an error saying &qu=
ot;kvm_run failed Interrupted system call&quot;.=C2=A0 I&#39;m not sure how=
 relevant that is but I just wanted to mention it in case it&#39;s importan=
t.</div><div><br></div><div>Anyway, I&#39;m really not sure what the proble=
m is.=C2=A0 This is everything I know at the moment but I really don&#39;t =
a have a good idea on why the operating system code isn&#39;t being run.=C2=
=A0 Please let me know your thoughts.</div><div><br></div><div>-Thanks!, Wa=
yne Li<br></div><div><br></div></div>

--000000000000e7f36a059ec8af30--

