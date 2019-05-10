Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E509C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF4D217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICYAV5C0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF4D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuDM-0004XR-1B
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:20:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hOuCM-0004B8-BV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hOuCJ-0005lG-Qo
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:19:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hOuCJ-0005kf-H6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:19:39 -0400
Received: by mail-ot1-x343.google.com with SMTP id f23so4105897otl.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=TirtAnEAr4dgD8ssSzW1QtvGdF697OhhsmL9O53O67w=;
	b=ICYAV5C0SD1w8STmvUbIeJypZFJrzMMqgm4EkrVFA8pVHxcel6a4zyxgPnyySSx8Ym
	Xcgydlx+hRZErAs0oEiF9Vi8meK/bO5MBqJK4Yhh3SIlUdGwI1fHGDXW2TQwG2RSsc0L
	2FXdpXfu1b0YDm8QZgfngy3Ic10GqMgS4CT8S++U09zXulsqAZY1MVlWiWDEyspfruhs
	GplaD2+WbywhtekylW0hGWeE6wzHJHAGvpAFYgO8n+zc9DQ9hpE5Q5GHcIrcRFU2nU66
	tCingf1/7PlXTxjDQbKrGnihWNXDdLe/U5604Laa03gxwLNiS3cAAeWVg53+KR5kIwMS
	XaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=TirtAnEAr4dgD8ssSzW1QtvGdF697OhhsmL9O53O67w=;
	b=IrFzOldSqRRrWpZ4Jg4/T9ulIhK1xuEvafgTnpHuvrMY1VzueDMdnvFSwnmWY2eU4X
	ud0bqX2UQpUIIrEL8dnYQ71+r0Ty9TxPYb9MOebc4SX3iQVmhoyqpzFjf12t9dzgc9iF
	6kbA+b8kif3f+JT2beP/irAtp1TggKUtcxXi2NE0wVtcCoVweKxT0N2FFuO+UQ4P90+T
	m+IhFBI9ZEu8aP2WK4Z6jOuof4ybpoGfSon/eUHeMMrmwO4U6MxGdyUCMz+SmV9ECrSF
	gltBzPeK5ihcMZreqMrDSuOfE9hC3KL24zexjltQMbPe8aXyLsoJDYH6YUd5RcLUxOAa
	iogQ==
X-Gm-Message-State: APjAAAV5K/aqbNBGdid8w0K6rBqXsy9ycFuXIgUFV4KymWYFHpUWZ8g/
	mRjTgm/ciJsOK/Kz56VWYklMiAb9s1zcAixv+e4=
X-Google-Smtp-Source: APXvYqxDyQk2zUhy3U3iMBZ4n310cTXIUiYLnzc0QI1NbtX9/6nYU8UCtUxmpZaFJXiH1qSqiwc/KcPEyXsoSaM0yJM=
X-Received: by 2002:a05:6830:14cd:: with SMTP id
	t13mr4685022otq.25.1557451178585; 
	Thu, 09 May 2019 18:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190509121820.16294-1-stefanha@redhat.com>
	<20190509121820.16294-3-stefanha@redhat.com>
In-Reply-To: <20190509121820.16294-3-stefanha@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 10 May 2019 09:19:02 +0800
Message-ID: <CAKXe6SLH=SKwOvvYUucXd4AoGfkFe7y8__b1RQRMd7ivikNgCw@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs: add Security chapter to the
 documentation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Qemu Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=889=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:20=E5=86=99=E9=81=93=EF=BC=9A

> This new chapter in the QEMU documentation covers the security
> requirements that QEMU is designed to meet and principles for securely
> deploying QEMU.
>
> It is just a starting point that can be extended in the future with more
> information.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>




>  Makefile           |   2 +-
>  docs/security.texi | 131 +++++++++++++++++++++++++++++++++++++++++++++
>  qemu-doc.texi      |   3 ++
>  3 files changed, 135 insertions(+), 1 deletion(-)
>  create mode 100644 docs/security.texi
>
> diff --git a/Makefile b/Makefile
> index d372493042..e2bc9c8c9d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -973,7 +973,7 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf
> qemu-doc.txt: \
>         qemu-img.texi qemu-nbd.texi qemu-options.texi
> qemu-option-trace.texi \
>         qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi
> qemu-ga.texi \
>         qemu-monitor-info.texi docs/qemu-block-drivers.texi \
> -       docs/qemu-cpu-models.texi
> +       docs/qemu-cpu-models.texi docs/security.texi
>
>  docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
>      docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
> diff --git a/docs/security.texi b/docs/security.texi
> new file mode 100644
> index 0000000000..927764f1e6
> --- /dev/null
> +++ b/docs/security.texi
> @@ -0,0 +1,131 @@
> +@node Security
> +@chapter Security
> +
> +@section Overview
> +
> +This chapter explains the security requirements that QEMU is designed to
> meet
> +and principles for securely deploying QEMU.
> +
> +@section Security Requirements
> +
> +QEMU supports many different use cases, some of which have stricter
> security
> +requirements than others.  The community has agreed on the overall
> security
> +requirements that users may depend on.  These requirements define what i=
s
> +considered supported from a security perspective.
> +
> +@subsection Virtualization Use Case
> +
> +The virtualization use case covers cloud and virtual private server (VPS=
)
> +hosting, as well as traditional data center and desktop virtualization.
> These
> +use cases rely on hardware virtualization extensions to execute guest co=
de
> +safely on the physical CPU at close-to-native speed.
> +
> +The following entities are untrusted, meaning that they may be buggy or
> +malicious:
> +
> +@itemize
> +@item Guest
> +@item User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> +@item Network protocols (e.g. NBD, live migration)
> +@item User-supplied files (e.g. disk images, kernels, device trees)
> +@item Passthrough devices (e.g. PCI, USB)
> +@end itemize
> +
> +Bugs affecting these entities are evaluated on whether they can cause
> damage in
> +real-world use cases and treated as security bugs if this is the case.
> +
> +@subsection Non-virtualization Use Case
> +
> +The non-virtualization use case covers emulation using the Tiny Code
> Generator
> +(TCG).  In principle the TCG and device emulation code used in
> conjunction with
> +the non-virtualization use case should meet the same security
> requirements as
> +the virtualization use case.  However, for historical reasons much of th=
e
> +non-virtualization use case code was not written with these security
> +requirements in mind.
> +
> +Bugs affecting the non-virtualization use case are not considered securi=
ty
> +bugs at this time.  Users with non-virtualization use cases must not rel=
y
> on
> +QEMU to provide guest isolation or any security guarantees.
> +
> +@section Architecture
> +
> +This section describes the design principles that ensure the security
> +requirements are met.
> +
> +@subsection Guest Isolation
> +
> +Guest isolation is the confinement of guest code to the virtual machine.
> When
> +guest code gains control of execution on the host this is called escapin=
g
> the
> +virtual machine.  Isolation also includes resource limits such as
> throttling of
> +CPU, memory, disk, or network.  Guests must be unable to exceed their
> resource
> +limits.
> +
> +QEMU presents an attack surface to the guest in the form of emulated
> devices.
> +The guest must not be able to gain control of QEMU.  Bugs in emulated
> devices
> +could allow malicious guests to gain code execution in QEMU.  At this
> point the
> +guest has escaped the virtual machine and is able to act in the context
> of the
> +QEMU process on the host.
> +
> +Guests often interact with other guests and share resources with them.  =
A
> +malicious guest must not gain control of other guests or access their
> data.
> +Disk image files and network traffic must be protected from other guests
> unless
> +explicitly shared between them by the user.
> +
> +@subsection Principle of Least Privilege
> +
> +The principle of least privilege states that each component only has
> access to
> +the privileges necessary for its function.  In the case of QEMU this
> means that
> +each process only has access to resources belonging to the guest.
> +
> +The QEMU process should not have access to any resources that are
> inaccessible
> +to the guest.  This way the guest does not gain anything by escaping int=
o
> the
> +QEMU process since it already has access to those same resources from
> within
> +the guest.
> +
> +Following the principle of least privilege immediately fulfills guest
> isolation
> +requirements.  For example, guest A only has access to its own disk imag=
e
> file
> +@code{a.img} and not guest B's disk image file @code{b.img}.
> +
> +In reality certain resources are inaccessible to the guest but must be
> +available to QEMU to perform its function.  For example, host system
> calls are
> +necessary for QEMU but are not exposed to guests.  A guest that escapes
> into
> +the QEMU process can then begin invoking host system calls.
> +
> +New features must be designed to follow the principle of least privilege=
.
> +Should this not be possible for technical reasons, the security risk mus=
t
> be
> +clearly documented so users are aware of the trade-off of enabling the
> feature.
> +
> +@subsection Isolation mechanisms
> +
> +Several isolation mechanisms are available to realize this architecture =
of
> +guest isolation and the principle of least privilege.  With the exceptio=
n
> of
> +Linux seccomp, these mechanisms are all deployed by management tools tha=
t
> +launch QEMU, such as libvirt.  They are also platform-specific so they
> are only
> +described briefly for Linux here.
> +
> +The fundamental isolation mechanism is that QEMU processes must run as
> +unprivileged users.  Sometimes it seems more convenient to launch QEMU a=
s
> +root to give it access to host devices (e.g. @code{/dev/net/tun}) but
> this poses a
> +huge security risk.  File descriptor passing can be used to give an
> otherwise
> +unprivileged QEMU process access to host devices without running QEMU as
> root.
> +It is also possible to launch QEMU as a non-root user and configure UNIX
> groups
> +for access to @code{/dev/kvm}, @code{/dev/net/tun}, and other device
> nodes.
> +Some Linux distros already ship with UNIX groups for these devices by
> default.
> +
> +@itemize
> +@item SELinux and AppArmor make it possible to confine processes beyond
> the
> +traditional UNIX process and file permissions model.  They restrict the
> QEMU
> +process from accessing processes and files on the host system that are n=
ot
> +needed by QEMU.
> +
> +@item Resource limits and cgroup controllers provide throughput and
> utilization
> +limits on key resources such as CPU time, memory, and I/O bandwidth.
> +
> +@item Linux namespaces can be used to make process, file system, and
> other system
> +resources unavailable to QEMU.  A namespaced QEMU process is restricted
> to only
> +those resources that were granted to it.
> +
> +@item Linux seccomp is available via the QEMU @option{--sandbox} option.
> It disables
> +system calls that are not needed by QEMU, thereby reducing the host kern=
el
> +attack surface.
> +@end itemize
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index ae3c3f9632..577d1e8376 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -38,6 +38,7 @@
>  * QEMU Guest Agent::
>  * QEMU User space emulator::
>  * System requirements::
> +* Security::
>  * Implementation notes::
>  * Deprecated features::
>  * Supported build platforms::
> @@ -2878,6 +2879,8 @@ added with Linux 4.5 which is supported by the majo=
r
> distros. And even
>  if RHEL7 has kernel 3.10, KVM there has the required functionality there
>  to make it close to a 4.5 or newer kernel.
>
> +@include docs/security.texi
> +
>  @include qemu-tech.texi
>
>  @include qemu-deprecated.texi
> --
> 2.21.0
>
>
>
