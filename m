Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABDFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17347208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX36gAg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17347208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvfx-0003eP-Cn
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.com@gmail.com>)
 id 1kAulm-0006i3-ML
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:43:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:51381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.com@gmail.com>)
 id 1kAulj-0007ai-GD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:43:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id w2so1380906wmi.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UeI8jfKWP+rt+IY3SHRTlPy8uLBwg/GMiNTAFFuYMJ4=;
 b=KX36gAg1xl6tnzeWG5I2VtetYDwp6zVNCufEUPFt5IyPFsTMfAxDMi1t3dBGrUaXJs
 XyXKWjfRsvommmOAknPM9evPHfU0y6iEN5AvCMfYMTHkbVPlknyJ+FelWDBjOYYH+rvC
 /eEd6ZfuxKol9nb4VsEy6XYGni+OrbpEW415rmNgPUv626dXEnn5cr8R9YYHygdaRwnA
 Y7oxLIppTc9iYi9LqoYajptQD/hYwR6Idni/VIeWHZY8BmasYVLCwfDFDTG+eDEoMwOt
 x4+BghLuGlAOXpirjLOjhTEQwpdFmnHqxW2PtFnwBQtJFPxWgACfnCEY1e0IDRAUexSF
 3bSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UeI8jfKWP+rt+IY3SHRTlPy8uLBwg/GMiNTAFFuYMJ4=;
 b=I+LI14/x/iU5k34sL/pLNgM3XvUerzljTlQ2MeNJSDVn1b3mD3iEeECwvHl/7g3JYS
 fKt16Wk8s+jiRsHdS/LJNaKeitbGjPPKEjhC5MxEMwwd4Lj6Erpvz8O7YCdPkqaex/95
 Oy0KgxNYSBksv8zsm+EwfMARjfIV4znUu9DDlB7L+BtNoxZk2gdIEtMzNaN25dNFTV1T
 XyS5Dz465PfhjSImhKKVlEQVTlhEN85AhoKg3CKsRPEIZPY7Q/PLtSCgYVWqHKq/bqVt
 FFk8ujN3M34a4hA2EuQrqsuem0Nee8htbeNrEsieh3v3bP6GfVNV/MEnt2pV6BKVlLOz
 o7kA==
X-Gm-Message-State: AOAM532CQ5J51dg11n8w5xlqvLhDkVjPiy/bM9KabT6JTuag5MICMTB+
 pfrp4+W8gXmYKQ8TbLOHv0dRWwbRMX8=
X-Google-Smtp-Source: ABdhPJxe5SVpf6cvUVcrBs+zH1dvA/IOiAQgfE3jhDKwPD/q0O6/uAeo1dXarEl1ljo35gBM5Ypw2g==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr7331261wmb.114.1598445788758;
 Wed, 26 Aug 2020 05:43:08 -0700 (PDT)
Received: from [192.168.15.71] ([195.200.173.126])
 by smtp.gmail.com with ESMTPSA id p1sm5542409wma.0.2020.08.26.05.43.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Aug 2020 05:43:08 -0700 (PDT)
From: "Emmanuel Blot" <eblot.com@gmail.com>
To: qemu-devel@nongnu.org
Subject: Issue with submodules on macOS & meson
Date: Wed, 26 Aug 2020 14:43:07 +0200
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <9AB9A3F5-8AA6-4F82-9693-D331251AA0CB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=eblot.com@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Aug 2020 09:40:13 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Using current master 78dca230 w/ Meson/ninja, build fails with capstone =

dependency.

* ../configure --target-list=3Driscv64-softmmu && ninja
   fails because capstone is automatically enabled @ configure stage, =

but capstone is not installed on the host, and the local capstone/ =

submodule is not automatically populated:

cc -Ilibqemu-riscv64-softmmu.fa.p -I. -I.. -Itarget/riscv =

-I../target/riscv -Iqapi -Itrace -Iui -Iui/shader =

-I/usr/local/Cellar/pixman/0.40.0/include/pixman-1 =

-I/usr/local/Cellar/glib/2.64.4_2/include =

-I/usr/local/Cellar/glib/2.64.4_2/include/glib-2.0 =

-I/usr/local/Cellar/glib/2.64.4_2/lib/glib-2.0/include =

-I/usr/local/opt/gettext/include -I/usr/local/Cellar/pcre/8.44/include =

-I/usr/local/Cellar/gnutls/3.6.14/include =

-I/usr/local/Cellar/nettle/3.6/include =

-I/usr/local/Cellar/libtasn1/4.16.0/include =

-I/usr/local/Cellar/libidn2/2.3.0/include =

-I/usr/local/Cellar/p11-kit/0.23.20_1/include/p11-kit-1 =

-I/Users/eblot/Sources/Git/github.com/QEMU/upstream/capstone/include =

-Xclang -fcolor-diagnostics -pipe -Wall -Winvalid-pch -std=3Dgnu99 -O2 -g=
 =

-m64 -mcx16 -DOS_OBJECT_USE_OBJC=3D0 -arch x86_64 -D_GNU_SOURCE =

-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes =

-Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes =

-fno-strict-aliasing -fno-common -fwrapv -Wold-style-definition =

-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self =

-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels =

-Wexpansion-to-defined -Wno-initializer-overrides =

-Wno-missing-include-dirs -Wno-shift-negative-value -Wno-string-plus-int =

-Wno-typedef-redefinition -Wno-tautological-type-limit-compare =

-fstack-protector-strong -iquote =

/Users/eblot/Sources/Git/github.com/QEMU/upstream/tcg/i386 -iquote . =

-iquote /Users/eblot/Sources/Git/github.com/QEMU/upstream -iquote =

/Users/eblot/Sources/Git/github.com/QEMU/upstream/accel/tcg -iquote =

/Users/eblot/Sources/Git/github.com/QEMU/upstream/include -iquote =

/Users/eblot/Sources/Git/github.com/QEMU/upstream/disas/libvixl =

-DNEED_CPU_H '-DCONFIG_TARGET=3D"riscv64-softmmu-config-target.h"' =

'-DCONFIG_DEVICES=3D"riscv64-softmmu-config-devices.h"' -MD -MQ =

libqemu-riscv64-softmmu.fa.p/disas.c.o -MF =

libqemu-riscv64-softmmu.fa.p/disas.c.o.d -o =

libqemu-riscv64-softmmu.fa.p/disas.c.o -c ../disas.c
In file included from ../disas.c:9:
/Users/eblot/Sources/Git/github.com/QEMU/upstream/include/disas/capstone.=
h:6:10: =

error: 'capstone.h' file not found with <angled> include; use "quotes" =

instead
#include <capstone.h>
          ^~~~~~~~~~~~
          "capstone.h"

* ../configure --target-list=3Driscv64-softmmu =E2=80=94enable-capstone=3D=
git && =

ninja
   fails for the same reason (git submodule is not pulled)

* git submodule init && git submodule update capstone && ../configure =

--target-list=3Driscv64-softmmu && ninja
   fails because capstone.h is now found, but the library is not built:

     ld: library not found for -lcapstone
     clang: error: linker command failed with exit code 1 (use -v to see =

invocation)

    build/capstone is created but stays empty.

* ../configure --target-list=3Driscv64-softmmu =E2=80=94disable-capstone
    seems ok

A similar issue arises with slirp: slirp is automatically selected while =

not installed on the host and not pulled as a submodule. If the =

submodule is manually pulled, slirp is not built and QEMU fails to build =

because libslirp-version.h is not generated.

    /Users/eblot/Sources/Git/github.com/QEMU/upstream/slirp/src/libslirp.=
h:17:10: =

fatal error: 'libslirp-version.h' file not found

Am I missing something obvious?

I cannot reproduce those issues with v.5.1.0


Thanks,
Emmanuel.

