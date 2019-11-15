Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FFC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC1420748
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtg2tckZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC1420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaTl-0005c3-Oq
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iVaPU-0000jA-Ir
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iVaPS-0007bb-5F
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:09:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iVaPS-0007ab-0i
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573819742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FyrX4rcI1HWv0Cg5BafeF4SUcaqWoHOIwp1NeoMFa9g=;
 b=dtg2tckZYgCVGtMRj3dKGZs5zgR8zGg0oK/g4RU2PHK3be0ftlqa0PAvifsAbfoKARBRp1
 ZwuzC3BfwRyDeBJ4Ik0RLcFHD1A0TjUTkkiob/yTWuVToZBSS5CSXPkB11losqrZ3THQDQ
 9Id2yKH2HldtTZBm1S5fKN1f2iTKQRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-DyMqPIisPCKlCPThZ6ZjeQ-1; Fri, 15 Nov 2019 07:09:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C297C8024E5
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-14.ams2.redhat.com
 [10.36.117.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2257BF6DE;
 Fri, 15 Nov 2019 12:08:54 +0000 (UTC)
Subject: Re: [PATCH qemu-web] Add a blog post on "Micro-Optimizing KVM
 VM-Exits"
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
References: <20191108092247.16207-1-kchamart@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f8dce546-ea28-0619-a20a-62c762f99721@redhat.com>
Date: Fri, 15 Nov 2019 13:08:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191108092247.16207-1-kchamart@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: DyMqPIisPCKlCPThZ6ZjeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: aarcange@redhat.com, pbonzini@redhat.com, vkuznets@redhat.com,
 dgilbert@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2019 10.22, Kashyap Chamarthy wrote:
> This blog post summarizes the talk "Micro-Optimizing KVM VM-Exits"[1],
> given by Andrea Arcangeli at the recently concluded KVM Forum 2019.
>=20

 Hi Kashyap,

first thanks for writing up this article! It's a really nice summary of
the presentation, I think.

But before we include it, let me ask a meta-question: Is an article
about the KVM *kernel* code suitable for the *QEMU* blog? Or is there
maybe a better place for this, like an article on www.linux-kvm.org ?

Opinions? Ideas?

 Thomas


> ---
>  ...019-11-06-micro-optimizing-kvm-vmexits.txt | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 _posts/2019-11-06-micro-optimizing-kvm-vmexits.txt
>=20
> diff --git a/_posts/2019-11-06-micro-optimizing-kvm-vmexits.txt b/_posts/=
2019-11-06-micro-optimizing-kvm-vmexits.txt
> new file mode 100644
> index 0000000000000000000000000000000000000000..f4a28d58ddb40103dd599fdfd=
861eeb4c41ed976
> --- /dev/null
> +++ b/_posts/2019-11-06-micro-optimizing-kvm-vmexits.txt
> @@ -0,0 +1,115 @@
> +---
> +layout: post
> +title: "Micro-Optimizing KVM VM-Exits"
> +date:   2019-11-08
> +categories: [kvm, optimization]
> +---
> +
> +Background on VM-Exits
> +----------------------
> +
> +KVM (Kernel-based Virtual Machine) is the Linux kernel module that
> +allows a host to run virtualized guests (Linux, Windows, etc).  The KVM
> +"guest execution loop", with QEMU (the open source emulator and
> +virtualizer) as its user space, is roughly as follows: QEMU issues the
> +ioctl(), KVM_RUN, to tell KVM to prepare to enter the CPU's "Guest Mode"
> +-- a special processor mode which allows guest code to safely run
> +directly on the physical CPU.  The guest code, which is inside a "jail"
> +and thus cannot interfere with the rest of the system, keeps running on
> +the hardware until it encounters a request it cannot handle.  Then the
> +processor gives the control back (referred to as "VM-Exit") either to
> +kernel space, or to the user space to handle the request.  Once the
> +request is handled, native execution of guest code on the processor
> +resumes again.  And the loop goes on.
> +
> +There are dozens of reasons for VM-Exits (Intel's Software Developer
> +Manual outlines 64 "Basic Exit Reasons").  For example, when a guest
> +needs to emulate the CPUID instruction, it causes a "light-weight exit"
> +to kernel space, because CPUID (among a few others) is emulated in the
> +kernel itself, for performance reasons.  But when the kernel _cannot_
> +handle a request, e.g. to emulate certain hardware, it results in a
> +"heavy-weight exit" to QEMU, to perform the emulation.  These VM-Exits
> +and subsequent re-entries ("VM-Enters"), even the light-weight ones, can
> +be expensive.  What can be done about it?
> +
> +Guest workloads that are hard to virtualize
> +-------------------------------------------
> +
> +At the 2019 edition of the KVM Forum in Lyon, kernel developer, Andrea
> +Arcangeli, attempted to address the kernel part of minimizing VM-Exits.
> +
> +His talk touched on the cost of VM-Exits into the kernel, especially for
> +guest workloads (e.g. enterprise databases) that are sensitive to their
> +performance penalty.  However, these workloads cannot avoid triggering
> +VM-Exits with a high frequency.  Andrea then outlined some of the
> +optimizations he's been working on to improve the VM-Exit performance in
> +the KVM code path -- especially in light of applying mitigations for
> +speculative execution flaws (Spectre v2, MDS, L1TF).
> +
> +Andrea gave a brief recap of the different kinds of speculative
> +execution attacks (retpolines, IBPB, PTI, SSBD, etc).  Followed by that
> +he outlined the performance impact of Spectre-v2 mitigations in context
> +of KVM.
> +
> +The microbechmark: CPUID in a one million loop
> +----------------------------------------------
> +
> +The synthetic microbenchmark (meaning, focus on measuring the
> +performance of a specific area of code) Andrea used was to run the CPUID
> +instruction one million times, without any GCC optimizations or caching.
> +This was done to test the latency of VM-Exits.
> +
> +While stressing that the results of these microbenchmarks do not
> +represent real-world workloads, he had two goals in mind with it: (a)
> +explain how the software mitigation works; and (b) to justify to the
> +broader community the value of the software optimizations he's working
> +on in KVM.
> +
> +Andrea then reasoned through several interesting graphs that show how
> +CPU computation time gets impacted when you disable or enable the
> +various kernel-space mitigations for Spectre v2, L1TF, MDS, et al.
> +
> +The proposal: "KVM Monolithic"
> +------------------------------
> +
> +Based on his investigation, Andrea proposed a patch series, ["KVM
> +monolithc"](https://lwn.net/Articles/800870/), to get rid of the KVM
> +common module, 'kvm.ko'.  Instead the KVM common code gets linked twice
> +into each of the vendor-specific KVM modules, 'kvm-intel.ko' and
> +'kvm-amd.ko'.
> +
> +The reason for doing this is that the 'kvm.ko' module indirectly calls
> +(via the "retpoline" technique) the vendor-specific KVM modules at every
> +VM-Exit, several times.  These indirect calls were not optimal before,
> +but the "retpoline" mitigation (which isolates indirect branches, that
> +allow a CPU to execute code from arbitrary locations, from speculative
> +execution) for Spectre v2 compounds the problem, as it degrades
> +performance.
> +
> +This approach will result in a few MiB of increased disk space for
> +'kvm-intel.ko' and 'kvm-amd.ko', but the upside in saved indirect calls,
> +and the elimination of "retpoline" overhead at run-time more than
> +compensate for it.
> +
> +With the "KVM Monolithic" patch series applied, Andrea's microbenchmarks
> +show a double-digit improvement in performance with default mitigations
> +(for Spectre v2, et al) enabled on both Intel 'VMX' and AMD 'SVM'.  And
> +with 'spectre_v2=3Doff' or for CPUs with IBRS_ALL in ARCH_CAPABILITIES
> +"KVM monolithic" still improve[s] performance, albiet it's on the order
> +of 1%.
> +
> +Conclusion
> +----------
> +
> +Removal of the common KVM module has a non-negligible positive
> +performance impact.  And the "KVM Monolitic" patch series is still
> +actively being reviewed, modulo some pending clean-ups.  Based on the
> +upstream review discussion, KVM Maintainer, Paolo Bonzini, and other
> +reviewers seemed amenable to merge the series.
> +
> +Although, we still have to deal with mitigations for 'indirect branch
> +prediction' for a long time, reducing the VM-Exit latency is important
> +in general; and more specifically, for guest workloads that happen to
> +trigger frequent VM-Exits, without having to disable Spectre v2
> +mitigations on the host, as Andrea stated in the cover letter of his
> +patch series.
>=20


