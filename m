Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F28C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08FE2063A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVMkPebO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08FE2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Qct-0004Jb-15
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 17:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k3Qc6-0003sb-Ag
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 17:06:18 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k3Qc4-0000Af-2C
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 17:06:17 -0400
Received: by mail-ot1-x335.google.com with SMTP id t7so20656820otp.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=hT+eQLgR0M4dFUAEvqnQEr8yJksS2Tqs27V64vQkmJg=;
 b=TVMkPebOOvHxXjv5qseD+grtLa4wy+ZaE4d87FjEVeQsko6C9zpJRo/cXjZTe5EIYR
 9Z26Ei6ArJt+GCKEXapPFy39eED1jM49KXYp9HCp9245vKc6umlXRSIBwzzJOAMq1YNC
 aFJreDcPKtzDUxVWebyWGa/X4LG5UTDQV8SVskf1PiUuuHBBF6bqvVhbSGgOcJr1XgR0
 ecrLJblqV5RuMdu2/Sah9DBAyvAwjXAGjnzbuIM1WHawvehfT00d69QA+BnF6VykvMcW
 j5/ors2LGu1cmvfLKw02rLJ+YOHhFOkAAZJfYl8kWqkSETA2W/I33PWrmu3jTjX8nZqm
 mEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=hT+eQLgR0M4dFUAEvqnQEr8yJksS2Tqs27V64vQkmJg=;
 b=X2p2JpkUjtzw1/QNTMJIwY/cY+G6KCfA+5E/62asHqUAdlNSGxaMNbEJXs/P3qLDF6
 6uv3IaFmr/jdJwDZU10flrcrCJLGXZcb2cy7aM5XoPtDSu7999qc7vyECWOzaPKOkbbV
 s2Ugmb/jl8HxX9iJbpddm4kUGY2sP/cHYpkG08cJqAcQ2cx5SGiIx3QHi0+mLBKZFbtq
 TFBBBVOeo81cUe3GNVoLSBN8dmfaQ6GZ8D0Q9oYei6awcgmMy8ASjWi5zsk0I+OkMi/Y
 fpG1oCjXe6ojPgmfOcUcmYJebXPc0FLzIyMqSfoP3u03KAseDkWgdb81vEwnQtSxO3ku
 Estg==
X-Gm-Message-State: AOAM532MbSJ9+rwbW0RdEd43lFxTWJSNWcgKQNnsrGHo5CYomwyw0Il3
 ofTNPiG9IFpmveLjZkZYWyw=
X-Google-Smtp-Source: ABdhPJwpYL/bMMDnFPT8OpASD0j0GpYaaqPv0xGmYmqrCFgE10CYR5dY1WBFn46ImpcOwh5E7cGSEQ==
X-Received: by 2002:a9d:4c12:: with SMTP id l18mr4585483otf.260.1596661574172; 
 Wed, 05 Aug 2020 14:06:14 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id k1sm687937oic.2.2020.08.05.14.06.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Aug 2020 14:06:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <159666156839.15098.4166343745625824849@sif>
Subject: [ANNOUNCE] QEMU 5.1.0-rc3 is now available
Date: Wed, 05 Aug 2020 16:06:08 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 5.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-5.1.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-5.1.0-rc3.tar.xz.sig

A note from the maintainer:

  Unless any last minute release-critical bugs are discovered, this will
  be the last release candidate before we release 5.1. (If anything
  does turn up, as usual we'll roll another rc and do the full release
  a bit later than scheduled).

You can help improve the quality of the QEMU 5.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/5.1

Please add entries to the ChangeLog for the 5.1 release below:

  http://wiki.qemu.org/ChangeLog/5.1

Thank you to everyone involved!

Changes since rc2:

e1d322c405: Update version for v5.1.0-rc3 release (Peter Maydell)
a65dabf71a: target/arm: Fix Rt/Rt2 in ESR_ELx for copro traps from AArch32 =
to 64 (Peter Maydell)
348fcc4f7a: qcow2-cluster: Fix integer left shift error in qcow2_alloc_clus=
ter_link_l2() (Tuguoyi)
d2a71d7474: Get rid of the libqemustub.a remainders (Thomas Huth)
35c7f5254b: target/riscv/vector_helper: Fix build on 32-bit big endian host=
s (Thomas Huth)
5896c53954: gitlab-ci: Fix Avocado cache usage (Thomas Huth)
699616db64: gitlab-ci.yml: Add build-system-debian and build-system-centos =
jobs (Thomas Huth)
4d6862ffc7: tests/acceptance: Disable the rx sash and arm cubieboard replay=
 test on Gitlab (Thomas Huth)
1caac1c0e4: tests/docker: Add python3-venv and netcat to the debian-amd64 c=
ontainer (Thomas Huth)
facc68516a: virtio-mem: Correct format specifier mismatch for RISC-V (Bruce=
 Rogers)
d250bb19ce: target/arm: Fix decode of LDRA[AB] instructions (Peter Collingb=
ourne)
ffdfca6fac: docs/devel: Document decodetree no-overlap groups (Richard Hend=
erson)
8e0ef06894: accel/xen: Fix xen_enabled() behavior on target-agnostic object=
s (Philippe Mathieu-Daud=C3=A9)
035e69b063: hw/net/net_tx_pkt: fix assertion failure in net_tx_pkt_add_raw_=
fragment() (Mauro Matteo Cascella)
f81cddfe8a: colo-compare: Remove superfluous NULL-pointer checks for s->iot=
hread (Lukas Straub)
13557fd392: hw/timer/imx_epit: Avoid assertion when CR.SWR is written (Pete=
r Maydell)
ce4f70e81e: hw/arm/nrf51_soc: Set system_clock_scale (Peter Maydell)
88a90e3de6: target/arm: Avoid maybe-uninitialized warning with gcc 4.9 (Kai=
ge Li)
8796fe40dd: target/arm: Fix AddPAC error indication (Richard Henderson)
fc6bb6e67e: msf2-soc, stellaris: Don't wire up SYSRESETREQ (Peter Maydell)
9e60d759d3: hw/intc/armv7m_nvic: Provide default "reset the system" behavio=
ur for SYSRESETREQ (Peter Maydell)
faf7c6de34: include/hw/irq.h: New function qemu_irq_is_connected() (Peter M=
aydell)
e7e5a9595a: hw/arm/netduino2, netduinoplus2: Set system_clock_scale (Peter =
Maydell)
edadc99a2e: iotests/169: Test source cont with backing bmap (Max Reitz)
fe16c7ddf8: qcow2: Release read-only bitmaps when inactivated (Max Reitz)
f7160f3218: schemas: Add vim modeline (Andrea Bolognani)
fbeed19761: qapi: Delete unwanted indentation of top-level expressions (Mar=
kus Armbruster)
6ac3f1e799: qapi/machine.json: Fix missing newline in doc comment (Peter Ma=
ydell)
1f42e24699: seabios: update to master snapshot (Gerd Hoffmann)
000822441e: tracetool: carefully define SDT_USE_VARIADIC (Stefan Hajnoczi)
148d25e0f6: s390x/s390-virtio-ccw: fix off-by-one in loadparm getter (Halil=
 Pasic)
1b7157be3a: trace/simple: Allow enabling simple traces from command line (J=
osh DuBois)

