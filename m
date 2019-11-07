Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8565FC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F094214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA5kkNwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F094214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSiI2-0003Hy-CO
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael.goffioul@gmail.com>) id 1iSiGz-0002I4-Et
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael.goffioul@gmail.com>) id 1iSiGx-0000fr-Nx
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:56:29 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:35300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <michael.goffioul@gmail.com>)
 id 1iSiGx-0000fO-Di
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:56:27 -0500
Received: by mail-pf1-x42c.google.com with SMTP id d13so2757987pfq.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=k6pSCwJ3XePFQlEgI+vDIu6IwMFmIMeLvi8QkSFnAyQ=;
 b=VA5kkNwh0UfHGsapPLTlk14Rswfia9AwsgcTOjEBTgukn6xs9kcVDALaQ9vwVKZob3
 wau1B4O+qAOtK53fz0kpS7PTvvMAEqGMbIwNRaWgpl86fC8eMH1U+y1crscEk44N/jUk
 kxQf6wF01EGoqFkxwFvJ4SNzf3yZH9GAcE44FC6JQP06VFklS0kM3phWGXWR1tv0F0D7
 NYZxlCqvdQT0qeXaSeXw/BmCr8tK17a/nFoS2Qra8tVXpYX/gk2UcLf5Cebc9Ug2yIhb
 NmM7mq7dRv7FFPAr3BcKFGAon6i8WEM6TzPzbXOzW7/MsG2fJiT/8dGi0lwCrpA3bfQj
 n20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=k6pSCwJ3XePFQlEgI+vDIu6IwMFmIMeLvi8QkSFnAyQ=;
 b=ZrBUpIl+GNng5Z3CCgRSURqwPuCsj4smAw099fl7a3chFbo9f+iF9huMX+h0RlHLu/
 eUmgNd52RwFNcIDRVBVSMEh2vCEBoopIsEntioNXt34VmVrsZEEUT6IF4ZOP2YiICXty
 xWk9JrBoNvggetnLYxnppT7nvQ2wPues2twZ6H6gl5IRFWXXIUaEVVPAXEo+V95Z3RMs
 W5N192lCq7IetFeaLL0XkQMQ3aP2Tr9o9VYL8gtjCeDhb79WcOEXZa1Za/ujibDi+cOd
 F4QExHOj3EhVlEPhESsa8QGtUvqY2iCVIIns/paLplC7fayWC4yMULqGCHzDYuTCoHvy
 fGpA==
X-Gm-Message-State: APjAAAXXjz4Y92wtC1Vw0BBBaAUdZPjBwFHYQEfCk50wsIyxUSYqieG4
 2FipOs7hcSCdr2nrkTnTGsBD/b2QFIpJdMhmjktwgzky
X-Google-Smtp-Source: APXvYqzUqu0sWp+Qqafe9F5PGGRNcyGdCEfSsAvVjv4WKc72xujR9M7V5wlWFqYlOQi6aa/xfrGhjSpKN3+56op03jo=
X-Received: by 2002:aa7:9488:: with SMTP id z8mr1712742pfk.213.1573134985479; 
 Thu, 07 Nov 2019 05:56:25 -0800 (PST)
MIME-Version: 1.0
From: Michael Goffioul <michael.goffioul@gmail.com>
Date: Thu, 7 Nov 2019 08:56:14 -0500
Message-ID: <CAB-99LsMqvvUx+Eug8cq2RNSoscoj8wo5Sq8M9wT_9R2FZ=MUw@mail.gmail.com>
Subject: How to clone CPUState in a new thread?
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000fec6b60596c20786"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
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

--000000000000fec6b60596c20786
Content-Type: multipart/alternative; boundary="000000000000fec6b30596c20784"

--000000000000fec6b30596c20784
Content-Type: text/plain; charset="UTF-8"

[originally posted on qemu-discuss]

=== (initial)

Hi,

I'm working on a project that wants to replace houdini (ARM-to-x86
translation layer for Android from Intel) with a free open-source
implementation. I'm trying to leverage qemu user-mode to achieve that, but
it requires code changes to allow executing dynamically loaded functions
instead of running a single executable.

In a nutshell, using ideas from unicorn-engine, I've enhanced CPUARMState
with a stop address. Whenever this address is encountered in the
translator, it generates a YIELD exception, which then makes the cpu_loop
to exit.

It works fine for simple cases, but I'm having trouble with multi-threading
aspect. Threads created from the native/ARM side do seem to work properly.
The problem is when a new Java thread (not created from native/ARM)
attempts to execute native code. The QEMU engine has been initialized in
the main thread, but new Java threads do not have access to thread-local
variable thread_cpu.

I've tried (maybe naively) to recreate what the clone syscall is doing to
create a new CPUState/CPUArchState object, usable from the new thread, but
executing any ARM code quickly lead to a crash. I suppose I'm doing
something wrong, or missing something to properly initiale a new cpu. I'm
hoping that someone could help me solve this problem.

I've attached the current QEMU patch I'm using, most of the Android glue
layer is in linux-user/main.c. It contains a set of utility functions that
my Android native bridge implementation is using.

=== (follow-up)

Basically Houdini implements the native bridge interface, as defined here:
https://android.googlesource.com/platform/system/core/+/refs/tags/android-10.0.0_r11/libnativebridge/include/nativebridge/native_bridge.h#172
It allows running Android APK that contains ARM-compiled native/JNI code on
an Android-x86 OS. It does so by taking care of loading the ARM .so JNI
files are providing trampoline stubs to the Android runtime JVM. It does
not expose the host native .so to the emulated code, instead it provides a
set of ARM-compiled core libraries from Android: it is actually very
similar to running dynamically linked code in qemu-user with a chroot'ed
ARM environment. Actual interaction with the native host is happening
mostly/only through binder socket.

To initialize the qemu-user engine, I make it load a custom ARM .so/ELF
file that uses the Android linker (from the ARM pseudo chroot environment)
as interpreter. This allows me to delegate all dynamic linking aspects.

So far, the emulation is working fine and I'm able to run simple
ARM-compiled apps on Android-x86, even if the native code spawns new
threads. My current (hopefully last) problem is when a Java thread,
different than the one that initialized the qemu engine) is trying to run
native code. I need to setup a new CPUState/CPUArchState instance for this
Java thread.

--000000000000fec6b30596c20784
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">[originally posted on qemu-discuss]<div><br></div><div>=3D=
=3D=3D (initial)</div><div><br></div><div>Hi,<br><br>I&#39;m working on a p=
roject that wants to replace houdini (ARM-to-x86 translation layer for Andr=
oid from Intel) with a free open-source implementation. I&#39;m trying to l=
everage qemu user-mode to achieve that, but it requires code changes to all=
ow executing dynamically loaded functions instead of running a single execu=
table.<br><br>In a nutshell, using ideas from unicorn-engine, I&#39;ve enha=
nced CPUARMState with a stop address. Whenever this address is encountered =
in the translator, it generates a YIELD exception, which then makes the cpu=
_loop to exit.<br><br>It works fine for simple cases, but I&#39;m having tr=
ouble with multi-threading aspect. Threads created from the native/ARM side=
 do seem to work properly. The problem is when a new Java thread (not creat=
ed from native/ARM) attempts to execute native code. The QEMU engine has be=
en initialized in the main thread, but new Java threads do not have access =
to thread-local variable thread_cpu.<br><br>I&#39;ve tried (maybe naively) =
to recreate what the clone syscall is doing to create a new CPUState/CPUArc=
hState object, usable from the new thread, but executing any ARM code quick=
ly lead to a crash. I suppose I&#39;m doing something wrong, or missing som=
ething to properly initiale a new cpu. I&#39;m hoping that someone could he=
lp me solve this problem.<br><br>I&#39;ve attached the current QEMU patch I=
&#39;m using, most of the Android glue layer is in linux-user/main.c. It co=
ntains a set of utility functions that my Android native bridge implementat=
ion is using.<br></div><div><br></div><div>=3D=3D=3D (follow-up)</div><div>=
<br></div><div>Basically Houdini implements the native bridge interface, as=
 defined here:=C2=A0<a href=3D"https://android.googlesource.com/platform/sy=
stem/core/+/refs/tags/android-10.0.0_r11/libnativebridge/include/nativebrid=
ge/native_bridge.h#172">https://android.googlesource.com/platform/system/co=
re/+/refs/tags/android-10.0.0_r11/libnativebridge/include/nativebridge/nati=
ve_bridge.h#172</a></div><div>It allows running Android APK that contains A=
RM-compiled native/JNI code on an Android-x86 OS. It does so by taking care=
 of loading the ARM .so JNI files are providing trampoline stubs to the And=
roid runtime JVM. It does not expose the host native .so to the emulated co=
de, instead it provides a set of ARM-compiled core libraries from Android: =
it is actually very similar to running dynamically linked code in qemu-user=
 with a chroot&#39;ed ARM environment. Actual interaction with the native h=
ost is happening mostly/only through binder socket.</div><div><br>To initia=
lize the qemu-user engine, I make it load a custom ARM .so/ELF file that us=
es the Android linker (from the ARM pseudo chroot environment) as interpret=
er. This allows me to delegate all dynamic linking aspects.<br><br>So far, =
the emulation is working fine and I&#39;m able to run simple ARM-compiled a=
pps on Android-x86, even if the native code spawns new threads. My current =
(hopefully last) problem is when a Java thread, different than the one that=
 initialized the qemu engine) is trying to run native code. I need to setup=
 a new CPUState/CPUArchState instance for this Java thread.<br></div></div>

--000000000000fec6b30596c20784--

--000000000000fec6b60596c20786
Content-Type: application/x-bzip; name="qemu-android.diff.bz2"
Content-Disposition: attachment; filename="qemu-android.diff.bz2"
Content-Transfer-Encoding: base64
Content-ID: <f_k2orv5190>
X-Attachment-Id: f_k2orv5190

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
ckU4UJBoD7k8
--000000000000fec6b60596c20786--

