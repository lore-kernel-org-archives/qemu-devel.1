Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D7BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A91207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A91207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHudB-0005EO-7C
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 15:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@m3y3r.de>) id 1kHucS-0004o7-PP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:58:32 -0400
Received: from www17.your-server.de ([213.133.104.17]:36828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@m3y3r.de>) id 1kHucQ-000118-TE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:58:32 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www17.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <thomas@m3y3r.de>) id 1kHucJ-000460-Ud
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:58:23 +0200
Received: from [2a02:908:4c22:ec00:8ad5:993:4cda:a89f]
 (helo=localhost.localdomain)
 by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <thomas@m3y3r.de>) id 1kHucJ-000Jx3-Qj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:58:23 +0200
Date: Mon, 14 Sep 2020 21:58:21 +0200
From: Thomas Meyer <thomas@m3y3r.de>
To: qemu-devel@nongnu.org
Subject: question regarding vexpress and aarch64 secure boot
Message-ID: <20200914195821.GA571133@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25929/Sun Sep 13 15:53:46 2020)
Received-SPF: none client-ip=213.133.104.17; envelope-from=thomas@m3y3r.de;
 helo=www17.your-server.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 15:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

When trying to boot an linux kernel with

qemu-system-aarch64 -s -S -kernel /path/to/kernel -append
"console=ttyAMA0 loglevel=9 nokaslr" -dtb /path/to/dtb -M vexpress-a15 -cpu cortex-a53 -nographic

I do hit the assertion:
qemu-system-aarch64: /builddir/build/BUILD/qemu-4.2.1/hw/arm/boot.c:742: do_cpu_reset: Assertion `!info->secure_boot' failed.

which seems to come from this commit:
43118f4351c hw/arm/boot.c (Peter Maydell          2018-03-13  745)                     /* AArch64 kernels never boot in secure mode */
43118f4351c hw/arm/boot.c (Peter Maydell          2018-03-13  746)                     assert(!info->secure_boot);
43118f4351c hw/arm/boot.c (Peter Maydell          2018-03-13  747)                     /* This hook is only supported for AArch32 currently:
43118f4351c hw/arm/boot.c (Peter Maydell          2018-03-13  748)                      * bootloader_aarch64[] will not call the hook, and
43118f4351c hw/arm/boot.c (Peter Maydell          2018-03-13  749)                      * the code above has already dropped us into EL2 or EL1.
43118f4351c hw/arm/boot.c (Peter Maydell          2018-03-13  750)                      */
43118f4351c hw/arm/boot.c (Peter Maydell          2018-03-13  751)                     assert(!info->secure_board_setup);

So I did try to boot with "-machine secure=off" which makes the kernel
boot (at least a bit...), but it also seems to drop EL3 support in vexpress.c:

        if (!secure) {
            object_property_set_bool(cpuobj, "has_el3", false, NULL);
        }

which triggers arm/cpu.c:

    if (!cpu->has_el3) {
        /* If the has_el3 CPU property is disabled then we need to disable the
         * feature.
         */
        unset_feature(env, ARM_FEATURE_EL3);

my kernel then tries to determine the secure state by issuing a SCM
instruction, which leads to an undefined exception because no EL3 is
available, see arm/target/op_helper.c:

    if (!arm_feature(env, ARM_FEATURE_EL3) &&
        cpu->psci_conduit != QEMU_PSCI_CONDUIT_SMC) {
        /* If we have no EL3 then SMC always UNDEFs and can't be
         * trapped to EL2. PSCI-via-SMC is a sort of ersatz EL3
         * firmware within QEMU, and we want an EL2 guest to be able
         * to forbid its EL1 from making PSCI calls into QEMU's
         * "firmware" via HCR.TSC, so for these purposes treat
         * PSCI-via-SMC as implying an EL3.
         * This handles the very last line of the previous table.
         */
        raise_exception(env, EXCP_UDEF, syn_uncategorized(),
                        exception_target_el(env));
    }

which leads the kernel to call die()

So may question is:
is above assert wrong? Is this a bug?

I think the assert in above commit tries to prevent the boot in secure
state (vs non-secure state/NS), but I think there is a mix-up between secure state and EL3
support?

what do you think?

bug or feature?

please be gentle as I'm fairly new to qemu and aarch64 :-)

with kind regards
thomas


