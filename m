Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E54C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 15:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F58206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoKXi6AA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F58206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaLZ5-0007xG-IM
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 11:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaLYM-0007NV-RM
 for qemu-devel@nongnu.org; Sun, 17 May 2020 11:50:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaLYL-0005RR-S2
 for qemu-devel@nongnu.org; Sun, 17 May 2020 11:50:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id s8so8913667wrt.9
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LJy8H+9l0u3TpNvpt8qY5LVw+b3JyrZ7vj+JoogyPOQ=;
 b=SoKXi6AAZMoUW16uOUBsuzbdvTTIbEK2TFcqdKrBQqShmL1sE4T+TjVi+IuvrsXJJN
 /TV24Cgr5W4WF2PxLRlv5fruha0RukxQ3fD4hysJbgnQvP2SUJrAdQXuwUGKZSgclUhc
 d8+K3vyNVbyw71I3IUIL69d4F46DWLLnlg5wnph76sPdGvjDGERFg8ARonSQWIXmSGhy
 5/0Sfqda6yCcW3zsWN+ys8pDRf5JeNgQOlrjwhA6+Nvl2TjvAWLNyK4+4HrZ++OMi5Kn
 iHoO9NRsN/ug2XKnOoUR2989QSEiL4k6Xj2Ejy8fW+Ue7XqD2v7sHjFPxVr7ztiPbEGS
 MX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LJy8H+9l0u3TpNvpt8qY5LVw+b3JyrZ7vj+JoogyPOQ=;
 b=k90yp1x0zAkEwjvzB4SAcJZofcDvyS1+GTdM/W9J1T1wvK6IgGzvAtumfBtemIJ3W1
 HXoI/i+jZ2x65N8VeFtWO1mTMFijcdqyPOxI6UAw5On8y9gYt6CewIrZVudupSfy/4ea
 yuww0PCOF6uuhV/IW9kyeOGl8h32wkoB4QTJjHAggBorzSoGUIpq3KP0JCgbts6QoEww
 FkRMIp0gG/4lws0d1Y0PUdnZpGCNM4QKaGRukEipTMCqIGYT7wpwMYxFlqiAtCynFPlU
 VlGQncIVeLQpEMiyFziykjmQICLyWiDcXz8lgU8cqp2K1kYOfuGHeZ2b5lao+m8xOZoC
 encg==
X-Gm-Message-State: AOAM531NzlbM6CXm1CXQq2uC7UxlTglaXRR7kU8wc06r1zZ51FxUzqmI
 uEna5m+bK9hlncn2KejDGT0=
X-Google-Smtp-Source: ABdhPJy8zOrxmRs6EwOANJwojyDJK0+cOMHObW1KPTFuVlY/H8AdiGRtfInKf5zTtHVeOTe2JBDhTQ==
X-Received: by 2002:a5d:6690:: with SMTP id l16mr15713624wru.115.1589730612530; 
 Sun, 17 May 2020 08:50:12 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m3sm12507542wrn.96.2020.05.17.08.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2020 08:50:11 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] exec: Fix (too) short device accesses
To: qemu-devel@nongnu.org, no-reply@patchew.org
References: <158972351258.15373.3545994368762600778@45ef0f9c86ae>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fbf8539a-1d92-288e-db59-5ad3285ea16a@amsat.org>
Date: Sun, 17 May 2020 17:50:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158972351258.15373.3545994368762600778@45ef0f9c86ae>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, lizhijian@cn.fujitsu.com, tony.nguyen@bt.com,
 aik@ozlabs.ru, jusual@redhat.com, peterx@redhat.com, alxndr@bu.edu,
 pbonzini@redhat.com, rth@twiddle.net, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/20 3:51 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200517113804.9063-1-f4bug@amsat.org/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>    TEST    check-qtest-x86_64: tests/qtest/tpm-crb-swtpm-test
>    TEST    check-qtest-x86_64: tests/qtest/tpm-crb-test
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/tpm-crb-test.c:53:tpm_crb_test: assertion failed (caddr > TPM_CRB_ADDR_BASE): (-1 > 4275306496)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/tpm-crb-test.c:53:tpm_crb_test: assertion failed (caddr > TPM_CRB_ADDR_BASE): (-1 > 4275306496)
> make: *** [check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
> qemu-system-aarch64: -accel kvm: invalid accelerator kvm
> qemu-system-aarch64: falling back to tcg
> ---
>    TEST    check-qtest-aarch64: tests/qtest/test-hmp
>    TEST    check-qtest-aarch64: tests/qtest/qos-test
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/sdhci-test.c:42:check_capab_capareg: assertion failed (capab == expec_capab): (0xffffffffffffffff == 0x280737ec6481)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/sdhci-test.c:42:check_capab_capareg: assertion failed (capab == expec_capab): (0xffffffffffffffff == 0x280737ec6481)
> make: *** [check-qtest-aarch64] Error 1

In both cases we abuse of 64-bit access to do 2x 32-bit ones, and there 
is no check of MEMTX_ERROR.

Actually since the memory transaction attributes are quite recent 
(2015), in most of the code there is no error check.

Quick grep for ignored return value:

hw/vfio/pci-quirks.c:1061: 
memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,
hw/vfio/pci-quirks.c:1093: 
memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,
hw/virtio/virtio-pci.c:556:    memory_region_dispatch_write(mr, addr, 
val, size_memop(len) | MO_LE,
hw/virtio/virtio-pci.c:580:    memory_region_dispatch_read(mr, addr, 
&val, size_memop(len) | MO_LE,

address_space_stl*(..., MemTxResult *result) with result = NULL:

hw/arm/aspeed.c:166:    address_space_stl_notdirty(as, 
AST_SMP_MBOX_FIELD_GOSIGN, 0,
hw/arm/boot.c:282:    address_space_stl_notdirty(as, info->smp_bootreg_addr,
hw/arm/boot.c:293:    address_space_stl_notdirty(as, p, value, \
hw/arm/highbank.c:91: 
address_space_stl_notdirty(&address_space_memory,
hw/arm/highbank.c:95: 
address_space_stl_notdirty(&address_space_memory,
hw/arm/highbank.c:99: 
address_space_stl_notdirty(&address_space_memory,
hw/i386/amd_iommu.c:162: 
address_space_stl_le(&address_space_memory, msg.address, msg.data,
hw/pci/msi.c:340:    address_space_stl_le(&dev->bus_master_as, 
msg.address, msg.data,
hw/s390x/css.c:1539:        address_space_stl(&address_space_memory, 
sch->curr_status.mba, count,
hw/sh4/r2d.c:330:        address_space_stl(&address_space_memory, 
SH7750_BCR1, 1 << 3,
target/i386/helper.c:1141:    address_space_stl_notdirty(as, addr, val, 
attrs, NULL);
target/i386/helper.c:1161:    address_space_stl(as, addr, val, attrs, NULL);
target/i386/misc_helper.c:82:    address_space_stl(&address_space_io, 
port, data,
target/xtensa/op_helper.c:214: 
address_space_stl(env->address_space_er, addr, data,

