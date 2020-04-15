Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973AEC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 23:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6133E20768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 23:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRt6x1z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6133E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOrkp-00067U-Hk
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 19:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jOrkB-0005gs-KE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 19:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jOrkA-0005Jz-6t
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 19:46:59 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:36045
 helo=mail-oo1-xc42.google.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jOrk9-0005JJ-W3
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 19:46:58 -0400
Received: by mail-oo1-xc42.google.com with SMTP id x17so277321ooa.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=D287IWwv15gfFlc7zpTf5ak2LFGi1AgodsoOBf1qMEA=;
 b=nRt6x1z0b3EA1zjx1v0GkjogSwiX9ilGDX+FhQc2k0aiQYp9M0wOM4Lu5QOo1uTOji
 AML34wynK9soM5C1KQFC3terFFLuwxL87COFErCVs20tKSuRwiv3fC3aS9jiqFw8SZAH
 a6DQZtxKzO3/x6bpieS9KbCV4nBvPdTmeDz344Kj/RW4yTN4q3b5ZPXWt1+h7VIyNfoC
 V8Ze4oFzFrZMHlXBkB11jmJevoKusKGYfUJ+pqShk1oeGJR9rtgJLzJvsdtkOluSlrIn
 TgHlGq5hd8tpTLgQRlEi6pCpvfYT2DHpUA3rg6SLIeburOKKx/6GK0nqNh9Bhxvcip2U
 S4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=D287IWwv15gfFlc7zpTf5ak2LFGi1AgodsoOBf1qMEA=;
 b=XGDEM/XczvJs8qpDN/T5BHnPsKYWVWN+BEQofCElY/HSi1Nu599838VOxBHpKejGes
 p0ZdsMI9K6Rzpd+RPb280jKEYyhHOLQkmWJ58pOobHERJWjjVNLAnsc+eNmqqm4YRChw
 W4X/0hKUMOb3Lkd2Vq1Vn5wJ1oFemi2cALBwf278WJ1darXtLABpRTLTq3Z7uZK+Oodn
 rnyvbpz0SMqu8cZPjcjNjzptJeRj1GkP6/tIO5bKbyDPJpAD1PH5TVQNZv8MgYoBe2va
 cgyWWreZJipFMpLDX/uU4ydo81QguO+SzBEjqQKbaWDOfYxsw4qi3C/GicVu3ca00jRC
 iv1w==
X-Gm-Message-State: AGi0Pub24qBhcrM7xmE7u3LOuTzR92o1B/DTS97cjY0OL7d7eO4Dtsyb
 4DQWhRmq1yBBLCIHjz7b0Uw=
X-Google-Smtp-Source: APiQypI2SDI5Wp6HbZ7IEp7cRnhLBUWon/Q5ox7kwaiphyv0IL4D6BFIYbyDy9fhxi8WthkbTaeY4g==
X-Received: by 2002:a4a:bc8f:: with SMTP id m15mr24639858oop.19.1586994416900; 
 Wed, 15 Apr 2020 16:46:56 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id r21sm1563749otg.67.2020.04.15.16.46.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Apr 2020 16:46:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <158699441116.20966.15964366228752647978@sif>
Subject: [ANNOUNCE] QEMU 5.0.0-rc3 is now available
Date: Wed, 15 Apr 2020 18:46:51 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 5.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-5.0.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-5.0.0-rc3.tar.xz.sig

A note from the maintainer:

  Unless there are any release critical bugs, this will be the
  final rc and we will release on Tuesday 21st April. If
  we need another rc, we'll have rc4 on Tuesday 21st and the
  final release on Tuesday 28th.

You can help improve the quality of the QEMU 5.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/5.0

Please add entries to the ChangeLog for the 5.0 release below:

  http://wiki.qemu.org/ChangeLog/5.0

Thank you to everyone involved!

Changes since rc2:

20038cd7a8: Update version for v5.0.0-rc3 release (Peter Maydell)
4ff97121a3: vhost-user-gpu: Release memory returned by vu_queue_pop() with =
free() (Philippe Mathieu-Daud=C3=A9)
1329651fb4: qga: Restrict guest-file-read count to 48 MB to avoid crashes (=
Philippe Mathieu-Daud=C3=A9)
ead83a136d: qga: Extract qmp_guest_file_read() to common commands.c (Philip=
pe Mathieu-Daud=C3=A9)
5d3586b834: qga: Extract guest_file_handle_find() to commands-common.h (Phi=
lippe Mathieu-Daud=C3=A9)
f62ebb6384: Revert "prevent crash when executing guest-file-read with large=
 count" (Philippe Mathieu-Daud=C3=A9)
377f8f08be: gdbstub: Introduce gdb_get_float32() to get 32-bit float regist=
ers (Philippe Mathieu-Daud=C3=A9)
7b8c1527ae: gdbstub: Do not use memset() on GByteArray (Philippe Mathieu-Da=
ud=C3=A9)
bbc40fefce: gdbstub: i386: Fix gdb_get_reg16() parameter to unbreak gdb (Pe=
ter Xu)
4b27f9b083: target/m68k/helper: Fix m68k_fpu_gdb_get_reg() use of GByteArra=
y (Philippe Mathieu-Daud=C3=A9)
7ad4d5a43e: linux-user: fix /proc/self/stat handling (Alex Benn=C3=A9e)
469a788cdd: configure: disable PIE for Windows builds (Alex Benn=C3=A9e)
988ae6c3a7: configure: redirect sphinx-build check to config.log (Alex Benn=
=C3=A9e)
551affb61e: tests/docker: add docs FEATURE flag and use for test-misc (Alex=
 Benn=C3=A9e)
84f82ddcbb: Deprecate KVM support for AArch32 (Peter Maydell)
bf3f857342: docs: Require Sphinx 1.6 or better (Peter Maydell)
152d1967f6: kernel-doc: Use c:struct for Sphinx 3.0 and later (Peter Maydel=
l)
a62d563796: scripts/kernel-doc: Add missing close-paren in c:function direc=
tives (Peter Maydell)
9f5a066418: hax: Windows doesn't like posix device names (Volker R=C3=BCmel=
in)
e43651ff88: tests: numa: test one backend with prealloc enabled (Igor Mamme=
dov)
2a4e02d104: hostmem: set default prealloc_threads to valid value (Igor Mamm=
edov)
516e8b7d4a: configure: Honour --disable-werror for Sphinx (Peter Maydell)
e5910d42dd: docs: Improve our gdbstub documentation (Peter Maydell)
9edfa3580f: scripts/coverity-scan: Add Docker support (Peter Maydell)
9c263d07fd: scripts/run-coverity-scan: Script to run Coverity Scan build (P=
eter Maydell)
94db8de179: linux-user/flatload.c: Use "" for include of QEMU header target=
_flat.h (Peter Maydell)
2e79802445: thread.h: Remove trailing semicolons from Coverity qemu_mutex_l=
ock() etc (Peter Maydell)
062c73c51e: thread.h: Fix Coverity version of qemu_cond_timedwait() (Peter =
Maydell)
c160f17cd6: osdep.h: Drop no-longer-needed Coverity workarounds (Peter Mayd=
ell)
ce4adc0b6e: exec: Fix for qemu_ram_resize() callback (David Hildenbrand)
394f0f72fd: fw_cfg: Migrate ACPI table mr sizes separately (Shameer Kolothu=
m)
bac78f9c69: acpi: Use macro for table-loader file name (Shameer Kolothum)
b372d79b23: MAINTAINERS: Add myself as vhost-user-blk maintainer (Raphael N=
orwitz)
267514b33f: module: increase dirs array size by one (Bruce Rogers)
d489ae4ac5: memory: Do not allow direct write access to rom_device regions =
(Alexander Duyck)
1148e4f4dc: vl.c: error out if -mem-path is used together with -M memory-ba=
ckend (Igor Mammedov)
fb8a9677b1: rcu: do not mention atomic_mb_read/set in documentation (Paolo =
Bonzini)
de99dab06f: atomics: update documentation (Paolo Bonzini)
a4e57084c1: tcg/mips: mips sync* encode error (lixinyu)
15e8699f00: atomics: convert to reStructuredText (Paolo Bonzini)
278fb16273: oslib-posix: take lock before qemu_cond_broadcast (Bauerchen)
9a709f06c8: piix: fix xenfv regression, add compat machine xenfv-4.2 (Olaf =
Hering)
5710a3e09f: async: use explicit memory barriers (Paolo Bonzini)
3c18a92dc4: aio-wait: delegate polling of main AioContext if BQL not held (=
Paolo Bonzini)
636b836d5f: aio-posix: signal-proof fdmon-io_uring (Stefan Hajnoczi)
40bd0502db: target/rx/translate: Add missing fall through comment (Philippe=
 Mathieu-Daud=C3=A9)
fde557ad25: target/xtensa: statically allocate xtensa_insnbufs in DisasCont=
ext (Max Filippov)
1a03362b14: target/xtensa: fix pasto in pfwait.r opcode name (Max Filippov)


