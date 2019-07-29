Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E91C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 07:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A615206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 07:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A615206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrznc-0005BV-SY
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 03:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hrznC-0004mq-7W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 03:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hrznA-0006Cb-M4
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 03:09:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hrznA-0006BL-Cn
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 03:09:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 74A012F8BDC;
 Mon, 29 Jul 2019 07:09:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92D4960C44;
 Mon, 29 Jul 2019 07:09:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1458E1138619; Mon, 29 Jul 2019 09:09:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
Date: Mon, 29 Jul 2019 09:09:49 +0200
In-Reply-To: <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 (Peter Maydell's message of "Sat, 27 Jul 2019 19:20:15 +0100")
Message-ID: <87ftmptiyq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 29 Jul 2019 07:09:55 +0000 (UTC)
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sat, 27 Jul 2019 at 13:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 27/07/19 09:16, Markus Armbruster wrote:
>> > We started with a single trace-events.  That wasn't good, so we split it
>> > up into one per directory.  That isn't good, so what about splitting it
>> > up into one per source file?  Pass -DTRACE_HEADER='"trace-DIR-FOO.h"
>> > instead of -DTRACE_HEADER='"trace-DIR.h"' when compiling DIR/FOO.c.
>>
>> For Make this would all work great, however not for Meson because it
>> doesn't allow per-file compile flags.
>
> Apologies for randomly parachuting into this email thread, but if
> Meson doesn't support per-file compile flags then what's the plan
> for handling the cases where we currently need per-file compile flags ?
> (This is one of the things that I thought was quite a nice move
> forward in our make infrastructure -- we now have clean syntax
> for saying "these files need to be built with these warnings disabled
> or these extra include paths or whatever" and also "these files
> imply we're going to need to link against library X".)

I vaguely remember from my review that Meson lets us express "these
files imply we're going to need to link against library X" even more
clearly.  I can't point you to an example, though.

Aside: I can't apply this series anymore.  I tried master, failed, tried
a merge commit shortly before its posting date, failed, gave up.  Can I
git-pull it from somewhere?

Losing the ability to add compiler flags per file with minimal fuss
would be regrettable.  How regrettable?  I append results of a quick
grep.

>> Meson maintainers suggest building a static library for each special set
>> of compile flags; we could do that automatically per-directory(*) but it
>> would be harder to scale that to per-file.

This is clearly not "minimal fuss", not even per directory, let alone
per file.

It's pretty lame even for the large sets we have (per target,
target-independent): I guess we'd either throw away the .a unused, or
link with --wholearchive.

The grep below shows multiple instances of per-file.

We should explore how to handle typical instances before we commit to
the conversion project.

>> (*) Still, I'd rather go on with the forwarding headers and look into
>> that later, to ease review.

For me, forwarding headers are just fine for a PoC, quite tolerable
while a conversion is in progress, and perhaps even tolerable as a
permanent work-around.  My *actual* question is how we could do per-file
rather than per-directory trace.h with Meson.  Quoting myself:

    We have trace-events with hundreds of tracepoints for tens of source
    files.  The generated trace.h clock in at hundreds of KiB for me.
    Messing with tracepoints in one source file recompiles most of the
    directory.  This is so much better than it used to be, but clearly not
    as good as it could be.

    The worst of the lot is trace-root.h, which gets included for >1300 .o
    in my "build everything" tree, mostly because it contains tracepoints
    for static inline functions in widely included headers.  See also
    "[PATCH 07/28] trace: Do not include qom/cpu.h into generated trace.h",
    Message-Id: <20190726120542.9894-8-armbru@redhat.com>.

    We started with a single trace-events.  That wasn't good, so we split it
    up into one per directory.  That isn't good, so what about splitting it
    up into one per source file?

Any ideas?


$ git-grep -F o-cflags
Makefile.objs:bt-host.o-cflags := $(BLUEZ_CFLAGS)
Makefile.objs:vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
Makefile.objs:qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
Makefile.objs:vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
audio/Makefile.objs:sdl.mo-cflags := $(SDL_CFLAGS)
block/Makefile.objs:iscsi.o-cflags     := $(LIBISCSI_CFLAGS)
block/Makefile.objs:curl.o-cflags      := $(CURL_CFLAGS)
block/Makefile.objs:rbd.o-cflags       := $(RBD_CFLAGS)
block/Makefile.objs:gluster.o-cflags   := $(GLUSTERFS_CFLAGS)
block/Makefile.objs:ssh.o-cflags       := $(LIBSSH_CFLAGS)
block/Makefile.objs:parallels.o-cflags := $(LIBXML2_CFLAGS)
chardev/Makefile.objs:baum.o-cflags := $(SDL_CFLAGS)
contrib/vhost-user-gpu/Makefile.objs:main.o-cflags := $(PIXMAN_CFLAGS) $(GBM_CFLAGS)
contrib/vhost-user-gpu/Makefile.objs:virgl.o-cflags := $(VIRGL_CFLAGS) $(GBM_CFLAGS)
contrib/vhost-user-gpu/Makefile.objs:vugbm.o-cflags := $(GBM_CFLAGS)
disas/Makefile.objs:arm-a64.o-cflags := -I$(libvixldir) -Wno-sign-compare
docs/devel/build-system.txt:  curl.o-cflags      := $(CURL_CFLAGS)
docs/devel/build-system.txt:  iscsi.o-cflags     := $(LIBISCSI_CFLAGS)
docs/devel/build-system.txt:  curl.o-cflags      := $(CURL_CFLAGS)
hw/display/Makefile.objs:milkymist-tmu2.o-cflags := $(X11_CFLAGS) $(OPENGL_CFLAGS)
hw/display/Makefile.objs:virtio-gpu.o-cflags := $(VIRGL_CFLAGS)
hw/display/Makefile.objs:virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
hw/usb/Makefile.objs:smartcard.mo-cflags := $(SMARTCARD_CFLAGS)
hw/usb/Makefile.objs:redirect.o-cflags = $(USB_REDIR_CFLAGS)
hw/usb/Makefile.objs:host-libusb.o-cflags := $(LIBUSB_CFLAGS)
hw/usb/Makefile.objs:xen-usb.o-cflags := $(LIBUSB_CFLAGS)
net/Makefile.objs:slirp.o-cflags := $(SLIRP_CFLAGS)
rules.mak:            $(if $($o-cflags), $o-cflags $(eval save-vars-$o-cflags := $($o-cflags))$(eval $o-cflags := )) \
rules.mak:            $(if $($o-cflags),
rules.mak:                $(eval $1$o-cflags := $($o-cflags)))
rules.mak:        # Pass the .mo-cflags and .mo-libs along to its member objects
rules.mak:                $(if $($o-cflags), $(eval $p-cflags += $($o-cflags)))
target/unicore32/Makefile.objs:helper.o-cflags := $(CURSES_CFLAGS)
tests/Makefile.include:tests/crypto-tls-x509-helpers.o-cflags := $(TASN1_CFLAGS)
tests/Makefile.include:tests/pkix_asn1_tab.o-cflags := $(TASN1_CFLAGS)
tests/Makefile.include:tests/test-crypto-tlscredsx509.o-cflags := $(TASN1_CFLAGS)
tests/Makefile.include:tests/test-crypto-tlssession.o-cflags := $(TASN1_CFLAGS)
ui/Makefile.objs:sdl.mo-cflags := $(SDL_CFLAGS)
ui/Makefile.objs:gtk.mo-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
ui/Makefile.objs:x_keymap.o-cflags := $(X11_CFLAGS)
ui/Makefile.objs:curses.mo-cflags := $(CURSES_CFLAGS) $(ICONV_CFLAGS)
ui/Makefile.objs:spice-app.mo-cflags := $(GIO_CFLAGS)
$ git-grep ':[^=].*CFLAGS'
Makefile:qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
Makefile:qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
configure:# Note: the prototype is needed since QEMU_CFLAGS
pc-bios/s390-ccw/netboot.mak:$(NETOBJS): QEMU_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
rules.mak:module-common.o: CFLAGS += $(DSO_OBJ_CFLAGS)
rules.mak:# Usage: CFLAGS+=$(call cc-option, -falign-functions=0, -malign-functions=0)
rules.mak:                   $(eval $($o-objs): CFLAGS += $(DSO_OBJ_CFLAGS))
target/nios2/Makefile.objs:$(obj)/op_helper.o: QEMU_CFLAGS += $(HELPER_CFLAGS)
tests/tcg/aarch64/Makefile.softmmu-target:memory: CFLAGS+=-DCHECK_UNALIGNED=1
tests/tcg/alpha/Makefile.softmmu-target:memory: CFLAGS+=-DCHECK_UNALIGNED=0
tests/tcg/alpha/Makefile.target:test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
tests/tcg/arm/Makefile.softmmu-target:test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0
tests/tcg/arm/Makefile.target:hello-arm: CFLAGS+=-marm -ffreestanding
tests/tcg/arm/Makefile.target:test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs -mfpu=fpv4-sp-d16
tests/tcg/arm/Makefile.target:# fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
tests/tcg/i386/Makefile.softmmu-target:memory: CFLAGS+=-DCHECK_UNALIGNED=1
tests/tcg/i386/Makefile.target:hello-i386: CFLAGS+=-ffreestanding
tests/tcg/mips/Makefile.target:hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -mabi=32

