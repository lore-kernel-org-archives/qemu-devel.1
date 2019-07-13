Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1305C742D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02A420830
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02A420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmIoz-0008Ct-Or
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 10:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41422)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hmIof-0007eQ-5Y
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hmIoY-0005rt-TC
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5919)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hmIoY-0005ps-FI
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D940F30C3180
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 14:15:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DABF51001B04;
 Sat, 13 Jul 2019 14:15:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 461541138648; Sat, 13 Jul 2019 16:15:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
Date: Sat, 13 Jul 2019 16:15:24 +0200
In-Reply-To: <1562775267-1222-5-git-send-email-pbonzini@redhat.com> (Paolo
 Bonzini's message of "Wed, 10 Jul 2019 18:14:23 +0200")
Message-ID: <87d0ie58cj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Sat, 13 Jul 2019 14:15:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Stefan for the tracing part.  Stefan, there are some observations
for you buried inline.  Search for "I guess the timestamp thing is for
avoiding recompilation", "generate trace.* per directory", and "we run
$(TRACETOOL) N times on the same input".

Paolo Bonzini <pbonzini@redhat.com> writes:

> This shows how to do some "computations" in meson.build using its array
> and dictionary data structures, and also a basic usage of the sourceset
> module for conditional compilation.
>
> Overall the look of the meson.build code is quite good, however Meson
> doesn't enjoy the same flexibility we have with Make in choosing
> the include path.

Might actually be a good thing.  The shorter the include path, the
easier it is to go from '#include WHATEVER' to the header file.

>                    In particular the tracing headers are using
> $(build_root)/$(<D); for now my solution is to generate headers like
> "trace/trace-audio.h" and have sixty one-line forwarding headers in the
> source tree; for example "audio/trace.h" includes "trace/trace-audio.h".
> I'm not sure if it's possible to instead add a one-line "generate
> trace headers" directive to each subdirectory's meson.build file.
> I suspect that it _is_ possible but you'd still have to change the
> include directives to include the subdirectory name (and then I prefer
> the forwarding headers).

I agree we want to keep '#include "trace.h"'.

I'm not sure I get the problem.

Having '#include "trace.h"' include trace.h from the including file's
directory doesn't rely on include paths (GCC manual: "For the quote form
of the include directive, the directory of the current file is searched
first"), so setting up a suitable include path can't be the problem.

Is convincing Meson to generate SUBDIR/FOO from SUBDIR/trace-events the
problem?

> The overall lines delta would be negative if it weren't for the forwarding
> headers.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitignore                       |   8 +-
>  Makefile                         | 172 ++++++---------------------------------
>  Makefile.objs                    |  88 +-------------------
>  audio/trace.h                    |   1 +
>  chardev/trace.h                  |   1 +
>  crypto/Makefile.objs             |   3 +-
>  hw/9pfs/trace.h                  |   1 +
>  hw/acpi/trace.h                  |   1 +
>  hw/alpha/trace.h                 |   1 +
>  hw/arm/trace.h                   |   1 +
>  hw/audio/trace.h                 |   1 +
>  hw/block/dataplane/trace.h       |   1 +
>  hw/block/trace.h                 |   1 +
>  hw/char/trace.h                  |   1 +
>  hw/display/trace.h               |   1 +
>  hw/dma/trace.h                   |   1 +
>  hw/gpio/trace.h                  |   1 +
>  hw/hppa/trace.h                  |   1 +
>  hw/i2c/trace.h                   |   1 +
>  hw/i386/trace.h                  |   1 +
>  hw/i386/xen/trace.h              |   1 +
>  hw/ide/trace.h                   |   1 +
>  hw/input/trace.h                 |   1 +
>  hw/intc/trace.h                  |   1 +
>  hw/isa/trace.h                   |   1 +
>  hw/mem/trace.h                   |   1 +
>  hw/misc/macio/trace.h            |   1 +
>  hw/misc/trace.h                  |   1 +
>  hw/net/trace.h                   |   1 +
>  hw/nvram/trace.h                 |   1 +
>  hw/pci-host/trace.h              |   1 +
>  hw/pci/trace.h                   |   1 +
>  hw/ppc/trace.h                   |   1 +
>  hw/rdma/trace.h                  |   1 +
>  hw/rdma/vmw/trace.h              |   1 +
>  hw/riscv/trace.h                 |   1 +
>  hw/s390x/trace.h                 |   1 +
>  hw/scsi/trace.h                  |   1 +
>  hw/sd/trace.h                    |   1 +
>  hw/sparc/trace.h                 |   1 +
>  hw/sparc64/trace.h               |   1 +
>  hw/timer/trace.h                 |   1 +
>  hw/tpm/trace.h                   |   1 +
>  hw/usb/trace.h                   |   1 +
>  hw/vfio/trace.h                  |   1 +
>  hw/virtio/trace.h                |   1 +
>  hw/watchdog/trace.h              |   1 +
>  hw/xen/trace.h                   |   1 +
>  meson.build                      | 129 +++++++++++++++++++++++++++++
>  migration/trace.h                |   1 +
>  net/trace.h                      |   1 +
>  qapi/Makefile.objs               |  20 -----
>  qapi/meson.build                 |  54 ++++++++++++
>  qapi/trace.h                     |   1 +
>  qobject/Makefile.objs            |   3 -
>  qobject/meson.build              |   3 +
>  qom/trace.h                      |   1 +
>  scripts/qapi-gen.py              |   2 +-
>  scripts/tracetool.py             |   2 +-
>  scripts/tracetool/backend/ust.py |   6 +-
>  scripts/tracetool/format/c.py    |   5 +-
>  stubs/Makefile.objs              |  43 ----------
>  stubs/meson.build                |  45 ++++++++++
>  target/arm/trace.h               |   1 +
>  target/hppa/trace.h              |   1 +
>  target/i386/trace.h              |   1 +
>  target/mips/trace.h              |   1 +
>  target/ppc/trace.h               |   1 +
>  target/riscv/trace.h             |   1 +
>  target/s390x/trace.h             |   1 +
>  target/sparc/trace.h             |   1 +
>  trace/Makefile.objs              |  51 ------------
>  trace/meson.build                |  75 +++++++++++++++++
>  ui/trace.h                       |   1 +
>  util/Makefile.objs               |  59 --------------
>  util/meson.build                 |  57 +++++++++++++
>  util/trace.h                     |   1 +
>  77 files changed, 455 insertions(+), 428 deletions(-)
>  create mode 100644 audio/trace.h
>  create mode 100644 chardev/trace.h
>  create mode 100644 hw/9pfs/trace.h
>  create mode 100644 hw/acpi/trace.h
>  create mode 100644 hw/alpha/trace.h
>  create mode 100644 hw/arm/trace.h
>  create mode 100644 hw/audio/trace.h
>  create mode 100644 hw/block/dataplane/trace.h
>  create mode 100644 hw/block/trace.h
>  create mode 100644 hw/char/trace.h
>  create mode 100644 hw/display/trace.h
>  create mode 100644 hw/dma/trace.h
>  create mode 100644 hw/gpio/trace.h
>  create mode 100644 hw/hppa/trace.h
>  create mode 100644 hw/i2c/trace.h
>  create mode 100644 hw/i386/trace.h
>  create mode 100644 hw/i386/xen/trace.h
>  create mode 100644 hw/ide/trace.h
>  create mode 100644 hw/input/trace.h
>  create mode 100644 hw/intc/trace.h
>  create mode 100644 hw/isa/trace.h
>  create mode 100644 hw/mem/trace.h
>  create mode 100644 hw/misc/macio/trace.h
>  create mode 100644 hw/misc/trace.h
>  create mode 100644 hw/net/trace.h
>  create mode 100644 hw/nvram/trace.h
>  create mode 100644 hw/pci-host/trace.h
>  create mode 100644 hw/pci/trace.h
>  create mode 100644 hw/ppc/trace.h
>  create mode 100644 hw/rdma/trace.h
>  create mode 100644 hw/rdma/vmw/trace.h
>  create mode 100644 hw/riscv/trace.h
>  create mode 100644 hw/s390x/trace.h
>  create mode 100644 hw/scsi/trace.h
>  create mode 100644 hw/sd/trace.h
>  create mode 100644 hw/sparc/trace.h
>  create mode 100644 hw/sparc64/trace.h
>  create mode 100644 hw/timer/trace.h
>  create mode 100644 hw/tpm/trace.h
>  create mode 100644 hw/usb/trace.h
>  create mode 100644 hw/vfio/trace.h
>  create mode 100644 hw/virtio/trace.h
>  create mode 100644 hw/watchdog/trace.h
>  create mode 100644 hw/xen/trace.h
>  create mode 100644 migration/trace.h
>  create mode 100644 net/trace.h
>  create mode 100644 qapi/meson.build
>  create mode 100644 qapi/trace.h
>  delete mode 100644 qobject/Makefile.objs
>  create mode 100644 qobject/meson.build
>  create mode 100644 qom/trace.h
>  delete mode 100644 stubs/Makefile.objs
>  create mode 100644 stubs/meson.build
>  create mode 100644 target/arm/trace.h
>  create mode 100644 target/hppa/trace.h
>  create mode 100644 target/i386/trace.h
>  create mode 100644 target/mips/trace.h
>  create mode 100644 target/ppc/trace.h
>  create mode 100644 target/riscv/trace.h
>  create mode 100644 target/s390x/trace.h
>  create mode 100644 target/sparc/trace.h
>  create mode 100644 trace/meson.build
>  create mode 100644 ui/trace.h
>  delete mode 100644 util/Makefile.objs
>  create mode 100644 util/meson.build
>  create mode 100644 util/trace.h
>
> diff --git a/.gitignore b/.gitignore
> index fd6e6c3..026dded 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -141,16 +141,10 @@ docker-src.*
>  *~
>  *.ast_raw
>  *.depend_raw
> -trace.h
> +/trace/trace-*.h
>  trace.c
> -trace-ust.h
> -trace-ust.h
>  trace-dtrace.h
>  trace-dtrace.dtrace
> -trace-root.h
> -trace-root.c
> -trace-ust-root.h
> -trace-ust-root.h
>  trace-ust-all.h
>  trace-ust-all.c
>  trace-dtrace-root.h
> diff --git a/Makefile b/Makefile
> index 7636cec..ddc7d27 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -115,24 +115,6 @@ FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSIO
>  
>  generated-files-y = qemu-version.h config-host.h qemu-options.def
>  
> -GENERATED_QAPI_FILES = qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
> -GENERATED_QAPI_FILES += qapi/qapi-types.h qapi/qapi-types.c
> -GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-types-%.h)
> -GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-types-%.c)
> -GENERATED_QAPI_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
> -GENERATED_QAPI_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
> -GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.h)
> -GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-visit-%.c)
> -GENERATED_QAPI_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
> -GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.h)
> -GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-commands-%.c)
> -GENERATED_QAPI_FILES += qapi/qapi-emit-events.h qapi/qapi-emit-events.c
> -GENERATED_QAPI_FILES += qapi/qapi-events.h qapi/qapi-events.c
> -GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.h)
> -GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
> -GENERATED_QAPI_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
> -GENERATED_QAPI_FILES += qapi/qapi-doc.texi
> -
>  generated-files-y += $(GENERATED_QAPI_FILES)

You're deleting QAPI code generation here, so you can do it in Meson.
Variable here, rules further down.  Good.

Deleted stuff should reappear in some meson.build.  We'll see.

>  
>  generated-files-y += trace/generated-tcg-tracers.h
> @@ -141,132 +123,50 @@ generated-files-y += trace/generated-helpers-wrappers.h
>  generated-files-y += trace/generated-helpers.h
>  generated-files-y += trace/generated-helpers.c
>  
> -generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.h
> -generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.c
> -
>  generated-files-y += module_block.h
>  
> -TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
> -TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
> -TRACE_DTRACE =
> -ifdef CONFIG_TRACE_DTRACE
> -TRACE_HEADERS += trace-dtrace-root.h $(trace-events-subdirs:%=%/trace-dtrace.h)
> -TRACE_DTRACE += trace-dtrace-root.dtrace $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
> -endif
> -ifdef CONFIG_TRACE_UST
> -TRACE_HEADERS += trace-ust-root.h $(trace-events-subdirs:%=%/trace-ust.h)
> -endif
> -
> -generated-files-y += $(TRACE_HEADERS)
> -generated-files-y += $(TRACE_SOURCES)
> -generated-files-y += $(BUILD_DIR)/trace-events-all

Also tracing code generation.  Variables here, rules next.  Good.

>  generated-files-y += .git-submodule-status
>  
> -trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
> -
>  tracetool-y = $(SRC_PATH)/scripts/tracetool.py
>  tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
>  
> -%/trace.h: %/trace.h-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -%/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=$(call trace-group-name,$@) \
> -		--format=h \
> -		--backends=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(@:%-timestamp=%)")
> -
> -%/trace.c: %/trace.c-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -%/trace.c-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=$(call trace-group-name,$@) \
> -		--format=c \
> -		--backends=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(@:%-timestamp=%)")
> -
> -%/trace-ust.h: %/trace-ust.h-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -%/trace-ust.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=$(call trace-group-name,$@) \
> -		--format=ust-events-h \
> -		--backends=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(@:%-timestamp=%)")
> -
> -%/trace-dtrace.dtrace: %/trace-dtrace.dtrace-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -%/trace-dtrace.dtrace-timestamp: $(SRC_PATH)/%/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=$(call trace-group-name,$@) \
> -		--format=d \
> -		--backends=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(@:%-timestamp=%)")
> -
> -%/trace-dtrace.h: %/trace-dtrace.dtrace $(tracetool-y)
> -	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
> -
> -%/trace-dtrace.o: %/trace-dtrace.dtrace $(tracetool-y)

Delete the pattern rules for generating the various tracing files in
sub-directories.

> -
> -
> -trace-root.h: trace-root.h-timestamp
> +trace/generated-helpers-wrappers.h: trace/generated-helpers-wrappers.h-timestamp
>  	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -trace-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
> +trace/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
>  	$(call quiet-command,$(TRACETOOL) \
>  		--group=root \
> -		--format=h \
> -		--backends=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(@:%-timestamp=%)")
> +		--format=tcg-helper-wrapper-h \
> +		--backend=$(TRACE_BACKENDS) \
> +		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")

Diff is a bit confusing here.  This is actually the deletion of
trace-root.h rules, and the move of trace/generated-helpers-wrappers.h
rules from trace/Makefile.objs.

Diversion: I guess the timestamp thing is for avoiding recompilation
when the generated .h does not change.  How is it supposed to work?
After .h-timestamp is remade without changing its contents, make will
then remake .h, but the recipe won't actually touch it.  How does make
know?  If it doesn't, it'll consider the .o depending on the .h out of
date.  Even if it does, it'll remake the .h on every make run until
remaking it actually changes it.

The make trick I learned to accomplish this puts the "maybe update" in
the .h-timestamp recipe, and keeps the .h recipe empty.  The rules for
generating code from the QAPI schema work like that.  Look for
qapi-gen-timestamp below.

Make is weird.  End of diversion.

>  
> -trace-root.c: trace-root.c-timestamp
> +trace/generated-helpers.h: trace/generated-helpers.h-timestamp
>  	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -trace-root.c-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
> +trace/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
>  	$(call quiet-command,$(TRACETOOL) \
>  		--group=root \
> -		--format=c \
> -		--backends=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(@:%-timestamp=%)")
> +		--format=tcg-helper-h \
> +		--backend=$(TRACE_BACKENDS) \
> +		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")

Likewise, deletion of trace-root.c rules, and move of
trace/generated-helpers.h rules from trace/Makefile.objs.

>  
> -trace-ust-root.h: trace-ust-root.h-timestamp
> +trace/generated-helpers.c: trace/generated-helpers.c-timestamp
>  	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -trace-ust-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
> +trace/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
>  	$(call quiet-command,$(TRACETOOL) \
>  		--group=root \
> -		--format=ust-events-h \
> -		--backends=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(@:%-timestamp=%)")
> +		--format=tcg-helper-c \
> +		--backend=$(TRACE_BACKENDS) \
> +		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
>  
> -trace-ust-all.h: trace-ust-all.h-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -trace-ust-all.h-timestamp: $(trace-events-files) $(tracetool-y) $(BUILD_DIR)/config-host.mak
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=all \
> -		--format=ust-events-h \
> -		--backends=$(TRACE_BACKENDS) \
> -		$(trace-events-files) > $@,"GEN","$(@:%-timestamp=%)")
> -
> -trace-ust-all.c: trace-ust-all.c-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -trace-ust-all.c-timestamp: $(trace-events-files) $(tracetool-y) $(BUILD_DIR)/config-host.mak
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=all \
> -		--format=ust-events-c \
> -		--backends=$(TRACE_BACKENDS) \
> -		$(trace-events-files) > $@,"GEN","$(@:%-timestamp=%)")
> +trace/generated-helpers.o: trace/generated-helpers.c

Likewise, deletion of trace-ust.root.c and trace-ust-all.[ch] rules, and
move of trace/generated-helpers.c rules from trace/Makefile.objs.

>  
> -trace-dtrace-root.dtrace: trace-dtrace-root.dtrace-timestamp
> +trace/generated-tcg-tracers.h: trace/generated-tcg-tracers.h-timestamp
>  	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -trace-dtrace-root.dtrace-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
> +trace/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
>  	$(call quiet-command,$(TRACETOOL) \
>  		--group=root \
> -		--format=d \
> -		--backends=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(@:%-timestamp=%)")
> -
> -trace-dtrace-root.h: trace-dtrace-root.dtrace
> -	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
> -
> -trace-dtrace-root.o: trace-dtrace-root.dtrace
> +		--format=tcg-h \
> +		--backend=$(TRACE_BACKENDS) \
> +		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")

Deletion of trace-dtrace-root.dtrace rules, and move of
trace/generated-tcg-tracers.h rules from trace/Makefile.objs.

Looks like you're deleting some tracing code generation here, so you can
do it in Meson, and move some other tracing code generation from trace/
to here.  Why is not obvious to me; I'm not really familiar with tracing
code generation.  Perhaps it'll become clearer further down.

>  
>  KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
>  KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
> @@ -416,10 +316,8 @@ include $(SRC_PATH)/Makefile.objs
>  endif
>  
>  dummy := $(call unnest-vars,, \
> -                stub-obj-y \
>                  authz-obj-y \
>                  chardev-obj-y \
> -                util-obj-y \
>                  qga-obj-y \
>                  elf2dmp-obj-y \
>                  ivshmem-client-obj-y \
> @@ -442,8 +340,7 @@ dummy := $(call unnest-vars,, \
>                  ui-obj-y \
>                  ui-obj-m \
>                  audio-obj-y \
> -                audio-obj-m \
> -                trace-obj-y)
> +                audio-obj-m)

Variables stub-obj-y, util-obj-y, trace-obj-y go away.  Their values are
exactly what makes up libqemuutil.a.  Good.

>  
>  include $(SRC_PATH)/tests/Makefile.include
>  
> @@ -527,8 +424,7 @@ Makefile: $(version-obj-y)
>  ######################################################################
>  # Build libraries
>  
> -libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
> -libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
> +libvhost-user.a: $(libvhost-user-obj-y)

Further down, we'll see that you link with $(COMMON_LDADDS), which is
libqemuutil.a, after libvhost-user.a.  This lets you not put
$(util-obj-y) $(stub-obj-y) into libvhost-user.a here.  Makes sense.

>  
>  ######################################################################
>  
> @@ -583,16 +479,6 @@ qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json $(qapi-p
>  		"GEN","$(@:%-timestamp=%)")
>  	@>$@
>  
> -qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json \
> -               $(QAPI_MODULES:%=$(SRC_PATH)/qapi/%.json)
> -
> -$(GENERATED_QAPI_FILES): qapi-gen-timestamp ;
> -qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
> -	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
> -		-o "qapi" -b $<, \
> -		"GEN","$(@:%-timestamp=%)")
> -	@>$@
> -

More QAPI code generation deletion.

>  QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qapi-commands.h)
>  $(qga-obj-y): $(QGALIB_GEN)
>  
> @@ -631,21 +517,21 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  endif
> -vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
> +vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a $(COMMON_LDADDS)
>  	$(call LINK, $^)

First instance of adding $(COMMON_LDADDS) after libvhost-user.a.  Two
more below.  What about the one in tests/Makefile.include?

> -vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
> +vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  
>  rdmacm-mux$(EXESUF): LIBS += "-libumad"
>  rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  
> -vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) libqemuutil.a libqemustub.a
> +vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)

Literal libqemuutil.a replaced by $(COMMON_LDADDS).  Good.

WTF is libqemustub.a?  Dig, dig, ...

    commit ebedb37c8d2aa477517158fd88e6ff0f6a60485d
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Tue Sep 19 16:20:31 2017 +0200

        Makefile: Remove libqemustub.a

        Using two libraries (libqemuutil.a and libqemustub.a) would sometimes
        result in circular dependencies. To avoid these issues let's just
        combine both into a single library that functions as both.

        Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
        Message-Id: <54e6458745493d10901964624479a7d9a872f481.1503077821.git.alistair.francis@xilinx.com>
        Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Two mentions of it

    $ git-grep -F libqemustub
    Makefile:vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) libqemuutil.a libqemustub.a
    tests/test-util-sockets.c:/* Syms in libqemustub.a are discarded at .o file granularity.

crept back in commit 30bdb3c56dd and commit d52c454aadc.  The one in
Makefile works because rules.mak has

    %.a:
            $(call quiet-command,rm -f $@ && $(AR) rcs $@ $^,"AR","$(TARGET_DIR)$@")

Make uses it to create an empty libqemustub.a.

Let's fix this in an independent patch.

>  
>  ifdef CONFIG_VHOST_USER_INPUT
>  ifdef CONFIG_LINUX
> -vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a libqemuutil.a
> +vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  
>  # build by default, do not install
> @@ -1117,10 +1003,6 @@ Makefile: $(generated-files-y)
>  endif
>  endif
>  
> -.SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=%-timestamp) \
> -	$(TRACE_SOURCES) $(TRACE_SOURCES:%=%-timestamp) \
> -	$(TRACE_DTRACE) $(TRACE_DTRACE:%=%-timestamp)
> -

This is trace-root.[ch] %/trace.[ch] trace-dtrace-root.{h,dtrace}
%/trace-dtrace.{h,dtrace} trace-ust-root.h %/trace-ust.h and their
-timestamp files.  The rules for making them were all removed above.
Good.

>  # Include automatically generated dependency files
>  # Dependencies in Makefile.objs files come from our recursive subdir rules
>  -include $(wildcard *.d tests/*.d)
> diff --git a/Makefile.objs b/Makefile.objs
> index 658cfc9..29ffaa3 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -1,8 +1,5 @@
>  #######################################################################
> -# Common libraries for tools and emulators
> -stub-obj-y = stubs/ util/ crypto/
> -util-obj-y = util/ qobject/ qapi/

More removal of stub-obj-y and util-obj-y.

Hmm, you add meson.build in qapi/ qobject/ stubs/ trace/ util/, but not
in crypto/.  What am I missing?

> -
> +# chardev-obj-y is code used by both qemu system emulation and some tests
>  chardev-obj-y = chardev/

Comment improvements could be in an independent patch.

>  
>  #######################################################################
> @@ -127,86 +124,3 @@ vhost-user-input-obj-y = contrib/vhost-user-input/
>  vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
>  
>  ######################################################################
> -trace-events-subdirs =
> -trace-events-subdirs += accel/kvm
> -trace-events-subdirs += accel/tcg
> -trace-events-subdirs += crypto
> -trace-events-subdirs += monitor
> -ifeq ($(CONFIG_USER_ONLY),y)
> -trace-events-subdirs += linux-user
> -endif
> -ifeq ($(CONFIG_BLOCK),y)
> -trace-events-subdirs += authz
> -trace-events-subdirs += block
> -trace-events-subdirs += io
> -trace-events-subdirs += nbd
> -trace-events-subdirs += scsi
> -endif
> -ifeq ($(CONFIG_SOFTMMU),y)
> -trace-events-subdirs += chardev
> -trace-events-subdirs += audio
> -trace-events-subdirs += hw/9pfs
> -trace-events-subdirs += hw/acpi
> -trace-events-subdirs += hw/alpha
> -trace-events-subdirs += hw/arm
> -trace-events-subdirs += hw/audio
> -trace-events-subdirs += hw/block
> -trace-events-subdirs += hw/block/dataplane
> -trace-events-subdirs += hw/char
> -trace-events-subdirs += hw/dma
> -trace-events-subdirs += hw/hppa
> -trace-events-subdirs += hw/i2c
> -trace-events-subdirs += hw/i386
> -trace-events-subdirs += hw/i386/xen
> -trace-events-subdirs += hw/ide
> -trace-events-subdirs += hw/input
> -trace-events-subdirs += hw/intc
> -trace-events-subdirs += hw/isa
> -trace-events-subdirs += hw/mem
> -trace-events-subdirs += hw/misc
> -trace-events-subdirs += hw/misc/macio
> -trace-events-subdirs += hw/net
> -trace-events-subdirs += hw/nvram
> -trace-events-subdirs += hw/pci
> -trace-events-subdirs += hw/pci-host
> -trace-events-subdirs += hw/ppc
> -trace-events-subdirs += hw/rdma
> -trace-events-subdirs += hw/rdma/vmw
> -trace-events-subdirs += hw/s390x
> -trace-events-subdirs += hw/scsi
> -trace-events-subdirs += hw/sd
> -trace-events-subdirs += hw/sparc
> -trace-events-subdirs += hw/sparc64
> -trace-events-subdirs += hw/timer
> -trace-events-subdirs += hw/tpm
> -trace-events-subdirs += hw/usb
> -trace-events-subdirs += hw/vfio
> -trace-events-subdirs += hw/virtio
> -trace-events-subdirs += hw/watchdog
> -trace-events-subdirs += hw/xen
> -trace-events-subdirs += hw/gpio
> -trace-events-subdirs += hw/riscv
> -trace-events-subdirs += migration
> -trace-events-subdirs += net
> -trace-events-subdirs += ui
> -endif
> -trace-events-subdirs += hw/display
> -trace-events-subdirs += qapi
> -trace-events-subdirs += qom
> -trace-events-subdirs += target/arm
> -trace-events-subdirs += target/hppa
> -trace-events-subdirs += target/i386
> -trace-events-subdirs += target/mips
> -trace-events-subdirs += target/ppc
> -trace-events-subdirs += target/riscv
> -trace-events-subdirs += target/s390x
> -trace-events-subdirs += target/sparc
> -trace-events-subdirs += util

We add sub-directories to the various FOO-obj-y, then add those of them
with tracepoints to trace-events-subdirs.  Annoying.  Let's see whether
you can do better with Meson.

> -
> -trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
> -
> -trace-obj-y = trace-root.o
> -trace-obj-y += $(trace-events-subdirs:%=%/trace.o)
> -trace-obj-$(CONFIG_TRACE_UST) += trace-ust-all.o
> -trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace-root.o
> -trace-obj-$(CONFIG_TRACE_DTRACE) += $(trace-events-subdirs:%=%/trace-dtrace.o)

So far, you deleted QAPI code generation, most of tracing code
generation, and moved the rest of tracing code generation from
trace/Makefile.objs here.

Can you explain why the move is necessary?

> diff --git a/audio/trace.h b/audio/trace.h
> new file mode 100644
> index 0000000..f6a23d0
> --- /dev/null
> +++ b/audio/trace.h
> @@ -0,0 +1 @@
> +#include "trace-audio.h"
> diff --git a/chardev/trace.h b/chardev/trace.h
> new file mode 100644
> index 0000000..a23cbd9
> --- /dev/null
> +++ b/chardev/trace.h
> @@ -0,0 +1 @@
> +#include "trace-chardev.h"

These are two of the stupid forwarding headers you mentioned.

Having to skip over them to review the meat of the patch is fairly
annoying.  Reordering the patch or adding the forwarding headers in a
separate patch before this one would help.

> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 7fe2fa9..3481529 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -26,6 +26,7 @@ crypto-obj-y += $(crypto-rng-obj-y)
>  crypto-obj-y += pbkdf.o
>  crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
>  crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
> +crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += pbkdf-stub.o
>  crypto-obj-y += ivgen.o
>  crypto-obj-y += ivgen-essiv.o
>  crypto-obj-y += ivgen-plain.o
> @@ -38,5 +39,3 @@ crypto-obj-y += block-luks.o
>  
>  # Let the userspace emulators avoid linking stuff they won't use.
>  crypto-user-obj-y = aes.o $(crypto-rng-obj-y) init.o
> -
> -stub-obj-y += pbkdf-stub.o

This is less than obvious, I'm afraid.

Three cases: if CONFIG_NETTLE=n, else if CONFIG_GCRYPT=y, else.

Before this patch, we add pbkdf-stub.o to libqemuutil.a unconditionally,
and pbkdf-gcrypt.o to crypto-obj-y in the second case.  We run the
linker so that pbkdf-gcrypt.o gets linked if present, else pbkdf-stub.o
if it's needed to satisfy a reference.  I figure it is needed exactly in
the third case.

After this patch, we add nothing to crypto-obj-y in the first case,
pbkdf-gcrypt.o in the second case, and pbkdf-stub.o in the third case.

What gets linked is now clearer.  The two $(if ...)s are perhaps harder
to understand than an equivalent ifeq(CONFIG_NETTLE,n) ... conditional.

Could be a separate patch, just to make this one easier to review.

[More forwarding headers snipped...]
> diff --git a/meson.build b/meson.build
> index 7615817..c625547 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1,6 +1,7 @@
>  project('qemu', 'c', meson_version: '>=0.50.999')
>  
>  kconfig = import('unstable-kconfig')
> +ss = import('sourceset')
>  config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
>  
>  add_project_arguments(config_host['QEMU_CFLAGS'].split(),
> @@ -11,3 +12,131 @@ add_project_arguments(config_host['QEMU_INCLUDES'].split(),
>  configure_file(input: files('scripts/ninjatool.py'),
>                 output: 'ninjatool',
>                 configuration: config_host)
> +
> +slirp = declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].split(),
> +                           link_args: config_host['SLIRP_LIBS'].split())
> +
> +target_dirs = config_host['TARGET_DIRS'].split()

config_host is from kconfig.load().  Looks like it's a dictionary
mapping to strings.  Having to convert from string to the appropriate
meson type (here: array) is annoying.  Any ideas on improving this?
Not necessarily right away, after the conversion to Meson is complete
would do.

> +have_user = false
> +have_system = false
> +foreach target : target_dirs
> +  have_user = have_user or target.endswith('-user')
> +  have_system = have_system or target.endswith('-softmmu')
> +endforeach

The loop is slightly disappointing.  I was hoping for something in a
more functional style, similar to

   (some (lambda (tdir) (endswith tdir "-softmmu")) target_dirs)

> +have_block = have_system or config_host['TOOLS'] != ''
> +
> +# Generators
> +
> +qapi_gen = find_program('scripts/qapi-gen.py')
> +qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/events.py',
> +                     meson.source_root() / 'scripts/qapi/introspect.py',
> +                     meson.source_root() / 'scripts/qapi/types.py',
> +                     meson.source_root() / 'scripts/qapi/visit.py',
> +                     meson.source_root() / 'scripts/qapi/common.py',
> +                     meson.source_root() / 'scripts/qapi/doc.py',
> +                     meson.source_root() / 'scripts/qapi-gen.py' ]

Copied, not moved from Makefile, but only because the QGA part of QAPI
code generation hasn't been converted, yet.  Okay.

Aside: tests/Makefile.include has another copy.

> +
> +# Collect sourcesets.
> +
> +util_obj = ss.source_set()
> +stub_obj = ss.source_set()
> +trace_obj = ss.source_set()
> +
> +# TODO: add each directory to the subdirs from its own meson.build, once
> +# we have those
> +trace_events_subdirs = [
> +  'accel/kvm',
> +  'accel/tcg',
> +  'crypto',
> +  'monitor',
> +]
> +if have_user
> +  trace_events_subdirs += [ 'linux-user' ]
> +endif
> +if have_block
> +  trace_events_subdirs += [
> +    'authz',
> +    'block',
> +    'io',
> +    'nbd',
> +    'scsi',
> +  ]
> +endif
> +if have_system
> +  trace_events_subdirs += [
> +    'chardev',
> +    'audio',
> +    'hw/9pfs',
> +    'hw/acpi',
> +    'hw/alpha',
> +    'hw/arm',
> +    'hw/audio',
> +    'hw/block',
> +    'hw/block/dataplane',
> +    'hw/char',
> +    'hw/dma',
> +    'hw/hppa',
> +    'hw/i2c',
> +    'hw/i386',
> +    'hw/i386/xen',
> +    'hw/ide',
> +    'hw/input',
> +    'hw/intc',
> +    'hw/isa',
> +    'hw/mem',
> +    'hw/misc',
> +    'hw/misc/macio',
> +    'hw/net',
> +    'hw/nvram',
> +    'hw/pci',
> +    'hw/pci-host',
> +    'hw/ppc',
> +    'hw/rdma',
> +    'hw/rdma/vmw',
> +    'hw/s390x',
> +    'hw/scsi',
> +    'hw/sd',
> +    'hw/sparc',
> +    'hw/sparc64',
> +    'hw/timer',
> +    'hw/tpm',
> +    'hw/usb',
> +    'hw/vfio',
> +    'hw/virtio',
> +    'hw/watchdog',
> +    'hw/xen',
> +    'hw/gpio',
> +    'hw/riscv',
> +    'migration',
> +    'net',
> +    'ui',
> +  ]
> +endif
> +trace_events_subdirs += [
> +  'hw/display',
> +  'qapi',
> +  'qom',
> +  'target/arm',
> +  'target/hppa',
> +  'target/i386',
> +  'target/mips',
> +  'target/ppc',
> +  'target/riscv',
> +  'target/s390x',
> +  'target/sparc',
> +  'util',
> +]

Straight translation from Makefile.objs for easy review.

Preexisting:

* The lists are sorted, except where they arent.

* The unconditional trace_events_subdirs are spread over two places.

* We add trace objects here, far from their users.  For instance, we add
  'qapi' here, but its users in qapi/meson.build.  Any conditions we
  duplicate.  For instance, we add hw/display to trace_events_subdirs
  unconditionally here, and to common-obj-y and obj-y in
  hw/Makefile.objs if CONFIG_SOFTMMU.  Inconsistent conditions.

  Any ideas on avoiding the duplication?  Not necessarily
  right away, after the conversion to Meson is complete would do.

  Perhaps your TODO comment above is about just that.

* Related, but well outside the scope of a conversion to Meson: we
  generate trace.* per directory.  Some of them are huge.  Some
  directories have files with complex conditions.

  Consider hw/net.  17 files include hw/net/trace.h.  The resulting
  trace.h exceeds 700KiB for me, more than twenty times as big as the
  average .c including it.  Wasteful.  The resulting trace.o eats almost
  80KiB text+data+bss.  Its users are all individually configured.
  Configuring any of them pulls in tracing code for all of them.
  Wasteful.

> +
> +subdir('qapi')
> +subdir('qobject')
> +subdir('stubs')
> +subdir('trace')
> +subdir('util')

Matches their removal from Makefile.objs, except for crypto/.

> +
> +# Build targets from sourcesets
> +
> +util_obj.add_all(stub_obj, trace_obj)
> +util_obj = util_obj.apply(config_host, strict: false)

Peeking at Meson docs... aha, this filters util_obj for config_host.  I
guess this takes care of the "when:" thingies in util/meson.build below.

No "when:" thingies in trace_obj, because we build it differently:
first, we build array trace_events_subdirs (above), then we add their
files to trace_obj (in trace/meson.build below).  To use "when:" there,
we'd have to put the condition in the array, which is probably more
complex and less readable.

> +libqemuutil = static_library('qemuutil',
> +                             sources: util_obj.sources(),
> +                             dependencies: util_obj.dependencies())
[More forwarding headers snipped...]
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index 729e518..e4e49c5 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -1,24 +1,4 @@
> -util-obj-y = qapi-visit-core.o qapi-dealloc-visitor.o qobject-input-visitor.o
> -util-obj-y += qobject-output-visitor.o qmp-registry.o qmp-dispatch.o
> -util-obj-y += string-input-visitor.o string-output-visitor.o
> -util-obj-y += opts-visitor.o qapi-clone-visitor.o
> -util-obj-y += qmp-event.o
> -util-obj-y += qapi-util.o
> -
> -QAPI_COMMON_MODULES = audio authz block-core block char common crypto
> -QAPI_COMMON_MODULES += introspect job migration misc net rdma rocker
> -QAPI_COMMON_MODULES += run-state sockets tpm trace transaction ui
>  QAPI_TARGET_MODULES = target
> -QAPI_MODULES = $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
> -
> -util-obj-y += qapi-builtin-types.o
> -util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-types-%.o)
> -util-obj-y += qapi-builtin-visit.o
> -util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-visit-%.o)
> -util-obj-y += qapi-emit-events.o
> -util-obj-y += $(QAPI_COMMON_MODULES:%=qapi-events-%.o)
> -
> -common-obj-y = $(QAPI_COMMON_MODULES:%=qapi-commands-%.o)
>  
>  obj-y = qapi-introspect.o
>  obj-y += $(QAPI_TARGET_MODULES:%=qapi-types-%.o)

Variables defined here and used elsewhere:

* QAPI_MODULES: the QAPI schema sub-modules

  Deleted.  Okay, since you also delete all its uses (see patch to
  top-level Makefile above).

* util-obj-y: the (target-independent) .o to put put into libqemutil.a

  Deleted.  Okay, since building libqemutil.a is now Meson's job.
  qapi/meson.build will have the replacement.

* obj-y: the target-dependent .o to link into $(QEMU_PROG_BUILD), via
  $(all-obj-y)

  Unchanged.  Makes sense, because building $(QEMU_PROG_BUILD) remains
  Makefile.target's job.

* common-obj-y: the target-independent .o to link into
  $(QEMU_PROG_BUILD), via $(all-obj-y)

  Deleted.  Doesn't feel right.  See below.

> diff --git a/qapi/meson.build b/qapi/meson.build
> new file mode 100644
> index 0000000..78b63c8
> --- /dev/null
> +++ b/qapi/meson.build
> @@ -0,0 +1,54 @@
> +util_obj.add(files('qapi-visit-core.c', 'qapi-dealloc-visitor.c',
> +  'qobject-input-visitor.c', 'qobject-output-visitor.c',
> +  'qmp-registry.c', 'qmp-dispatch.c',
> +  'string-input-visitor.c', 'string-output-visitor.c',
> +  'opts-visitor.c', 'qapi-clone-visitor.c',
> +  'qmp-event.c', 'qapi-util.c'))

Straight translation from qapi/Makefile.objs's first paragraph for easy
review.  For non-RFC patches, I'd ask you to sort them.

> +
> +qapi_common_modules = [ 'audio', 'authz', 'block-core', 'block', 'char', 'common',
> +  'crypto', 'introspect', 'job', 'migration', 'misc', 'net', 'rdma', 'rocker',
> +  'run-state', 'sockets', 'tpm', 'trace', 'transaction', 'ui' ]
> +
> +qapi_target_modules = [ 'target' ]

Straight translation from qapi/Makefile.objs's second paragraph, except
you omitted QAPI_MODULES as unnecessary.

Idle thought, feel free to ignore.  "git-ls-files qapi/\*json" less
qapi-schema.json yields the QAPI modules.  The ones ending with
target.json are in qapi_target_modules, the others are in
qapi_common_modules.  My point is: having to restate what git already
knows annoys me a bit.

Of course, git-ls-files doesn't work when building from a tarball.
Putting a generated list of files into the tarball could replace it
there.

> +
> +qapi_util_outputs = [
> +  'qapi-builtin-types.c', 'qapi-builtin-visit.c',
> +  'qapi-emit-events.c'
> +]
> +qapi_all_outputs = qapi_util_outputs
> +qapi_inputs = []
> +foreach module : qapi_common_modules + qapi_target_modules
> +  qapi_module_outputs = [
> +    'qapi-types-@0@.c'.format(module),
> +    'qapi-types-@0@.h'.format(module),
> +    'qapi-visit-@0@.c'.format(module),
> +    'qapi-visit-@0@.h'.format(module),
> +    'qapi-commands-@0@.c'.format(module),
> +    'qapi-commands-@0@.h'.format(module),
> +    'qapi-events-@0@.c'.format(module),
> +    'qapi-events-@0@.h'.format(module),
> +  ]
> +  qapi_inputs += [ files(module + '.json') ]
> +  qapi_all_outputs += qapi_module_outputs
> +  if qapi_common_modules.contains(module)
> +    qapi_util_outputs += qapi_module_outputs
> +  endif
> +endforeach
> +
> +qapi_all_outputs += [
> +  'qapi-introspect.c', 'qapi-introspect.h',
> +  'qapi-doc.texi'
> +]

Variables defined here, all array of file name:

* qapi_inputs: the QAPI schema sources except for qapi-schema.json

  The name qapi_inputs suggests it has all of the inputs.

* qapi_all_outputs: all the files generated for this schema

* qapi_util_outputs: the target-independent subset of qapi_all_outputs,
  less qapi-introspect.[ch] and qapi-doc.texi

Below, I'll compare them to qapi/Makefile.objs before the patch.

> +
> +qapi_files = custom_target('QAPI files',
> +  output: qapi_all_outputs,
> +  input: [ files('qapi-schema.json') ],
> +  command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
> +  depend_files: [ qapi_inputs, qapi_gen_depends ])

This replaces rules deleted from the top-level Makefile.  Good.
Note the conspicious loss of stamp file trickery :)

> +
> +# qapi_util_outputs must be at the beginning of qapi_all_outputs.
> +i = 0
> +foreach output : qapi_util_outputs
> +  util_obj.add(qapi_files[i])
> +  i = i + 1
> +endforeach

Hmm... "must be at the beginning" because the loop needs to iterate over
the subset of qapi_files that corresponds to qapi_util_outputs.  Works
(I guess) because the [index] method of the custom target object
returned by custom_target() "corresponds to the index of the custom
target's output argument", i.e. to qapi_all_outputs[index].  By putting
qapi_util_outputs first in qapi_all_outputs, the qapi_files[i]
correspond to the qapi_util_outputs[i].

Let's compare with qapi/Makefile.objs before the patch.  Three sets of
files:

* The (target-independent) .o to put put into libqemutil.a

  Before the patch: $(util-obj-y), which contains the .o for

  - all the hand-written .c
  - the generated qapi-builtin-{types,visit}.c, qapi-emit-events.c
  - the generated target-independent qapi-{types,visit,events}-*.c

  Afterwards: util_obj, which contains the file objects for

  - all the hand-written .c
  - the generated qapi-builtin-{types,visit}.c, qapi-emit-events.c
  - the generated target-independent
    qapi-{types,visit,events,commands}-*.c
  
  You're adding the target-independent qapi-commands-*.c to
  libqemutil.a.  Intentional?

  Hmm, these are exactly the .o lost by deleting common-obj-y in
  qapi/Makefile.objs.  That's why you can still link.  Still, these
  files have no business in libqemutil.a; anything linking to them needs
  to link with the .o for the hand-written qmp_FOO(), and only the
  qemu-system-FOO do.

* The target-independent .o to link into $(QEMU_PROG_BUILD)

  Before the patch: $(common-obj-y), which contains the .o for the
  generated target-independent qapi-commands-*.c.

  Afterwards: nothing.  That's okay, because building $(QEMU_PROG_BUILD)
  hasn't been converted to Meson, yet.

* The target-dependent .o to link into $(QEMU_PROG_BUILD)

  Before the patch: $(obj-y), which contains the .o for the generated
  target-dependent qapi-introspect.c
  qapi-{types,visit,events,commands}*.o.

  Afterwards: nothing.  That's okay, because building $(QEMU_PROG_BUILD)
  hasn't been converted to Meson, yet.

[Another forwarding header snipped...]
> diff --git a/qobject/Makefile.objs b/qobject/Makefile.objs
> deleted file mode 100644
> index 7b12c9c..0000000
> --- a/qobject/Makefile.objs
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -util-obj-y = qnull.o qnum.o qstring.o qdict.o qlist.o qbool.o qlit.o
> -util-obj-y += qjson.o qobject.o json-lexer.o json-streamer.o json-parser.o
> -util-obj-y += block-qdict.o
> diff --git a/qobject/meson.build b/qobject/meson.build
> new file mode 100644
> index 0000000..71aab08
> --- /dev/null
> +++ b/qobject/meson.build
> @@ -0,0 +1,3 @@
> +util_obj.add(files('qnull.c', 'qnum.c', 'qstring.c', 'qdict.c', 'qlist.c', 'qbool.c',
> +  'qlit.c', 'qjson.c', 'qobject.c', 'json-lexer.c', 'json-streamer.c', 'json-parser.c',
> +  'block-qdict.c'))

Reviewers get a breather here :)

Long lines.

[Another forwarding header snipped...]
> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index 3d98ca2..c15daac 100755
> --- a/scripts/qapi-gen.py
> +++ b/scripts/qapi-gen.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3

Can't wait.  But does it belong to this patch?

>  # QAPI generator
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
> diff --git a/scripts/tracetool.py b/scripts/tracetool.py
> index 3beaa66..264cc9e 100755
> --- a/scripts/tracetool.py
> +++ b/scripts/tracetool.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3

Likewise.

>  # -*- coding: utf-8 -*-
>  
>  """
> diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
> index 280cb7c..31d67e1 100644
> --- a/scripts/tracetool/backend/ust.py
> +++ b/scripts/tracetool/backend/ust.py
> @@ -20,11 +20,7 @@ PUBLIC = True
>  
>  
>  def generate_h_begin(events, group):
> -    if group == "root":
> -        header = "trace-ust-root.h"
> -    else:
> -        header = "trace-ust.h"
> -
> +    header = "trace-ust-' + group + '.h"
>      out('#include <lttng/tracepoint.h>',
>          '#include "%s"' % header,
>          '',
> diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
> index 833c05a..2c45028 100644
> --- a/scripts/tracetool/format/c.py
> +++ b/scripts/tracetool/format/c.py
> @@ -20,10 +20,7 @@ def generate(events, backend, group):
>      active_events = [e for e in events
>                       if "disable" not in e.properties]
>  
> -    if group == "root":
> -        header = "trace-root.h"
> -    else:
> -        header = "trace.h"
> +    header = "trace-" + group + ".h"
>  
>      out('/* This file is autogenerated by tracetool, do not edit. */',
>          '',

Similar code in backend/dtrace.py, format/tcg_h.py,
format/tcg_helper_c.py.  Do they need patching, too?

> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> deleted file mode 100644
> index 9c7393b..0000000
> --- a/stubs/Makefile.objs
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -stub-obj-y += bdrv-next-monitor-owned.o
> -stub-obj-y += blk-commit-all.o
> -stub-obj-y += blockdev-close-all-bdrv-states.o
> -stub-obj-y += clock-warp.o
> -stub-obj-y += cpu-get-clock.o
> -stub-obj-y += cpu-get-icount.o
> -stub-obj-y += dump.o
> -stub-obj-y += error-printf.o
> -stub-obj-y += fdset.o
> -stub-obj-y += gdbstub.o
> -stub-obj-y += get-vm-name.o
> -stub-obj-y += iothread.o
> -stub-obj-y += iothread-lock.o
> -stub-obj-y += is-daemonized.o
> -stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
> -stub-obj-y += machine-init-done.o
> -stub-obj-y += migr-blocker.o
> -stub-obj-y += change-state-handler.o
> -stub-obj-y += monitor.o
> -stub-obj-y += notify-event.o
> -stub-obj-y += qtest.o
> -stub-obj-y += replay.o
> -stub-obj-y += runstate-check.o
> -stub-obj-y += set-fd-handler.o
> -stub-obj-y += sysbus.o
> -stub-obj-y += tpm.o
> -stub-obj-y += trace-control.o
> -stub-obj-y += uuid.o
> -stub-obj-y += vm-stop.o
> -stub-obj-y += vmstate.o
> -stub-obj-y += fd-register.o
> -stub-obj-y += qmp_memory_device.o
> -stub-obj-y += target-monitor-defs.o
> -stub-obj-y += target-get-monitor-def.o
> -stub-obj-y += pc_madt_cpu_entry.o
> -stub-obj-y += vmgenid.o
> -stub-obj-y += xen-common.o
> -stub-obj-y += xen-hvm.o
> -stub-obj-y += pci-host-piix.o
> -stub-obj-y += ram-block.o
> -stub-obj-y += ramfb.o
> -stub-obj-y += fw_cfg.o
> -stub-obj-$(CONFIG_SOFTMMU) += semihost.o
> diff --git a/stubs/meson.build b/stubs/meson.build
> new file mode 100644
> index 0000000..655ef86
> --- /dev/null
> +++ b/stubs/meson.build
> @@ -0,0 +1,45 @@
> +stub_obj.add(files('bdrv-next-monitor-owned.c'))
> +stub_obj.add(files('blk-commit-all.c'))
> +stub_obj.add(files('blockdev-close-all-bdrv-states.c'))
> +stub_obj.add(files('clock-warp.c'))
> +stub_obj.add(files('cpu-get-clock.c'))
> +stub_obj.add(files('cpu-get-icount.c'))
> +stub_obj.add(files('dump.c'))
> +stub_obj.add(files('error-printf.c'))
> +stub_obj.add(files('fdset.c'))
> +stub_obj.add(files('gdbstub.c'))
> +stub_obj.add(files('get-vm-name.c'))
> +stub_obj.add(files('iothread.c'))
> +stub_obj.add(files('iothread-lock.c'))
> +stub_obj.add(files('is-daemonized.c'))
> +stub_obj.add(when: 'CONFIG_LINUX_AIO', if_true: files('linux-aio.c'))
> +stub_obj.add(files('machine-init-done.c'))
> +stub_obj.add(files('migr-blocker.c'))
> +stub_obj.add(files('change-state-handler.c'))
> +stub_obj.add(files('monitor.c'))
> +stub_obj.add(files('notify-event.c'))
> +stub_obj.add(files('qtest.c'))
> +stub_obj.add(files('replay.c'))
> +stub_obj.add(files('runstate-check.c'))
> +stub_obj.add(files('set-fd-handler.c'))
> +stub_obj.add(files('sysbus.c'))
> +stub_obj.add(files('tpm.c'))
> +stub_obj.add(files('trace-control.c'))
> +stub_obj.add(files('uuid.c'))
> +stub_obj.add(files('vm-stop.c'))
> +stub_obj.add(files('vmstate.c'))
> +stub_obj.add(files('fd-register.c'))
> +stub_obj.add(files('qmp_memory_device.c'))
> +stub_obj.add(files('target-monitor-defs.c'))
> +stub_obj.add(files('target-get-monitor-def.c'))
> +stub_obj.add(files('pc_madt_cpu_entry.c'))
> +stub_obj.add(files('vmgenid.c'))
> +stub_obj.add(files('xen-common.c'))
> +stub_obj.add(files('xen-hvm.c'))
> +stub_obj.add(files('pci-host-piix.c'))
> +stub_obj.add(files('ram-block.c'))
> +stub_obj.add(files('ramfb.c'))
> +stub_obj.add(files('fw_cfg.c'))
> +if have_system
> +  stub_obj.add(files('semihost.c'))
> +endif

Another easy one.

[More forwarding headers snipped...]
> diff --git a/trace/Makefile.objs b/trace/Makefile.objs
> index c544509..a429474 100644
> --- a/trace/Makefile.objs
> +++ b/trace/Makefile.objs
> @@ -1,59 +1,8 @@
>  # -*- mode: makefile -*-
>  
> -$(BUILD_DIR)/trace-events-all: $(trace-events-files)

Aside: $(BUILD_DIR)/ should never be necessary in a rule target.

> -	$(call quiet-command,cat $^ > $@)
> -
>  
>  ##################################################
>  # Translation level
>  
> -$(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -$(obj)/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=root \
> -		--format=tcg-helper-wrapper-h \
> -		--backend=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
> -
> -$(obj)/generated-helpers.h: $(obj)/generated-helpers.h-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -$(obj)/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=root \
> -		--format=tcg-helper-h \
> -		--backend=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
> -
> -$(obj)/generated-helpers.c: $(obj)/generated-helpers.c-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -$(obj)/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=root \
> -		--format=tcg-helper-c \
> -		--backend=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
> -
> -$(obj)/generated-helpers.o: $(obj)/generated-helpers.c
> -
>  obj-y += generated-helpers.o
> -
> -
> -$(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
> -	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -$(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
> -	$(call quiet-command,$(TRACETOOL) \
> -		--group=root \
> -		--format=tcg-h \
> -		--backend=$(TRACE_BACKENDS) \
> -		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")

These rules move to the top-level Makefile, visible above.

Left here (but hard to see): obj-y += generated-helpers.o.  That's
because obj-y is for linking into $(QEMU_PROG_BUILD), which is still
Make's job.

Aside: we run $(TRACETOOL) N times on the same input to generate N
output files.  Same elsewhere.  QAPI code generation was similarly
inefficient, until commit fb0bc835e5 switched to generating all files in
one run.  Simpler, except for some Make awkwardness, which shouldn't be
necessary with Meson.

> -
> -
> -######################################################################
> -# Backend code
> -
> -util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
> -util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
> -util-obj-y += control.o
>  obj-y += control-target.o
> -util-obj-y += qmp.o

The util-obj-y additions move to trace/meson.build.  The obj-y addition
remains here for the same reason the one above does.

Should you keep the comment?

> diff --git a/trace/meson.build b/trace/meson.build
> new file mode 100644
> index 0000000..31831d4
> --- /dev/null
> +++ b/trace/meson.build
> @@ -0,0 +1,75 @@
> +# common options
> +tracetool = [
> +  find_program('scripts/tracetool.py'),
> +   '--backend=' + config_host['TRACE_BACKENDS']
> +]
> +
> +trace_events_files = []
> +foreach dir : [ '.' ] + trace_events_subdirs
> +  trace_events_file = meson.source_root() / dir / 'trace-events'
> +  trace_events_files += [ trace_events_file ]
> +  group_name = dir == '.' ? 'root' : dir.underscorify()
> +  group = '--group=' + group_name
> +  fmt = '@0@-' + group_name + '.@1@'
> +
> +  trace_h = custom_target(fmt.format('trace', 'h'),
> +                          output: fmt.format('trace', 'h'),
> +                          input: trace_events_file,
> +                          command: [ tracetool, group, '--format=h', '@INPUT@' ],
> +                          capture: true)
> +  trace_c = custom_target(fmt.format('trace', 'c'),
> +                          output: fmt.format('trace', 'c'),
> +                          input: trace_events_file,
> +                          command: [ tracetool, group, '--format=c', '@INPUT@' ],
> +                          capture: true)
> +  if config_host.has_key('CONFIG_TRACE_UST')
> +    trace_ust_h = custom_target(fmt.format('trace-ust', 'h'),
> +                                output: fmt.format('trace-ust', 'h'),
> +                                input: trace_events_file,
> +                                command: [ tracetool, group, '--format=ust-events-h', '@INPUT@' ],
> +                                capture: true)
> +  endif
> +  trace_obj.add(trace_h, trace_c)
> +  if config_host.has_key('CONFIG_TRACE_DTRACE')
> +    trace_dtrace = custom_target(fmt.format('trace-dtrace', 'dtrace'),
> +                                 output: fmt.format('trace-dtrace', 'dtrace'),
> +                                 input: trace_events_file,
> +                                 command: [ tracetool, group, '--format=d', '@INPUT@' ],
> +                                 capture: true)
> +    trace_dtrace_h = custom_target(fmt.format('trace-dtrace', 'h'),
> +                                   output: fmt.format('trace-dtrace', 'h'),
> +                                   input: trace_dtrace,
> +                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-h', '-s', '@INPUT@' ])
> +    trace_dtrace_o = custom_target(fmt.format('trace-dtrace', 'o'),
> +                                   output: fmt.format('trace-dtrace', 'o'),
> +                                   input: trace_dtrace,
> +                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-G', '-s', '@INPUT@' ])
> +
> +    trace_obj.add(trace_dtrace_h, trace_dtrace_o)
> +  endif
> +endforeach

This replaces the pattern rules you deleted from the top-level Makefile.
Good.

It also replaces the -root rules you deleted there; they're no longer a
special case here.  Good.

The degradation from declarative to imperative is a bit sad.

I *guess* this is also where the problem you mentioned in the commit
message really is: we generate the tracing files centrally here, and
because of that the generated headers end up in one place rather than
next to their trace-events.

> +
> +custom_target('trace-events-all',
> +              output: 'trace-events-all',
> +              input: trace_events_files,
> +              command: [ 'cat', '@INPUT@' ],
> +              capture: true)
> +
> +if config_host.has_key('CONFIG_TRACE_UST')
> +  trace_ust_all_h = custom_target(fmt.format('trace-ust', 'h'),
> +                                  output: fmt.format('trace-ust', 'h'),
> +                                  input: trace_events_files,
> +                                  command: [ tracetool, '--group=all', '--format=ust-events-h', '@INPUT@' ],
> +                                  capture: true)
> +  trace_ust_all_c = custom_target(fmt.format('trace-ust', 'c'),
> +                                  output: fmt.format('trace-ust', 'c'),
> +                                  input: trace_events_files,
> +                                  command: [ tracetool, '--group=all', '--format=ust-events-c', '@INPUT@' ],
> +                                  capture: true)
> +  trace_obj.add(trace_ust_all_h, trace_ust_all_c)
> +endif

This replaces the -all rules you deleted from the top-level Makefile.
Good.

> +
> +trace_obj.add(when: 'CONFIG_TRACE_SIMPLE', if_true: files('simple.c'))
> +trace_obj.add(when: 'CONFIG_TRACE_FTRACE', if_true: files('ftrace.c'))
> +trace_obj.add(files('control.c'))
> +trace_obj.add(files('qmp.c'))

This replaces the util-obj-y additions you deleted from
trace/Makefile.objs.  Good.

[Another forwarding header snipped...]
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> deleted file mode 100644
> index 3817820..0000000
> --- a/util/Makefile.objs
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
> -util-obj-y += bufferiszero.o
> -util-obj-y += lockcnt.o
> -util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
> -util-obj-y += main-loop.o iohandler.o
> -main-loop.o-cflags := $(SLIRP_CFLAGS)
> -util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
> -util-obj-$(CONFIG_POSIX) += aio-posix.o
> -util-obj-$(CONFIG_POSIX) += compatfd.o
> -util-obj-$(CONFIG_POSIX) += event_notifier-posix.o
> -util-obj-$(CONFIG_POSIX) += mmap-alloc.o
> -util-obj-$(CONFIG_POSIX) += oslib-posix.o
> -util-obj-$(CONFIG_POSIX) += qemu-openpty.o
> -util-obj-$(CONFIG_POSIX) += qemu-thread-posix.o
> -util-obj-$(CONFIG_POSIX) += memfd.o
> -util-obj-$(CONFIG_WIN32) += aio-win32.o
> -util-obj-$(CONFIG_WIN32) += event_notifier-win32.o
> -util-obj-$(CONFIG_WIN32) += oslib-win32.o
> -util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
> -util-obj-y += envlist.o path.o module.o
> -util-obj-y += host-utils.o
> -util-obj-y += bitmap.o bitops.o hbitmap.o
> -util-obj-y += fifo8.o
> -util-obj-y += cacheinfo.o
> -util-obj-y += error.o qemu-error.o
> -util-obj-y += qemu-print.o
> -util-obj-y += id.o
> -util-obj-y += iov.o qemu-config.o qemu-sockets.o uri.o notify.o
> -util-obj-y += qemu-option.o qemu-progress.o
> -util-obj-y += keyval.o
> -util-obj-y += hexdump.o
> -util-obj-y += crc32c.o
> -util-obj-y += uuid.o
> -util-obj-y += throttle.o
> -util-obj-y += getauxval.o
> -util-obj-y += readline.o
> -util-obj-y += rcu.o
> -util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
> -util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
> -util-obj-y += qemu-coroutine-sleep.o
> -util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
> -util-obj-y += buffer.o
> -util-obj-y += timed-average.o
> -util-obj-y += base64.o
> -util-obj-y += log.o
> -util-obj-y += pagesize.o
> -util-obj-y += qdist.o
> -util-obj-y += qht.o
> -util-obj-y += qsp.o
> -util-obj-y += range.o
> -util-obj-y += stats64.o
> -util-obj-y += systemd.o
> -util-obj-y += iova-tree.o
> -util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
> -util-obj-$(CONFIG_LINUX) += vfio-helpers.o
> -util-obj-$(CONFIG_POSIX) += drm.o
> -util-obj-y += guest-random.o
> -
> -stub-obj-y += filemonitor-stub.o
> diff --git a/util/meson.build b/util/meson.build
> new file mode 100644
> index 0000000..efb1fbc
> --- /dev/null
> +++ b/util/meson.build
> @@ -0,0 +1,57 @@
> +util_obj.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
> +util_obj.add(files('bufferiszero.c'))
> +util_obj.add(files('lockcnt.c'))
> +util_obj.add(files('aiocb.c', 'async.c', 'aio-wait.c', 'thread-pool.c', 'qemu-timer.c'))
> +util_obj.add(files('main-loop.c', 'iohandler.c'), slirp)
> +util_obj.add(when: 'CONFIG_ATOMIC64', if_false: files('atomic64.c'))
> +util_obj.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
> +util_obj.add(when: 'CONFIG_POSIX', if_true: files('compatfd.c'))
> +util_obj.add(when: 'CONFIG_POSIX', if_true: files('event_notifier-posix.c'))
> +util_obj.add(when: 'CONFIG_POSIX', if_true: files('mmap-alloc.c'))
> +util_obj.add(when: 'CONFIG_POSIX', if_true: files('oslib-posix.c'))
> +util_obj.add(when: 'CONFIG_POSIX', if_true: files('qemu-openpty.c'))
> +util_obj.add(when: 'CONFIG_POSIX', if_true: files('qemu-thread-posix.c'))
> +util_obj.add(when: 'CONFIG_POSIX', if_true: files('memfd.c'))
> +util_obj.add(when: 'CONFIG_WIN32', if_true: files('aio-win32.c'))
> +util_obj.add(when: 'CONFIG_WIN32', if_true: files('event_notifier-win32.c'))
> +util_obj.add(when: 'CONFIG_WIN32', if_true: files('oslib-win32.c'))
> +util_obj.add(when: 'CONFIG_WIN32', if_true: files('qemu-thread-win32.c'))
> +util_obj.add(files('envlist.c', 'path.c', 'module.c'))
> +util_obj.add(files('host-utils.c'))
> +util_obj.add(files('bitmap.c', 'bitops.c', 'hbitmap.c'))
> +util_obj.add(files('fifo8.c'))
> +util_obj.add(files('cacheinfo.c'))
> +util_obj.add(files('error.c', 'qemu-error.c'))
> +util_obj.add(files('qemu-print.c'))
> +util_obj.add(files('id.c'))
> +util_obj.add(files('iov.c', 'qemu-config.c', 'qemu-sockets.c', 'uri.c', 'notify.c'))
> +util_obj.add(files('qemu-option.c', 'qemu-progress.c'))
> +util_obj.add(files('keyval.c'))
> +util_obj.add(files('hexdump.c'))
> +util_obj.add(files('crc32c.c'))
> +util_obj.add(files('uuid.c'))
> +util_obj.add(files('throttle.c'))
> +util_obj.add(files('getauxval.c'))
> +util_obj.add(files('readline.c'))
> +util_obj.add(files('rcu.c'))
> +util_obj.add(when: 'CONFIG_MEMBARRIER', if_true: files('sys_membarrier.c'))
> +util_obj.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
> +util_obj.add(files('qemu-coroutine-sleep.c'))
> +util_obj.add(files('coroutine-@0@.c'.format(config_host['CONFIG_COROUTINE_BACKEND'])))
> +util_obj.add(files('buffer.c'))
> +util_obj.add(files('timed-average.c'))
> +util_obj.add(files('base64.c'))
> +util_obj.add(files('log.c'))
> +util_obj.add(files('pagesize.c'))
> +util_obj.add(files('qdist.c'))
> +util_obj.add(files('qht.c'))
> +util_obj.add(files('qsp.c'))
> +util_obj.add(files('range.c'))
> +util_obj.add(files('stats64.c'))
> +util_obj.add(files('systemd.c'))
> +util_obj.add(files('iova-tree.c'))
> +util_obj.add(when: 'CONFIG_INOTIFY1', if_true: files('filemonitor-inotify.c'),
> +                                      if_false: files('filemonitor-stub.c'))
> +util_obj.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
> +util_obj.add(when: 'CONFIG_POSIX', if_true: files('drm.c'))
> +util_obj.add(files('guest-random.c'))

Looks like a straightforward conversion (I admit I didn't look closely).

[Another forwarding header snipped...]

Okay, time to take a step back and look at the whole picture.

I still agree with your stated objectives for the conversion.

I went through this patch (and all of the v1 series before) with a fine
comb, because I think replacing build tools is a momentous decision.

The Meson sources feel more organized than the Makefiles they replace.
Related stuff tends to be together.

Also, intent often feels more obvious.  I think that's because Meson
includes more useful batteries than Make, and their use tends to be more
self-documenting than the "build up a bunch of variables containing
<whatever>, to be used somewhere else <however>" we have with Make,
where the reader is expected to know or find out <whatever> and
<however>.  Comments explaining the purpose of important variables could
help some, of course.

I'm a bit concerned about debugability.  Not exactly easy with complex
Makefiles such as ours, but the "Meson generates Ninja generates
Makefile" scares me.  Even with the last translation gone after the
conversion completes, an uneasy feeling remains.  Could be just fear of
the unknown.

As to next steps...

I think we should try to find out how to generate trace.h next to their
trace-events.  Not because the forwarding headers are show-stoppers
(they are not), but to get a feel for how constraining Meson is.  I
understand why constraints can be beneficial, but too much results in a
straightjacket.

You mentioned during review of v1 that testing might pose some
additional difficulties.  A PoC for selected tests would be nice.

