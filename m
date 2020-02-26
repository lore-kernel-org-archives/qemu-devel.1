Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE57EC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9767720838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5H1nApv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9767720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vCm-0001rq-Pe
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6vAg-0007tP-MO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6vAd-0005WH-CW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:48:10 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j6vAd-0005Th-2Z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:48:07 -0500
Received: by mail-ot1-x341.google.com with SMTP id 59so2626761otp.12
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=O7WgE7WhSIhVjGZhtJoITccnHwGC8huMkjymMtd2vSw=;
 b=X5H1nApv4Nb71RFkjQl/9VT22MFXerIoQyfAm6LCRs/h7oiNuFzWKB8SyHJqEqoA+/
 lPW81qtcKHwQ7+HwvZ5fkX3SCvcbB735HTpD7aZEjGupJBfpLgDPLRrhUs76DaFx+83n
 LtRdWlZreAtYh0spPmtGcWSBFdzikh4UFBtlefaSDstfSrFGN/c1ddnx9pExXhalmIlJ
 z+nxCZFXTh6d3L0CsZti2rd6cGQcaed6I/m1HWoibcjVq+8/GrKP/Lu1jZv1b2mEZkVJ
 5JyPjnjWVocVTQ2nNgvPEoghEePNHvC8IBpZ5NNvUHUrf1jLSRWrvEZluuhS4BWzAq2J
 dm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=O7WgE7WhSIhVjGZhtJoITccnHwGC8huMkjymMtd2vSw=;
 b=A5/VqZK0rSqO6QSq8vz/ZuvdyTFdt6SWpIEZdJ0uMJWqyWwrgSM1e1SabuW0ECk7f+
 d7pesZ2N9PsrhPWJlaBn44dXZzZqh+x+uSNHTTuuLITjkcd9m7gf4C8FlsHv6KWDG/Ky
 DJOYP9y8A4M90GVk7iG6NbticKQE2XZ9Ylkxfe32YlwPv4UOm2T6MDuvRvf9Sg9ZcmJ5
 10uK0fH2fOrdOk4n2pai/Ll7mCU0V8KszNzLdMcFtVSiHNz5v/Fvv8ayuhtGdGbqxFs5
 5vB41exJeuBM77C4f5u125J2KV7TnQafIbozQX/Vu9EsbxAHfg/E1AkPwdDQOUZLyRoE
 Jrqw==
X-Gm-Message-State: APjAAAXe6T4fwsie/LjnCaU9SHGrOPkAHWB53OLSCwvsKhtC+gRPqzD1
 TMoMrlUNRFE3wjkO9W4eP1bXf9T0mcLx3PCMUYc=
X-Google-Smtp-Source: APXvYqyRkdO15y5J60GJXCbH+I7fnCMFh+8jB1Rh73y9GTRq9A+v0V2bDo0c/6+ZBKr/uhs4axQw086v+Zi4r2jQAeI=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr2604256otp.306.1582717685672; 
 Wed, 26 Feb 2020 03:48:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 26 Feb 2020 03:48:05 -0800 (PST)
In-Reply-To: <20200225154121.21116-2-peter.maydell@linaro.org>
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <20200225154121.21116-2-peter.maydell@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Feb 2020 12:48:05 +0100
Message-ID: <CAL1e-=g3xeFsU9Swz3jQpAr9S666i8XseSeBQxrAtVe0e2MCRw@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs: Convert security.texi to rST format
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006f2ea8059f792d87"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006f2ea8059f792d87
Content-Type: text/plain; charset="UTF-8"

On Tuesday, February 25, 2020, Peter Maydell <peter.maydell@linaro.org>
wrote:

> security.texi is included from qemu-doc.texi but is not used
> in the qemu.1 manpage. So we can do a straightforward conversion
> of the contents, which go into the system manual.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---


FWIW:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>  Makefile                                    |  2 +-
>  docs/system/index.rst                       |  1 +
>  docs/{security.texi => system/security.rst} | 82 +++++++++++----------
>  qemu-doc.texi                               |  3 -
>  4 files changed, 46 insertions(+), 42 deletions(-)
>  rename docs/{security.texi => system/security.rst} (77%)
>
> diff --git a/Makefile b/Makefile
> index aa9cc0b5847..5f0f803b471 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1117,7 +1117,7 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf
> qemu-doc.txt: \
>         qemu-tech.texi qemu-option-trace.texi \
>         qemu-deprecated.texi qemu-monitor.texi \
>         qemu-monitor-info.texi \
> -       docs/qemu-cpu-models.texi docs/security.texi
> +       docs/qemu-cpu-models.texi
>
>  docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
>      docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index f66e6ea585c..794e5d8de03 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -15,3 +15,4 @@ Contents:
>     :maxdepth: 2
>
>     qemu-block-drivers
> +   security
> diff --git a/docs/security.texi b/docs/system/security.rst
> similarity index 77%
> rename from docs/security.texi
> rename to docs/system/security.rst
> index 0d6b30edfc0..f2092c8768b 100644
> --- a/docs/security.texi
> +++ b/docs/system/security.rst
> @@ -1,19 +1,22 @@
> -@node Security
> -@chapter Security
> +Security
> +========
>
> -@section Overview
> +Overview
> +--------
>
>  This chapter explains the security requirements that QEMU is designed to
> meet
>  and principles for securely deploying QEMU.
>
> -@section Security Requirements
> +Security Requirements
> +---------------------
>
>  QEMU supports many different use cases, some of which have stricter
> security
>  requirements than others.  The community has agreed on the overall
> security
>  requirements that users may depend on.  These requirements define what is
>  considered supported from a security perspective.
>
> -@subsection Virtualization Use Case
> +Virtualization Use Case
> +'''''''''''''''''''''''
>
>  The virtualization use case covers cloud and virtual private server (VPS)
>  hosting, as well as traditional data center and desktop virtualization.
> These
> @@ -23,18 +26,17 @@ safely on the physical CPU at close-to-native speed.
>  The following entities are untrusted, meaning that they may be buggy or
>  malicious:
>
> -@itemize
> -@item Guest
> -@item User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> -@item Network protocols (e.g. NBD, live migration)
> -@item User-supplied files (e.g. disk images, kernels, device trees)
> -@item Passthrough devices (e.g. PCI, USB)
> -@end itemize
> +- Guest
> +- User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> +- Network protocols (e.g. NBD, live migration)
> +- User-supplied files (e.g. disk images, kernels, device trees)
> +- Passthrough devices (e.g. PCI, USB)
>
>  Bugs affecting these entities are evaluated on whether they can cause
> damage in
>  real-world use cases and treated as security bugs if this is the case.
>
> -@subsection Non-virtualization Use Case
> +Non-virtualization Use Case
> +'''''''''''''''''''''''''''
>
>  The non-virtualization use case covers emulation using the Tiny Code
> Generator
>  (TCG).  In principle the TCG and device emulation code used in
> conjunction with
> @@ -47,12 +49,14 @@ Bugs affecting the non-virtualization use case are not
> considered security
>  bugs at this time.  Users with non-virtualization use cases must not rely
> on
>  QEMU to provide guest isolation or any security guarantees.
>
> -@section Architecture
> +Architecture
> +------------
>
>  This section describes the design principles that ensure the security
>  requirements are met.
>
> -@subsection Guest Isolation
> +Guest Isolation
> +'''''''''''''''
>
>  Guest isolation is the confinement of guest code to the virtual machine.
> When
>  guest code gains control of execution on the host this is called escaping
> the
> @@ -71,7 +75,8 @@ malicious guest must not gain control of other guests or
> access their data.
>  Disk image files and network traffic must be protected from other guests
> unless
>  explicitly shared between them by the user.
>
> -@subsection Principle of Least Privilege
> +Principle of Least Privilege
> +''''''''''''''''''''''''''''
>
>  The principle of least privilege states that each component only has
> access to
>  the privileges necessary for its function.  In the case of QEMU this
> means that
> @@ -84,7 +89,7 @@ the guest.
>
>  Following the principle of least privilege immediately fulfills guest
> isolation
>  requirements.  For example, guest A only has access to its own disk image
> file
> -@code{a.img} and not guest B's disk image file @code{b.img}.
> +``a.img`` and not guest B's disk image file ``b.img``.
>
>  In reality certain resources are inaccessible to the guest but must be
>  available to QEMU to perform its function.  For example, host system
> calls are
> @@ -95,7 +100,8 @@ New features must be designed to follow the principle
> of least privilege.
>  Should this not be possible for technical reasons, the security risk must
> be
>  clearly documented so users are aware of the trade-off of enabling the
> feature.
>
> -@subsection Isolation mechanisms
> +Isolation mechanisms
> +''''''''''''''''''''
>
>  Several isolation mechanisms are available to realize this architecture of
>  guest isolation and the principle of least privilege.  With the exception
> of
> @@ -105,46 +111,46 @@ described briefly for Linux here.
>
>  The fundamental isolation mechanism is that QEMU processes must run as
>  unprivileged users.  Sometimes it seems more convenient to launch QEMU as
> -root to give it access to host devices (e.g. @code{/dev/net/tun}) but
> this poses a
> +root to give it access to host devices (e.g. ``/dev/net/tun``) but this
> poses a
>  huge security risk.  File descriptor passing can be used to give an
> otherwise
>  unprivileged QEMU process access to host devices without running QEMU as
> root.
>  It is also possible to launch QEMU as a non-root user and configure UNIX
> groups
> -for access to @code{/dev/kvm}, @code{/dev/net/tun}, and other device
> nodes.
> +for access to ``/dev/kvm``, ``/dev/net/tun``, and other device nodes.
>  Some Linux distros already ship with UNIX groups for these devices by
> default.
>
> -@itemize
> -@item SELinux and AppArmor make it possible to confine processes beyond
> the
> -traditional UNIX process and file permissions model.  They restrict the
> QEMU
> -process from accessing processes and files on the host system that are not
> -needed by QEMU.
> +- SELinux and AppArmor make it possible to confine processes beyond the
> +  traditional UNIX process and file permissions model.  They restrict the
> QEMU
> +  process from accessing processes and files on the host system that are
> not
> +  needed by QEMU.
>
> -@item Resource limits and cgroup controllers provide throughput and
> utilization
> -limits on key resources such as CPU time, memory, and I/O bandwidth.
> +- Resource limits and cgroup controllers provide throughput and
> utilization
> +  limits on key resources such as CPU time, memory, and I/O bandwidth.
>
> -@item Linux namespaces can be used to make process, file system, and
> other system
> -resources unavailable to QEMU.  A namespaced QEMU process is restricted
> to only
> -those resources that were granted to it.
> +- Linux namespaces can be used to make process, file system, and other
> system
> +  resources unavailable to QEMU.  A namespaced QEMU process is restricted
> to only
> +  those resources that were granted to it.
>
> -@item Linux seccomp is available via the QEMU @option{--sandbox} option.
> It disables
> -system calls that are not needed by QEMU, thereby reducing the host kernel
> -attack surface.
> -@end itemize
> +- Linux seccomp is available via the QEMU ``--sandbox`` option.  It
> disables
> +  system calls that are not needed by QEMU, thereby reducing the host
> kernel
> +  attack surface.
>
> -@section Sensitive configurations
> +Sensitive configurations
> +------------------------
>
>  There are aspects of QEMU that can have security implications which users
> &
>  management applications must be aware of.
>
> -@subsection Monitor console (QMP and HMP)
> +Monitor console (QMP and HMP)
> +'''''''''''''''''''''''''''''
>
>  The monitor console (whether used with QMP or HMP) provides an interface
>  to dynamically control many aspects of QEMU's runtime operation. Many of
> the
>  commands exposed will instruct QEMU to access content on the host file
> system
>  and/or trigger spawning of external processes.
>
> -For example, the @code{migrate} command allows for the spawning of
> arbitrary
> +For example, the ``migrate`` command allows for the spawning of arbitrary
>  processes for the purpose of tunnelling the migration data stream. The
> -@code{blockdev-add} command instructs QEMU to open arbitrary files,
> exposing
> +``blockdev-add`` command instructs QEMU to open arbitrary files, exposing
>  their content to the guest as a virtual disk.
>
>  Unless QEMU is otherwise confined using technologies such as SELinux,
> AppArmor,
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 33b9597b1dc..c11b1a5d5ad 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -40,7 +40,6 @@
>  * QEMU System emulator for non PC targets::
>  * QEMU User space emulator::
>  * System requirements::
> -* Security::
>  * Implementation notes::
>  * Deprecated features::
>  * Recently removed features::
> @@ -2836,8 +2835,6 @@ added with Linux 4.5 which is supported by the major
> distros. And even
>  if RHEL7 has kernel 3.10, KVM there has the required functionality there
>  to make it close to a 4.5 or newer kernel.
>
> -@include docs/security.texi
> -
>  @include qemu-tech.texi
>
>  @include qemu-deprecated.texi
> --
> 2.20.1
>
>
>

--0000000000006f2ea8059f792d87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, February 25, 2020, Peter Maydell &lt;<a href=3D"mailto:=
peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">security.texi is included from qemu-doc.texi but i=
s not used<br>
in the qemu.1 manpage. So we can do a straightforward conversion<br>
of the contents, which go into the system manual.<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
">peter.maydell@linaro.org</a>&gt;<br>
---</blockquote><div><br></div><div>FWIW:</div><div><br></div><div>Reviewed=
-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com">amar=
kovic@wavecomp.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
2 +-<br>
=C2=A0docs/system/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0docs/{security.texi =3D&gt; system/security.rst} | 82 +++++++++++----=
------<br>
=C2=A0qemu-doc.texi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 -<br>
=C2=A04 files changed, 46 insertions(+), 42 deletions(-)<br>
=C2=A0rename docs/{security.texi =3D&gt; system/security.rst} (77%)<br>
<br>
diff --git a/Makefile b/Makefile<br>
index aa9cc0b5847..5f0f803b471 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -1117,7 +1117,7 @@ qemu-doc.html <a href=3D"http://qemu-doc.info" target=
=3D"_blank">qemu-doc.info</a> qemu-doc.pdf qemu-doc.txt: \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-tech.texi qemu-option-trace.texi \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-deprecated.texi qemu-monitor.texi \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu-monitor-info.texi \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0docs/qemu-cpu-models.texi docs/security.texi<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0docs/qemu-cpu-models.texi<br>
<br>
=C2=A0docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \<br>
=C2=A0 =C2=A0 =C2=A0docs/interop/<a href=3D"http://qemu-ga-ref.info" target=
=3D"_blank">qemu-ga-ref.info</a> docs/interop/qemu-ga-ref.pdf \<br>
diff --git a/docs/system/index.rst b/docs/system/index.rst<br>
index f66e6ea585c..794e5d8de03 100644<br>
--- a/docs/system/index.rst<br>
+++ b/docs/system/index.rst<br>
@@ -15,3 +15,4 @@ Contents:<br>
=C2=A0 =C2=A0 :maxdepth: 2<br>
<br>
=C2=A0 =C2=A0 qemu-block-drivers<br>
+=C2=A0 =C2=A0security<br>
diff --git a/docs/security.texi b/docs/system/security.rst<br>
similarity index 77%<br>
rename from docs/security.texi<br>
rename to docs/system/security.rst<br>
index 0d6b30edfc0..f2092c8768b 100644<br>
--- a/docs/security.texi<br>
+++ b/docs/system/security.rst<br>
@@ -1,19 +1,22 @@<br>
-@node Security<br>
-@chapter Security<br>
+Security<br>
+=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
-@section Overview<br>
+Overview<br>
+--------<br>
<br>
=C2=A0This chapter explains the security requirements that QEMU is designed=
 to meet<br>
=C2=A0and principles for securely deploying QEMU.<br>
<br>
-@section Security Requirements<br>
+Security Requirements<br>
+---------------------<br>
<br>
=C2=A0QEMU supports many different use cases, some of which have stricter s=
ecurity<br>
=C2=A0requirements than others.=C2=A0 The community has agreed on the overa=
ll security<br>
=C2=A0requirements that users may depend on.=C2=A0 These requirements defin=
e what is<br>
=C2=A0considered supported from a security perspective.<br>
<br>
-@subsection Virtualization Use Case<br>
+Virtualization Use Case<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
<br>
=C2=A0The virtualization use case covers cloud and virtual private server (=
VPS)<br>
=C2=A0hosting, as well as traditional data center and desktop virtualizatio=
n.=C2=A0 These<br>
@@ -23,18 +26,17 @@ safely on the physical CPU at close-to-native speed.<br=
>
=C2=A0The following entities are untrusted, meaning that they may be buggy =
or<br>
=C2=A0malicious:<br>
<br>
-@itemize<br>
-@item Guest<br>
-@item User-facing interfaces (e.g. VNC, SPICE, WebSocket)<br>
-@item Network protocols (e.g. NBD, live migration)<br>
-@item User-supplied files (e.g. disk images, kernels, device trees)<br>
-@item Passthrough devices (e.g. PCI, USB)<br>
-@end itemize<br>
+- Guest<br>
+- User-facing interfaces (e.g. VNC, SPICE, WebSocket)<br>
+- Network protocols (e.g. NBD, live migration)<br>
+- User-supplied files (e.g. disk images, kernels, device trees)<br>
+- Passthrough devices (e.g. PCI, USB)<br>
<br>
=C2=A0Bugs affecting these entities are evaluated on whether they can cause=
 damage in<br>
=C2=A0real-world use cases and treated as security bugs if this is the case=
.<br>
<br>
-@subsection Non-virtualization Use Case<br>
+Non-virtualization Use Case<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
<br>
=C2=A0The non-virtualization use case covers emulation using the Tiny Code =
Generator<br>
=C2=A0(TCG).=C2=A0 In principle the TCG and device emulation code used in c=
onjunction with<br>
@@ -47,12 +49,14 @@ Bugs affecting the non-virtualization use case are not =
considered security<br>
=C2=A0bugs at this time.=C2=A0 Users with non-virtualization use cases must=
 not rely on<br>
=C2=A0QEMU to provide guest isolation or any security guarantees.<br>
<br>
-@section Architecture<br>
+Architecture<br>
+------------<br>
<br>
=C2=A0This section describes the design principles that ensure the security=
<br>
=C2=A0requirements are met.<br>
<br>
-@subsection Guest Isolation<br>
+Guest Isolation<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;<br>
<br>
=C2=A0Guest isolation is the confinement of guest code to the virtual machi=
ne.=C2=A0 When<br>
=C2=A0guest code gains control of execution on the host this is called esca=
ping the<br>
@@ -71,7 +75,8 @@ malicious guest must not gain control of other guests or =
access their data.<br>
=C2=A0Disk image files and network traffic must be protected from other gue=
sts unless<br>
=C2=A0explicitly shared between them by the user.<br>
<br>
-@subsection Principle of Least Privilege<br>
+Principle of Least Privilege<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
<br>
=C2=A0The principle of least privilege states that each component only has =
access to<br>
=C2=A0the privileges necessary for its function.=C2=A0 In the case of QEMU =
this means that<br>
@@ -84,7 +89,7 @@ the guest.<br>
<br>
=C2=A0Following the principle of least privilege immediately fulfills guest=
 isolation<br>
=C2=A0requirements.=C2=A0 For example, guest A only has access to its own d=
isk image file<br>
-@code{a.img} and not guest B&#39;s disk image file @code{b.img}.<br>
+``a.img`` and not guest B&#39;s disk image file ``b.img``.<br>
<br>
=C2=A0In reality certain resources are inaccessible to the guest but must b=
e<br>
=C2=A0available to QEMU to perform its function.=C2=A0 For example, host sy=
stem calls are<br>
@@ -95,7 +100,8 @@ New features must be designed to follow the principle of=
 least privilege.<br>
=C2=A0Should this not be possible for technical reasons, the security risk =
must be<br>
=C2=A0clearly documented so users are aware of the trade-off of enabling th=
e feature.<br>
<br>
-@subsection Isolation mechanisms<br>
+Isolation mechanisms<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;<br>
<br>
=C2=A0Several isolation mechanisms are available to realize this architectu=
re of<br>
=C2=A0guest isolation and the principle of least privilege.=C2=A0 With the =
exception of<br>
@@ -105,46 +111,46 @@ described briefly for Linux here.<br>
<br>
=C2=A0The fundamental isolation mechanism is that QEMU processes must run a=
s<br>
=C2=A0unprivileged users.=C2=A0 Sometimes it seems more convenient to launc=
h QEMU as<br>
-root to give it access to host devices (e.g. @code{/dev/net/tun}) but this=
 poses a<br>
+root to give it access to host devices (e.g. ``/dev/net/tun``) but this po=
ses a<br>
=C2=A0huge security risk.=C2=A0 File descriptor passing can be used to give=
 an otherwise<br>
=C2=A0unprivileged QEMU process access to host devices without running QEMU=
 as root.<br>
=C2=A0It is also possible to launch QEMU as a non-root user and configure U=
NIX groups<br>
-for access to @code{/dev/kvm}, @code{/dev/net/tun}, and other device nodes=
.<br>
+for access to ``/dev/kvm``, ``/dev/net/tun``, and other device nodes.<br>
=C2=A0Some Linux distros already ship with UNIX groups for these devices by=
 default.<br>
<br>
-@itemize<br>
-@item SELinux and AppArmor make it possible to confine processes beyond th=
e<br>
-traditional UNIX process and file permissions model.=C2=A0 They restrict t=
he QEMU<br>
-process from accessing processes and files on the host system that are not=
<br>
-needed by QEMU.<br>
+- SELinux and AppArmor make it possible to confine processes beyond the<br=
>
+=C2=A0 traditional UNIX process and file permissions model.=C2=A0 They res=
trict the QEMU<br>
+=C2=A0 process from accessing processes and files on the host system that =
are not<br>
+=C2=A0 needed by QEMU.<br>
<br>
-@item Resource limits and cgroup controllers provide throughput and utiliz=
ation<br>
-limits on key resources such as CPU time, memory, and I/O bandwidth.<br>
+- Resource limits and cgroup controllers provide throughput and utilizatio=
n<br>
+=C2=A0 limits on key resources such as CPU time, memory, and I/O bandwidth=
.<br>
<br>
-@item Linux namespaces can be used to make process, file system, and other=
 system<br>
-resources unavailable to QEMU.=C2=A0 A namespaced QEMU process is restrict=
ed to only<br>
-those resources that were granted to it.<br>
+- Linux namespaces can be used to make process, file system, and other sys=
tem<br>
+=C2=A0 resources unavailable to QEMU.=C2=A0 A namespaced QEMU process is r=
estricted to only<br>
+=C2=A0 those resources that were granted to it.<br>
<br>
-@item Linux seccomp is available via the QEMU @option{--sandbox} option.=
=C2=A0 It disables<br>
-system calls that are not needed by QEMU, thereby reducing the host kernel=
<br>
-attack surface.<br>
-@end itemize<br>
+- Linux seccomp is available via the QEMU ``--sandbox`` option.=C2=A0 It d=
isables<br>
+=C2=A0 system calls that are not needed by QEMU, thereby reducing the host=
 kernel<br>
+=C2=A0 attack surface.<br>
<br>
-@section Sensitive configurations<br>
+Sensitive configurations<br>
+------------------------<br>
<br>
=C2=A0There are aspects of QEMU that can have security implications which u=
sers &amp;<br>
=C2=A0management applications must be aware of.<br>
<br>
-@subsection Monitor console (QMP and HMP)<br>
+Monitor console (QMP and HMP)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
<br>
=C2=A0The monitor console (whether used with QMP or HMP) provides an interf=
ace<br>
=C2=A0to dynamically control many aspects of QEMU&#39;s runtime operation. =
Many of the<br>
=C2=A0commands exposed will instruct QEMU to access content on the host fil=
e system<br>
=C2=A0and/or trigger spawning of external processes.<br>
<br>
-For example, the @code{migrate} command allows for the spawning of arbitra=
ry<br>
+For example, the ``migrate`` command allows for the spawning of arbitrary<=
br>
=C2=A0processes for the purpose of tunnelling the migration data stream. Th=
e<br>
-@code{blockdev-add} command instructs QEMU to open arbitrary files, exposi=
ng<br>
+``blockdev-add`` command instructs QEMU to open arbitrary files, exposing<=
br>
=C2=A0their content to the guest as a virtual disk.<br>
<br>
=C2=A0Unless QEMU is otherwise confined using technologies such as SELinux,=
 AppArmor,<br>
diff --git a/qemu-doc.texi b/qemu-doc.texi<br>
index 33b9597b1dc..c11b1a5d5ad 100644<br>
--- a/qemu-doc.texi<br>
+++ b/qemu-doc.texi<br>
@@ -40,7 +40,6 @@<br>
=C2=A0* QEMU System emulator for non PC targets::<br>
=C2=A0* QEMU User space emulator::<br>
=C2=A0* System requirements::<br>
-* Security::<br>
=C2=A0* Implementation notes::<br>
=C2=A0* Deprecated features::<br>
=C2=A0* Recently removed features::<br>
@@ -2836,8 +2835,6 @@ added with Linux 4.5 which is supported by the major =
distros. And even<br>
=C2=A0if RHEL7 has kernel 3.10, KVM there has the required functionality th=
ere<br>
=C2=A0to make it close to a 4.5 or newer kernel.<br>
<br>
-@include docs/security.texi<br>
-<br>
=C2=A0@include qemu-tech.texi<br>
<br>
=C2=A0@include qemu-deprecated.texi<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--0000000000006f2ea8059f792d87--

