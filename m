Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DA1C83007
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 22:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24E5206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 22:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5iYIpG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24E5206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTYIt-0002Tw-Nz
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 18:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jTYHR-0001Lw-Bd
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 18:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jTYGx-0003lx-KC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 18:00:41 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:35311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jTYGx-0003lh-6u
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 18:00:11 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id t12so5080380oot.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=2tvEASnXUSKymBXcF8m1LXzBlFSReQNEA1hj8jSxLyA=;
 b=n5iYIpG2EaKugbiIPrHzivmctJL/PfIHCHVLFQf5lWswnSEaYznDiqNqWKfR3joIS2
 rE/GgA3zrqxRSRCa0KjvO+/HsCUn0OXsJhNOd0HXoH3LmJ7gZ64kGHxgCqICUMIJOKMg
 73sJ5ypjQzhzvcN0NMPPqlcO7IzjVSuw8go9EQpM2sMIvZOfA32ImWvxWxLoP2QGH4i8
 J/DOqWjzhzbahISCsVQFwxceLyf9koWDsKEzCOUl0merq8ZHlAwZKo1glTaL3TC+9FNq
 G3mL/hXd5kRtTO2IDw8A9bu3tSnV3hcpyIYPe5jawLPAswAinDJkBNLR0PLUlllpcTmK
 XX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=2tvEASnXUSKymBXcF8m1LXzBlFSReQNEA1hj8jSxLyA=;
 b=pY6xMSFZFsrb4GFf6OgUxVhMzGd+ExsH4rxaDbeBXdw4XPYpiS8UtrKFoD1poQED9m
 72wlq7wvh3Kqq8nnPkwEcFgER1ensooei90qjv4lay1Ib7062tB1Gcqb+tco80ShBXzB
 2h6ZXQwXqsC833plxyclz8vQcF+AZmQiBCdEGuuynMSTYGCAOOMgfdgm1ClGN4sSJ+O4
 MNvcGAItdd30jRmi2Gb+PcfXtPB992Q0oBQqd4lClxe51bB//rWBwImtbx6Zeeunvsh2
 NafOzHC27NlKvTzXJxRC9oev0zp7wvajJsymRF35YqbocTZX77tD/nzMfulyrFs1GzwI
 EX9A==
X-Gm-Message-State: AGi0PuZPosMRM2FG+TS3cejzttjKh+wWNcnH6Fp/r8DQCljnR7vokaYJ
 mLvB//rBtx7KSfV0PE5JazY=
X-Google-Smtp-Source: APiQypIDylmyi0ibePkLLalSLIDNxh1oYJW374x8Y3xwk7LKCkEKazQTUyo1CIDblp/GfDvI+HC8Gw==
X-Received: by 2002:a4a:e688:: with SMTP id u8mr22470126oot.65.1588111209587; 
 Tue, 28 Apr 2020 15:00:09 -0700 (PDT)
Received: from localhost ([2600:1700:70:e488:68c5:7d63:aa93:5eb])
 by smtp.gmail.com with ESMTPSA id x4sm5056516otp.74.2020.04.28.15.00.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 28 Apr 2020 15:00:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <158811120356.21490.10859203295112388157@sif>
Subject: [ANNOUNCE] QEMU 5.0.0 is now available
Date: Tue, 28 Apr 2020 17:00:03 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc2a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::c2a
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

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 5.0.0 release. This release contains 2800+ commits from 232
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/5.0

Highlights include:

 * Support for passing host filesystem directory to guest via virtiofsd
 * Live migration support for external processes running on QEMU D-Bus
 * Support for using memory backends for main/"built-in" guest RAM
 * block: support for compressed backup images via block jobs
 * block: qemu-img: 'measure' command now supports LUKS images, 'convert'
   command now supports skipping zero'ing of target image
 * block: experimental support for qemu-storage-daemon, which provides acce=
ss
   to QEMU block-layer/QMP features like blocks jobs or built-in NBD server
   without starting a full VM

 * ARM: support for the following architecture features:
        ARMv8.1 VHE/VMID16/PAN/PMU
        ARMv8.2 UAO/DCPoP/ATS1E1/TTCNP
        ARMv8.3 RCPC/CCIDX
        ARMv8.4 PMU/RCPC
 * ARM: support for Cortex-M7 CPU
 * ARM: new board support for tacoma-bmc, Netduino Plus 2, and Orangepi PC
 * ARM: 'virt' machine now supports vTPM and virtio-iommu devices
 * HPPA: graphical console support via HP Artist graphics device
 * MIPS: support for GINVT (global TLB invalidation) instruction
 * PowerPC: 'pseries' machine no longer requires reboot to negotiate between
   XIVE/XICS interrupt controllers when ic-mode=3Ddual
 * PowerPC: 'powernv' machine can now emulate KVM hardware acceleration to =
run
   KVM guests while in TCG mode
 * PowerPC: support for file-backed NVDIMMs for persistent memory emulation
 * RISC-V: 'virt' and 'sifive_u' boards now support generic syscon drivers =
in
   Linux to control power/reboot
 * RISC-V: 'virt' board now supports Goldfish RTC
 * RISC-V: experimental support for v0.5 of draft hypervisor extension
 * s390: support for Adapter Interrupt Suppression while running in KVM mode

 * and lots more...

Thank you to everyone involved!


