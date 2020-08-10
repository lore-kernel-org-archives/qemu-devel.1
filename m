Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923A3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351CA207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTxZiULv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351CA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CTv-0006pz-Aq
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5CEd-0004zb-VK
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:09:23 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5CEb-0001YS-DY
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:09:23 -0400
Received: by mail-ot1-x341.google.com with SMTP id a65so8001249otc.8
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2PbhD7VrW6sTP4hIAtS6dG3NV4UeppoRdKIRGrD5904=;
 b=dTxZiULvo1Vl6+jPYhhO5emSFn7QhNtghaTEpsatgp7ttubOGnIlYsHfJIYmI7Whvq
 RC3UdWef2XIxyqbfCJJhRpSDvNcykAKhpWm6LUvDjq5Z16UtZdsRiPTChe0kqXfqjpSI
 1uw/cyTIXdUI1Gh304SrV73W2GtWgS09s/vFZSqsV6bk8wVspvmFs/i2xnuk4PXsKcgy
 /4lvFvnj+Y+6zuOcjdyFiPuD3hfVsRgBJ6YQGBcvNAHFeKFNbqj2vR9Ca7tosNtGq81w
 D2y9upo0mj7sYy9FHSEDouYJS+lQUlFKgSDQEWK9V8nC1C5pAJ1XlNal/7EgIm06ufM/
 B8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2PbhD7VrW6sTP4hIAtS6dG3NV4UeppoRdKIRGrD5904=;
 b=PIceNbNGaoHqa0xBrr1P7iiGR0aaNa2an0hie53FvrR6sj16RWmIAbqBnldJ5JEXxC
 3i53RZ9ejWOyUuFZKDoBMviYBYuSEyWoAr35a6aAXC2WmE1HVj3dhzmPU/1UM/La9xBy
 ErkosJ/upFzjykbl2Z67CT93nylciSlC9yHoJfXt0oEkwjkVCpaHMXKLGjgKXIrCkHWl
 MRDLq7M/Ebj1tQUtj+SmCkldnPtZByvep4JyjQhYHoefT1qSC//dWHIG1w9CsEtgr2e0
 efj5p+2K9rkrTFAnkNhPJTk2l6Nc5rSEG+XH3TD40pZdJkaal8aaoHue0M70MBhf9RS6
 fhjg==
X-Gm-Message-State: AOAM533mPM8rDshP5BjsMVqTwFy+G7hfOrlzwg2uwvPi81ZhWUbsK33S
 5AQN39opK1EmQNWM+4wEt1av6r2tKBJt7dM8JaW2/A==
X-Google-Smtp-Source: ABdhPJwx06ICQyk/PjhQhBQDIbzxiHc7urQjbNwIsQQ3pOWlaQZIPz9kKWb7zqEwq/Jpeg/wGazP6aUyZYrAxqv/co8=
X-Received: by 2002:a9d:24e7:: with SMTP id z94mr1755526ota.91.1597082959094; 
 Mon, 10 Aug 2020 11:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 19:09:07 +0100
Message-ID: <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 18:09, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This version is substantially less "draft-like", and the diffstat
> is actually quite large with Thursday's draft.
>
> The changes are as follows:
> - updated oss-fuzz build script
> - various cases fixed that broke depending on present/absent dependencies
> - all build scripts handle --python correctly
> - git submodules properly updated before running meson
> - no warnings from Meson master (will be 0.56.0), one from upcoming 0.55.1
> - installation matches current build system
> - fixes for virtio-vga broken merge
> - includes updated s390-ccw patch from Thomas
> - less noisy "make check"
> - tested with GitLab CI, BSD VM builds and various Docker builds
> - input-keymap files properly regenerated
>
> Of our supported build platforms, only Mac OS and non-x86 hosts are
> still untested.  But I guess this might finally count as a v1.

Here's a trio of different failures trying the patchseries in my
usual merge-test setup:

Build failure, windows crossbuilds:

make: Entering directory '/home/petmay01/qemu-for-merges/build/w64'
config-host.mak is out-of-date, running configure
  GEN     tests/test-qapi-gen
Submodule 'meson' (https://github.com/mesonbuild/meson/) registered
for path 'meson'
Cloning into '/home/petmay01/qemu-for-merges/meson'...
Disabling PIE due to missing toolchain support
cross containers  no

NOTE: guest cross-compilers enabled: cc
The Meson build system
Version: 0.55.0
Source dir: /home/petmay01/qemu-for-merges
Build dir: /home/petmay01/qemu-for-merges/build/w64
Build type: cross build

../../meson.build:1:0: ERROR: prefix value 'c:/Program Files/QEMU'
must be an absolute path

A full log can be found at
/home/petmay01/qemu-for-merges/build/w64/meson-logs/meson-log.txt

ERROR: meson setup failed

make: *** Deleting file 'config-host.mak'
make: *** No rule to make target 'config-host.mak', needed by
'meson-private/coredata.dat'.  Stop.
make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'


Build failure, aarch32:

make: Entering directory '/home/peter.maydell/qemu/build/all-a32'
config-host.mak is out-of-date, running configure
  GEN     tests/test-qapi-gen
Submodule 'meson' (https://github.com/mesonbuild/meson/) registered
for path 'meson'
Cloning into '/home/peter.maydell/qemu/meson'...
cross containers  no

NOTE: guest cross-compilers enabled: cc cc cc cc
Traceback (most recent call last):
  File "/home/peter.maydell/qemu/meson/meson.py", line 26, in <module>
    from mesonbuild import mesonmain
  File "/home/peter.maydell/qemu/meson/mesonbuild/mesonmain.py", line
25, in <module>
    from . import mconf, mdist, minit, minstall, mintro, msetup,
mtest, rewriter, msubprojects, munstable_coredata, mcompile
  File "/home/peter.maydell/qemu/meson/mesonbuild/mconf.py", line 16,
in <module>
    from . import coredata, environment, mesonlib, build, mintro, mlog
  File "/home/peter.maydell/qemu/meson/mesonbuild/build.py", line 26,
in <module>
    from . import dependencies
  File "/home/peter.maydell/qemu/meson/mesonbuild/dependencies/__init__.py",
line 15, in <module>
    from .boost import BoostDependency
  File "/home/peter.maydell/qemu/meson/mesonbuild/dependencies/boost.py",
line 25, in <module>
    from .base import DependencyException, ExternalDependency,
PkgConfigDependency
  File "/home/peter.maydell/qemu/meson/mesonbuild/dependencies/base.py",
line 32, in <module>
    import pkg_resources
ModuleNotFoundError: No module named 'pkg_resources'

ERROR: meson setup failed

make: *** Deleting file 'config-host.mak'
make: *** No rule to make target 'config-host.mak', needed by
'meson-private/coredata.dat'.  Stop.
make: Leaving directory '/home/peter.maydell/qemu/build/all-a32'


Build failure, aarch64:

Program scripts/grepy.sh found: YES
Configuring config-all-devices.mak with command
Program scripts/hxtool found: YES
Program scripts/shaderinclude.pl found: YES
Program scripts/qapi-gen.py found: YES
Program scripts/tracetool.py found: YES
Program scripts/qemu-version.sh found: YES
Program keycodemapdb/tools/keymap-gen found: YES
Program scripts/decodetree.py found: YES
Program ../scripts/modules/module_block.py found: YES
Program nm found: YES
Program scripts/undefsym.sh found: YES
Program scripts/feature_to_c.sh found: YES
Program scripts/tracetool.py found: YES

../../meson.build:969:2: ERROR: File kvm64.c does not exist.

A full log can be found at /home/pm/qemu/build/all/meson-logs/meson-log.txt

ERROR: meson setup failed

make: *** Deleting file 'config-host.mak'
make: *** No rule to make target 'config-host.mak', needed by
'meson-private/coredata.dat'.  Stop.
make: Leaving directory '/home/pm/qemu/build/all'


The other hosts are still running, will report results as
they finish. These are just the ones that bailed out
immediately.

thanks
-- PMM

