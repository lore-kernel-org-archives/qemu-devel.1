Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A97C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 16:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B5321479
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 16:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B5321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHADR-0005Us-IQ
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 12:48:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHAC3-0004jl-EN
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHAC1-0007CT-BM
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:47:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hHAC1-0007Bf-28
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:47:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so3738247wrx.10
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 09:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=oIthSc46FQaeIvPSAivG/mAWHvXGjhdaRHRny7QBr7Y=;
	b=E8k3ebRZpwFxKJRwNE7ln8aCG/GgCeZ+aKNgQqEiikxbwR4wreBmIkz+hIxHCGxbGv
	/QrHB+G3i1XHdazJ+MnLe3CS79Dk2llA0Uc6oPzDKJcFs259vHh5AYx20B5C8pqHsW14
	0O52ph/uwpAN/QUIYyRPTpxUUsw1QytlRZQHN34QBw6dl0+YfEr/rfFec45i1AroySSQ
	MVGLfMJ8/5l6OpNiB/KSQ/w64YhhXfj1uw3oaFelxLbfP+9YLs4eCtAFvaXMQpjSqT0/
	P/AH6eZITAzIBhlRkvdYsncMXx2xDjeLkAM79FNQwbUn6Ph5t7Vy2DvGAkNHk9S1b4td
	UcSA==
X-Gm-Message-State: APjAAAW7ojrwG8VmBC7VElPV+oNcW11wwSuoBwDDfuf+e7ndTZmOm3j1
	USvPpIC3RI/FdgozNphGaB+AoA==
X-Google-Smtp-Source: APXvYqzo2D7995u7snuK7kLFYXmgguE6WORRdyLnXzeP6iUMfKtaLprRigqEQ0yeQzDMvKbz+kv2Kw==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr62134921wrp.194.1555606039896;
	Thu, 18 Apr 2019 09:47:19 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	c10sm1689036wru.83.2019.04.18.09.47.18
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 09:47:19 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190418161311.24197-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <21091c08-02cf-52de-6d7c-2031dfd38cd5@redhat.com>
Date: Thu, 18 Apr 2019 18:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418161311.24197-1-stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] security.rst: add Security Guide to
 developer docs
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
Cc: Eduardo Otubo <otubo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418164718.ufRK7EGUwd09u0XGP1buUgvFWHO89Bcnc9JwnsqPI9o@z>

Hi Stefan,

On 4/18/19 6:13 PM, Stefan Hajnoczi wrote:
> At KVM Forum 2018 I gave a presentation on security in QEMU:
> https://www.youtube.com/watch?v=YAdRf_hwxU8 (video)
> https://vmsplice.net/~stefan/stefanha-kvm-forum-2018.pdf (slides)
> 
> This patch adds a security guide to the developer docs.  This document
> covers things that developers should know about security in QEMU.  It is
> just a starting point that we can expand on later.  I hope it will be
> useful as a resource for new contributors and will save code reviewers
> from explaining the same concepts many times.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/devel/index.rst    |   1 +
>  docs/devel/security.rst | 220 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 docs/devel/security.rst
> 
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index ebbab636ce..fd0b5fa387 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -20,3 +20,4 @@ Contents:
>     stable-process
>     testing
>     decodetree
> +   security
> diff --git a/docs/devel/security.rst b/docs/devel/security.rst
> new file mode 100644
> index 0000000000..c6a6c9973d
> --- /dev/null
> +++ b/docs/devel/security.rst
> @@ -0,0 +1,220 @@
> +==============
> +Security Guide
> +==============
> +Overview
> +--------
> +This guide covers security topics relevant to developers working on QEMU.  It
> +includes an explanation of the security requirements that QEMU gives its users,
> +the architecture of the code, and secure coding practices.
> +
> +Security Requirements
> +---------------------
> +QEMU supports many different use cases, some of which have stricter security
> +requirements than others.  The community has agreed on the overall security
> +requirements that users may depend on.  These requirements define what is
> +considered supported from a security perspective.
> +
> +Virtualization Use Case
> +~~~~~~~~~~~~~~~~~~~~~~~
> +The virtualization use case covers cloud and virtual private server (VPS)
> +hosting, as well as traditional data center and desktop virtualization.  These
> +use cases rely on hardware virtualization extensions to execute guest code
> +safely on the physical CPU at close-to-native speed.
> +
> +The following entities are **untrusted**, meaning that they may be buggy or
> +malicious:
> +
> +* Guest
> +* User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> +* Network protocols (e.g. NBD, live migration)
> +* User-supplied files (e.g. disk images, kernels, device trees)

What about pass-thru USB/PCI devices?

> +
> +Bugs affecting these entities are evaluated on whether they can cause damage in
> +real-world use cases and treated as security bugs if this is the case.
> +
> +Non-virtualization Use Case
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The non-virtualization use case covers emulation using the Tiny Code Generator
> +(TCG).  In principle the TCG and device emulation code used in conjunction with
> +the non-virtualization use case should meet the same security requirements as
> +the virtualization use case.  However, for historical reasons much of the
> +non-virtualization use case code was not written with these security
> +requirements in mind.
> +
> +Bugs affecting the non-virtualization use case are not considered security
> +bugs at this time.  Users with non-virtualization use cases must not rely on
> +QEMU to provide guest isolation or any security guarantees.
> +
> +Architecture
> +------------
> +This section describes the design principles that ensure the security
> +requirements are met.
> +
> +Guest Isolation
> +~~~~~~~~~~~~~~~
> +Guest isolation is the confinement of guest code to the virtual machine.  When
> +guest code gains control of execution on the host this is called escaping the
> +virtual machine.  Isolation also includes resource limits such as CPU, memory,
> +disk, or network throttling.  Guests must be unable to exceed their resource

I'm unsure but I'd have written "... such as throttling of CPU, memory,
disk or network".

> +limits.
> +
> +QEMU presents an attack surface to the guest in the form of emulated devices.
> +The guest must not be able to gain control of QEMU.  Bugs in emulated devices
> +could allow malicious guests to gain code execution in QEMU.  At this point the
> +guest has escaped the virtual machine and is able to act in the context of the
> +QEMU process on the host.
> +
> +Guests often interact with other guests and share resources with them.  A
> +malicious guest must not gain control of other guests or access their data.
> +Disk image files and network traffic must be protected from other guests unless
> +explicitly shared between them by the user.
> +
> +Principle of Least Privilege
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The principle of least privilege states that each component only has access to
> +the privileges necessary for its function.  In the case of QEMU this means that
> +each process only has access to resources belonging to the guest.
> +
> +The QEMU process should not have access to any resources that are inaccessible
> +to the guest.  This way the guest does not gain anything by escaping into the
> +QEMU process since it already has access to those same resources from within
> +the guest.
> +
> +Following the principle of least privilege immediately fulfills guest isolation
> +requirements.  For example, guest A only has access to its own disk image file
> +``a.img`` and not guest B's disk image file ``b.img``.
> +
> +In reality certain resources are inaccessible to the guest but must be
> +available to QEMU to perform its function.  For example, host system calls are
> +necessary for QEMU but are not exposed to guests.  A guest that escapes into
> +the QEMU process can then begin invoking host system calls.
> +
> +New features must be designed to follow the principle of least privilege.
> +Should this not be possible for technical reasons, the security risk must be
> +clearly documented so users are aware of the trade-off of enabling the feature.
> +
> +Isolation mechanisms
> +~~~~~~~~~~~~~~~~~~~~
> +Several isolation mechanisms are available to realize this architecture of
> +guest isolation and the principle of least privilege.  With the exception of
> +Linux seccomp, these mechanisms are all deployed by management tools that
> +launch QEMU, such as libvirt.  They are also platform-specific so they are only
> +described briefly for Linux here.
> +
> +The fundamental isolation mechanism is that QEMU processes must run as
> +**unprivileged users**.  Sometimes it seems more convenient to launch QEMU as
> +root to give it access to host devices (e.g. ``/dev/net/tun``) but this poses a
> +huge security risk.  File descriptor passing can be used to give an otherwise
> +unprivileged QEMU process access to host devices without running QEMU as root.
> +
> +**SELinux** and **AppArmor** make it possible to confine processes beyond the
> +traditional UNIX process and file permissions model.  They restrict the QEMU
> +process from accessing processes and files on the host system that are not
> +needed by QEMU.
> +
> +**Resource limits** and **cgroup controllers** provide throughput and utilization
> +limits on key resources such as CPU time, memory, and I/O bandwidth.
> +
> +**Linux namespaces** can be used to make process, file system, and other system
> +resources unavailable to QEMU.  A namespaced QEMU process is restricted to only
> +those resources that were granted to it.
> +
> +**Linux seccomp** is available via the QEMU ``--sandbox`` option.  It disables
> +system calls that are not needed by QEMU, thereby reducing the host kernel
> +attack surface.
> +
> +Secure coding practices
> +-----------------------
> +At the source code level there are several points to keep in mind.  Both
> +developers and security researchers must be aware of them so that they can
> +develop safe code and audit existing code properly.
> +
> +General Secure C Coding Practices
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Most CVEs (security bugs) reported against QEMU are not specific to
> +virtualization or emulation.  They are simply C programming bugs.  Therefore
> +it's critical to be aware of common classes of security bugs.
> +
> +There is a wide selection of resources available covering secure C coding.  For
> +example, the `CERT C Coding Standard
> +<https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standard>`_
> +covers the most important classes of security bugs.
> +
> +Instead of describing them in detail here, only the names of the most important
> +classes of security bugs are mentioned:
> +
> +* Buffer overflows
> +* Use-after-free and double-free
> +* Integer overflows
> +* Format string vulnerabilities
> +
> +Some of these classes of bugs can be detected by analyzers.  Static analysis is
> +performed regularly by Coverity and the most obvious of these bugs are even
> +reported by compilers.  Dynamic analysis is possible with valgrind, tsan, and
> +asan.
> +
> +Input Validation
> +~~~~~~~~~~~~~~~~
> +Inputs from the guest or external sources (e.g. network, files) cannot be
> +trusted and may be invalid.  Inputs must be checked before using them in a way
> +that could crash the program, expose host memory to the guest, or otherwise be
> +exploitable by an attacker.
> +
> +The most sensitive attack surface is device emulation.  All hardware register
> +accesses and data read from guest memory must be validated.  A typical example
> +is a device that contains multiple units that are selectable by the guest via
> +an index register::
> +
> +  typedef struct {
> +      ProcessingUnit unit[2];
> +      ...
> +  } MyDeviceState;
> +
> +  static void mydev_writel(void *opaque, uint32_t addr, uint32_t val)
> +  {
> +      MyDeviceState *mydev = opaque;
> +      ProcessingUnit *unit;
> +
> +      switch (addr) {
> +      case MYDEV_SELECT_UNIT:
> +          unit = &mydev->unit[val];   <-- this input wasn't validated!
> +          ...
> +      }
> +  }
> +
> +If ``val`` is not in range [0, 1] then an out-of-bounds memory access will take
> +place when ``unit`` is dereferenced.  The code must check that ``val`` is 0 or
> +1 and handle the case where it is invalid.
> +
> +Unexpected Device Accesses
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The guest may access device registers in unusual orders or at unexpected
> +moments.  Device emulation code must not assume that the guest follows the
> +typical "theory of operation" presented in driver writer manuals.  The guest
> +may make nonsense accesses to device registers such as starting operations
> +before the device has been fully initialized.
> +
> +A related issue is that device emulation code must be prepared for unexpected
> +device register accesses while asynchronous operations are in progress.  A
> +well-behaved guest might wait for a completion interrupt before accessing
> +certain device registers.  Device emulation code must handle the case where the
> +guest overwrites registers or submits further requests before an ongoing
> +request completes.  Unexpected accesses must not cause memory corruption or
> +leaks in QEMU.

Might worth to tell such unexpected accesses might be logged with
'qemu_log_mask(LOG_GUEST_ERROR, ...) and audited with -d guest_errors?

> +
> +Live migration
> +~~~~~~~~~~~~~~
> +Device state can be saved to disk image files and shared with other users.
> +Live migration code must validate inputs when loading device state so an
> +attacker cannot gain control by crafting invalid device states.  Device state
> +is therefore considered untrusted even though it is typically generated by QEMU
> +itself.
> +
> +Guest Memory Access Races
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +Guests with multiple vCPUs may modify guest RAM while device emulation code is
> +running.  Device emulation code must copy in descriptors and other guest RAM
> +structures and only process the local copy.  This prevents
> +time-of-check-to-time-of-use (TOCTOU) race conditions that could cause QEMU to
> +crash when a vCPU thread modifies guest RAM while device emulation is
> +processing it.
> 

Thanks for this document!

Regards,

Phil.

