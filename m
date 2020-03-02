Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AF7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439112166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD8rFtGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439112166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jAg-0003qP-Cm
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8j9b-0002yk-5G
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8j9Q-0005gl-0z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:22:31 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8j9P-0005gf-At
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:22:19 -0500
Received: by mail-wm1-x32a.google.com with SMTP id f15so10697120wml.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZSP8Dcbm7kP5WTmVqNZYwXadOZbLxa7vpbUSdlwAZ7s=;
 b=rD8rFtGsFH8AYAn7LI0npyTKywcfMojaAWo2aAnaIAHvTjplAIhFoL0KFTnQ9HUF2K
 Pfpy5Lx5opqWgd1IoTtD22IN01g0RFvra2JD43by+2/k72NGPHS07q83Sl/BppmCBIrv
 F+7v0CcQi9cbLZtSrFILtajnacy/hhbnzeN0/FLBPoWBJHxLVJGv/ajAlvPQ/JqvNHnS
 Nm//Jzc2tSVj3kPuzdjdEsglb2TEatseeV6w4cR4zofN3J3dARkw+KfcajW/Wt7M32rp
 LpfhNewCdndgjSCzyISCdlEmstM1mwy9RxEBOYcyjCJpdxMQU1KDi8YL06hO2ct/3yOF
 WNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZSP8Dcbm7kP5WTmVqNZYwXadOZbLxa7vpbUSdlwAZ7s=;
 b=dnIii/mT9w76p4MtUVlqdIGApcE+/665ka41qKYLlOPYr2YPu8ULdSJv6KErHBGB5r
 7XAsNL1k0UD27ZeuE4StUHmlNXHojgUE7pSAVdj6UxZ2SF0A8hXQG4NPFxIPF36lFyWi
 DzvFTQfWs+IR2APytYoX4OrNT+9OvBVZy/UpSwbscNaIOHyyCHDL4Lu8vRjjXiQIwTHB
 CydwSdNKN4NLlZe93oCzXkFG+XV8LNVT1guNvlgbZAaph9Bv3CZFhWtmPk+NYFjz37tT
 76bjpiHmLN0Z9fXx65f6nNnmwN6p3Yj5Y5LS+FfDUSaraGv2QnHAnEGjY61VGg/l/+aa
 mJTA==
X-Gm-Message-State: APjAAAVIsSPKWWM2d+YbzULngAT3m2fwW7h2rtpsmEinmqKFZQfdcQla
 zxKzoPwluAb1ucQJwzwl3ubabg==
X-Google-Smtp-Source: APXvYqzujfZFyXcckg5Ptc96qrF5+vYrQ3nJM+rqQibdYH+UY/6b55eg5qZNppvsdRWa/9UgR7cFaw==
X-Received: by 2002:a1c:417:: with SMTP id 23mr14307076wme.92.1583148134990;
 Mon, 02 Mar 2020 03:22:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 12sm14979202wmo.30.2020.03.02.03.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:22:13 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 011911FF87;
 Mon,  2 Mar 2020 11:22:12 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-6-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 05/33] qemu-doc: split qemu-doc.texi in multiple files
In-reply-to: <20200228153619.9906-6-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:22:12 +0000
Message-ID: <87wo83atnf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> In order to facilitate the reorganization of qemu-doc.texi content,
> as well as the conversion to rST/Sphinx, split it in multiple .texi
> files that are included from docs/system.
>
> The "other devices" section is renamed to ivshmem and placed last.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-6-pbonzini@redhat.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile                         |   16 +
>  docs/system/build-platforms.texi |   67 ++
>  docs/system/gdb.texi             |   71 ++

The gdb test would be better served in docs/core if we could have
optional sections on invocation rendering depending on if it's built
with system emulation or linux-user docs. Is that something that's
already supported?

Anyway not holding this up:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>  docs/system/images.texi          |   88 ++
>  docs/system/invocation.texi      |  240 +++++
>  docs/system/ivshmem.texi         |   60 ++
>  docs/system/keys.texi            |   53 ++
>  docs/system/license.texi         |    9 +
>  docs/system/linuxboot.texi       |   27 +
>  docs/system/monitor.texi         |   35 +
>  docs/system/mux-chardev.texi     |   51 ++
>  docs/system/net.texi             |   96 ++
>  docs/system/quickstart.texi      |   13 +
>  docs/system/tls.texi             |  329 +++++++
>  docs/system/usb.texi             |  115 +++
>  docs/system/vnc-security.texi    |  196 ++++
>  qemu-doc.texi                    | 1471 +-----------------------------
>  17 files changed, 1483 insertions(+), 1454 deletions(-)
>  create mode 100644 docs/system/build-platforms.texi
>  create mode 100644 docs/system/gdb.texi
>  create mode 100644 docs/system/images.texi
>  create mode 100644 docs/system/invocation.texi
>  create mode 100644 docs/system/ivshmem.texi
>  create mode 100644 docs/system/keys.texi
>  create mode 100644 docs/system/license.texi
>  create mode 100644 docs/system/linuxboot.texi
>  create mode 100644 docs/system/monitor.texi
>  create mode 100644 docs/system/mux-chardev.texi
>  create mode 100644 docs/system/net.texi
>  create mode 100644 docs/system/quickstart.texi
>  create mode 100644 docs/system/tls.texi
>  create mode 100644 docs/system/usb.texi
>  create mode 100644 docs/system/vnc-security.texi
>
> diff --git a/Makefile b/Makefile
> index f75a7b51938..9790a0fd15b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1123,6 +1123,22 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.=
txt: \
>  	qemu-tech.texi qemu-option-trace.texi \
>  	qemu-deprecated.texi qemu-monitor.texi \
>  	qemu-monitor-info.texi \
> +        docs/system/quickstart.texi \
> +        docs/system/invocation.texi \
> +        docs/system/keys.texi \
> +        docs/system/mux-chardev.texi \
> +        docs/system/monitor.texi \
> +        docs/system/cpu-models-x86.texi \
> +        docs/system/images.texi \
> +        docs/system/net.texi \
> +        docs/system/usb.texi \
> +        docs/system/ivshmem.texi \
> +        docs/system/linuxboot.texi \
> +        docs/system/vnc-security.texi \
> +        docs/system/tls.texi \
> +        docs/system/gdb.texi \
> +        docs/system/build-platforms.texi \
> +        docs/system/license.texi \
>  	docs/system/cpu-models-x86.texi docs/system/cpu-models-mips.texi \
>  	docs/security.texi
>=20=20
> diff --git a/docs/system/build-platforms.texi b/docs/system/build-platfor=
ms.texi
> new file mode 100644
> index 00000000000..531ef5bed44
> --- /dev/null
> +++ b/docs/system/build-platforms.texi
> @@ -0,0 +1,67 @@
> +@node Supported build platforms
> +@appendix Supported build platforms
> +
> +QEMU aims to support building and executing on multiple host OS platform=
s.
> +This appendix outlines which platforms are the major build targets. These
> +platforms are used as the basis for deciding upon the minimum required
> +versions of 3rd party software QEMU depends on. The supported platforms
> +are the targets for automated testing performed by the project when patc=
hes
> +are submitted for review, and tested before and after merge.
> +
> +If a platform is not listed here, it does not imply that QEMU won't work.
> +If an unlisted platform has comparable software versions to a listed pla=
tform,
> +there is every expectation that it will work. Bug reports are welcome for
> +problems encountered on unlisted platforms unless they are clearly older
> +vintage than what is described here.
> +
> +Note that when considering software versions shipped in distros as suppo=
rt
> +targets, QEMU considers only the version number, and assumes the feature=
s in
> +that distro match the upstream release with the same version. In other w=
ords,
> +if a distro backports extra features to the software in their distro, QE=
MU
> +upstream code will not add explicit support for those backports, unless =
the
> +feature is auto-detectable in a manner that works for the upstream relea=
ses
> +too.
> +
> +The Repology site @url{https://repology.org} is a useful resource to ide=
ntify
> +currently shipped versions of software in various operating systems, tho=
ugh
> +it does not cover all distros listed below.
> +
> +@section Linux OS
> +
> +For distributions with frequent, short-lifetime releases, the project wi=
ll
> +aim to support all versions that are not end of life by their respective
> +vendors. For the purposes of identifying supported software versions, the
> +project will look at Fedora, Ubuntu, and openSUSE distros. Other short-
> +lifetime distros will be assumed to ship similar software versions.
> +
> +For distributions with long-lifetime releases, the project will aim to s=
upport
> +the most recent major version at all times. Support for the previous maj=
or
> +version will be dropped 2 years after the new major version is released,
> +or when it reaches ``end of life''. For the purposes of identifying
> +supported software versions, the project will look at RHEL, Debian,
> +Ubuntu LTS, and SLES distros. Other long-lifetime distros will be
> +assumed to ship similar software versions.
> +
> +@section Windows
> +
> +The project supports building with current versions of the MinGW toolcha=
in,
> +hosted on Linux.
> +
> +@section macOS
> +
> +The project supports building with the two most recent versions of macOS=
, with
> +the current homebrew package set available.
> +
> +@section FreeBSD
> +
> +The project aims to support the all the versions which are not end of li=
fe.
> +
> +@section NetBSD
> +
> +The project aims to support the most recent major version at all times. =
Support
> +for the previous major version will be dropped 2 years after the new maj=
or
> +version is released.
> +
> +@section OpenBSD
> +
> +The project aims to support the all the versions which are not end of li=
fe.
> diff --git a/docs/system/gdb.texi b/docs/system/gdb.texi
> new file mode 100644
> index 00000000000..f49bc5891e9
> --- /dev/null
> +++ b/docs/system/gdb.texi
> @@ -0,0 +1,71 @@
> +@node gdb_usage
> +@section GDB usage
> +
> +QEMU has a primitive support to work with gdb, so that you can do
> +'Ctrl-C' while the virtual machine is running and inspect its state.
> +
> +In order to use gdb, launch QEMU with the '-s' option. It will wait for a
> +gdb connection:
> +@example
> +@value{qemu_system} -s -kernel bzImage -hda rootdisk.img -append "root=
=3D/dev/hda"
> +Connected to host network interface: tun0
> +Waiting gdb connection on port 1234
> +@end example
> +
> +Then launch gdb on the 'vmlinux' executable:
> +@example
> +> gdb vmlinux
> +@end example
> +
> +In gdb, connect to QEMU:
> +@example
> +(gdb) target remote localhost:1234
> +@end example
> +
> +Then you can use gdb normally. For example, type 'c' to launch the kerne=
l:
> +@example
> +(gdb) c
> +@end example
> +
> +Here are some useful tips in order to use gdb on system code:
> +
> +@enumerate
> +@item
> +Use @code{info reg} to display all the CPU registers.
> +@item
> +Use @code{x/10i $eip} to display the code at the PC position.
> +@item
> +Use @code{set architecture i8086} to dump 16 bit code. Then use
> +@code{x/10i $cs*16+$eip} to dump the code at the PC position.
> +@end enumerate
> +
> +Advanced debugging options:
> +
> +The default single stepping behavior is step with the IRQs and timer ser=
vice routines off.  It is set this way because when gdb executes a single s=
tep it expects to advance beyond the current instruction.  With the IRQs an=
d timer service routines on, a single step might jump into the one of the i=
nterrupt or exception vectors instead of executing the current instruction.=
 This means you may hit the same breakpoint a number of times before execut=
ing the instruction gdb wants to have executed.  Because there are rare cir=
cumstances where you want to single step into an interrupt vector the behav=
ior can be controlled from GDB.  There are three commands you can query and=
 set the single step behavior:
> +@table @code
> +@item maintenance packet qqemu.sstepbits
> +
> +This will display the MASK bits used to control the single stepping IE:
> +@example
> +(gdb) maintenance packet qqemu.sstepbits
> +sending: "qqemu.sstepbits"
> +received: "ENABLE=3D1,NOIRQ=3D2,NOTIMER=3D4"
> +@end example
> +@item maintenance packet qqemu.sstep
> +
> +This will display the current value of the mask used when single steppin=
g IE:
> +@example
> +(gdb) maintenance packet qqemu.sstep
> +sending: "qqemu.sstep"
> +received: "0x7"
> +@end example
> +@item maintenance packet Qqemu.sstep=3DHEX_VALUE
> +
> +This will change the single step mask, so if wanted to enable IRQs on th=
e single step, but not timers, you would use:
> +@example
> +(gdb) maintenance packet Qqemu.sstep=3D0x5
> +sending: "qemu.sstep=3D0x5"
> +received: "OK"
> +@end example
> +@end table
> +
> diff --git a/docs/system/images.texi b/docs/system/images.texi
> new file mode 100644
> index 00000000000..c5060348ecc
> --- /dev/null
> +++ b/docs/system/images.texi
> @@ -0,0 +1,88 @@
> +@node disk_images
> +@section Disk Images
> +
> +QEMU supports many disk image formats, including growable disk images
> +(their size increase as non empty sectors are written), compressed and
> +encrypted disk images.
> +
> +@menu
> +* disk_images_quickstart::    Quick start for disk image creation
> +* disk_images_snapshot_mode:: Snapshot mode
> +* vm_snapshots::              VM snapshots
> +@end menu
> +
> +@node disk_images_quickstart
> +@subsection Quick start for disk image creation
> +
> +You can create a disk image with the command:
> +@example
> +qemu-img create myimage.img mysize
> +@end example
> +where @var{myimage.img} is the disk image filename and @var{mysize} is i=
ts
> +size in kilobytes. You can add an @code{M} suffix to give the size in
> +megabytes and a @code{G} suffix for gigabytes.
> +
> +@c When this document is converted to rst we should make this into
> +@c a proper linked reference to the qemu-img documentation again:
> +See the qemu-img invocation documentation for more information.
> +
> +@node disk_images_snapshot_mode
> +@subsection Snapshot mode
> +
> +If you use the option @option{-snapshot}, all disk images are
> +considered as read only. When sectors in written, they are written in
> +a temporary file created in @file{/tmp}. You can however force the
> +write back to the raw disk images by using the @code{commit} monitor
> +command (or @key{C-a s} in the serial console).
> +
> +@node vm_snapshots
> +@subsection VM snapshots
> +
> +VM snapshots are snapshots of the complete virtual machine including
> +CPU state, RAM, device state and the content of all the writable
> +disks. In order to use VM snapshots, you must have at least one non
> +removable and writable block device using the @code{qcow2} disk image
> +format. Normally this device is the first virtual hard drive.
> +
> +Use the monitor command @code{savevm} to create a new VM snapshot or
> +replace an existing one. A human readable name can be assigned to each
> +snapshot in addition to its numerical ID.
> +
> +Use @code{loadvm} to restore a VM snapshot and @code{delvm} to remove
> +a VM snapshot. @code{info snapshots} lists the available snapshots
> +with their associated information:
> +
> +@example
> +(qemu) info snapshots
> +Snapshot devices: hda
> +Snapshot list (from hda):
> +ID        TAG                 VM SIZE                DATE       VM CLOCK
> +1         start                   41M 2006-08-06 12:38:02   00:00:14.954
> +2                                 40M 2006-08-06 12:43:29   00:00:18.633
> +3         msys                    40M 2006-08-06 12:44:04   00:00:23.514
> +@end example
> +
> +A VM snapshot is made of a VM state info (its size is shown in
> +@code{info snapshots}) and a snapshot of every writable disk image.
> +The VM state info is stored in the first @code{qcow2} non removable
> +and writable block device. The disk image snapshots are stored in
> +every disk image. The size of a snapshot in a disk image is difficult
> +to evaluate and is not shown by @code{info snapshots} because the
> +associated disk sectors are shared among all the snapshots to save
> +disk space (otherwise each snapshot would need a full copy of all the
> +disk images).
> +
> +When using the (unrelated) @code{-snapshot} option
> +(@ref{disk_images_snapshot_mode}), you can always make VM snapshots,
> +but they are deleted as soon as you exit QEMU.
> +
> +VM snapshots currently have the following known limitations:
> +@itemize
> +@item
> +They cannot cope with removable devices if they are removed or
> +inserted after a snapshot is done.
> +@item
> +A few device drivers still have incomplete snapshot support so their
> +state is not saved or restored properly (in particular USB).
> +@end itemize
> +
> diff --git a/docs/system/invocation.texi b/docs/system/invocation.texi
> new file mode 100644
> index 00000000000..dac41cc7e55
> --- /dev/null
> +++ b/docs/system/invocation.texi
> @@ -0,0 +1,240 @@
> +@node sec_invocation
> +@section Invocation
> +
> +@example
> +@c man begin SYNOPSIS
> +@command{@value{qemu_system}} [@var{options}] [@var{disk_image}]
> +@c man end
> +@end example
> +
> +@c man begin OPTIONS
> +@var{disk_image} is a raw hard disk image for IDE hard disk 0. Some
> +targets do not need a disk image.
> +
> +@include qemu-options.texi
> +
> +@c man end
> +
> +@subsection Device URL Syntax
> +@c TODO merge this with section Disk Images
> +
> +@c man begin NOTES
> +
> +In addition to using normal file images for the emulated storage devices,
> +QEMU can also use networked resources such as iSCSI devices. These are
> +specified using a special URL syntax.
> +
> +@table @option
> +@item iSCSI
> +iSCSI support allows QEMU to access iSCSI resources directly and use as
> +images for the guest storage. Both disk and cdrom images are supported.
> +
> +Syntax for specifying iSCSI LUNs is
> +``iscsi://<target-ip>[:<port>]/<target-iqn>/<lun>''
> +
> +By default qemu will use the iSCSI initiator-name
> +'iqn.2008-11.org.linux-kvm[:<name>]' but this can also be set from the c=
ommand
> +line or a configuration file.
> +
> +Since version Qemu 2.4 it is possible to specify a iSCSI request timeout=
 to detect
> +stalled requests and force a reestablishment of the session. The timeout
> +is specified in seconds. The default is 0 which means no timeout. Libisc=
si
> +1.15.0 or greater is required for this feature.
> +
> +Example (without authentication):
> +@example
> +@value{qemu_system} -iscsi initiator-name=3Diqn.2001-04.com.example:my-i=
nitiator \
> +                 -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \
> +                 -drive file=3Discsi://192.0.2.1/iqn.2001-04.com.example=
/1
> +@end example
> +
> +Example (CHAP username/password via URL):
> +@example
> +@value{qemu_system} -drive file=3Discsi://user%password@@192.0.2.1/iqn.2=
001-04.com.example/1
> +@end example
> +
> +Example (CHAP username/password via environment variables):
> +@example
> +LIBISCSI_CHAP_USERNAME=3D"user" \
> +LIBISCSI_CHAP_PASSWORD=3D"password" \
> +@value{qemu_system} -drive file=3Discsi://192.0.2.1/iqn.2001-04.com.exam=
ple/1
> +@end example
> +
> +@item NBD
> +QEMU supports NBD (Network Block Devices) both using TCP protocol as well
> +as Unix Domain Sockets.  With TCP, the default port is 10809.
> +
> +Syntax for specifying a NBD device using TCP, in preferred URI form:
> +``nbd://<server-ip>[:<port>]/[<export>]''
> +
> +Syntax for specifying a NBD device using Unix Domain Sockets; remember
> +that '?' is a shell glob character and may need quoting:
> +``nbd+unix:///[<export>]?socket=3D<domain-socket>''
> +
> +Older syntax that is also recognized:
> +``nbd:<server-ip>:<port>[:exportname=3D<export>]''
> +
> +Syntax for specifying a NBD device using Unix Domain Sockets
> +``nbd:unix:<domain-socket>[:exportname=3D<export>]''
> +
> +Example for TCP
> +@example
> +@value{qemu_system} --drive file=3Dnbd:192.0.2.1:30000
> +@end example
> +
> +Example for Unix Domain Sockets
> +@example
> +@value{qemu_system} --drive file=3Dnbd:unix:/tmp/nbd-socket
> +@end example
> +
> +@item SSH
> +QEMU supports SSH (Secure Shell) access to remote disks.
> +
> +Examples:
> +@example
> +@value{qemu_system} -drive file=3Dssh://user@@host/path/to/disk.img
> +@value{qemu_system} -drive file.driver=3Dssh,file.user=3Duser,file.host=
=3Dhost,file.port=3D22,file.path=3D/path/to/disk.img
> +@end example
> +
> +Currently authentication must be done using ssh-agent.  Other
> +authentication methods may be supported in future.
> +
> +@item Sheepdog
> +Sheepdog is a distributed storage system for QEMU.
> +QEMU supports using either local sheepdog devices or remote networked
> +devices.
> +
> +Syntax for specifying a sheepdog device
> +@example
> +sheepdog[+tcp|+unix]://[host:port]/vdiname[?socket=3Dpath][#snapid|#tag]
> +@end example
> +
> +Example
> +@example
> +@value{qemu_system} --drive file=3Dsheepdog://192.0.2.1:30000/MyVirtualM=
achine
> +@end example
> +
> +See also @url{https://sheepdog.github.io/sheepdog/}.
> +
> +@item GlusterFS
> +GlusterFS is a user space distributed file system.
> +QEMU supports the use of GlusterFS volumes for hosting VM disk images us=
ing
> +TCP, Unix Domain Sockets and RDMA transport protocols.
> +
> +Syntax for specifying a VM disk image on GlusterFS volume is
> +@example
> +
> +URI:
> +gluster[+type]://[host[:port]]/volume/path[?socket=3D...][,debug=3DN][,l=
ogfile=3D...]
> +
> +JSON:
> +'json:@{"driver":"qcow2","file":@{"driver":"gluster","volume":"testvol",=
"path":"a.img","debug":N,"logfile":"...",
> +@                                 "server":[@{"type":"tcp","host":"...",=
"port":"..."@},
> +@                                           @{"type":"unix","socket":"..=
."@}]@}@}'
> +@end example
> +
> +
> +Example
> +@example
> +URI:
> +@value{qemu_system} --drive file=3Dgluster://192.0.2.1/testvol/a.img,
> +@                               file.debug=3D9,file.logfile=3D/var/log/q=
emu-gluster.log
> +
> +JSON:
> +@value{qemu_system} 'json:@{"driver":"qcow2",
> +@                          "file":@{"driver":"gluster",
> +@                                   "volume":"testvol","path":"a.img",
> +@                                   "debug":9,"logfile":"/var/log/qemu-g=
luster.log",
> +@                                   "server":[@{"type":"tcp","host":"1.2=
.3.4","port":24007@},
> +@                                             @{"type":"unix","socket":"=
/var/run/glusterd.socket"@}]@}@}'
> +@value{qemu_system} -drive driver=3Dqcow2,file.driver=3Dgluster,file.vol=
ume=3Dtestvol,file.path=3D/path/a.img,
> +@                                      file.debug=3D9,file.logfile=3D/va=
r/log/qemu-gluster.log,
> +@                                      file.server.0.type=3Dtcp,file.ser=
ver.0.host=3D1.2.3.4,file.server.0.port=3D24007,
> +@                                      file.server.1.type=3Dunix,file.se=
rver.1.socket=3D/var/run/glusterd.socket
> +@end example
> +
> +See also @url{http://www.gluster.org}.
> +
> +@item HTTP/HTTPS/FTP/FTPS
> +QEMU supports read-only access to files accessed over http(s) and ftp(s).
> +
> +Syntax using a single filename:
> +@example
> +<protocol>://[<username>[:<password>]@@]<host>/<path>
> +@end example
> +
> +where:
> +@table @option
> +@item protocol
> +'http', 'https', 'ftp', or 'ftps'.
> +
> +@item username
> +Optional username for authentication to the remote server.
> +
> +@item password
> +Optional password for authentication to the remote server.
> +
> +@item host
> +Address of the remote server.
> +
> +@item path
> +Path on the remote server, including any query string.
> +@end table
> +
> +The following options are also supported:
> +@table @option
> +@item url
> +The full URL when passing options to the driver explicitly.
> +
> +@item readahead
> +The amount of data to read ahead with each range request to the remote s=
erver.
> +This value may optionally have the suffix 'T', 'G', 'M', 'K', 'k' or 'b'=
. If it
> +does not have a suffix, it will be assumed to be in bytes. The value mus=
t be a
> +multiple of 512 bytes. It defaults to 256k.
> +
> +@item sslverify
> +Whether to verify the remote server's certificate when connecting over S=
SL. It
> +can have the value 'on' or 'off'. It defaults to 'on'.
> +
> +@item cookie
> +Send this cookie (it can also be a list of cookies separated by ';') with
> +each outgoing request.  Only supported when using protocols such as HTTP
> +which support cookies, otherwise ignored.
> +
> +@item timeout
> +Set the timeout in seconds of the CURL connection. This timeout is the t=
ime
> +that CURL waits for a response from the remote server to get the size of=
 the
> +image to be downloaded. If not set, the default timeout of 5 seconds is =
used.
> +@end table
> +
> +Note that when passing options to qemu explicitly, @option{driver} is th=
e value
> +of <protocol>.
> +
> +Example: boot from a remote Fedora 20 live ISO image
> +@example
> +@value{qemu_system_x86} --drive media=3Dcdrom,file=3Dhttps://archives.fe=
doraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Liv=
e-Desktop-x86_64-20-1.iso,readonly
> +
> +@value{qemu_system_x86} --drive media=3Dcdrom,file.driver=3Dhttp,file.ur=
l=3Dhttp://archives.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86=
_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
> +@end example
> +
> +Example: boot from a remote Fedora 20 cloud image using a local overlay =
for
> +writes, copy-on-read, and a readahead of 64k
> +@example
> +qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"http",=
, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linux/re=
leases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.read=
ahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
> +
> +@value{qemu_system_x86} -drive file=3D/tmp/Fedora-x86_64-20-20131211.1-s=
da.qcow2,copy-on-read=3Don
> +@end example
> +
> +Example: boot from an image stored on a VMware vSphere server with a sel=
f-signed
> +certificate using a local overlay for writes, a readahead of 64k and a t=
imeout
> +of 10 seconds.
> +@example
> +qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"https"=
,, "file.url":"https://user:password@@vsphere.example.com/folder/test/test-=
flat.vmdk?dcPath=3DDatacenter&dsName=3Ddatastore1",, "file.sslverify":"off"=
,, "file.readahead":"64k",, "file.timeout":10@}' /tmp/test.qcow2
> +
> +@value{qemu_system_x86} -drive file=3D/tmp/test.qcow2
> +@end example
> +
> +@end table
> +
> +@c man end
> +
> diff --git a/docs/system/ivshmem.texi b/docs/system/ivshmem.texi
> new file mode 100644
> index 00000000000..bd97719eaf7
> --- /dev/null
> +++ b/docs/system/ivshmem.texi
> @@ -0,0 +1,60 @@
> +@node pcsys_ivshmem
> +@section Inter-VM Shared Memory device
> +
> +On Linux hosts, a shared memory device is available.  The basic syntax
> +is:
> +
> +@example
> +@value{qemu_system_x86} -device ivshmem-plain,memdev=3D@var{hostmem}
> +@end example
> +
> +where @var{hostmem} names a host memory backend.  For a POSIX shared
> +memory backend, use something like
> +
> +@example
> +-object memory-backend-file,size=3D1M,share,mem-path=3D/dev/shm/ivshmem,=
id=3D@var{hostmem}
> +@end example
> +
> +If desired, interrupts can be sent between guest VMs accessing the same =
shared
> +memory region.  Interrupt support requires using a shared memory server =
and
> +using a chardev socket to connect to it.  The code for the shared memory=
 server
> +is qemu.git/contrib/ivshmem-server.  An example syntax when using the sh=
ared
> +memory server is:
> +
> +@example
> +# First start the ivshmem server once and for all
> +ivshmem-server -p @var{pidfile} -S @var{path} -m @var{shm-name} -l @var{=
shm-size} -n @var{vectors}
> +
> +# Then start your qemu instances with matching arguments
> +@value{qemu_system_x86} -device ivshmem-doorbell,vectors=3D@var{vectors}=
,chardev=3D@var{id}
> +                 -chardev socket,path=3D@var{path},id=3D@var{id}
> +@end example
> +
> +When using the server, the guest will be assigned a VM ID (>=3D0) that a=
llows guests
> +using the same server to communicate via interrupts.  Guests can read th=
eir
> +VM ID from a device register (see ivshmem-spec.txt).
> +
> +@subsection Migration with ivshmem
> +
> +With device property @option{master=3Don}, the guest will copy the shared
> +memory on migration to the destination host.  With @option{master=3Doff},
> +the guest will not be able to migrate with the device attached.  In the
> +latter case, the device should be detached and then reattached after
> +migration using the PCI hotplug support.
> +
> +At most one of the devices sharing the same memory can be master.  The
> +master must complete migration before you plug back the other devices.
> +
> +@subsection ivshmem and hugepages
> +
> +Instead of specifying the <shm size> using POSIX shm, you may specify
> +a memory backend that has hugepage support:
> +
> +@example
> +@value{qemu_system_x86} -object memory-backend-file,size=3D1G,mem-path=
=3D/dev/hugepages/my-shmem-file,share,id=3Dmb1
> +                 -device ivshmem-plain,memdev=3Dmb1
> +@end example
> +
> +ivshmem-server also supports hugepages mount points with the
> +@option{-m} memory path argument.
> +
> diff --git a/docs/system/keys.texi b/docs/system/keys.texi
> new file mode 100644
> index 00000000000..4c74b3bf4dd
> --- /dev/null
> +++ b/docs/system/keys.texi
> @@ -0,0 +1,53 @@
> +@node pcsys_keys
> +@section Keys in the graphical frontends
> +
> +@c man begin OPTIONS
> +
> +During the graphical emulation, you can use special key combinations to =
change
> +modes. The default key mappings are shown below, but if you use @code{-a=
lt-grab}
> +then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt) and if you use
> +@code{-ctrl-grab} then the modifier is the right Ctrl key (instead of Ct=
rl-Alt):
> +
> +@table @key
> +@item Ctrl-Alt-f
> +@kindex Ctrl-Alt-f
> +Toggle full screen
> +
> +@item Ctrl-Alt-+
> +@kindex Ctrl-Alt-+
> +Enlarge the screen
> +
> +@item Ctrl-Alt--
> +@kindex Ctrl-Alt--
> +Shrink the screen
> +
> +@item Ctrl-Alt-u
> +@kindex Ctrl-Alt-u
> +Restore the screen's un-scaled dimensions
> +
> +@item Ctrl-Alt-n
> +@kindex Ctrl-Alt-n
> +Switch to virtual console 'n'. Standard console mappings are:
> +@table @emph
> +@item 1
> +Target system display
> +@item 2
> +Monitor
> +@item 3
> +Serial port
> +@end table
> +
> +@item Ctrl-Alt
> +@kindex Ctrl-Alt
> +Toggle mouse and keyboard grab.
> +@end table
> +
> +@kindex Ctrl-Up
> +@kindex Ctrl-Down
> +@kindex Ctrl-PageUp
> +@kindex Ctrl-PageDown
> +In the virtual consoles, you can use @key{Ctrl-Up}, @key{Ctrl-Down},
> +@key{Ctrl-PageUp} and @key{Ctrl-PageDown} to move in the back log.
> +
> +@c man end
> +
> diff --git a/docs/system/license.texi b/docs/system/license.texi
> new file mode 100644
> index 00000000000..b682235a7e9
> --- /dev/null
> +++ b/docs/system/license.texi
> @@ -0,0 +1,9 @@
> +@node License
> +@appendix License
> +
> +QEMU is a trademark of Fabrice Bellard.
> +
> +QEMU is released under the
> +@url{https://www.gnu.org/licenses/gpl-2.0.txt,GNU General Public License=
},
> +version 2. Parts of QEMU have specific licenses, see file
> +@url{https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3DLICENSE,LICEN=
SE}.
> diff --git a/docs/system/linuxboot.texi b/docs/system/linuxboot.texi
> new file mode 100644
> index 00000000000..97c3cefae0a
> --- /dev/null
> +++ b/docs/system/linuxboot.texi
> @@ -0,0 +1,27 @@
> +@node direct_linux_boot
> +@section Direct Linux Boot
> +
> +This section explains how to launch a Linux kernel inside QEMU without
> +having to make a full bootable image. It is very useful for fast Linux
> +kernel testing.
> +
> +The syntax is:
> +@example
> +@value{qemu_system} -kernel bzImage -hda rootdisk.img -append "root=3D/d=
ev/hda"
> +@end example
> +
> +Use @option{-kernel} to provide the Linux kernel image and
> +@option{-append} to give the kernel command line arguments. The
> +@option{-initrd} option can be used to provide an INITRD image.
> +
> +If you do not need graphical output, you can disable it and redirect
> +the virtual serial port and the QEMU monitor to the console with the
> +@option{-nographic} option. The typical command line is:
> +@example
> +@value{qemu_system} -kernel bzImage -hda rootdisk.img \
> +                 -append "root=3D/dev/hda console=3DttyS0" -nographic
> +@end example
> +
> +Use @key{Ctrl-a c} to switch between the serial console and the
> +monitor (@pxref{pcsys_keys}).
> +
> diff --git a/docs/system/monitor.texi b/docs/system/monitor.texi
> new file mode 100644
> index 00000000000..c5b6a9b38e4
> --- /dev/null
> +++ b/docs/system/monitor.texi
> @@ -0,0 +1,35 @@
> +@node pcsys_monitor
> +@section QEMU Monitor
> +@cindex QEMU monitor
> +
> +The QEMU monitor is used to give complex commands to the QEMU
> +emulator. You can use it to:
> +
> +@itemize @minus
> +
> +@item
> +Remove or insert removable media images
> +(such as CD-ROM or floppies).
> +
> +@item
> +Freeze/unfreeze the Virtual Machine (VM) and save or restore its state
> +from a disk file.
> +
> +@item Inspect the VM state without an external debugger.
> +
> +@end itemize
> +
> +@subsection Commands
> +
> +The following commands are available:
> +
> +@include qemu-monitor.texi
> +
> +@include qemu-monitor-info.texi
> +
> +@subsection Integer expressions
> +
> +The monitor understands integers expressions for every integer
> +argument. You can use register names to get the value of specifics
> +CPU registers by prefixing them with @emph{$}.
> +
> diff --git a/docs/system/mux-chardev.texi b/docs/system/mux-chardev.texi
> new file mode 100644
> index 00000000000..c9a2d14cb88
> --- /dev/null
> +++ b/docs/system/mux-chardev.texi
> @@ -0,0 +1,51 @@
> +@node mux_keys
> +@section Keys in the character backend multiplexer
> +
> +@c man begin OPTIONS
> +
> +During emulation, if you are using a character backend multiplexer
> +(which is the default if you are using @option{-nographic}) then
> +several commands are available via an escape sequence. These
> +key sequences all start with an escape character, which is @key{Ctrl-a}
> +by default, but can be changed with @option{-echr}. The list below assum=
es
> +you're using the default.
> +
> +@table @key
> +@item Ctrl-a h
> +@kindex Ctrl-a h
> +Print this help
> +@item Ctrl-a x
> +@kindex Ctrl-a x
> +Exit emulator
> +@item Ctrl-a s
> +@kindex Ctrl-a s
> +Save disk data back to file (if -snapshot)
> +@item Ctrl-a t
> +@kindex Ctrl-a t
> +Toggle console timestamps
> +@item Ctrl-a b
> +@kindex Ctrl-a b
> +Send break (magic sysrq in Linux)
> +@item Ctrl-a c
> +@kindex Ctrl-a c
> +Rotate between the frontends connected to the multiplexer (usually
> +this switches between the monitor and the console)
> +@item Ctrl-a Ctrl-a
> +@kindex Ctrl-a Ctrl-a
> +Send the escape character to the frontend
> +@end table
> +@c man end
> +
> +@ignore
> +
> +@c man begin SEEALSO
> +The HTML documentation of QEMU for more precise information and Linux
> +user mode emulator invocation.
> +@c man end
> +
> +@c man begin AUTHOR
> +Fabrice Bellard
> +@c man end
> +
> +@end ignore
> +
> diff --git a/docs/system/net.texi b/docs/system/net.texi
> new file mode 100644
> index 00000000000..4a6fb2e6a8a
> --- /dev/null
> +++ b/docs/system/net.texi
> @@ -0,0 +1,96 @@
> +@node pcsys_network
> +@section Network emulation
> +
> +QEMU can simulate several network cards (e.g. PCI or ISA cards on the PC
> +target) and can connect them to a network backend on the host or an emul=
ated
> +hub. The various host network backends can either be used to connect the=
 NIC of
> +the guest to a real network (e.g. by using a TAP devices or the non-priv=
ileged
> +user mode network stack), or to other guest instances running in another=
 QEMU
> +process (e.g. by using the socket host network backend).
> +
> +@subsection Using TAP network interfaces
> +
> +This is the standard way to connect QEMU to a real network. QEMU adds
> +a virtual network device on your host (called @code{tapN}), and you
> +can then configure it as if it was a real ethernet card.
> +
> +@subsubsection Linux host
> +
> +As an example, you can download the @file{linux-test-xxx.tar.gz}
> +archive and copy the script @file{qemu-ifup} in @file{/etc} and
> +configure properly @code{sudo} so that the command @code{ifconfig}
> +contained in @file{qemu-ifup} can be executed as root. You must verify
> +that your host kernel supports the TAP network interfaces: the
> +device @file{/dev/net/tun} must be present.
> +
> +See @ref{sec_invocation} to have examples of command lines using the
> +TAP network interfaces.
> +
> +@subsubsection Windows host
> +
> +There is a virtual ethernet driver for Windows 2000/XP systems, called
> +TAP-Win32. But it is not included in standard QEMU for Windows,
> +so you will need to get it separately. It is part of OpenVPN package,
> +so download OpenVPN from : @url{https://openvpn.net/}.
> +
> +@subsection Using the user mode network stack
> +
> +By using the option @option{-net user} (default configuration if no
> +@option{-net} option is specified), QEMU uses a completely user mode
> +network stack (you don't need root privilege to use the virtual
> +network). The virtual network configuration is the following:
> +
> +@example
> +
> +     guest (10.0.2.15)  <------>  Firewall/DHCP server <-----> Internet
> +                           |          (10.0.2.2)
> +                           |
> +                           ---->  DNS server (10.0.2.3)
> +                           |
> +                           ---->  SMB server (10.0.2.4)
> +@end example
> +
> +The QEMU VM behaves as if it was behind a firewall which blocks all
> +incoming connections. You can use a DHCP client to automatically
> +configure the network in the QEMU VM. The DHCP server assign addresses
> +to the hosts starting from 10.0.2.15.
> +
> +In order to check that the user mode network is working, you can ping
> +the address 10.0.2.2 and verify that you got an address in the range
> +10.0.2.x from the QEMU virtual DHCP server.
> +
> +Note that ICMP traffic in general does not work with user mode networkin=
g.
> +@code{ping}, aka. ICMP echo, to the local router (10.0.2.2) shall work,
> +however. If you're using QEMU on Linux >=3D 3.0, it can use unprivileged=
 ICMP
> +ping sockets to allow @code{ping} to the Internet. The host admin has to=
 set
> +the ping_group_range in order to grant access to those sockets. To allow=
 ping
> +for GID 100 (usually users group):
> +
> +@example
> +echo 100 100 > /proc/sys/net/ipv4/ping_group_range
> +@end example
> +
> +When using the built-in TFTP server, the router is also the TFTP
> +server.
> +
> +When using the @option{'-netdev user,hostfwd=3D...'} option, TCP or UDP
> +connections can be redirected from the host to the guest. It allows for
> +example to redirect X11, telnet or SSH connections.
> +
> +@subsection Hubs
> +
> +QEMU can simulate several hubs. A hub can be thought of as a virtual con=
nection
> +between several network devices. These devices can be for example QEMU v=
irtual
> +ethernet cards or virtual Host ethernet devices (TAP devices). You can c=
onnect
> +guest NICs or host network backends to such a hub using the @option{-net=
dev
> +hubport} or @option{-nic hubport} options. The legacy @option{-net} opti=
on
> +also connects the given device to the emulated hub with ID 0 (i.e. the d=
efault
> +hub) unless you specify a netdev with @option{-net nic,netdev=3Dxxx} her=
e.
> +
> +@subsection Connecting emulated networks between QEMU instances
> +
> +Using the @option{-netdev socket} (or @option{-nic socket} or
> +@option{-net socket}) option, it is possible to create emulated
> +networks that span several QEMU instances.
> +See the description of the @option{-netdev socket} option in the
> +@ref{sec_invocation,,Invocation chapter} to have a basic example.
> diff --git a/docs/system/quickstart.texi b/docs/system/quickstart.texi
> new file mode 100644
> index 00000000000..8cd5b4bc6e5
> --- /dev/null
> +++ b/docs/system/quickstart.texi
> @@ -0,0 +1,13 @@
> +@node pcsys_quickstart
> +@section Quick Start
> +@cindex quick start
> +
> +Download and uncompress a hard disk image with Linux installed (e.g.
> +@file{linux.img}) and type:
> +
> +@example
> +@value{qemu_system} linux.img
> +@end example
> +
> +Linux should boot and give you a prompt.
> +
> diff --git a/docs/system/tls.texi b/docs/system/tls.texi
> new file mode 100644
> index 00000000000..c233531d3a1
> --- /dev/null
> +++ b/docs/system/tls.texi
> @@ -0,0 +1,329 @@
> +@node network_tls
> +@section TLS setup for network services
> +
> +Almost all network services in QEMU have the ability to use TLS for
> +session data encryption, along with x509 certificates for simple
> +client authentication. What follows is a description of how to
> +generate certificates suitable for usage with QEMU, and applies to
> +the VNC server, character devices with the TCP backend, NBD server
> +and client, and migration server and client.
> +
> +At a high level, QEMU requires certificates and private keys to be
> +provided in PEM format. Aside from the core fields, the certificates
> +should include various extension data sets, including v3 basic
> +constraints data, key purpose, key usage and subject alt name.
> +
> +The GnuTLS package includes a command called @code{certtool} which can
> +be used to easily generate certificates and keys in the required format
> +with expected data present. Alternatively a certificate management
> +service may be used.
> +
> +At a minimum it is necessary to setup a certificate authority, and
> +issue certificates to each server. If using x509 certificates for
> +authentication, then each client will also need to be issued a
> +certificate.
> +
> +Assuming that the QEMU network services will only ever be exposed to
> +clients on a private intranet, there is no need to use a commercial
> +certificate authority to create certificates. A self-signed CA is
> +sufficient, and in fact likely to be more secure since it removes
> +the ability of malicious 3rd parties to trick the CA into mis-issuing
> +certs for impersonating your services. The only likely exception
> +where a commercial CA might be desirable is if enabling the VNC
> +websockets server and exposing it directly to remote browser clients.
> +In such a case it might be useful to use a commercial CA to avoid
> +needing to install custom CA certs in the web browsers.
> +
> +The recommendation is for the server to keep its certificates in either
> +@code{/etc/pki/qemu} or for unprivileged users in @code{$HOME/.pki/qemu}.
> +
> +@menu
> +* tls_generate_ca::
> +* tls_generate_server::
> +* tls_generate_client::
> +* tls_creds_setup::
> +* tls_psk::
> +@end menu
> +@node tls_generate_ca
> +@subsection Setup the Certificate Authority
> +
> +This step only needs to be performed once per organization / organizatio=
nal
> +unit. First the CA needs a private key. This key must be kept VERY secret
> +and secure. If this key is compromised the entire trust chain of the cer=
tificates
> +issued with it is lost.
> +
> +@example
> +# certtool --generate-privkey > ca-key.pem
> +@end example
> +
> +To generate a self-signed certificate requires one core piece of informa=
tion,
> +the name of the organization. A template file @code{ca.info} should be
> +populated with the desired data to avoid having to deal with interactive
> +prompts from certtool:
> +@example
> +# cat > ca.info <<EOF
> +cn =3D Name of your organization
> +ca
> +cert_signing_key
> +EOF
> +# certtool --generate-self-signed \
> +           --load-privkey ca-key.pem
> +           --template ca.info \
> +           --outfile ca-cert.pem
> +@end example
> +
> +The @code{ca} keyword in the template sets the v3 basic constraints exte=
nsion
> +to indicate this certificate is for a CA, while @code{cert_signing_key} =
sets
> +the key usage extension to indicate this will be used for signing other =
keys.
> +The generated @code{ca-cert.pem} file should be copied to all servers and
> +clients wishing to utilize TLS support in the VNC server. The @code{ca-k=
ey.pem}
> +must not be disclosed/copied anywhere except the host responsible for is=
suing
> +certificates.
> +
> +@node tls_generate_server
> +@subsection Issuing server certificates
> +
> +Each server (or host) needs to be issued with a key and certificate. Whe=
n connecting
> +the certificate is sent to the client which validates it against the CA =
certificate.
> +The core pieces of information for a server certificate are the hostname=
s and/or IP
> +addresses that will be used by clients when connecting. The hostname / I=
P address
> +that the client specifies when connecting will be validated against the =
hostname(s)
> +and IP address(es) recorded in the server certificate, and if no match i=
s found
> +the client will close the connection.
> +
> +Thus it is recommended that the server certificate include both the full=
y qualified
> +and unqualified hostnames. If the server will have permanently assigned =
IP address(es),
> +and clients are likely to use them when connecting, they may also be inc=
luded in the
> +certificate. Both IPv4 and IPv6 addresses are supported. Historically ce=
rtificates
> +only included 1 hostname in the @code{CN} field, however, usage of this =
field for
> +validation is now deprecated. Instead modern TLS clients will validate a=
gainst the
> +Subject Alt Name extension data, which allows for multiple entries. In t=
he future
> +usage of the @code{CN} field may be discontinued entirely, so providing =
SAN
> +extension data is strongly recommended.
> +
> +On the host holding the CA, create template files containing the informa=
tion
> +for each server, and use it to issue server certificates.
> +
> +@example
> +# cat > server-hostNNN.info <<EOF
> +organization =3D Name  of your organization
> +cn =3D hostNNN.foo.example.com
> +dns_name =3D hostNNN
> +dns_name =3D hostNNN.foo.example.com
> +ip_address =3D 10.0.1.87
> +ip_address =3D 192.8.0.92
> +ip_address =3D 2620:0:cafe::87
> +ip_address =3D 2001:24::92
> +tls_www_server
> +encryption_key
> +signing_key
> +EOF
> +# certtool --generate-privkey > server-hostNNN-key.pem
> +# certtool --generate-certificate \
> +           --load-ca-certificate ca-cert.pem \
> +           --load-ca-privkey ca-key.pem \
> +           --load-privkey server-hostNNN-key.pem \
> +           --template server-hostNNN.info \
> +           --outfile server-hostNNN-cert.pem
> +@end example
> +
> +The @code{dns_name} and @code{ip_address} fields in the template are set=
ting
> +the subject alt name extension data. The @code{tls_www_server} keyword i=
s the
> +key purpose extension to indicate this certificate is intended for usage=
 in
> +a web server. Although QEMU network services are not in fact HTTP servers
> +(except for VNC websockets), setting this key purpose is still recommend=
ed.
> +The @code{encryption_key} and @code{signing_key} keyword is the key usage
> +extension to indicate this certificate is intended for usage in the data
> +session.
> +
> +The @code{server-hostNNN-key.pem} and @code{server-hostNNN-cert.pem} fil=
es
> +should now be securely copied to the server for which they were generate=
d,
> +and renamed to @code{server-key.pem} and @code{server-cert.pem} when add=
ed
> +to the @code{/etc/pki/qemu} directory on the target host. The @code{serv=
er-key.pem}
> +file is security sensitive and should be kept protected with file mode 0=
600
> +to prevent disclosure.
> +
> +@node tls_generate_client
> +@subsection Issuing client certificates
> +
> +The QEMU x509 TLS credential setup defaults to enabling client verificat=
ion
> +using certificates, providing a simple authentication mechanism. If this
> +default is used, each client also needs to be issued a certificate. The =
client
> +certificate contains enough metadata to uniquely identify the client wit=
h the
> +scope of the certificate authority. The client certificate would typical=
ly
> +include fields for organization, state, city, building, etc.
> +
> +Once again on the host holding the CA, create template files containing =
the
> +information for each client, and use it to issue client certificates.
> +
> +
> +@example
> +# cat > client-hostNNN.info <<EOF
> +country =3D GB
> +state =3D London
> +locality =3D City Of London
> +organization =3D Name of your organization
> +cn =3D hostNNN.foo.example.com
> +tls_www_client
> +encryption_key
> +signing_key
> +EOF
> +# certtool --generate-privkey > client-hostNNN-key.pem
> +# certtool --generate-certificate \
> +           --load-ca-certificate ca-cert.pem \
> +           --load-ca-privkey ca-key.pem \
> +           --load-privkey client-hostNNN-key.pem \
> +           --template client-hostNNN.info \
> +           --outfile client-hostNNN-cert.pem
> +@end example
> +
> +The subject alt name extension data is not required for clients, so the
> +the @code{dns_name} and @code{ip_address} fields are not included.
> +The @code{tls_www_client} keyword is the key purpose extension to indica=
te
> +this certificate is intended for usage in a web client. Although QEMU
> +network clients are not in fact HTTP clients, setting this key purpose is
> +still recommended. The @code{encryption_key} and @code{signing_key} keyw=
ord
> +is the key usage extension to indicate this certificate is intended for
> +usage in the data session.
> +
> +The @code{client-hostNNN-key.pem} and @code{client-hostNNN-cert.pem} fil=
es
> +should now be securely copied to the client for which they were generate=
d,
> +and renamed to @code{client-key.pem} and @code{client-cert.pem} when add=
ed
> +to the @code{/etc/pki/qemu} directory on the target host. The @code{clie=
nt-key.pem}
> +file is security sensitive and should be kept protected with file mode 0=
600
> +to prevent disclosure.
> +
> +If a single host is going to be using TLS in both a client and server
> +role, it is possible to create a single certificate to cover both roles.
> +This would be quite common for the migration and NBD services, where a
> +QEMU process will be started by accepting a TLS protected incoming migra=
tion,
> +and later itself be migrated out to another host. To generate a single
> +certificate, simply include the template data from both the client and s=
erver
> +instructions in one.
> +
> +@example
> +# cat > both-hostNNN.info <<EOF
> +country =3D GB
> +state =3D London
> +locality =3D City Of London
> +organization =3D Name of your organization
> +cn =3D hostNNN.foo.example.com
> +dns_name =3D hostNNN
> +dns_name =3D hostNNN.foo.example.com
> +ip_address =3D 10.0.1.87
> +ip_address =3D 192.8.0.92
> +ip_address =3D 2620:0:cafe::87
> +ip_address =3D 2001:24::92
> +tls_www_server
> +tls_www_client
> +encryption_key
> +signing_key
> +EOF
> +# certtool --generate-privkey > both-hostNNN-key.pem
> +# certtool --generate-certificate \
> +           --load-ca-certificate ca-cert.pem \
> +           --load-ca-privkey ca-key.pem \
> +           --load-privkey both-hostNNN-key.pem \
> +           --template both-hostNNN.info \
> +           --outfile both-hostNNN-cert.pem
> +@end example
> +
> +When copying the PEM files to the target host, save them twice,
> +once as @code{server-cert.pem} and @code{server-key.pem}, and
> +again as @code{client-cert.pem} and @code{client-key.pem}.
> +
> +@node tls_creds_setup
> +@subsection TLS x509 credential configuration
> +
> +QEMU has a standard mechanism for loading x509 credentials that will be
> +used for network services and clients. It requires specifying the
> +@code{tls-creds-x509} class name to the @code{--object} command line
> +argument for the system emulators.  Each set of credentials loaded should
> +be given a unique string identifier via the @code{id} parameter. A single
> +set of TLS credentials can be used for multiple network backends, so VNC,
> +migration, NBD, character devices can all share the same credentials. No=
te,
> +however, that credentials for use in a client endpoint must be loaded
> +separately from those used in a server endpoint.
> +
> +When specifying the object, the @code{dir} parameters specifies which
> +directory contains the credential files. This directory is expected to
> +contain files with the names mentioned previously, @code{ca-cert.pem},
> +@code{server-key.pem}, @code{server-cert.pem}, @code{client-key.pem}
> +and @code{client-cert.pem} as appropriate. It is also possible to
> +include a set of pre-generated Diffie-Hellman (DH) parameters in a file
> +@code{dh-params.pem}, which can be created using the
> +@code{certtool --generate-dh-params} command. If omitted, QEMU will
> +dynamically generate DH parameters when loading the credentials.
> +
> +The @code{endpoint} parameter indicates whether the credentials will
> +be used for a network client or server, and determines which PEM
> +files are loaded.
> +
> +The @code{verify} parameter determines whether x509 certificate
> +validation should be performed. This defaults to enabled, meaning
> +clients will always validate the server hostname against the
> +certificate subject alt name fields and/or CN field. It also
> +means that servers will request that clients provide a certificate
> +and validate them. Verification should never be turned off for
> +client endpoints, however, it may be turned off for server endpoints
> +if an alternative mechanism is used to authenticate clients. For
> +example, the VNC server can use SASL to authenticate clients
> +instead.
> +
> +To load server credentials with client certificate validation
> +enabled
> +
> +@example
> +@value{qemu_system} -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu=
,endpoint=3Dserver
> +@end example
> +
> +while to load client credentials use
> +
> +@example
> +@value{qemu_system} -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu=
,endpoint=3Dclient
> +@end example
> +
> +Network services which support TLS will all have a @code{tls-creds}
> +parameter which expects the ID of the TLS credentials object. For
> +example with VNC:
> +
> +@example
> +@value{qemu_system} -vnc 0.0.0.0:0,tls-creds=3Dtls0
> +@end example
> +
> +@node tls_psk
> +@subsection TLS Pre-Shared Keys (PSK)
> +
> +Instead of using certificates, you may also use TLS Pre-Shared Keys
> +(TLS-PSK).  This can be simpler to set up than certificates but is
> +less scalable.
> +
> +Use the GnuTLS @code{psktool} program to generate a @code{keys.psk}
> +file containing one or more usernames and random keys:
> +
> +@example
> +mkdir -m 0700 /tmp/keys
> +psktool -u rich -p /tmp/keys/keys.psk
> +@end example
> +
> +TLS-enabled servers such as qemu-nbd can use this directory like so:
> +
> +@example
> +qemu-nbd \
> +  -t -x / \
> +  --object tls-creds-psk,id=3Dtls0,endpoint=3Dserver,dir=3D/tmp/keys \
> +  --tls-creds tls0 \
> +  image.qcow2
> +@end example
> +
> +When connecting from a qemu-based client you must specify the
> +directory containing @code{keys.psk} and an optional @var{username}
> +(defaults to ``qemu''):
> +
> +@example
> +qemu-img info \
> +  --object tls-creds-psk,id=3Dtls0,dir=3D/tmp/keys,username=3Drich,endpo=
int=3Dclient \
> +  --image-opts \
> +  file.driver=3Dnbd,file.host=3Dlocalhost,file.port=3D10809,file.tls-cre=
ds=3Dtls0,file.export=3D/
> +@end example
> +
> diff --git a/docs/system/usb.texi b/docs/system/usb.texi
> new file mode 100644
> index 00000000000..840adac9785
> --- /dev/null
> +++ b/docs/system/usb.texi
> @@ -0,0 +1,115 @@
> +@node pcsys_usb
> +@section USB emulation
> +
> +QEMU can emulate a PCI UHCI, OHCI, EHCI or XHCI USB controller. You can
> +plug virtual USB devices or real host USB devices (only works with certa=
in
> +host operating systems). QEMU will automatically create and connect virt=
ual
> +USB hubs as necessary to connect multiple USB devices.
> +
> +@menu
> +* usb_devices::
> +* host_usb_devices::
> +@end menu
> +@node usb_devices
> +@subsection Connecting USB devices
> +
> +USB devices can be connected with the @option{-device usb-...} command l=
ine
> +option or the @code{device_add} monitor command. Available devices are:
> +
> +@table @code
> +@item usb-mouse
> +Virtual Mouse.  This will override the PS/2 mouse emulation when activat=
ed.
> +@item usb-tablet
> +Pointer device that uses absolute coordinates (like a touchscreen).
> +This means QEMU is able to report the mouse position without having
> +to grab the mouse.  Also overrides the PS/2 mouse emulation when activat=
ed.
> +@item usb-storage,drive=3D@var{drive_id}
> +Mass storage device backed by @var{drive_id} (@pxref{disk_images})
> +@item usb-uas
> +USB attached SCSI device, see
> +@url{https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/usb-stor=
age.txt,usb-storage.txt}
> +for details
> +@item usb-bot
> +Bulk-only transport storage device, see
> +@url{https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/usb-stor=
age.txt,usb-storage.txt}
> +for details here, too
> +@item usb-mtp,rootdir=3D@var{dir}
> +Media transfer protocol device, using @var{dir} as root of the file tree
> +that is presented to the guest.
> +@item usb-host,hostbus=3D@var{bus},hostaddr=3D@var{addr}
> +Pass through the host device identified by @var{bus} and @var{addr}
> +@item usb-host,vendorid=3D@var{vendor},productid=3D@var{product}
> +Pass through the host device identified by @var{vendor} and @var{product=
} ID
> +@item usb-wacom-tablet
> +Virtual Wacom PenPartner tablet.  This device is similar to the @code{ta=
blet}
> +above but it can be used with the tslib library because in addition to t=
ouch
> +coordinates it reports touch pressure.
> +@item usb-kbd
> +Standard USB keyboard.  Will override the PS/2 keyboard (if present).
> +@item usb-serial,chardev=3D@var{id}
> +Serial converter. This emulates an FTDI FT232BM chip connected to host c=
haracter
> +device @var{id}.
> +@item usb-braille,chardev=3D@var{id}
> +Braille device.  This will use BrlAPI to display the braille output on a=
 real
> +or fake device referenced by @var{id}.
> +@item usb-net[,netdev=3D@var{id}]
> +Network adapter that supports CDC ethernet and RNDIS protocols.  @var{id}
> +specifies a netdev defined with @code{-netdev @dots{},id=3D@var{id}}.
> +For instance, user-mode networking can be used with
> +@example
> +@value{qemu_system} [...] -netdev user,id=3Dnet0 -device usb-net,netdev=
=3Dnet0
> +@end example
> +@item usb-ccid
> +Smartcard reader device
> +@item usb-audio
> +USB audio device
> +@end table
> +
> +@node host_usb_devices
> +@subsection Using host USB devices on a Linux host
> +
> +WARNING: this is an experimental feature. QEMU will slow down when
> +using it. USB devices requiring real time streaming (i.e. USB Video
> +Cameras) are not supported yet.
> +
> +@enumerate
> +@item If you use an early Linux 2.4 kernel, verify that no Linux driver
> +is actually using the USB device. A simple way to do that is simply to
> +disable the corresponding kernel module by renaming it from @file{mydriv=
er.o}
> +to @file{mydriver.o.disabled}.
> +
> +@item Verify that @file{/proc/bus/usb} is working (most Linux distributi=
ons should enable it by default). You should see something like that:
> +@example
> +ls /proc/bus/usb
> +001  devices  drivers
> +@end example
> +
> +@item Since only root can access to the USB devices directly, you can ei=
ther launch QEMU as root or change the permissions of the USB devices you w=
ant to use. For testing, the following suffices:
> +@example
> +chown -R myuid /proc/bus/usb
> +@end example
> +
> +@item Launch QEMU and do in the monitor:
> +@example
> +info usbhost
> +  Device 1.2, speed 480 Mb/s
> +    Class 00: USB device 1234:5678, USB DISK
> +@end example
> +You should see the list of the devices you can use (Never try to use
> +hubs, it won't work).
> +
> +@item Add the device in QEMU by using:
> +@example
> +device_add usb-host,vendorid=3D0x1234,productid=3D0x5678
> +@end example
> +
> +Normally the guest OS should report that a new USB device is plugged.
> +You can use the option @option{-device usb-host,...} to do the same.
> +
> +@item Now you can try to use the host USB device in QEMU.
> +
> +@end enumerate
> +
> +When relaunching QEMU, you may have to unplug and plug again the USB
> +device to make it work again (this is a bug).
> +
> diff --git a/docs/system/vnc-security.texi b/docs/system/vnc-security.texi
> new file mode 100644
> index 00000000000..abf7f7fa43a
> --- /dev/null
> +++ b/docs/system/vnc-security.texi
> @@ -0,0 +1,196 @@
> +@node vnc_security
> +@section VNC security
> +
> +The VNC server capability provides access to the graphical console
> +of the guest VM across the network. This has a number of security
> +considerations depending on the deployment scenarios.
> +
> +@menu
> +* vnc_sec_none::
> +* vnc_sec_password::
> +* vnc_sec_certificate::
> +* vnc_sec_certificate_verify::
> +* vnc_sec_certificate_pw::
> +* vnc_sec_sasl::
> +* vnc_sec_certificate_sasl::
> +* vnc_setup_sasl::
> +@end menu
> +@node vnc_sec_none
> +@subsection Without passwords
> +
> +The simplest VNC server setup does not include any form of authenticatio=
n.
> +For this setup it is recommended to restrict it to listen on a UNIX doma=
in
> +socket only. For example
> +
> +@example
> +@value{qemu_system} [...OPTIONS...] -vnc unix:/home/joebloggs/.qemu-myvm=
-vnc
> +@end example
> +
> +This ensures that only users on local box with read/write access to that
> +path can access the VNC server. To securely access the VNC server from a
> +remote machine, a combination of netcat+ssh can be used to provide a sec=
ure
> +tunnel.
> +
> +@node vnc_sec_password
> +@subsection With passwords
> +
> +The VNC protocol has limited support for password based authentication. =
Since
> +the protocol limits passwords to 8 characters it should not be considered
> +to provide high security. The password can be fairly easily brute-forced=
 by
> +a client making repeat connections. For this reason, a VNC server using =
password
> +authentication should be restricted to only listen on the loopback inter=
face
> +or UNIX domain sockets. Password authentication is not supported when op=
erating
> +in FIPS 140-2 compliance mode as it requires the use of the DES cipher. =
Password
> +authentication is requested with the @code{password} option, and then on=
ce QEMU
> +is running the password is set with the monitor. Until the monitor is us=
ed to
> +set the password all clients will be rejected.
> +
> +@example
> +@value{qemu_system} [...OPTIONS...] -vnc :1,password -monitor stdio
> +(qemu) change vnc password
> +Password: ********
> +(qemu)
> +@end example
> +
> +@node vnc_sec_certificate
> +@subsection With x509 certificates
> +
> +The QEMU VNC server also implements the VeNCrypt extension allowing use =
of
> +TLS for encryption of the session, and x509 certificates for authenticat=
ion.
> +The use of x509 certificates is strongly recommended, because TLS on its
> +own is susceptible to man-in-the-middle attacks. Basic x509 certificate
> +support provides a secure session, but no authentication. This allows any
> +client to connect, and provides an encrypted session.
> +
> +@example
> +@value{qemu_system} [...OPTIONS...] \
> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dno \
> +  -vnc :1,tls-creds=3Dtls0 -monitor stdio
> +@end example
> +
> +In the above example @code{/etc/pki/qemu} should contain at least three =
files,
> +@code{ca-cert.pem}, @code{server-cert.pem} and @code{server-key.pem}. Un=
privileged
> +users will want to use a private directory, for example @code{$HOME/.pki=
/qemu}.
> +NB the @code{server-key.pem} file should be protected with file mode 060=
0 to
> +only be readable by the user owning it.
> +
> +@node vnc_sec_certificate_verify
> +@subsection With x509 certificates and client verification
> +
> +Certificates can also provide a means to authenticate the client connect=
ing.
> +The server will request that the client provide a certificate, which it =
will
> +then validate against the CA certificate. This is a good choice if deplo=
ying
> +in an environment with a private internal certificate authority. It uses=
 the
> +same syntax as previously, but with @code{verify-peer} set to @code{yes}
> +instead.
> +
> +@example
> +@value{qemu_system} [...OPTIONS...] \
> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dyes \
> +  -vnc :1,tls-creds=3Dtls0 -monitor stdio
> +@end example
> +
> +
> +@node vnc_sec_certificate_pw
> +@subsection With x509 certificates, client verification and passwords
> +
> +Finally, the previous method can be combined with VNC password authentic=
ation
> +to provide two layers of authentication for clients.
> +
> +@example
> +@value{qemu_system} [...OPTIONS...] \
> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dyes \
> +  -vnc :1,tls-creds=3Dtls0,password -monitor stdio
> +(qemu) change vnc password
> +Password: ********
> +(qemu)
> +@end example
> +
> +
> +@node vnc_sec_sasl
> +@subsection With SASL authentication
> +
> +The SASL authentication method is a VNC extension, that provides an
> +easily extendable, pluggable authentication method. This allows for
> +integration with a wide range of authentication mechanisms, such as
> +PAM, GSSAPI/Kerberos, LDAP, SQL databases, one-time keys and more.
> +The strength of the authentication depends on the exact mechanism
> +configured. If the chosen mechanism also provides a SSF layer, then
> +it will encrypt the datastream as well.
> +
> +Refer to the later docs on how to choose the exact SASL mechanism
> +used for authentication, but assuming use of one supporting SSF,
> +then QEMU can be launched with:
> +
> +@example
> +@value{qemu_system} [...OPTIONS...] -vnc :1,sasl -monitor stdio
> +@end example
> +
> +@node vnc_sec_certificate_sasl
> +@subsection With x509 certificates and SASL authentication
> +
> +If the desired SASL authentication mechanism does not supported
> +SSF layers, then it is strongly advised to run it in combination
> +with TLS and x509 certificates. This provides securely encrypted
> +data stream, avoiding risk of compromising of the security
> +credentials. This can be enabled, by combining the 'sasl' option
> +with the aforementioned TLS + x509 options:
> +
> +@example
> +@value{qemu_system} [...OPTIONS...] \
> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dyes \
> +  -vnc :1,tls-creds=3Dtls0,sasl -monitor stdio
> +@end example
> +
> +@node vnc_setup_sasl
> +
> +@subsection Configuring SASL mechanisms
> +
> +The following documentation assumes use of the Cyrus SASL implementation=
 on a
> +Linux host, but the principles should apply to any other SASL implementa=
tion
> +or host. When SASL is enabled, the mechanism configuration will be loade=
d from
> +system default SASL service config /etc/sasl2/qemu.conf. If running QEMU=
 as an
> +unprivileged user, an environment variable SASL_CONF_PATH can be used to=
 make
> +it search alternate locations for the service config file.
> +
> +If the TLS option is enabled for VNC, then it will provide session encry=
ption,
> +otherwise the SASL mechanism will have to provide encryption. In the lat=
ter
> +case the list of possible plugins that can be used is drastically reduce=
d. In
> +fact only the GSSAPI SASL mechanism provides an acceptable level of secu=
rity
> +by modern standards. Previous versions of QEMU referred to the DIGEST-MD5
> +mechanism, however, it has multiple serious flaws described in detail in
> +RFC 6331 and thus should never be used any more. The SCRAM-SHA-1 mechani=
sm
> +provides a simple username/password auth facility similar to DIGEST-MD5,=
 but
> +does not support session encryption, so can only be used in combination =
with
> +TLS.
> +
> +When not using TLS the recommended configuration is
> +
> +@example
> +mech_list: gssapi
> +keytab: /etc/qemu/krb5.tab
> +@end example
> +
> +This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol, w=
ith
> +the server principal stored in /etc/qemu/krb5.tab. For this to work the
> +administrator of your KDC must generate a Kerberos principal for the ser=
ver,
> +with a name of 'qemu/somehost.example.com@@EXAMPLE.COM' replacing
> +'somehost.example.com' with the fully qualified host name of the machine
> +running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
> +
> +When using TLS, if username+password authentication is desired, then a
> +reasonable configuration is
> +
> +@example
> +mech_list: scram-sha-1
> +sasldb_path: /etc/qemu/passwd.db
> +@end example
> +
> +The @code{saslpasswd2} program can be used to populate the @code{passwd.=
db}
> +file with accounts.
> +
> +Other SASL configurations will be left as an exercise for the reader. No=
te that
> +all mechanisms, except GSSAPI, should be combined with use of TLS to ens=
ure a
> +secure data channel.
> +
> +
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 617a701b678..33d24caf946 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -142,9 +142,9 @@ accelerator is required to use more than one host CPU=
 for emulation.
>  * cpu_models_x86::     Supported CPU model configurations on x86 hosts
>  * disk_images::        Disk Images
>  * pcsys_network::      Network emulation
> -* pcsys_other_devs::   Other Devices
> -* direct_linux_boot::  Direct Linux Boot
>  * pcsys_usb::          USB emulation
> +* pcsys_ivshmem::      Inter-VM Shared Memory device
> +* direct_linux_boot::  Direct Linux Boot
>  * vnc_security::       VNC security
>  * network_tls::        TLS setup for network services
>  * gdb_usage::          GDB usage
> @@ -222,1384 +222,20 @@ CS4231A is the chip used in Windows Sound System =
and GUSMAX products
>=20=20
>  @c man end
>=20=20
> -@node pcsys_quickstart
> -@section Quick Start
> -@cindex quick start
> -
> -Download and uncompress a hard disk image with Linux installed (e.g.
> -@file{linux.img}) and type:
> -
> -@example
> -@value{qemu_system} linux.img
> -@end example
> -
> -Linux should boot and give you a prompt.
> -
> -@node sec_invocation
> -@section Invocation
> -
> -@example
> -@c man begin SYNOPSIS
> -@command{@value{qemu_system}} [@var{options}] [@var{disk_image}]
> -@c man end
> -@end example
> -
> -@c man begin OPTIONS
> -@var{disk_image} is a raw hard disk image for IDE hard disk 0. Some
> -targets do not need a disk image.
> -
> -@include qemu-options.texi
> -
> -@c man end
> -
> -@subsection Device URL Syntax
> -@c TODO merge this with section Disk Images
> -
> -@c man begin NOTES
> -
> -In addition to using normal file images for the emulated storage devices,
> -QEMU can also use networked resources such as iSCSI devices. These are
> -specified using a special URL syntax.
> -
> -@table @option
> -@item iSCSI
> -iSCSI support allows QEMU to access iSCSI resources directly and use as
> -images for the guest storage. Both disk and cdrom images are supported.
> -
> -Syntax for specifying iSCSI LUNs is
> -``iscsi://<target-ip>[:<port>]/<target-iqn>/<lun>''
> -
> -By default qemu will use the iSCSI initiator-name
> -'iqn.2008-11.org.linux-kvm[:<name>]' but this can also be set from the c=
ommand
> -line or a configuration file.
> -
> -Since version Qemu 2.4 it is possible to specify a iSCSI request timeout=
 to detect
> -stalled requests and force a reestablishment of the session. The timeout
> -is specified in seconds. The default is 0 which means no timeout. Libisc=
si
> -1.15.0 or greater is required for this feature.
> -
> -Example (without authentication):
> -@example
> -@value{qemu_system} -iscsi initiator-name=3Diqn.2001-04.com.example:my-i=
nitiator \
> -                 -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \
> -                 -drive file=3Discsi://192.0.2.1/iqn.2001-04.com.example=
/1
> -@end example
> -
> -Example (CHAP username/password via URL):
> -@example
> -@value{qemu_system} -drive file=3Discsi://user%password@@192.0.2.1/iqn.2=
001-04.com.example/1
> -@end example
> -
> -Example (CHAP username/password via environment variables):
> -@example
> -LIBISCSI_CHAP_USERNAME=3D"user" \
> -LIBISCSI_CHAP_PASSWORD=3D"password" \
> -@value{qemu_system} -drive file=3Discsi://192.0.2.1/iqn.2001-04.com.exam=
ple/1
> -@end example
> -
> -@item NBD
> -QEMU supports NBD (Network Block Devices) both using TCP protocol as well
> -as Unix Domain Sockets.  With TCP, the default port is 10809.
> -
> -Syntax for specifying a NBD device using TCP, in preferred URI form:
> -``nbd://<server-ip>[:<port>]/[<export>]''
> -
> -Syntax for specifying a NBD device using Unix Domain Sockets; remember
> -that '?' is a shell glob character and may need quoting:
> -``nbd+unix:///[<export>]?socket=3D<domain-socket>''
> -
> -Older syntax that is also recognized:
> -``nbd:<server-ip>:<port>[:exportname=3D<export>]''
> -
> -Syntax for specifying a NBD device using Unix Domain Sockets
> -``nbd:unix:<domain-socket>[:exportname=3D<export>]''
> -
> -Example for TCP
> -@example
> -@value{qemu_system} --drive file=3Dnbd:192.0.2.1:30000
> -@end example
> -
> -Example for Unix Domain Sockets
> -@example
> -@value{qemu_system} --drive file=3Dnbd:unix:/tmp/nbd-socket
> -@end example
> -
> -@item SSH
> -QEMU supports SSH (Secure Shell) access to remote disks.
> -
> -Examples:
> -@example
> -@value{qemu_system} -drive file=3Dssh://user@@host/path/to/disk.img
> -@value{qemu_system} -drive file.driver=3Dssh,file.user=3Duser,file.host=
=3Dhost,file.port=3D22,file.path=3D/path/to/disk.img
> -@end example
> -
> -Currently authentication must be done using ssh-agent.  Other
> -authentication methods may be supported in future.
> -
> -@item Sheepdog
> -Sheepdog is a distributed storage system for QEMU.
> -QEMU supports using either local sheepdog devices or remote networked
> -devices.
> -
> -Syntax for specifying a sheepdog device
> -@example
> -sheepdog[+tcp|+unix]://[host:port]/vdiname[?socket=3Dpath][#snapid|#tag]
> -@end example
> -
> -Example
> -@example
> -@value{qemu_system} --drive file=3Dsheepdog://192.0.2.1:30000/MyVirtualM=
achine
> -@end example
> -
> -See also @url{https://sheepdog.github.io/sheepdog/}.
> -
> -@item GlusterFS
> -GlusterFS is a user space distributed file system.
> -QEMU supports the use of GlusterFS volumes for hosting VM disk images us=
ing
> -TCP, Unix Domain Sockets and RDMA transport protocols.
> -
> -Syntax for specifying a VM disk image on GlusterFS volume is
> -@example
> -
> -URI:
> -gluster[+type]://[host[:port]]/volume/path[?socket=3D...][,debug=3DN][,l=
ogfile=3D...]
> -
> -JSON:
> -'json:@{"driver":"qcow2","file":@{"driver":"gluster","volume":"testvol",=
"path":"a.img","debug":N,"logfile":"...",
> -@                                 "server":[@{"type":"tcp","host":"...",=
"port":"..."@},
> -@                                           @{"type":"unix","socket":"..=
."@}]@}@}'
> -@end example
> -
> -
> -Example
> -@example
> -URI:
> -@value{qemu_system} --drive file=3Dgluster://192.0.2.1/testvol/a.img,
> -@                               file.debug=3D9,file.logfile=3D/var/log/q=
emu-gluster.log
> -
> -JSON:
> -@value{qemu_system} 'json:@{"driver":"qcow2",
> -@                          "file":@{"driver":"gluster",
> -@                                   "volume":"testvol","path":"a.img",
> -@                                   "debug":9,"logfile":"/var/log/qemu-g=
luster.log",
> -@                                   "server":[@{"type":"tcp","host":"1.2=
.3.4","port":24007@},
> -@                                             @{"type":"unix","socket":"=
/var/run/glusterd.socket"@}]@}@}'
> -@value{qemu_system} -drive driver=3Dqcow2,file.driver=3Dgluster,file.vol=
ume=3Dtestvol,file.path=3D/path/a.img,
> -@                                      file.debug=3D9,file.logfile=3D/va=
r/log/qemu-gluster.log,
> -@                                      file.server.0.type=3Dtcp,file.ser=
ver.0.host=3D1.2.3.4,file.server.0.port=3D24007,
> -@                                      file.server.1.type=3Dunix,file.se=
rver.1.socket=3D/var/run/glusterd.socket
> -@end example
> -
> -See also @url{http://www.gluster.org}.
> -
> -@item HTTP/HTTPS/FTP/FTPS
> -QEMU supports read-only access to files accessed over http(s) and ftp(s).
> -
> -Syntax using a single filename:
> -@example
> -<protocol>://[<username>[:<password>]@@]<host>/<path>
> -@end example
> -
> -where:
> -@table @option
> -@item protocol
> -'http', 'https', 'ftp', or 'ftps'.
> -
> -@item username
> -Optional username for authentication to the remote server.
> -
> -@item password
> -Optional password for authentication to the remote server.
> -
> -@item host
> -Address of the remote server.
> -
> -@item path
> -Path on the remote server, including any query string.
> -@end table
> -
> -The following options are also supported:
> -@table @option
> -@item url
> -The full URL when passing options to the driver explicitly.
> -
> -@item readahead
> -The amount of data to read ahead with each range request to the remote s=
erver.
> -This value may optionally have the suffix 'T', 'G', 'M', 'K', 'k' or 'b'=
. If it
> -does not have a suffix, it will be assumed to be in bytes. The value mus=
t be a
> -multiple of 512 bytes. It defaults to 256k.
> -
> -@item sslverify
> -Whether to verify the remote server's certificate when connecting over S=
SL. It
> -can have the value 'on' or 'off'. It defaults to 'on'.
> -
> -@item cookie
> -Send this cookie (it can also be a list of cookies separated by ';') with
> -each outgoing request.  Only supported when using protocols such as HTTP
> -which support cookies, otherwise ignored.
> -
> -@item timeout
> -Set the timeout in seconds of the CURL connection. This timeout is the t=
ime
> -that CURL waits for a response from the remote server to get the size of=
 the
> -image to be downloaded. If not set, the default timeout of 5 seconds is =
used.
> -@end table
> -
> -Note that when passing options to qemu explicitly, @option{driver} is th=
e value
> -of <protocol>.
> -
> -Example: boot from a remote Fedora 20 live ISO image
> -@example
> -@value{qemu_system_x86} --drive media=3Dcdrom,file=3Dhttps://archives.fe=
doraproject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Liv=
e-Desktop-x86_64-20-1.iso,readonly
> -
> -@value{qemu_system_x86} --drive media=3Dcdrom,file.driver=3Dhttp,file.ur=
l=3Dhttp://archives.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86=
_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
> -@end example
> -
> -Example: boot from a remote Fedora 20 cloud image using a local overlay =
for
> -writes, copy-on-read, and a readahead of 64k
> -@example
> -qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"http",=
, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linux/re=
leases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.read=
ahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
> -
> -@value{qemu_system_x86} -drive file=3D/tmp/Fedora-x86_64-20-20131211.1-s=
da.qcow2,copy-on-read=3Don
> -@end example
> -
> -Example: boot from an image stored on a VMware vSphere server with a sel=
f-signed
> -certificate using a local overlay for writes, a readahead of 64k and a t=
imeout
> -of 10 seconds.
> -@example
> -qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"https"=
,, "file.url":"https://user:password@@vsphere.example.com/folder/test/test-=
flat.vmdk?dcPath=3DDatacenter&dsName=3Ddatastore1",, "file.sslverify":"off"=
,, "file.readahead":"64k",, "file.timeout":10@}' /tmp/test.qcow2
> -
> -@value{qemu_system_x86} -drive file=3D/tmp/test.qcow2
> -@end example
> -
> -@end table
> -
> -@c man end
> -
> -@node pcsys_keys
> -@section Keys in the graphical frontends
> -
> -@c man begin OPTIONS
> -
> -During the graphical emulation, you can use special key combinations to =
change
> -modes. The default key mappings are shown below, but if you use @code{-a=
lt-grab}
> -then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt) and if you use
> -@code{-ctrl-grab} then the modifier is the right Ctrl key (instead of Ct=
rl-Alt):
> -
> -@table @key
> -@item Ctrl-Alt-f
> -@kindex Ctrl-Alt-f
> -Toggle full screen
> -
> -@item Ctrl-Alt-+
> -@kindex Ctrl-Alt-+
> -Enlarge the screen
> -
> -@item Ctrl-Alt--
> -@kindex Ctrl-Alt--
> -Shrink the screen
> -
> -@item Ctrl-Alt-u
> -@kindex Ctrl-Alt-u
> -Restore the screen's un-scaled dimensions
> -
> -@item Ctrl-Alt-n
> -@kindex Ctrl-Alt-n
> -Switch to virtual console 'n'. Standard console mappings are:
> -@table @emph
> -@item 1
> -Target system display
> -@item 2
> -Monitor
> -@item 3
> -Serial port
> -@end table
> -
> -@item Ctrl-Alt
> -@kindex Ctrl-Alt
> -Toggle mouse and keyboard grab.
> -@end table
> -
> -@kindex Ctrl-Up
> -@kindex Ctrl-Down
> -@kindex Ctrl-PageUp
> -@kindex Ctrl-PageDown
> -In the virtual consoles, you can use @key{Ctrl-Up}, @key{Ctrl-Down},
> -@key{Ctrl-PageUp} and @key{Ctrl-PageDown} to move in the back log.
> -
> -@c man end
> -
> -@node mux_keys
> -@section Keys in the character backend multiplexer
> -
> -@c man begin OPTIONS
> -
> -During emulation, if you are using a character backend multiplexer
> -(which is the default if you are using @option{-nographic}) then
> -several commands are available via an escape sequence. These
> -key sequences all start with an escape character, which is @key{Ctrl-a}
> -by default, but can be changed with @option{-echr}. The list below assum=
es
> -you're using the default.
> -
> -@table @key
> -@item Ctrl-a h
> -@kindex Ctrl-a h
> -Print this help
> -@item Ctrl-a x
> -@kindex Ctrl-a x
> -Exit emulator
> -@item Ctrl-a s
> -@kindex Ctrl-a s
> -Save disk data back to file (if -snapshot)
> -@item Ctrl-a t
> -@kindex Ctrl-a t
> -Toggle console timestamps
> -@item Ctrl-a b
> -@kindex Ctrl-a b
> -Send break (magic sysrq in Linux)
> -@item Ctrl-a c
> -@kindex Ctrl-a c
> -Rotate between the frontends connected to the multiplexer (usually
> -this switches between the monitor and the console)
> -@item Ctrl-a Ctrl-a
> -@kindex Ctrl-a Ctrl-a
> -Send the escape character to the frontend
> -@end table
> -@c man end
> -
> -@ignore
> -
> -@c man begin SEEALSO
> -The HTML documentation of QEMU for more precise information and Linux
> -user mode emulator invocation.
> -@c man end
> -
> -@c man begin AUTHOR
> -Fabrice Bellard
> -@c man end
> -
> -@end ignore
> -
> -@node pcsys_monitor
> -@section QEMU Monitor
> -@cindex QEMU monitor
> -
> -The QEMU monitor is used to give complex commands to the QEMU
> -emulator. You can use it to:
> -
> -@itemize @minus
> -
> -@item
> -Remove or insert removable media images
> -(such as CD-ROM or floppies).
> -
> -@item
> -Freeze/unfreeze the Virtual Machine (VM) and save or restore its state
> -from a disk file.
> -
> -@item Inspect the VM state without an external debugger.
> -
> -@end itemize
> -
> -@subsection Commands
> -
> -The following commands are available:
> -
> -@include qemu-monitor.texi
> -
> -@include qemu-monitor-info.texi
> -
> -@subsection Integer expressions
> -
> -The monitor understands integers expressions for every integer
> -argument. You can use register names to get the value of specifics
> -CPU registers by prefixing them with @emph{$}.
> -
> +@include docs/system/quickstart.texi
> +@include docs/system/invocation.texi
> +@include docs/system/keys.texi
> +@include docs/system/mux-chardev.texi
> +@include docs/system/monitor.texi
>  @include docs/system/cpu-models-x86.texi
> -
> -@node disk_images
> -@section Disk Images
> -
> -QEMU supports many disk image formats, including growable disk images
> -(their size increase as non empty sectors are written), compressed and
> -encrypted disk images.
> -
> -@menu
> -* disk_images_quickstart::    Quick start for disk image creation
> -* disk_images_snapshot_mode:: Snapshot mode
> -* vm_snapshots::              VM snapshots
> -@end menu
> -
> -@node disk_images_quickstart
> -@subsection Quick start for disk image creation
> -
> -You can create a disk image with the command:
> -@example
> -qemu-img create myimage.img mysize
> -@end example
> -where @var{myimage.img} is the disk image filename and @var{mysize} is i=
ts
> -size in kilobytes. You can add an @code{M} suffix to give the size in
> -megabytes and a @code{G} suffix for gigabytes.
> -
> -@c When this document is converted to rst we should make this into
> -@c a proper linked reference to the qemu-img documentation again:
> -See the qemu-img invocation documentation for more information.
> -
> -@node disk_images_snapshot_mode
> -@subsection Snapshot mode
> -
> -If you use the option @option{-snapshot}, all disk images are
> -considered as read only. When sectors in written, they are written in
> -a temporary file created in @file{/tmp}. You can however force the
> -write back to the raw disk images by using the @code{commit} monitor
> -command (or @key{C-a s} in the serial console).
> -
> -@node vm_snapshots
> -@subsection VM snapshots
> -
> -VM snapshots are snapshots of the complete virtual machine including
> -CPU state, RAM, device state and the content of all the writable
> -disks. In order to use VM snapshots, you must have at least one non
> -removable and writable block device using the @code{qcow2} disk image
> -format. Normally this device is the first virtual hard drive.
> -
> -Use the monitor command @code{savevm} to create a new VM snapshot or
> -replace an existing one. A human readable name can be assigned to each
> -snapshot in addition to its numerical ID.
> -
> -Use @code{loadvm} to restore a VM snapshot and @code{delvm} to remove
> -a VM snapshot. @code{info snapshots} lists the available snapshots
> -with their associated information:
> -
> -@example
> -(qemu) info snapshots
> -Snapshot devices: hda
> -Snapshot list (from hda):
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> -1         start                   41M 2006-08-06 12:38:02   00:00:14.954
> -2                                 40M 2006-08-06 12:43:29   00:00:18.633
> -3         msys                    40M 2006-08-06 12:44:04   00:00:23.514
> -@end example
> -
> -A VM snapshot is made of a VM state info (its size is shown in
> -@code{info snapshots}) and a snapshot of every writable disk image.
> -The VM state info is stored in the first @code{qcow2} non removable
> -and writable block device. The disk image snapshots are stored in
> -every disk image. The size of a snapshot in a disk image is difficult
> -to evaluate and is not shown by @code{info snapshots} because the
> -associated disk sectors are shared among all the snapshots to save
> -disk space (otherwise each snapshot would need a full copy of all the
> -disk images).
> -
> -When using the (unrelated) @code{-snapshot} option
> -(@ref{disk_images_snapshot_mode}), you can always make VM snapshots,
> -but they are deleted as soon as you exit QEMU.
> -
> -VM snapshots currently have the following known limitations:
> -@itemize
> -@item
> -They cannot cope with removable devices if they are removed or
> -inserted after a snapshot is done.
> -@item
> -A few device drivers still have incomplete snapshot support so their
> -state is not saved or restored properly (in particular USB).
> -@end itemize
> -
> -@node pcsys_network
> -@section Network emulation
> -
> -QEMU can simulate several network cards (e.g. PCI or ISA cards on the PC
> -target) and can connect them to a network backend on the host or an emul=
ated
> -hub. The various host network backends can either be used to connect the=
 NIC of
> -the guest to a real network (e.g. by using a TAP devices or the non-priv=
ileged
> -user mode network stack), or to other guest instances running in another=
 QEMU
> -process (e.g. by using the socket host network backend).
> -
> -@subsection Using TAP network interfaces
> -
> -This is the standard way to connect QEMU to a real network. QEMU adds
> -a virtual network device on your host (called @code{tapN}), and you
> -can then configure it as if it was a real ethernet card.
> -
> -@subsubsection Linux host
> -
> -As an example, you can download the @file{linux-test-xxx.tar.gz}
> -archive and copy the script @file{qemu-ifup} in @file{/etc} and
> -configure properly @code{sudo} so that the command @code{ifconfig}
> -contained in @file{qemu-ifup} can be executed as root. You must verify
> -that your host kernel supports the TAP network interfaces: the
> -device @file{/dev/net/tun} must be present.
> -
> -See @ref{sec_invocation} to have examples of command lines using the
> -TAP network interfaces.
> -
> -@subsubsection Windows host
> -
> -There is a virtual ethernet driver for Windows 2000/XP systems, called
> -TAP-Win32. But it is not included in standard QEMU for Windows,
> -so you will need to get it separately. It is part of OpenVPN package,
> -so download OpenVPN from : @url{https://openvpn.net/}.
> -
> -@subsection Using the user mode network stack
> -
> -By using the option @option{-net user} (default configuration if no
> -@option{-net} option is specified), QEMU uses a completely user mode
> -network stack (you don't need root privilege to use the virtual
> -network). The virtual network configuration is the following:
> -
> -@example
> -
> -     guest (10.0.2.15)  <------>  Firewall/DHCP server <-----> Internet
> -                           |          (10.0.2.2)
> -                           |
> -                           ---->  DNS server (10.0.2.3)
> -                           |
> -                           ---->  SMB server (10.0.2.4)
> -@end example
> -
> -The QEMU VM behaves as if it was behind a firewall which blocks all
> -incoming connections. You can use a DHCP client to automatically
> -configure the network in the QEMU VM. The DHCP server assign addresses
> -to the hosts starting from 10.0.2.15.
> -
> -In order to check that the user mode network is working, you can ping
> -the address 10.0.2.2 and verify that you got an address in the range
> -10.0.2.x from the QEMU virtual DHCP server.
> -
> -Note that ICMP traffic in general does not work with user mode networkin=
g.
> -@code{ping}, aka. ICMP echo, to the local router (10.0.2.2) shall work,
> -however. If you're using QEMU on Linux >=3D 3.0, it can use unprivileged=
 ICMP
> -ping sockets to allow @code{ping} to the Internet. The host admin has to=
 set
> -the ping_group_range in order to grant access to those sockets. To allow=
 ping
> -for GID 100 (usually users group):
> -
> -@example
> -echo 100 100 > /proc/sys/net/ipv4/ping_group_range
> -@end example
> -
> -When using the built-in TFTP server, the router is also the TFTP
> -server.
> -
> -When using the @option{'-netdev user,hostfwd=3D...'} option, TCP or UDP
> -connections can be redirected from the host to the guest. It allows for
> -example to redirect X11, telnet or SSH connections.
> -
> -@subsection Hubs
> -
> -QEMU can simulate several hubs. A hub can be thought of as a virtual con=
nection
> -between several network devices. These devices can be for example QEMU v=
irtual
> -ethernet cards or virtual Host ethernet devices (TAP devices). You can c=
onnect
> -guest NICs or host network backends to such a hub using the @option{-net=
dev
> -hubport} or @option{-nic hubport} options. The legacy @option{-net} opti=
on
> -also connects the given device to the emulated hub with ID 0 (i.e. the d=
efault
> -hub) unless you specify a netdev with @option{-net nic,netdev=3Dxxx} her=
e.
> -
> -@subsection Connecting emulated networks between QEMU instances
> -
> -Using the @option{-netdev socket} (or @option{-nic socket} or
> -@option{-net socket}) option, it is possible to create emulated
> -networks that span several QEMU instances.
> -See the description of the @option{-netdev socket} option in the
> -@ref{sec_invocation,,Invocation chapter} to have a basic example.
> -
> -@node pcsys_other_devs
> -@section Other Devices
> -
> -@subsection Inter-VM Shared Memory device
> -
> -On Linux hosts, a shared memory device is available.  The basic syntax
> -is:
> -
> -@example
> -@value{qemu_system_x86} -device ivshmem-plain,memdev=3D@var{hostmem}
> -@end example
> -
> -where @var{hostmem} names a host memory backend.  For a POSIX shared
> -memory backend, use something like
> -
> -@example
> --object memory-backend-file,size=3D1M,share,mem-path=3D/dev/shm/ivshmem,=
id=3D@var{hostmem}
> -@end example
> -
> -If desired, interrupts can be sent between guest VMs accessing the same =
shared
> -memory region.  Interrupt support requires using a shared memory server =
and
> -using a chardev socket to connect to it.  The code for the shared memory=
 server
> -is qemu.git/contrib/ivshmem-server.  An example syntax when using the sh=
ared
> -memory server is:
> -
> -@example
> -# First start the ivshmem server once and for all
> -ivshmem-server -p @var{pidfile} -S @var{path} -m @var{shm-name} -l @var{=
shm-size} -n @var{vectors}
> -
> -# Then start your qemu instances with matching arguments
> -@value{qemu_system_x86} -device ivshmem-doorbell,vectors=3D@var{vectors}=
,chardev=3D@var{id}
> -                 -chardev socket,path=3D@var{path},id=3D@var{id}
> -@end example
> -
> -When using the server, the guest will be assigned a VM ID (>=3D0) that a=
llows guests
> -using the same server to communicate via interrupts.  Guests can read th=
eir
> -VM ID from a device register (see ivshmem-spec.txt).
> -
> -@subsubsection Migration with ivshmem
> -
> -With device property @option{master=3Don}, the guest will copy the shared
> -memory on migration to the destination host.  With @option{master=3Doff},
> -the guest will not be able to migrate with the device attached.  In the
> -latter case, the device should be detached and then reattached after
> -migration using the PCI hotplug support.
> -
> -At most one of the devices sharing the same memory can be master.  The
> -master must complete migration before you plug back the other devices.
> -
> -@subsubsection ivshmem and hugepages
> -
> -Instead of specifying the <shm size> using POSIX shm, you may specify
> -a memory backend that has hugepage support:
> -
> -@example
> -@value{qemu_system_x86} -object memory-backend-file,size=3D1G,mem-path=
=3D/dev/hugepages/my-shmem-file,share,id=3Dmb1
> -                 -device ivshmem-plain,memdev=3Dmb1
> -@end example
> -
> -ivshmem-server also supports hugepages mount points with the
> -@option{-m} memory path argument.
> -
> -@node direct_linux_boot
> -@section Direct Linux Boot
> -
> -This section explains how to launch a Linux kernel inside QEMU without
> -having to make a full bootable image. It is very useful for fast Linux
> -kernel testing.
> -
> -The syntax is:
> -@example
> -@value{qemu_system} -kernel bzImage -hda rootdisk.img -append "root=3D/d=
ev/hda"
> -@end example
> -
> -Use @option{-kernel} to provide the Linux kernel image and
> -@option{-append} to give the kernel command line arguments. The
> -@option{-initrd} option can be used to provide an INITRD image.
> -
> -If you do not need graphical output, you can disable it and redirect
> -the virtual serial port and the QEMU monitor to the console with the
> -@option{-nographic} option. The typical command line is:
> -@example
> -@value{qemu_system} -kernel bzImage -hda rootdisk.img \
> -                 -append "root=3D/dev/hda console=3DttyS0" -nographic
> -@end example
> -
> -Use @key{Ctrl-a c} to switch between the serial console and the
> -monitor (@pxref{pcsys_keys}).
> -
> -@node pcsys_usb
> -@section USB emulation
> -
> -QEMU can emulate a PCI UHCI, OHCI, EHCI or XHCI USB controller. You can
> -plug virtual USB devices or real host USB devices (only works with certa=
in
> -host operating systems). QEMU will automatically create and connect virt=
ual
> -USB hubs as necessary to connect multiple USB devices.
> -
> -@menu
> -* usb_devices::
> -* host_usb_devices::
> -@end menu
> -@node usb_devices
> -@subsection Connecting USB devices
> -
> -USB devices can be connected with the @option{-device usb-...} command l=
ine
> -option or the @code{device_add} monitor command. Available devices are:
> -
> -@table @code
> -@item usb-mouse
> -Virtual Mouse.  This will override the PS/2 mouse emulation when activat=
ed.
> -@item usb-tablet
> -Pointer device that uses absolute coordinates (like a touchscreen).
> -This means QEMU is able to report the mouse position without having
> -to grab the mouse.  Also overrides the PS/2 mouse emulation when activat=
ed.
> -@item usb-storage,drive=3D@var{drive_id}
> -Mass storage device backed by @var{drive_id} (@pxref{disk_images})
> -@item usb-uas
> -USB attached SCSI device, see
> -@url{https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/usb-stor=
age.txt,usb-storage.txt}
> -for details
> -@item usb-bot
> -Bulk-only transport storage device, see
> -@url{https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/usb-stor=
age.txt,usb-storage.txt}
> -for details here, too
> -@item usb-mtp,rootdir=3D@var{dir}
> -Media transfer protocol device, using @var{dir} as root of the file tree
> -that is presented to the guest.
> -@item usb-host,hostbus=3D@var{bus},hostaddr=3D@var{addr}
> -Pass through the host device identified by @var{bus} and @var{addr}
> -@item usb-host,vendorid=3D@var{vendor},productid=3D@var{product}
> -Pass through the host device identified by @var{vendor} and @var{product=
} ID
> -@item usb-wacom-tablet
> -Virtual Wacom PenPartner tablet.  This device is similar to the @code{ta=
blet}
> -above but it can be used with the tslib library because in addition to t=
ouch
> -coordinates it reports touch pressure.
> -@item usb-kbd
> -Standard USB keyboard.  Will override the PS/2 keyboard (if present).
> -@item usb-serial,chardev=3D@var{id}
> -Serial converter. This emulates an FTDI FT232BM chip connected to host c=
haracter
> -device @var{id}.
> -@item usb-braille,chardev=3D@var{id}
> -Braille device.  This will use BrlAPI to display the braille output on a=
 real
> -or fake device referenced by @var{id}.
> -@item usb-net[,netdev=3D@var{id}]
> -Network adapter that supports CDC ethernet and RNDIS protocols.  @var{id}
> -specifies a netdev defined with @code{-netdev @dots{},id=3D@var{id}}.
> -For instance, user-mode networking can be used with
> -@example
> -@value{qemu_system} [...] -netdev user,id=3Dnet0 -device usb-net,netdev=
=3Dnet0
> -@end example
> -@item usb-ccid
> -Smartcard reader device
> -@item usb-audio
> -USB audio device
> -@end table
> -
> -@node host_usb_devices
> -@subsection Using host USB devices on a Linux host
> -
> -WARNING: this is an experimental feature. QEMU will slow down when
> -using it. USB devices requiring real time streaming (i.e. USB Video
> -Cameras) are not supported yet.
> -
> -@enumerate
> -@item If you use an early Linux 2.4 kernel, verify that no Linux driver
> -is actually using the USB device. A simple way to do that is simply to
> -disable the corresponding kernel module by renaming it from @file{mydriv=
er.o}
> -to @file{mydriver.o.disabled}.
> -
> -@item Verify that @file{/proc/bus/usb} is working (most Linux distributi=
ons should enable it by default). You should see something like that:
> -@example
> -ls /proc/bus/usb
> -001  devices  drivers
> -@end example
> -
> -@item Since only root can access to the USB devices directly, you can ei=
ther launch QEMU as root or change the permissions of the USB devices you w=
ant to use. For testing, the following suffices:
> -@example
> -chown -R myuid /proc/bus/usb
> -@end example
> -
> -@item Launch QEMU and do in the monitor:
> -@example
> -info usbhost
> -  Device 1.2, speed 480 Mb/s
> -    Class 00: USB device 1234:5678, USB DISK
> -@end example
> -You should see the list of the devices you can use (Never try to use
> -hubs, it won't work).
> -
> -@item Add the device in QEMU by using:
> -@example
> -device_add usb-host,vendorid=3D0x1234,productid=3D0x5678
> -@end example
> -
> -Normally the guest OS should report that a new USB device is plugged.
> -You can use the option @option{-device usb-host,...} to do the same.
> -
> -@item Now you can try to use the host USB device in QEMU.
> -
> -@end enumerate
> -
> -When relaunching QEMU, you may have to unplug and plug again the USB
> -device to make it work again (this is a bug).
> -
> -@node vnc_security
> -@section VNC security
> -
> -The VNC server capability provides access to the graphical console
> -of the guest VM across the network. This has a number of security
> -considerations depending on the deployment scenarios.
> -
> -@menu
> -* vnc_sec_none::
> -* vnc_sec_password::
> -* vnc_sec_certificate::
> -* vnc_sec_certificate_verify::
> -* vnc_sec_certificate_pw::
> -* vnc_sec_sasl::
> -* vnc_sec_certificate_sasl::
> -* vnc_setup_sasl::
> -@end menu
> -@node vnc_sec_none
> -@subsection Without passwords
> -
> -The simplest VNC server setup does not include any form of authenticatio=
n.
> -For this setup it is recommended to restrict it to listen on a UNIX doma=
in
> -socket only. For example
> -
> -@example
> -@value{qemu_system} [...OPTIONS...] -vnc unix:/home/joebloggs/.qemu-myvm=
-vnc
> -@end example
> -
> -This ensures that only users on local box with read/write access to that
> -path can access the VNC server. To securely access the VNC server from a
> -remote machine, a combination of netcat+ssh can be used to provide a sec=
ure
> -tunnel.
> -
> -@node vnc_sec_password
> -@subsection With passwords
> -
> -The VNC protocol has limited support for password based authentication. =
Since
> -the protocol limits passwords to 8 characters it should not be considered
> -to provide high security. The password can be fairly easily brute-forced=
 by
> -a client making repeat connections. For this reason, a VNC server using =
password
> -authentication should be restricted to only listen on the loopback inter=
face
> -or UNIX domain sockets. Password authentication is not supported when op=
erating
> -in FIPS 140-2 compliance mode as it requires the use of the DES cipher. =
Password
> -authentication is requested with the @code{password} option, and then on=
ce QEMU
> -is running the password is set with the monitor. Until the monitor is us=
ed to
> -set the password all clients will be rejected.
> -
> -@example
> -@value{qemu_system} [...OPTIONS...] -vnc :1,password -monitor stdio
> -(qemu) change vnc password
> -Password: ********
> -(qemu)
> -@end example
> -
> -@node vnc_sec_certificate
> -@subsection With x509 certificates
> -
> -The QEMU VNC server also implements the VeNCrypt extension allowing use =
of
> -TLS for encryption of the session, and x509 certificates for authenticat=
ion.
> -The use of x509 certificates is strongly recommended, because TLS on its
> -own is susceptible to man-in-the-middle attacks. Basic x509 certificate
> -support provides a secure session, but no authentication. This allows any
> -client to connect, and provides an encrypted session.
> -
> -@example
> -@value{qemu_system} [...OPTIONS...] \
> -  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dno \
> -  -vnc :1,tls-creds=3Dtls0 -monitor stdio
> -@end example
> -
> -In the above example @code{/etc/pki/qemu} should contain at least three =
files,
> -@code{ca-cert.pem}, @code{server-cert.pem} and @code{server-key.pem}. Un=
privileged
> -users will want to use a private directory, for example @code{$HOME/.pki=
/qemu}.
> -NB the @code{server-key.pem} file should be protected with file mode 060=
0 to
> -only be readable by the user owning it.
> -
> -@node vnc_sec_certificate_verify
> -@subsection With x509 certificates and client verification
> -
> -Certificates can also provide a means to authenticate the client connect=
ing.
> -The server will request that the client provide a certificate, which it =
will
> -then validate against the CA certificate. This is a good choice if deplo=
ying
> -in an environment with a private internal certificate authority. It uses=
 the
> -same syntax as previously, but with @code{verify-peer} set to @code{yes}
> -instead.
> -
> -@example
> -@value{qemu_system} [...OPTIONS...] \
> -  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dyes \
> -  -vnc :1,tls-creds=3Dtls0 -monitor stdio
> -@end example
> -
> -
> -@node vnc_sec_certificate_pw
> -@subsection With x509 certificates, client verification and passwords
> -
> -Finally, the previous method can be combined with VNC password authentic=
ation
> -to provide two layers of authentication for clients.
> -
> -@example
> -@value{qemu_system} [...OPTIONS...] \
> -  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dyes \
> -  -vnc :1,tls-creds=3Dtls0,password -monitor stdio
> -(qemu) change vnc password
> -Password: ********
> -(qemu)
> -@end example
> -
> -
> -@node vnc_sec_sasl
> -@subsection With SASL authentication
> -
> -The SASL authentication method is a VNC extension, that provides an
> -easily extendable, pluggable authentication method. This allows for
> -integration with a wide range of authentication mechanisms, such as
> -PAM, GSSAPI/Kerberos, LDAP, SQL databases, one-time keys and more.
> -The strength of the authentication depends on the exact mechanism
> -configured. If the chosen mechanism also provides a SSF layer, then
> -it will encrypt the datastream as well.
> -
> -Refer to the later docs on how to choose the exact SASL mechanism
> -used for authentication, but assuming use of one supporting SSF,
> -then QEMU can be launched with:
> -
> -@example
> -@value{qemu_system} [...OPTIONS...] -vnc :1,sasl -monitor stdio
> -@end example
> -
> -@node vnc_sec_certificate_sasl
> -@subsection With x509 certificates and SASL authentication
> -
> -If the desired SASL authentication mechanism does not supported
> -SSF layers, then it is strongly advised to run it in combination
> -with TLS and x509 certificates. This provides securely encrypted
> -data stream, avoiding risk of compromising of the security
> -credentials. This can be enabled, by combining the 'sasl' option
> -with the aforementioned TLS + x509 options:
> -
> -@example
> -@value{qemu_system} [...OPTIONS...] \
> -  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver=
,verify-peer=3Dyes \
> -  -vnc :1,tls-creds=3Dtls0,sasl -monitor stdio
> -@end example
> -
> -@node vnc_setup_sasl
> -
> -@subsection Configuring SASL mechanisms
> -
> -The following documentation assumes use of the Cyrus SASL implementation=
 on a
> -Linux host, but the principles should apply to any other SASL implementa=
tion
> -or host. When SASL is enabled, the mechanism configuration will be loade=
d from
> -system default SASL service config /etc/sasl2/qemu.conf. If running QEMU=
 as an
> -unprivileged user, an environment variable SASL_CONF_PATH can be used to=
 make
> -it search alternate locations for the service config file.
> -
> -If the TLS option is enabled for VNC, then it will provide session encry=
ption,
> -otherwise the SASL mechanism will have to provide encryption. In the lat=
ter
> -case the list of possible plugins that can be used is drastically reduce=
d. In
> -fact only the GSSAPI SASL mechanism provides an acceptable level of secu=
rity
> -by modern standards. Previous versions of QEMU referred to the DIGEST-MD5
> -mechanism, however, it has multiple serious flaws described in detail in
> -RFC 6331 and thus should never be used any more. The SCRAM-SHA-1 mechani=
sm
> -provides a simple username/password auth facility similar to DIGEST-MD5,=
 but
> -does not support session encryption, so can only be used in combination =
with
> -TLS.
> -
> -When not using TLS the recommended configuration is
> -
> -@example
> -mech_list: gssapi
> -keytab: /etc/qemu/krb5.tab
> -@end example
> -
> -This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol, w=
ith
> -the server principal stored in /etc/qemu/krb5.tab. For this to work the
> -administrator of your KDC must generate a Kerberos principal for the ser=
ver,
> -with a name of 'qemu/somehost.example.com@@EXAMPLE.COM' replacing
> -'somehost.example.com' with the fully qualified host name of the machine
> -running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
> -
> -When using TLS, if username+password authentication is desired, then a
> -reasonable configuration is
> -
> -@example
> -mech_list: scram-sha-1
> -sasldb_path: /etc/qemu/passwd.db
> -@end example
> -
> -The @code{saslpasswd2} program can be used to populate the @code{passwd.=
db}
> -file with accounts.
> -
> -Other SASL configurations will be left as an exercise for the reader. No=
te that
> -all mechanisms, except GSSAPI, should be combined with use of TLS to ens=
ure a
> -secure data channel.
> -
> -
> -@node network_tls
> -@section TLS setup for network services
> -
> -Almost all network services in QEMU have the ability to use TLS for
> -session data encryption, along with x509 certificates for simple
> -client authentication. What follows is a description of how to
> -generate certificates suitable for usage with QEMU, and applies to
> -the VNC server, character devices with the TCP backend, NBD server
> -and client, and migration server and client.
> -
> -At a high level, QEMU requires certificates and private keys to be
> -provided in PEM format. Aside from the core fields, the certificates
> -should include various extension data sets, including v3 basic
> -constraints data, key purpose, key usage and subject alt name.
> -
> -The GnuTLS package includes a command called @code{certtool} which can
> -be used to easily generate certificates and keys in the required format
> -with expected data present. Alternatively a certificate management
> -service may be used.
> -
> -At a minimum it is necessary to setup a certificate authority, and
> -issue certificates to each server. If using x509 certificates for
> -authentication, then each client will also need to be issued a
> -certificate.
> -
> -Assuming that the QEMU network services will only ever be exposed to
> -clients on a private intranet, there is no need to use a commercial
> -certificate authority to create certificates. A self-signed CA is
> -sufficient, and in fact likely to be more secure since it removes
> -the ability of malicious 3rd parties to trick the CA into mis-issuing
> -certs for impersonating your services. The only likely exception
> -where a commercial CA might be desirable is if enabling the VNC
> -websockets server and exposing it directly to remote browser clients.
> -In such a case it might be useful to use a commercial CA to avoid
> -needing to install custom CA certs in the web browsers.
> -
> -The recommendation is for the server to keep its certificates in either
> -@code{/etc/pki/qemu} or for unprivileged users in @code{$HOME/.pki/qemu}.
> -
> -@menu
> -* tls_generate_ca::
> -* tls_generate_server::
> -* tls_generate_client::
> -* tls_creds_setup::
> -* tls_psk::
> -@end menu
> -@node tls_generate_ca
> -@subsection Setup the Certificate Authority
> -
> -This step only needs to be performed once per organization / organizatio=
nal
> -unit. First the CA needs a private key. This key must be kept VERY secret
> -and secure. If this key is compromised the entire trust chain of the cer=
tificates
> -issued with it is lost.
> -
> -@example
> -# certtool --generate-privkey > ca-key.pem
> -@end example
> -
> -To generate a self-signed certificate requires one core piece of informa=
tion,
> -the name of the organization. A template file @code{ca.info} should be
> -populated with the desired data to avoid having to deal with interactive
> -prompts from certtool:
> -@example
> -# cat > ca.info <<EOF
> -cn =3D Name of your organization
> -ca
> -cert_signing_key
> -EOF
> -# certtool --generate-self-signed \
> -           --load-privkey ca-key.pem
> -           --template ca.info \
> -           --outfile ca-cert.pem
> -@end example
> -
> -The @code{ca} keyword in the template sets the v3 basic constraints exte=
nsion
> -to indicate this certificate is for a CA, while @code{cert_signing_key} =
sets
> -the key usage extension to indicate this will be used for signing other =
keys.
> -The generated @code{ca-cert.pem} file should be copied to all servers and
> -clients wishing to utilize TLS support in the VNC server. The @code{ca-k=
ey.pem}
> -must not be disclosed/copied anywhere except the host responsible for is=
suing
> -certificates.
> -
> -@node tls_generate_server
> -@subsection Issuing server certificates
> -
> -Each server (or host) needs to be issued with a key and certificate. Whe=
n connecting
> -the certificate is sent to the client which validates it against the CA =
certificate.
> -The core pieces of information for a server certificate are the hostname=
s and/or IP
> -addresses that will be used by clients when connecting. The hostname / I=
P address
> -that the client specifies when connecting will be validated against the =
hostname(s)
> -and IP address(es) recorded in the server certificate, and if no match i=
s found
> -the client will close the connection.
> -
> -Thus it is recommended that the server certificate include both the full=
y qualified
> -and unqualified hostnames. If the server will have permanently assigned =
IP address(es),
> -and clients are likely to use them when connecting, they may also be inc=
luded in the
> -certificate. Both IPv4 and IPv6 addresses are supported. Historically ce=
rtificates
> -only included 1 hostname in the @code{CN} field, however, usage of this =
field for
> -validation is now deprecated. Instead modern TLS clients will validate a=
gainst the
> -Subject Alt Name extension data, which allows for multiple entries. In t=
he future
> -usage of the @code{CN} field may be discontinued entirely, so providing =
SAN
> -extension data is strongly recommended.
> -
> -On the host holding the CA, create template files containing the informa=
tion
> -for each server, and use it to issue server certificates.
> -
> -@example
> -# cat > server-hostNNN.info <<EOF
> -organization =3D Name  of your organization
> -cn =3D hostNNN.foo.example.com
> -dns_name =3D hostNNN
> -dns_name =3D hostNNN.foo.example.com
> -ip_address =3D 10.0.1.87
> -ip_address =3D 192.8.0.92
> -ip_address =3D 2620:0:cafe::87
> -ip_address =3D 2001:24::92
> -tls_www_server
> -encryption_key
> -signing_key
> -EOF
> -# certtool --generate-privkey > server-hostNNN-key.pem
> -# certtool --generate-certificate \
> -           --load-ca-certificate ca-cert.pem \
> -           --load-ca-privkey ca-key.pem \
> -           --load-privkey server-hostNNN-key.pem \
> -           --template server-hostNNN.info \
> -           --outfile server-hostNNN-cert.pem
> -@end example
> -
> -The @code{dns_name} and @code{ip_address} fields in the template are set=
ting
> -the subject alt name extension data. The @code{tls_www_server} keyword i=
s the
> -key purpose extension to indicate this certificate is intended for usage=
 in
> -a web server. Although QEMU network services are not in fact HTTP servers
> -(except for VNC websockets), setting this key purpose is still recommend=
ed.
> -The @code{encryption_key} and @code{signing_key} keyword is the key usage
> -extension to indicate this certificate is intended for usage in the data
> -session.
> -
> -The @code{server-hostNNN-key.pem} and @code{server-hostNNN-cert.pem} fil=
es
> -should now be securely copied to the server for which they were generate=
d,
> -and renamed to @code{server-key.pem} and @code{server-cert.pem} when add=
ed
> -to the @code{/etc/pki/qemu} directory on the target host. The @code{serv=
er-key.pem}
> -file is security sensitive and should be kept protected with file mode 0=
600
> -to prevent disclosure.
> -
> -@node tls_generate_client
> -@subsection Issuing client certificates
> -
> -The QEMU x509 TLS credential setup defaults to enabling client verificat=
ion
> -using certificates, providing a simple authentication mechanism. If this
> -default is used, each client also needs to be issued a certificate. The =
client
> -certificate contains enough metadata to uniquely identify the client wit=
h the
> -scope of the certificate authority. The client certificate would typical=
ly
> -include fields for organization, state, city, building, etc.
> -
> -Once again on the host holding the CA, create template files containing =
the
> -information for each client, and use it to issue client certificates.
> -
> -
> -@example
> -# cat > client-hostNNN.info <<EOF
> -country =3D GB
> -state =3D London
> -locality =3D City Of London
> -organization =3D Name of your organization
> -cn =3D hostNNN.foo.example.com
> -tls_www_client
> -encryption_key
> -signing_key
> -EOF
> -# certtool --generate-privkey > client-hostNNN-key.pem
> -# certtool --generate-certificate \
> -           --load-ca-certificate ca-cert.pem \
> -           --load-ca-privkey ca-key.pem \
> -           --load-privkey client-hostNNN-key.pem \
> -           --template client-hostNNN.info \
> -           --outfile client-hostNNN-cert.pem
> -@end example
> -
> -The subject alt name extension data is not required for clients, so the
> -the @code{dns_name} and @code{ip_address} fields are not included.
> -The @code{tls_www_client} keyword is the key purpose extension to indica=
te
> -this certificate is intended for usage in a web client. Although QEMU
> -network clients are not in fact HTTP clients, setting this key purpose is
> -still recommended. The @code{encryption_key} and @code{signing_key} keyw=
ord
> -is the key usage extension to indicate this certificate is intended for
> -usage in the data session.
> -
> -The @code{client-hostNNN-key.pem} and @code{client-hostNNN-cert.pem} fil=
es
> -should now be securely copied to the client for which they were generate=
d,
> -and renamed to @code{client-key.pem} and @code{client-cert.pem} when add=
ed
> -to the @code{/etc/pki/qemu} directory on the target host. The @code{clie=
nt-key.pem}
> -file is security sensitive and should be kept protected with file mode 0=
600
> -to prevent disclosure.
> -
> -If a single host is going to be using TLS in both a client and server
> -role, it is possible to create a single certificate to cover both roles.
> -This would be quite common for the migration and NBD services, where a
> -QEMU process will be started by accepting a TLS protected incoming migra=
tion,
> -and later itself be migrated out to another host. To generate a single
> -certificate, simply include the template data from both the client and s=
erver
> -instructions in one.
> -
> -@example
> -# cat > both-hostNNN.info <<EOF
> -country =3D GB
> -state =3D London
> -locality =3D City Of London
> -organization =3D Name of your organization
> -cn =3D hostNNN.foo.example.com
> -dns_name =3D hostNNN
> -dns_name =3D hostNNN.foo.example.com
> -ip_address =3D 10.0.1.87
> -ip_address =3D 192.8.0.92
> -ip_address =3D 2620:0:cafe::87
> -ip_address =3D 2001:24::92
> -tls_www_server
> -tls_www_client
> -encryption_key
> -signing_key
> -EOF
> -# certtool --generate-privkey > both-hostNNN-key.pem
> -# certtool --generate-certificate \
> -           --load-ca-certificate ca-cert.pem \
> -           --load-ca-privkey ca-key.pem \
> -           --load-privkey both-hostNNN-key.pem \
> -           --template both-hostNNN.info \
> -           --outfile both-hostNNN-cert.pem
> -@end example
> -
> -When copying the PEM files to the target host, save them twice,
> -once as @code{server-cert.pem} and @code{server-key.pem}, and
> -again as @code{client-cert.pem} and @code{client-key.pem}.
> -
> -@node tls_creds_setup
> -@subsection TLS x509 credential configuration
> -
> -QEMU has a standard mechanism for loading x509 credentials that will be
> -used for network services and clients. It requires specifying the
> -@code{tls-creds-x509} class name to the @code{--object} command line
> -argument for the system emulators.  Each set of credentials loaded should
> -be given a unique string identifier via the @code{id} parameter. A single
> -set of TLS credentials can be used for multiple network backends, so VNC,
> -migration, NBD, character devices can all share the same credentials. No=
te,
> -however, that credentials for use in a client endpoint must be loaded
> -separately from those used in a server endpoint.
> -
> -When specifying the object, the @code{dir} parameters specifies which
> -directory contains the credential files. This directory is expected to
> -contain files with the names mentioned previously, @code{ca-cert.pem},
> -@code{server-key.pem}, @code{server-cert.pem}, @code{client-key.pem}
> -and @code{client-cert.pem} as appropriate. It is also possible to
> -include a set of pre-generated Diffie-Hellman (DH) parameters in a file
> -@code{dh-params.pem}, which can be created using the
> -@code{certtool --generate-dh-params} command. If omitted, QEMU will
> -dynamically generate DH parameters when loading the credentials.
> -
> -The @code{endpoint} parameter indicates whether the credentials will
> -be used for a network client or server, and determines which PEM
> -files are loaded.
> -
> -The @code{verify} parameter determines whether x509 certificate
> -validation should be performed. This defaults to enabled, meaning
> -clients will always validate the server hostname against the
> -certificate subject alt name fields and/or CN field. It also
> -means that servers will request that clients provide a certificate
> -and validate them. Verification should never be turned off for
> -client endpoints, however, it may be turned off for server endpoints
> -if an alternative mechanism is used to authenticate clients. For
> -example, the VNC server can use SASL to authenticate clients
> -instead.
> -
> -To load server credentials with client certificate validation
> -enabled
> -
> -@example
> -@value{qemu_system} -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu=
,endpoint=3Dserver
> -@end example
> -
> -while to load client credentials use
> -
> -@example
> -@value{qemu_system} -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu=
,endpoint=3Dclient
> -@end example
> -
> -Network services which support TLS will all have a @code{tls-creds}
> -parameter which expects the ID of the TLS credentials object. For
> -example with VNC:
> -
> -@example
> -@value{qemu_system} -vnc 0.0.0.0:0,tls-creds=3Dtls0
> -@end example
> -
> -@node tls_psk
> -@subsection TLS Pre-Shared Keys (PSK)
> -
> -Instead of using certificates, you may also use TLS Pre-Shared Keys
> -(TLS-PSK).  This can be simpler to set up than certificates but is
> -less scalable.
> -
> -Use the GnuTLS @code{psktool} program to generate a @code{keys.psk}
> -file containing one or more usernames and random keys:
> -
> -@example
> -mkdir -m 0700 /tmp/keys
> -psktool -u rich -p /tmp/keys/keys.psk
> -@end example
> -
> -TLS-enabled servers such as qemu-nbd can use this directory like so:
> -
> -@example
> -qemu-nbd \
> -  -t -x / \
> -  --object tls-creds-psk,id=3Dtls0,endpoint=3Dserver,dir=3D/tmp/keys \
> -  --tls-creds tls0 \
> -  image.qcow2
> -@end example
> -
> -When connecting from a qemu-based client you must specify the
> -directory containing @code{keys.psk} and an optional @var{username}
> -(defaults to ``qemu''):
> -
> -@example
> -qemu-img info \
> -  --object tls-creds-psk,id=3Dtls0,dir=3D/tmp/keys,username=3Drich,endpo=
int=3Dclient \
> -  --image-opts \
> -  file.driver=3Dnbd,file.host=3Dlocalhost,file.port=3D10809,file.tls-cre=
ds=3Dtls0,file.export=3D/
> -@end example
> -
> -@node gdb_usage
> -@section GDB usage
> -
> -QEMU has a primitive support to work with gdb, so that you can do
> -'Ctrl-C' while the virtual machine is running and inspect its state.
> -
> -In order to use gdb, launch QEMU with the '-s' option. It will wait for a
> -gdb connection:
> -@example
> -@value{qemu_system} -s -kernel bzImage -hda rootdisk.img -append "root=
=3D/dev/hda"
> -Connected to host network interface: tun0
> -Waiting gdb connection on port 1234
> -@end example
> -
> -Then launch gdb on the 'vmlinux' executable:
> -@example
> -> gdb vmlinux
> -@end example
> -
> -In gdb, connect to QEMU:
> -@example
> -(gdb) target remote localhost:1234
> -@end example
> -
> -Then you can use gdb normally. For example, type 'c' to launch the kerne=
l:
> -@example
> -(gdb) c
> -@end example
> -
> -Here are some useful tips in order to use gdb on system code:
> -
> -@enumerate
> -@item
> -Use @code{info reg} to display all the CPU registers.
> -@item
> -Use @code{x/10i $eip} to display the code at the PC position.
> -@item
> -Use @code{set architecture i8086} to dump 16 bit code. Then use
> -@code{x/10i $cs*16+$eip} to dump the code at the PC position.
> -@end enumerate
> -
> -Advanced debugging options:
> -
> -The default single stepping behavior is step with the IRQs and timer ser=
vice routines off.  It is set this way because when gdb executes a single s=
tep it expects to advance beyond the current instruction.  With the IRQs an=
d timer service routines on, a single step might jump into the one of the i=
nterrupt or exception vectors instead of executing the current instruction.=
 This means you may hit the same breakpoint a number of times before execut=
ing the instruction gdb wants to have executed.  Because there are rare cir=
cumstances where you want to single step into an interrupt vector the behav=
ior can be controlled from GDB.  There are three commands you can query and=
 set the single step behavior:
> -@table @code
> -@item maintenance packet qqemu.sstepbits
> -
> -This will display the MASK bits used to control the single stepping IE:
> -@example
> -(gdb) maintenance packet qqemu.sstepbits
> -sending: "qqemu.sstepbits"
> -received: "ENABLE=3D1,NOIRQ=3D2,NOTIMER=3D4"
> -@end example
> -@item maintenance packet qqemu.sstep
> -
> -This will display the current value of the mask used when single steppin=
g IE:
> -@example
> -(gdb) maintenance packet qqemu.sstep
> -sending: "qqemu.sstep"
> -received: "0x7"
> -@end example
> -@item maintenance packet Qqemu.sstep=3DHEX_VALUE
> -
> -This will change the single step mask, so if wanted to enable IRQs on th=
e single step, but not timers, you would use:
> -@example
> -(gdb) maintenance packet Qqemu.sstep=3D0x5
> -sending: "qemu.sstep=3D0x5"
> -received: "OK"
> -@end example
> -@end table
> +@include docs/system/images.texi
> +@include docs/system/net.texi
> +@include docs/system/usb.texi
> +@include docs/system/ivshmem.texi
> +@include docs/system/linuxboot.texi
> +@include docs/system/vnc-security.texi
> +@include docs/system/tls.texi
> +@include docs/system/gdb.texi
>=20=20
>  @node QEMU System emulator for non PC targets
>  @chapter QEMU System emulator for non PC targets
> @@ -2411,83 +1047,10 @@ to make it close to a 4.5 or newer kernel.
>=20=20
>  @include qemu-deprecated.texi
>=20=20
> -@node Supported build platforms
> -@appendix Supported build platforms
> +@include docs/system/build-platforms.texi
>=20=20
> -QEMU aims to support building and executing on multiple host OS platform=
s.
> -This appendix outlines which platforms are the major build targets. These
> -platforms are used as the basis for deciding upon the minimum required
> -versions of 3rd party software QEMU depends on. The supported platforms
> -are the targets for automated testing performed by the project when patc=
hes
> -are submitted for review, and tested before and after merge.
> +@include docs/system/license.texi
>=20=20
> -If a platform is not listed here, it does not imply that QEMU won't work.
> -If an unlisted platform has comparable software versions to a listed pla=
tform,
> -there is every expectation that it will work. Bug reports are welcome for
> -problems encountered on unlisted platforms unless they are clearly older
> -vintage than what is described here.
> -
> -Note that when considering software versions shipped in distros as suppo=
rt
> -targets, QEMU considers only the version number, and assumes the feature=
s in
> -that distro match the upstream release with the same version. In other w=
ords,
> -if a distro backports extra features to the software in their distro, QE=
MU
> -upstream code will not add explicit support for those backports, unless =
the
> -feature is auto-detectable in a manner that works for the upstream relea=
ses
> -too.
> -
> -The Repology site @url{https://repology.org} is a useful resource to ide=
ntify
> -currently shipped versions of software in various operating systems, tho=
ugh
> -it does not cover all distros listed below.
> -
> -@section Linux OS
> -
> -For distributions with frequent, short-lifetime releases, the project wi=
ll
> -aim to support all versions that are not end of life by their respective
> -vendors. For the purposes of identifying supported software versions, the
> -project will look at Fedora, Ubuntu, and openSUSE distros. Other short-
> -lifetime distros will be assumed to ship similar software versions.
> -
> -For distributions with long-lifetime releases, the project will aim to s=
upport
> -the most recent major version at all times. Support for the previous maj=
or
> -version will be dropped 2 years after the new major version is released,
> -or when it reaches ``end of life''. For the purposes of identifying
> -supported software versions, the project will look at RHEL, Debian,
> -Ubuntu LTS, and SLES distros. Other long-lifetime distros will be
> -assumed to ship similar software versions.
> -
> -@section Windows
> -
> -The project supports building with current versions of the MinGW toolcha=
in,
> -hosted on Linux.
> -
> -@section macOS
> -
> -The project supports building with the two most recent versions of macOS=
, with
> -the current homebrew package set available.
> -
> -@section FreeBSD
> -
> -The project aims to support the all the versions which are not end of li=
fe.
> -
> -@section NetBSD
> -
> -The project aims to support the most recent major version at all times. =
Support
> -for the previous major version will be dropped 2 years after the new maj=
or
> -version is released.
> -
> -@section OpenBSD
> -
> -The project aims to support the all the versions which are not end of li=
fe.
> -
> -@node License
> -@appendix License
> -
> -QEMU is a trademark of Fabrice Bellard.
> -
> -QEMU is released under the
> -@url{https://www.gnu.org/licenses/gpl-2.0.txt,GNU General Public License=
},
> -version 2. Parts of QEMU have specific licenses, see file
> -@url{https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3DLICENSE,LICEN=
SE}.
>=20=20
>  @node Index
>  @appendix Index


--=20
Alex Benn=C3=A9e

