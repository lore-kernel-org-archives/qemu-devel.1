Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88109C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5752E208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5752E208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfoO1-0007Ks-9a
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hfo5E-000340-Sr
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hfo5B-00065i-6J
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:14:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43246)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hfo59-000619-LD
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:14:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4736C308FE62;
 Tue, 25 Jun 2019 16:14:03 +0000 (UTC)
Received: from redhat.com (ovpn-112-73.ams2.redhat.com [10.36.112.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69E04600C7;
 Tue, 25 Jun 2019 16:14:00 +0000 (UTC)
Date: Tue, 25 Jun 2019 17:13:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190625161357.GI3139@redhat.com>
References: <20190625050008.12789-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190625050008.12789-1-ehabkost@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 25 Jun 2019 16:14:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/6] x86 CPU model versioning
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Pavel Hrdina <phrdina@redhat.com>, Tao Xu <tao3.xu@intel.com>, "Hu,
 Robert" <robert.hu@intel.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 02:00:02AM -0300, Eduardo Habkost wrote:
> This series implements basic infrastructure for CPU model
> versioning, as discussed before[1][2][3].  This will finally
> allow us to update CPU models in ways that introduce new software
> or hardware requirements.
> 
> My original plan was to use "query-cpu-model-expansion
> mode=static" to resolve aliases, but I dropped that plan because
> it would increase complexity for management software a lot.
> static CPU models are documented as not being affected by the
> machine type and accelerator at all, which would make the
> versioned CPU models very inconvenient to use in the command
> line.  e.g.: users would be forced to replace:
> 
>   -cpu Haswell
> 
> with:
> 
>   -cpu Haswell-4.1,+2apic,+monitor,+kvmclock,+kvm-nopiodelay,+kvm-asyncpf,+kvm-steal-time,+kvm-pv-eoi,+kvmclock-stable-bit,+x2apic,-acpi,-monitor,-svm
> 
> In the end, making the versioned CPU models static is not a
> requirement at all: what we really need is to drop the
> runnability guarantees from unversioned CPU model names, and
> require management software to resolve the unversioned alias
> before saving the VM configuration.
> 
> Guest ABI compatibility and live migration guarantees are going
> to be kept: unversioned CPU models will still be usable with live
> migration.  Only runnability guarantees when updating the machine
> type will be dropped.  This means unversioned CPU models are
> still reported as migration-safe in query-cpu-definitions.

I'm having a little bit of a hard time parsing the overall behaviour
from the above description. Let me outline the examples so you can
confirm if I've got it right.

Lets assume there is a VM configured using "Haswell"

Today a mgmt app would pass the CPU model name in to QEMU as is,
and thus we get

  $QEMU -machine pc-i440fx-4.0 -cpu Haswell ...more args...

The semantics of "Haswell" here is going to vary according to
what the machine type pc-i440fx-4.0 customizes wrt Haswell.

If the config later has the machine type changed to pc-i440fx-4.1
the semantics of Haswell might change in an arbitrary way. It
might even become unrunnable on the current hardware.

With the new versioned machine types, the VM config of "Haswell"
would be resolved into some arbitrary versioned machine type
"Haswell-NNN" and thus the mgmt app would launch

  $QEMU -machine pc-i440fx-4.0 -cpu Haswell-NNN ...more args...

The semantics of "Haswell-NNN" will never change no matter what
the machine type does.

The end user has the option to explicitly give "Haswell-NNN" to
the mgmt app if they know they want that particular variant, and
in this case the mgmt app won't need to resolve anything (or at
least the process of trying to resolve it won't change it).


> 
> The last patch in the series demonstrates how the new feature can
> be used to update a CPU model: it adds a Cascadelake-Server-4.1.1
> CPU model, including "arch-capabilities=on" and "stepping=5".
> Unfortunately we can't enable arch-capabilities in the -4.1
> version of Cascadelake-Server because it would break our existing
> runnability guarantees.
> 
> [1] https://www.mail-archive.com/libvir-list@redhat.com/msg167342.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg590034.html
> [3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg611244.html
> 
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Pavel Hrdina <phrdina@redhat.com>
> Cc: Jiri Denemark <jdenemar@redhat.com>
> Cc: "Hu, Robert" <robert.hu@intel.com>
> Cc: Tao Xu <tao3.xu@intel.com>
> Cc: Richard Henderson <rth@twiddle.net>
> 
> Eduardo Habkost (6):
>   i386: Add x-force-features option for testing
>   i386: Remove unused host_cpudef variable
>   qmp: Add "alias-of" field to query-cpu-definitions
>   i386: Infrastructure for versioned CPU models
>   docs: Deprecate CPU model runnability guarantees
>   i386: Add Cascadelake-Server-4.1.1 CPU model
> 
>  qapi/target.json                           |   9 +-
>  include/hw/i386/pc.h                       |   3 +
>  target/i386/cpu-qom.h                      |  10 +-
>  target/i386/cpu.h                          |  16 ++
>  hw/i386/pc.c                               |   3 +
>  hw/i386/pc_piix.c                          |   4 +
>  hw/i386/pc_q35.c                           |   4 +
>  target/i386/cpu.c                          | 188 +++++++++++++++++----
>  qemu-deprecated.texi                       |  19 +++
>  tests/acceptance/x86_cpu_model_versions.py | 173 +++++++++++++++++++
>  10 files changed, 388 insertions(+), 41 deletions(-)
>  create mode 100644 tests/acceptance/x86_cpu_model_versions.py
> 
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

