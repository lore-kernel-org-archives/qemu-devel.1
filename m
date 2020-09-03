Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE9C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D3D20665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D3D20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDi9T-00033I-CM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kDi8u-0002dv-K7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:50:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:32962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kDi8s-0007fs-3i
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:50:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kDi8q-0001Pk-Jm
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7FE772E80EA
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 05:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2020 05:42:05 -0000
From: Paolo Bonzini <1893758@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Won't Fix; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bonzini philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Paolo Bonzini (bonzini)
References: <159895503437.23051.7002685011475326158.malonedeb@wampee.canonical.com>
Message-Id: <159911172557.20713.515724951157935446.malone@chaenomeles.canonical.com>
Subject: [Bug 1893758] Re: meson: scary KeyboardInterrupt backtrace displayed
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: 19d9224e3eda0fb26fb55338a92b2bc5a98b03b4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:20:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1893758 <1893758@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That's just how Python works. :-(

https://bugs.python.org/issue14229

** Bug watch added: Python Roundup #14229
   http://bugs.python.org/issue14229

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893758

Title:
  meson: scary KeyboardInterrupt backtrace displayed

Status in QEMU:
  Won't Fix

Bug description:
  Pressing ^C while building (calling 'make') sometime displays
  KeyboardInterrupt exception backtrace (host Fedora 32):

  $ make qemu-system-arm
  Generating qemu-version.h with a meson_exe.py custom command
  ^CTraceback (most recent call last):
    File "/usr/bin/meson", line 6, in <module>
      from pkg_resources import load_entry_point
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 3252, in <module>
      def _initialize_master_working_set():
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 3235, in _call_aside
      f(*args, **kwargs)
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 3277, in _initialize_master_working_set
      tuple(
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 3278, in <genexpr>
      dist.activate(replace=3DFalse)
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 2782, in activate
      fixup_namespace_packages(self.location)
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 2295, in fixup_namespace_packages
      subpath =3D _handle_ns(package, path_item)
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 2194, in _handle_ns
      importer =3D get_importer(path_item)
    File "/usr/lib64/python3.8/pkgutil.py", line 415, in get_importer
      importer =3D sys.path_importer_cache[path_item]
  KeyboardInterrupt

  =

  $ make
  [...]
  Compiling C object libcommon.fa.p/disas_alpha.c.o
  Compiling C object libcommon.fa.p/hw_isa_smc37c669-superio.c.o
  Compiling C object libcommon.fa.p/hw_isa_isa-superio.c.o
  Compiling C object libcommon.fa.p/hw_char_serial-isa.c.o
  Compiling C object libcommon.fa.p/hw_acpi_aml-build-stub.c.o
  ^CTraceback (most recent call last):
    File "/usr/bin/meson", line 6, in <module>
      from pkg_resources import load_entry_point
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 3252, in <module>
  make: *** [Makefile.ninja:994: libcommon.fa.p/disas_alpha.c.o] Interrupt
  make: *** [Makefile.ninja:998: libcommon.fa.p/hw_isa_smc37c669-superio.c.=
o] Interrupt
  make: *** [Makefile.ninja:1025: libcommon.fa.p/hw_isa_isa-superio.c.o] In=
terrupt
  make: *** [Makefile.ninja:1069: libcommon.fa.p/hw_char_serial-isa.c.o] In=
terrupt
  make: *** [Makefile.ninja:1102: libcommon.fa.p/hw_acpi_aml-build-stub.c.o=
] Interrupt
  make: *** [Makefile.ninja:2138: qemu-system-alpha.p/softmmu_main.c.o] Int=
errupt
  make: *** [Makefile.ninja:949: libblock.fa.p/block_qcow2.c.o] Interrupt
      def _initialize_master_working_set():
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 3235, in _call_aside
      f(*args, **kwargs)
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 3287, in _initialize_master_working_set
      list(map(working_set.add_entry, sys.path))
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 623, in add_entry
      for dist in find_distributions(entry, True):
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 2065, in find_on_path
      for dist in factory(fullpath):
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 2134, in distributions_from_metadata
      yield Distribution.from_location(
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 2590, in from_location
      return cls(
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 2571, in __init__
      self._version =3D safe_version(version)
    File "/usr/lib/python3.8/site-packages/pkg_resources/__init__.py", line=
 1331, in safe_version
      return str(packaging.version.Version(version))
    File "/usr/lib/python3.8/site-packages/pkg_resources/_vendor/packaging/=
version.py", line 205, in __init__
      self._version =3D _Version(
    File "<string>", line 1, in __new__
  KeyboardInterrupt
  make: *** [Makefile.ninja:875: qemu.syms.stamp] Interrupt

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893758/+subscriptions

