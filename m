Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7941BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BFB22265
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lt0YhTZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BFB22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvtX-00061N-3Y
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvrw-0004Ig-Nb
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvru-0001Ix-PN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id x7so2451725wrl.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UKB3B/oOABY9cP+HWO8RbNw0KpptfT1tg2NNxPLwvWg=;
 b=Lt0YhTZxl33eEKvrr7u4yyDiJHBnforevQ9Pte7p4PmbGh5XgSFMw9nqnJkgiMbXc3
 WXyKlnxQ0E4A2CnNJ/hoBBdVSXE++oKBHeJ/FYU6jDeFUtV8tHjSlBMFzccEohMx4NOX
 5NHv/yi2PxAKzPZ8j6Abu7lZcoDIX4QfRPcjf4FSNOUkvSBYtugl5u0y7PTBEhCHIivD
 AxeLeKoBH1SGVn9dleZ5eSNT9BPABebm3aR95PklKSB1U9jeI62wZscBONpAYPCuUaDf
 Q3hJ6XjkpaOKqLh3A2mBjeXq1qE0CCHh/lNh7OSLEoEeP2esW0j87+IM5TPETFE0X88H
 AAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UKB3B/oOABY9cP+HWO8RbNw0KpptfT1tg2NNxPLwvWg=;
 b=sPdoXX55VaZVrTIPooagqDJ7JoQWQ2ka2LIPMMelA+1poXpkc/tlJ1s1HYiUyLXZbu
 tmhZSdwe4ZiI3N+yZIZlDkriEbGjLUhMojrlsPoiZ4YZiOQQMKaFlogSkVsX0hFuV+W+
 kLL9uIJ9I+P0UtSq05NNYjmeHNe9NOakTIki8CUEd/09bKmbOE+6QsFuROnX143XJ8b9
 RVgrYu76T2iMRozHid82A1XJq0LObxC8aB8kppt0U14RsEngjs2XpN5EYQVUYxHvmwp0
 SoTDOufefZT0EZVx3YUf/h1gcJRwxmfPBRLyBoWsJYdjPZJwCe27pOyL7MdIa5D1UpUY
 aqIw==
X-Gm-Message-State: AOAM531ssr3vQbhegivulUQgxbjxNrB6BJvBY75Rl+s5uAJwpF7Oykl1
 bxDQu/bI5EeoOfOECCRbwCHoQA==
X-Google-Smtp-Source: ABdhPJwg8uO7dXx0hESM8JGyAxT4TshaogFZNee63Rd2Jb8BN2V/JnFUcDWvqAX7Z+uC1/I8Nf43DQ==
X-Received: by 2002:adf:ba85:: with SMTP id p5mr2332196wrg.64.1602263265176;
 Fri, 09 Oct 2020 10:07:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm12119778wrt.1.2020.10.09.10.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 10:07:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 00F741FF7E;
 Fri,  9 Oct 2020 18:07:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  0/4] generic loader FDT support (for direct Xen boot)
Date: Fri,  9 Oct 2020 18:07:38 +0100
Message-Id: <20201009170742.23695-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series adds the ability to append FDT data for blobs loaded by
the generic loader. My principle use-case was to be able to directly
boot Xen with a kernel image which avoided having to:

  - get the kernel image into my system image
  - deal with bugs in FDT munging by -bios firmware and/or grub

as such this currently a developer hack that makes *my* life easy and
is thus presented as an RFC for discussion. While I've tested it with
Xen I'm sure the approach would be applicable to other hypervisors or
firmware which expect to consume FDT data pointing at various blobs.

An example command line that launches this is (magic from -kernel):

  ./aarch64-softmmu/qemu-system-aarch64 -cpu cortex-a57 \
    -machine type=virt,virtualization=on -display none \
    -serial mon:stdio \
    -netdev user,id=unet,hostfwd=tcp::2222-:22 \
    -device virtio-net-pci,netdev=unet,id=virt-net,disable-legacy=on \
    -device virtio-scsi-pci,id=virt-scsi,disable-legacy=on \
    -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-buster-arm64 \
    -device scsi-hd,drive=hd,id=virt-scsi-hd \
    -smp 4 -m 4096 \
    -kernel ~/lsrc/xen.git/xen/xen \
    -append "dom0_mem=1G,max:1G loglvl=all guest_loglvl=all" \
    -device loader,addr=0x47000000,file=$HOME/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image,len-fdt-compat=2,fdt-compat[0]='multiboot,,module',fdt-compat[1]='multiboot,,kernel',fdt-bootargs="root=/dev/sda2 ro console=hvc0 earlyprintk=xen"

So a couple of choices I've made doing this:

Promoting *fdt to MachineState

This seemed the simplest approach to making the fdt available to the
global state, especially as MachineState already has a *dtb pointer.
I've converted the ARM virt machine and a RISCV machine but if this is
acceptable I can convert the others.

"Polluting" the generic loader arguments

This was mainly out of convenience as the loader already knows the
size of the blob being loaded. However you could certainly argue it
makes sense to have a more generic "FDT expander" virtual device that
could for example query the QOM model somehow to find the details it
needs.

FDT isn't the only way of passing system information up the boot
chain. We could reasonably want to do a similar thing with ACPI which
is what should be being used on SBSA like devices to communicate with
the hypervisor.

Also relying on ,, in the QemuOpt parser is ugly. It might be worth
having better quoting support if I press on with this.

So what do people think? Something worth developing?


Alex Bennée (4):
  hw/board: promote fdt from ARM VirtMachineState to MachineState
  hw/riscv: migrate fdt field to generic MachineState
  device_tree: add qemu_fdt_setprop_string_array helper
  generic_loader: allow the insertion of /chosen/module stanzas

 include/hw/arm/virt.h            |   1 -
 include/hw/boards.h              |   1 +
 include/hw/core/generic-loader.h |   4 +
 include/hw/riscv/virt.h          |   1 -
 include/sysemu/device_tree.h     |  17 ++
 device_tree.c                    |  26 +++
 hw/arm/virt.c                    | 322 ++++++++++++++++---------------
 hw/core/generic-loader.c         |  42 ++++
 hw/riscv/virt.c                  |  18 +-
 9 files changed, 268 insertions(+), 164 deletions(-)

-- 
2.20.1


