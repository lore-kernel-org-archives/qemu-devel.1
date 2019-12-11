Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFD0C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 21:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593502054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 21:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXmT14GM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593502054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if9T0-0002Nj-FE
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 16:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1if9SK-0001tp-No
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 16:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1if9SI-00033M-DT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 16:23:36 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:34041)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1if9SH-0002zs-0a
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 16:23:33 -0500
Received: by mail-io1-xd2b.google.com with SMTP id z193so400945iof.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 13:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=y/N7Uct4xnt6Pmvk6B2B9B76HxjU+qvLek1odbUamro=;
 b=rXmT14GMuxtJZ2qlt1K2eSjd9tL4q+MzcbDV8JpFd9C5vwUv2U8z03Wy7qYrYdx6sw
 l2jDADR4W3mYLC0k44lee2MasJMTyUPoG8zGoNBmVcErcc2VwELPxcJomt8OIpHaLjk0
 gxCxD8kpjt2YuFpcwdVgxkt8mLoepxSlM0PlOy1kQ9Jdlmk4GZH18Y8KsuN7q23qE0Is
 jnvgDvkAuM7PYKKl7Bs0irir4J063zvZfBZ7ptKvGxDRoiOVk672bXrpl630RqMe4kQ0
 Hn4Ed2dxPv4vnl9j9pwD4q3v+FOw5DJQSOBcUH6Iffc8ORB2Lry3+TcWPFKGnua5iZnj
 lTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=y/N7Uct4xnt6Pmvk6B2B9B76HxjU+qvLek1odbUamro=;
 b=n/KztawCYAJ/j5PpU2CczUXyzVN65PbLCoXWnazAS3tY14aKckUN6LtJJRwxPzl2Du
 Q9r8GGW5hUP3CHbysqQwuSLZ2w0Pe6y4fq0x8/InPJMkhGaytSCcY+6j6BzQch7l5+T3
 xBUf/CM0PTEC90QtWyGSxi0HWP9L1BWlLgF7ILWzBlcSYQWiJIy46tHcC2xHXh8KI6X4
 URRGPDxszItU8zXJcNjjG4OGzgBNjQg0k2zG0GQL3jIhBqjUURjQpQXXGSe+mbqwcpRc
 1uLxnUACxEazss3Du6gW4jX3PwrkvNznvvpnkGC3gua6g+7838pYQeOw2zN6hWDt0kAa
 GrWA==
X-Gm-Message-State: APjAAAU+jd+D2nkDhmAbWJBPyd2cGzxhBAaFKGQ7Nh2IdGczGkeruRyL
 oHTKmkxi9M7nj6XFraE3CIKf56IEbDQS2MW5Nd8JLfZ9
X-Google-Smtp-Source: APXvYqxdMBvDG3yVrhO0w1zNyxxYqthqeUm+VK3MJlDTbuCySNblFmhUZchZlODVFfaUE25eaQRMji52+MwQqPdT6xk=
X-Received: by 2002:a6b:f60f:: with SMTP id n15mr201125ioh.263.1576099411687; 
 Wed, 11 Dec 2019 13:23:31 -0800 (PST)
MIME-Version: 1.0
From: Wayne Li <waynli329@gmail.com>
Date: Wed, 11 Dec 2019 15:23:20 -0600
Message-ID: <CAM2K0nrhkOhiJDxnANGmAu2140-TP0a9pY58i_PN1k9xAWGz9A@mail.gmail.com>
Subject: QEMU VM crashes when enabling KVM
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000090800f0599743d3c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2b
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

--00000000000090800f0599743d3c
Content-Type: text/plain; charset="UTF-8"

Dear QEMU list members,

So we developed a virtual machine that that runs on QEMU.  The virtual
machine emulates a certain piece of equipment running on a PowerPC 7457
processor.  And we are running the virtual machine on a T4240-RDB which as
a PowerPC e6500 processor.  I can't give any more details than that as this
project has military applications.

The problem I'm having right now is when I use the -enable-kvm option when
starting the virtual machine, the virtual machine crashes like so:

kvm error: missing PVR setting capability
kvm_init_vcpu failed: Function not implemented
common_qemu_exit() has been called

Now I am fairly sure KVM is actually enabled on the system.  Finding that
out was another story that spanned a couple of months.  But long story
short, lsmod doesn't show that the KVM kernel module is running.  But
that's because KVM is built-in and it can't actually be built as a loadable
kernel module in this particular system.

So I'm not really sure what could be the problem.  Though I was thinking if
I understood the error better that might help?  Following the code I see
that the "Missing PVR setting capability." is called when a variable called
"cap_segstate" is 0:

if (!cap_segstate) {
            fprintf(stderr, "kvm error: missing PVR setting capability\n");
            return -ENOSYS;
}

And the cap_segstate variable is set by the following function:

cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);

From there I'm pretty lost; I simply don't understand what any of these
terms mean.  Do any of you guys know what PVR setting capability,
cap_segstate, or KVM_CAP_PPC_SEGSTATE mean?  Do I have to set up any kind
of communication between my virtual machine and KVM?  Any of you guys know
what's going on here?  I'm just pretty lost right now haha.

-Thanks, Wayne Li

--00000000000090800f0599743d3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear QEMU list members,</div><div><br></div><div>So w=
e developed a virtual machine that that runs on QEMU.=C2=A0 The virtual mac=
hine emulates a certain piece of equipment running on a PowerPC 7457 proces=
sor.=C2=A0 And we are running the virtual machine on a T4240-RDB which as a=
 PowerPC e6500 processor.=C2=A0 I can&#39;t give any more details than that=
 as this project has military applications.<br></div><div><br></div><div>Th=
e problem I&#39;m having right now is when I use the -enable-kvm option whe=
n starting the virtual machine, the virtual machine crashes like so:</div><=
div><br></div><div>kvm error: missing PVR setting capability</div><div>kvm_=
init_vcpu failed: Function not implemented<br>common_qemu_exit() has been c=
alled</div><div><br></div><div>Now I am fairly sure KVM is actually enabled=
 on the system.=C2=A0 Finding that out was another story that spanned a cou=
ple of months.=C2=A0 But long story short, lsmod doesn&#39;t show that the =
KVM kernel module is running.=C2=A0 But that&#39;s because KVM is built-in =
and it can&#39;t actually be built as a loadable kernel module in this part=
icular system.<br></div><div><br></div><div>So I&#39;m not really sure what=
 could be the problem.=C2=A0 Though I was thinking if I understood the erro=
r better that might help?=C2=A0 Following the code I see that the &quot;Mis=
sing PVR setting capability.&quot; is called when a variable called &quot;c=
ap_segstate&quot; is 0:</div><div><br></div><div>if (!cap_segstate) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;kvm error: =
missing PVR setting capability\n&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -ENOSYS;</div><div> }</div><div><br></div><div>And the ca=
p_segstate variable is set by the following function:</div><div><br></div><=
div>cap_segstate =3D kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);</div><di=
v><br></div><div>From there I&#39;m pretty lost; I simply don&#39;t underst=
and what any of these terms mean.=C2=A0 Do any of you guys know what PVR se=
tting capability, cap_segstate, or=20
KVM_CAP_PPC_SEGSTATE mean?=C2=A0 Do I have to set up any kind of communicat=
ion between my virtual machine and KVM?=C2=A0 Any of you guys know what&#39=
;s going on here?=C2=A0 I&#39;m just pretty lost right now haha.</div><div>=
<br></div><div>-Thanks, Wayne Li<br></div></div>

--00000000000090800f0599743d3c--

