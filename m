Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A7C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8356E2075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8356E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37697 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMVJF-0007k5-R6
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 06:20:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMVI3-0006rx-S4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMVI1-0006CC-QM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hMVI1-0006Bw-HF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:19:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C84003086222;
	Fri,  3 May 2019 10:19:36 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 692151001E8B;
	Fri,  3 May 2019 10:19:24 +0000 (UTC)
Date: Fri, 3 May 2019 11:19:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190503101921.GC17905@redhat.com>
References: <20190425133503.30847-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190425133503.30847-1-stefanha@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 03 May 2019 10:19:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] security.rst: add Security Guide to
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Otubo <otubo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503101921.kqIjUvPug4QlZV6mLfN4JeVkG_vOv4RTFUGXdUSW4PU@z>

On Thu, Apr 25, 2019 at 02:35:03PM +0100, Stefan Hajnoczi wrote:
> At KVM Forum 2018 I gave a presentation on security in QEMU:
> https://www.youtube.com/watch?v=YAdRf_hwxU8 (video)
> https://vmsplice.net/~stefan/stefanha-kvm-forum-2018.pdf (slides)
> 
> This patch adds a security guide to the developer docs.  This document
> covers things that developers should know about security in QEMU.  It is
> just a starting point that we can expand on later.  I hope it will be
> useful as a resource for new contributors and will save code reviewers
> from explaining the same concepts many times.

I'm wondering if we should split this doc in two parts. The first 50%
of it is actually relevant to both QEMU developers and downstream QEMU
developers of mgmt apps and/or end users.

The latter half is purely of interest to QEMU developers.

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Added mention of passthrough USB and PCI devices [philmd]
>  * Reworded resource limits [philmd]
>  * Added qemu_log_mask(LOG_GUEST_ERROR) [philmd]
> ---
>  docs/devel/index.rst    |   1 +
>  docs/devel/security.rst | 225 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 226 insertions(+)
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
> index 0000000000..83c6fb2231
> --- /dev/null
> +++ b/docs/devel/security.rst
> @@ -0,0 +1,225 @@
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
> +* Passthrough devices (e.g. PCI, USB)
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
> +virtual machine.  Isolation also includes resource limits such as throttling of
> +CPU, memory, disk, or network.  Guests must be unable to exceed their resource
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


Break here.

Everything above here is useful to QEMU devs, app devs & end users and
should be made part of the main QEMU doc - convert it to texi and @include
it from qemu-doc.texi, as we do for other stuff under docs/

Everything below here could just be renamed to "secure-coding-practices.rst"
and solely target qemu devs.


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
> +
> +Invalid device register accesses can be reported with
> +``qemu_log_mask(LOG_GUEST_ERROR, ...)``.  The ``-d guest_errors`` command-line
> +option enables these log messages.
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
> -- 
> 2.20.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

