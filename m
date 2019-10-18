Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57AECA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDCD222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDCD222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSni-0008QA-KO
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdenemar@redhat.com>) id 1iLSlw-0006m5-Bc
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdenemar@redhat.com>) id 1iLSlu-0001Le-0G
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:58:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1iLSlr-0001KM-SD
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D7CF118C4299
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 13:58:22 +0000 (UTC)
Received: from virval.usersys.redhat.com (unknown [10.43.2.188])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 967A864045;
 Fri, 18 Oct 2019 13:58:22 +0000 (UTC)
Received: by virval.usersys.redhat.com (Postfix, from userid 500)
 id 4BC97101CE9; Fri, 18 Oct 2019 15:58:21 +0200 (CEST)
Date: Fri, 18 Oct 2019 15:58:21 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: Default CPU models on s390x and ppc64
Message-ID: <20191018135821.GR4204@orkuz.int.mamuti.net>
References: <20191017151606.GA1880840@orkuz.int.mamuti.net>
 <82ea23ea-be23-c374-3f10-65d8f6e79432@redhat.com>
 <3c2d2d20-682e-ab4f-ced4-c7f48473dd24@redhat.com>
 <9083f32c-68db-cc28-e0ea-7fafd014be9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9083f32c-68db-cc28-e0ea-7fafd014be9b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 18 Oct 2019 13:58:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: David Gibson <dgibson@redhat.com>, David Hildenbrand <dhildenb@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 17:35:30 +0200, David Hildenbrand wrote:
> On 17.10.19 17:31, David Hildenbrand wrote:
> > On 17.10.19 17:18, David Hildenbrand wrote:
> >> On 17.10.19 17:16, Jiri Denemark wrote:
> >>> Hi David and David,
> >>>
> >>> I'm working on libvirt's support [1] for query-machines'
> >>> default-cpu-type, which is supposed to return the type of the default
> >>> CPU model that QEMU uses for each machine type. Rather than hard coding
> >>> the default in libvirt (which we currently do on x86), we ask QEMU for
> >>> the default CPU model and use it unless a user asks for a specific CPU
> >>> model explicitly.
> >>>
...
> >>> This situation on s390x is not so complicated, but not really better.
> >>> The default CPU is said to be "qemu" for all machine types, which works
> >>> fine for TCG domains, but it doesn't work on KVM because QEMU complains
> >>> that some features requested in the CPU model are not available. In
> >>> other words the "qemu" CPU model is not runnable on KVM. This a bit
> >>> similar to what happens on x86_64, but QEMU just ignores missing
> >>> features and starts happily there.
> >>
> >> The default model under KVM is "host", under TCG it's "qemu". We should
> >> not use "qemu" under KVM, although it might work on some setups ...
> >>
> >> Where/how is this default model detected?

All this is about probing QEMU capabilities so that we can tell users
what to expect and let them change the default. E.g., qemu64 default CPU
model on x86_64 is never the right one to be used with KVM. By making
the default CPU model visible in the domain XML even before the domain
gets started, we help users detect such suboptimal configurations.

> > 
> > ... target/s390x/kvm.c:kvm_arch_init()
> > 
> > MachineClass *mc = MACHINE_GET_CLASS(ms);
> > 
> > mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
> > 
> > 
> > I think the call order should make sure that "host" is set after "qemu"
> > is set. I'll go ahead and verify that.kvm_arch_init(
> > 
> 
> configure_accelerator(current_machine, argv[0]) -> kvm_arch_init()
> 
> is called after
> 
> current_machine = MACHINE(object_new(object_class_get_name(
> 		  OBJECT_CLASS(machine_class))));
> 
> and therefore after the .class_init function of the machine was called.
> 
> I don't see how the default cpu model could not be "host" if qemu was 
> started with "--enable-kvm"

I guess the problem could be that QEMU capabilities probing in libvirt
is done with -machine none. We first probe with KVM enabled and then for
a few specific commands reprobe with TCG only. We could do it with
query-machines too to get different default CPU models depending on the
accelerator, but it wouldn't actually help.

The full command line used for capabilities probing is

    qemu-system-s390x \
        -S \
        -no-user-config \
        -nodefaults \
        -nographic \
        -machine none,accel=kvm:tcg \
        -qmp unix:/tmp/qmp-ivG4UN/qmp.monitor,server,nowait \
        -pidfile /tmp/qmp-ivG4UN/qmp.pid \
        -daemonize

One of the command we send is

    {"execute":"query-kvm","id":"libvirt-5"}

and the reply is

    {"return": {"enabled": true, "present": true}, "id": "libvirt-5"}

Which means KVM is usable and enabled, but still query-machines returns

    {
      "return": [
        {
          "hotpluggable-cpus": true,
          "name": "s390-ccw-virtio-4.0",
          "numa-mem-supported": false,
          "default-cpu-type": "qemu-s390x-cpu",
          "cpu-max": 248,
          "deprecated": false
        },
        {
          "hotpluggable-cpus": true,
          "name": "s390-ccw-virtio-3.1",
          "numa-mem-supported": false,
          "default-cpu-type": "qemu-s390x-cpu",
          "cpu-max": 248,
          "deprecated": false
        },
        ...
      ]
    }

So it seems the code is run during the machine initialization and thus
it doesn't affect what query-machines returns with -machine none.

Jirka

