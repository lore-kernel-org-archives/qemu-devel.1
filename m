Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14D4C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FE52080A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkLTiIfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FE52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHcx-0002PY-F8
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHbV-0001En-0p
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:08:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHbT-0002LF-98
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:08:48 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so3391181wme.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U6bWn24qutCEJpkcIB3Sk04svrNwgIxXmNUz2ZSTyUU=;
 b=IkLTiIfrX2BDaPHJeXntNlRbnExzljVBtiWHvuz8mU7ol5N48oEn/aEJZgwJmsXxaB
 IiMRcIVCZkX/HYvVbDXg03RIjn52IiBeeTjuo3DiIANvaRhGlM7jLZqMKOc2ktibx46X
 0p2j2CKQNFkN3LqDhdL+vHpxloea7HOFi6MTqm8mpxkt33cibzUf0a1QSZs1ksKeR2Yp
 QfAostjLF1RqLd4XAPykeff4qnqZeno5I2GVEbEjvyfXU9tyXfXLPuCtAWEEYwES/vly
 Uc/7IAnXJOVF2RNMFNgjKIgrjX8+WvRDtOGYSgifNUABNbw00oJEyZCXPdrrQjYStDXl
 D9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U6bWn24qutCEJpkcIB3Sk04svrNwgIxXmNUz2ZSTyUU=;
 b=RW6PxkC+ZMT/VKPaTCRjkzcK99vy9IdYHPGh6+r7746RYcuUMqiuIoOZ22ZwLj6ZhW
 ExULV/eJstzmEGHEgZ6vpVAWAAMFdGzjo73o2ArYsk+lwOlHth72MVTPhIHY1/pOPgEn
 Bt0PUE2DMS/4xFLiv7UE/3zW9lroFI4zvwBfI2hugOMgXgIOxON720ZyaWS4dWrqxznW
 Nz32MEUDwjU1k2DFeaYg0zrnyZ4jdyWntovzLE8QtoucLVAnEZN8Jt2U9s7YEm7MzCWH
 hCHTJqfT2oPK6GsPGrFFP+5zRJTDpWtEVOtmGVn2YRhtHryG4hFnPfRYYIvb52TMTlbv
 PY+w==
X-Gm-Message-State: AOAM531NN/GH/Lid6ak2dWqu+D3wCT954a5bcZViSVoBF14LCDvOQBNq
 8X/E/gVfAhc83AJ9z7AW3h4kyg==
X-Google-Smtp-Source: ABdhPJzOgheb48BpdEJSBIn4PcULqB/NG+9nJFS/6VQV/oOa1VDyXwe0H8isni1dARs/GxOCrJQQ4A==
X-Received: by 2002:a1c:6146:: with SMTP id v67mr4540756wmb.27.1603300124762; 
 Wed, 21 Oct 2020 10:08:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e7sm5040536wrm.6.2020.10.21.10.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:08:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D96BD1FF7E;
 Wed, 21 Oct 2020 18:08:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/4] add guest-loader (for direct Xen boot)
Date: Wed, 21 Oct 2020 18:08:38 +0100
Message-Id: <20201021170842.25762-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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

This is a refinement of the Xen loader I posted a few weeks ago.
Rather than complicate the generic loader with extra options I went
for the more expedient approach of adding a completely new device
called the guest-loader. As it didn't need to deal with any of the
subtleties of the generic-loader it also worked out somewhat simpler.

Instead of allowing the user to hand hack FDT blobs we simply add
syntactic sugar that understands the difference between a kernel and
initrd. This could be expanded in future if we want although at the
moment I don't know what else you would add.

The new syntax is now simpler:

  -device guest-loader,addr=0x42000000,kernel=Image,bootargs="console=hvc0 earlyprintk=xen" \
  -device guest-loader,addr=0x47000000,initrd=rootfs.cpio

So any objections? It would be nice to get in this cycle but we only
have a week left until soft-freeze.

Alex Bennée (4):
  hw/board: promote fdt from ARM VirtMachineState to MachineState
  hw/riscv: migrate fdt field to generic MachineState
  device_tree: add qemu_fdt_setprop_string_array helper
  hw/core: implement a guest-loader to support static hypervisor guests

 hw/core/guest-loader.h       |  34 ++++
 include/hw/arm/virt.h        |   1 -
 include/hw/boards.h          |   1 +
 include/hw/riscv/virt.h      |   1 -
 include/sysemu/device_tree.h |  17 ++
 hw/arm/virt.c                | 322 ++++++++++++++++++-----------------
 hw/core/guest-loader.c       | 140 +++++++++++++++
 hw/riscv/virt.c              |  18 +-
 softmmu/device_tree.c        |  26 +++
 hw/core/meson.build          |   2 +
 10 files changed, 398 insertions(+), 164 deletions(-)
 create mode 100644 hw/core/guest-loader.h
 create mode 100644 hw/core/guest-loader.c

-- 
2.20.1


