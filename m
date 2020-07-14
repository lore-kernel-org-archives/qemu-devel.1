Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21568C433EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E984320760
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E984320760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLL2-0005aT-2C
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1jvLJD-00037i-NM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:49:23 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:10839)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1jvLJA-0002K2-Fq
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:49:23 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 06EDjtoJ074611;
 Tue, 14 Jul 2020 15:45:55 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 06EDjtCV011096; Tue, 14 Jul 2020 15:45:55 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 06EDjtif011095;
 Tue, 14 Jul 2020 15:45:55 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 0/6] CTU CAN FD core support - patchew report
Date: Tue, 14 Jul 2020 15:45:54 +0200
User-Agent: KMail/1.9.10
References: <159473087133.2008.6283012861257625888@07a7f0d89f7d>
In-Reply-To: <159473087133.2008.6283012861257625888@07a7f0d89f7d>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202007141545.54577.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 06EDjtoJ074611
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.414, required 6, autolearn=not spam, BAYES_00 -0.50,
 KHOP_HELO_FCRDNS 0.09, NICE_REPLY_A -0.00, SPF_HELO_NONE 0.00,
 SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1595339160.41143@vR8/Edg2yylM96culGlDIw
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 09:49:16
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Cc: marex@denx.de, jnovak@fel.cvut.cz, stefanha@gmail.com,
 deniz.eren@icloud.com, armbru@redhat.com, o.rempel@pengutronix.de,
 frederic.konrad@adacore.com, jan.kiszka@siemens.com, charvj10@fel.cvut.cz,
 socketcan@hartkopp.net, pbonzini@redhat.com, ondrej.ille@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello everybody,

On Tuesday 14 of July 2020 14:47:53 no-reply@patchew.org wrote:
> /tmp/qemu-test/src/hw/net/can/ctucan_pci.c: In function
> 'ctucan_pci_id_cra_io_read':
> /tmp/qemu-test/src/hw/net/can/ctucan_pci.c:105:20: error: format '%lx'
> expects argument of type 'long unsigned int', but argument 2 has type
> 'hwaddr' {aka 'long long unsigned int'} [-Werror=format=] 105 |    
> printf("addr=%lx,size=%x,tmp=%lx\n", addr, size, tmp);

excuse me, I have overlooked this printf used during debugging.
We fix that.

As for the following reported problem with formating, I am not sure
what to do. The hardware registers layout header files files are generated 
from CACTUS/IP-XACT XML fromat sources same as VHDL implementation
of registers accesses and fields.

The top level tool (pyXact_generator) is under our control (Ondrej Ille
is an author). Problem is, that tool output has been tuned to match
Linux kernel requirements, but QEMU has incompatible requirements
for indentation. Manual style correction in files is not a right
way to go. Adding switch for QEMU style to pyXact_generator
is possible but then header files intended for the Linux kernel
cannot be compared with corresponding QEMU ones and generally,
configurable setup and multiple options to generate files
would lead to mess. We take directly header files from main
CTU CAN FD IP core repository where match between sources and generated
files is checked as continuous integration step.


On Tuesday 14 of July 2020 14:48:50 no-reply@patchew.org wrote:
> Patchew URL:
> https://patchew.org/QEMU/cover.1594725647.git.pisa@cmp.felk.cvut.cz/
...
> === OUTPUT BEGIN ===
> 1/6 Checking commit 28bfb20d4aa8 (net/can: Initial host SocketCan support
> for CAN FD.) 2/6 Checking commit d9207e106794 (hw/net/can: sja1000 ignore
> CAN FD frames) 3/6 Checking commit 733ab67ddcc2 (net/can: Add can_dlc2len
> and can_len2dlc for CAN FD.) 4/6 Checking commit dc95d778bb88
> (hw/net/can/ctucafd: Add CTU CAN FD core register definitions.) WARNING:
> added, moved or deleted file(s), does MAINTAINERS need updating? #30:
> new file mode 100644
>
> WARNING: Block comments use a leading /* on a separate line
> #36: FILE: hw/net/can/ctu_can_fd_frame.h:2:
> +/*************************************************************************
>******
>
> WARNING: architecture specific defines should be avoided
> #67: FILE: hw/net/can/ctu_can_fd_frame.h:33:
> +#ifndef __CTU_CAN_FD_CAN_FD_FRAME_FORMAT__
>
> ERROR: code indent should never use tabs
> #72: FILE: hw/net/can/ctu_can_fd_frame.h:38:
> +^ICTU_CAN_FD_FRAME_FORM_W        = 0x0,$
>
> ERROR: code indent should never use tabs
> #73: FILE: hw/net/can/ctu_can_fd_frame.h:39:
> +^ICTU_CAN_FD_IDENTIFIER_W        = 0x4,$

> ERROR: code indent should never use tabs
> #221: FILE: hw/net/can/ctu_can_fd_frame.h:187:
> +^I} s;$
>
> WARNING: Block comments use a leading /* on a separate line
> #232: FILE: hw/net/can/ctu_can_fd_regs.h:2:
> +/*************************************************************************
>******
>
> WARNING: architecture specific defines should be avoided
> #263: FILE: hw/net/can/ctu_can_fd_regs.h:33:
> +#ifndef __CTU_CAN_FD_CAN_FD_REGISTER_MAP__
>
> ERROR: code indent should never use tabs
> #268: FILE: hw/net/can/ctu_can_fd_regs.h:38:
> +^ICTU_CAN_FD_DEVICE_ID             = 0x0,$
>
> ERROR: code indent should never use tabs
> #269: FILE: hw/net/can/ctu_can_fd_regs.h:39:
> +^ICTU_CAN_FD_VERSION               = 0x2,$
>
> ERROR: code indent should never use tabs
> #270: FILE: hw/net/can/ctu_can_fd_regs.h:40:
> +^ICTU_CAN_FD_MODE                  = 0x4,$

As for the functionality, the solution has been tested only for little-endian
guests and host systems for now. I am not fully sure how things map on 
different variants of big-endian systems and how well they would match
reality. Generally, the Linux driver is written such way that it detects
switched byte order and should adapt for it automatically.

I can try some MIPS based system, if the check result is important.
But it would worth to have even real HW to compare real programmed
PCIe card behavior and I do not pose Linux capable big endian systems.
I have some safety based Cortex-R big endian ARMS there, but they do not
have PCIe and QEMU support.

Thanks for review and suggestions in advance,

                Pavel
-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/


