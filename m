Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DD6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736C320872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synology.com header.i=@synology.com header.b="D9HFnw4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736C320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aTl-0002ou-Jy
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andychiu@synology.com>) id 1i7aSG-0001Y2-Vx
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andychiu@synology.com>) id 1i7aSC-0002d6-Di
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:20:48 -0400
Received: from mail.synology.com ([211.23.38.101]:39913 helo=synology.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andychiu@synology.com>)
 id 1i7aS2-0002Y7-Rj; Tue, 10 Sep 2019 03:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
 t=1568100031; bh=XxGIZRetHEHpy1xc2C5pzP4xUOpULeRAcsZ0qj5fH9w=;
 h=From:Subject:To:Cc:References:Date:In-Reply-To;
 b=D9HFnw4St83Lcr+zhSvHlDgmRP76qtx1SoVWU8QcxPe5uCVxLEMpvCJc5f84drf0a
 rERqghL/L3ZtZA6UDvWb5my8vyv7uA/Df4lmKRHipqI2CqcG49AmacaPTKM3BEUSTN
 Cps67ACTJmEVu9dYaON1Xp7Dje9nyrpDj3PdotkY=
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com
References: <1568049517-10261-1-git-send-email-andychiu@synology.com>
 <6eb1dbda-85fe-de7c-613c-a6871fc2d28f@redhat.com>
Message-ID: <2c725a24-1da4-f46f-7811-06cb1e533a78@synology.com>
Date: Tue, 10 Sep 2019 15:20:31 +0800
MIME-Version: 1.0
In-Reply-To: <6eb1dbda-85fe-de7c-613c-a6871fc2d28f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 211.23.38.101
Subject: Re: [Qemu-devel] [PATCH] ahci: enable pci bus master MemoryRegion
 before loading ahci engines
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
From: Andy via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Andy <andychiu@synology.com>
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi John,

Sorry I'm re-sending this mail due to format issue in the last one.

This issue can only be reproduced on Windows 10.
I've observed and compared the behavior of Windows 10 and Windows 7.
It seems Windows 7 wouldn't disable the PCI_COMMAND_MASTER flag
when disabling ahci devices. That's why this issue won't happen on Win7.

Here's the trace log on both guest OS, on disabling and re-engaging SATA=20
disk:

Windows 10, disabling SATA disk:

ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:=20
0x00040000
handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
0x00: 27 80 ea 00 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:=20
0x00080000
handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
0x00: 27 80 e0 00 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:GHC] @ 0x4:=20
0x0000000080000000
pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x507
pci_cfg_write ich9-ahci 26:0 @0x82 <- 0x80
pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x500
pci_update_mappings_del d=3D0x7f6da4eb0b20 00:1a.0 4,0xc0a0+0x20
pci_update_mappings_del d=3D0x7f6da4eb0b20 00:1a.0 5,0xfebf1000+0x1000
-------------------------------------------------------------------

Windows 10, re-engaging SATA disk:

pci_cfg_write ich9-ahci 26:0 @0x14 <- 0x0
pci_cfg_write ich9-ahci 26:0 @0x18 <- 0x0
pci_cfg_write ich9-ahci 26:0 @0x1c <- 0x0
pci_cfg_write ich9-ahci 26:0 @0x20 <- 0xc0a0
pci_cfg_write ich9-ahci 26:0 @0x24 <- 0xfebf1000
pci_cfg_write ich9-ahci 26:0 @0x30 <- 0x0
pci_cfg_write ich9-ahci 26:0 @0x3c <- 0x0
pci_cfg_write ich9-ahci 26:0 @0xc <- 0x0
pci_cfg_write ich9-ahci 26:0 @0xd <- 0x0
pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x500
pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x507
pci_update_mappings_add d=3D0x7f6da4eb0b20 00:1a.0 4,0xc0a0+0x20
pci_update_mappings_add d=3D0x7f6da4eb0b20 00:1a.0 5,0xfebf1000+0x1000
pci_cfg_write ich9-ahci 26:0 @0x6 <- 0xf900
pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x507
pci_cfg_write ich9-ahci 26:0 @0x82 <- 0x80
pci_cfg_write ich9-ahci 26:0 @0x84 <- 0xfee0100c
pci_cfg_write ich9-ahci 26:0 @0x88 <- 0x0
pci_cfg_write ich9-ahci 26:0 @0x8c <- 0x49a1
pci_cfg_write ich9-ahci 26:0 @0x82 <- 0x81
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:GHC] @ 0x4:=20
0x0000000080000002
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCLB] @ 0x0:=20
0x7fe9f000
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCLBU] @ 0x4:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxFB] @ 0x8:=20
0x7fe9f400
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxFBU] @ 0xc:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCLB] @ 0x0:=20
0x7fea5000
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCLBU] @ 0x4:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxFB] @ 0x8:=20
0x7fea5400
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxFBU] @ 0xc:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCLB] @ 0x0:=20
0x7feab000
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCLBU] @ 0x4:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxFB] @ 0x8:=20
0x7feab400
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxFBU] @ 0xc:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCLB] @ 0x0:=20
0x7feb1000
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCLBU] @ 0x4:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxFB] @ 0x8:=20
0x7feb1400
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxFBU] @ 0xc:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCLB] @ 0x0:=20
0x7feb7000
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCLBU] @ 0x4:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxFB] @ 0x8:=20
0x7feb7400
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxFBU] @ 0xc:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCLB] @ 0x0:=20
0x7fe99000
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCLBU] @ 0x4:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxFB] @ 0x8:=20
0x7fe99400
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxFBU] @ 0xc:=20
0x00000000
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:=20
0x0000c016
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:=20
0x00004006
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PXIE] @ 0x14:=20
0x7d00000f
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxSCTL] @ 0x2c:=20
0x00000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxSCTL] @ 0x2c:=20
0x00000000
ahci_reset_port ahci(0x7f6da4eb1400)[0]: reset port
ide_reset IDEstate 0x7f6da4eb39f0
ide_reset IDEstate 0x7f6da4eb3dc0
ahci_set_signature ahci(0x7f6da4eb1400)[0]: set signature sector:0x01=20
nsector:0x01 lcyl:0x00 hcyl:0x00 (cumulatively: 0x00000101)
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PXIE] @ 0x14:=20
0x7d40004f
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:=20
0x00000016
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0xffffffff
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PXIE] @ 0x14:=20
0x7d40004f
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:=20
0x00004017
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:=20
0x00000001
handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
0x00: 27 80 ef 66 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:=20
0x00000001
handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
0x00: 27 80 ef 66 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:=20
0x00000001
handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
0x00: 27 80 f5 00 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:=20
0x00000001
handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
0x00: 27 80 ef 02 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:=20
0x00100000
handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
0x00: 27 80 42 00 00 00 00 e0 00 00 00 00 01 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:=20
0x00200000
handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
0x00: 27 80 b0 d8 01 4f c2 a0 00 00 00 00 01 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:=20
0x00400000
handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
0x00: 27 80 ec 00 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_populate_sglist ahci(0x7f6da4eb1400)[0]
ahci_dma_prepare_buf ahci(0x7f6da4eb1400)[0]: prepare buf limit=3D512=20
prepared=3D512
ahci_start_transfer ahci(0x7f6da4eb1400)[0]: reading 512 bytes on ata w/=20
sglist
ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000003
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxIS] @ 0x10:=20
0xffffffff
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000002
ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PXIE] @ 0x14:=20
0x7d40004f
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxIS] @ 0x10:=20
0xffffffff
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000004
ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PXIE] @ 0x14:=20
0x7d40004f
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxIS] @ 0x10:=20
0xffffffff
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000008
ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PXIE] @ 0x14:=20
0x7d40004f
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxIS] @ 0x10:=20
0xffffffff
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000010
ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PXIE] @ 0x14:=20
0x7d40004f
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:=20
0x00000006
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxIS] @ 0x10:=20
0xffffffff
ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:=20
0x0000000000000020
ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PXIE] @ 0x14:=20
0x7d40004f
-------------------------------------------------------------------

Windows 7, disabling SATA disk:

ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:=20
0x00020000
handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
0x00: 27 80 ea 00 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:=20
0x00040000
handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
0x00: 27 80 e0 00 00 00 00 00 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
-------------------------------------------------------------------

Windows 7, re-engaging SATA disk:

ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:=20
0x00002000
handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
0x00: 27 80 ef 66 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:=20
0x00004000
handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
0x00: 27 80 f5 00 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:=20
0x00008000
handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
0x00: 27 80 ef 02 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:=20
0x00010000
handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
0x00: 27 80 ec 00 00 00 00 a0 00 00 00 00 00 00 00 00
0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

ahci_populate_sglist ahci(0x7fcc4e19b4a0)[0]
ahci_dma_prepare_buf ahci(0x7fcc4e19b4a0)[0]: prepare buf limit=3D512=20
prepared=3D512
ahci_start_transfer ahci(0x7fcc4e19b4a0)[0]: reading 512 bytes on ata w/=20
sglist
ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30:=20
0xffffffff
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000001
ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:=20
0x00000002
ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:=20
0x0000000000000001
-------------------------------------------------------------------


--
Best regards,
Andy Chiu

On 2019/9/10 =E4=B8=8A=E5=8D=882:13, John Snow wrote:
> On 9/9/19 1:18 PM, andychiu via Qemu-devel wrote:
>> If Windows 10 guests have enabled 'turn off hard disk after idle'
>> option in power settings, and the guest has a SATA disk plugged in,
>> the SATA disk will be turned off after a specified idle time.
>> If the guest is live migrated or saved/loaded with its SATA disk
>> turned off, the following error will occur:
>>
>> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS =
receive buffer address
>> qemu-system-x86_64: Failed to load ich9_ahci:ahci
>> qemu-system-x86_64: error while loading state for instance 0x0 of devi=
ce '0000:00:1a.0/ich9_ahci'
>> qemu-system-x86_64: load of migration failed: Operation not permitted
>>
> Oof. That can't have been fun to discover.
>
>> Observation from trace logs shows that a while after Windows 10 turns =
off
>> a SATA disk (IDE disks don't have the following behavior),
>> it will disable the PCI_COMMAND_MASTER flag of the pci device containi=
ng
>> the ahci device. When the the disk is turning back on,
>> the PCI_COMMAND_MASTER flag will be restored first.
>> But if the guest is migrated or saved/loaded while the disk is off,
>> the post_load callback of ahci device, ahci_state_post_load(), will fa=
il
>> at ahci_cond_start_engines() if the MemoryRegion
>> pci_dev->bus_master_enable_region is not enabled, with pci_dev pointin=
g
>> to the PCIDevice struct containing the ahci device.
>>
>> This patch enables pci_dev->bus_master_enable_region before calling
>> ahci_cond_start_engines() in ahci_state_post_load(), and restore the
>> MemoryRegion to its original state afterwards.>
> This looks good to me from an AHCI perspective, but I'm not as clear on
> the implications of toggling the MemoryRegion, so I have some doubts.
>
>
> MST, can you chime in and clear my confusion?
>
> I suppose when the PCI_COMMAND_MASTER bit is turned off, we disable the
> memory region, as a guest would be unable to establish a new mapping in
> this time, so it makes sense that the attempt to map it fails.
>
> What's less clear to me is what happens to existing mappings when a
> region is disabled. Are they invalidated? If so, does it make sense tha=
t
> we are trying to establish a mapping here at all? Maybe it's absolutely
> correct that this fails.
>
> (I suppose, though, that the simple toggling of the region won't be a
> guest-visible event, so it's probably safe to do. Right?)
>
> What I find weird for AHCI is this: We try to engage the CLB mapping
> before the FIS mapping, but we fail at the FIS mapping. So why is
> PORT_CMD_FIS_RX set while PORT_CMD_START is unset?
>
> It kind of looks like we only half-heartedly stopped the AHCI device.
> Maybe that's just what Windows does, but I wonder if there's a bug wher=
e
> we're erroneously leaving PORT_CMD_FIS_RX set when we've been disabled.
> It seems like the guest would need to re-set the mappings anyway, so
> maybe trying to restore a stale mapping is not the right thing to do.
>
>
>
> Andy, if you have traces left over: What AHCI registers does Windows
> touch when it disables the AHCI device? What registers does it touch
> when it re-engages it?
>
> I just want to make sure I'm not leaving something dangling by accident=
.
>
> --js
>
>> Signed-off-by: andychiu<andychiu@synology.com>
>> ---
>>   hw/ide/ahci.c | 53 ++++++++++++++++++++++++++++++++++++-------------=
----
>>   1 file changed, 36 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index d45393c..83f8c30 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -1649,33 +1649,52 @@ static const VMStateDescription vmstate_ahci_d=
evice =3D {
>>       },
>>   };
>>  =20
>> +static int ahci_state_load_engines(AHCIState *s, AHCIDevice *ad)
>> +{
>> +    AHCIPortRegs *pr =3D &ad->port_regs;
>> +    DeviceState *dev_state =3D s->container;
>> +    PCIDevice *pci_dev =3D (PCIDevice *) object_dynamic_cast(OBJECT(d=
ev_state),
>> +                                                           TYPE_PCI_D=
EVICE);
>> +    bool pci_bus_master_enabled =3D pci_dev->bus_master_enable_region=
.enabled;
>> +
>> +    if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_ON)) =
{
>> +        error_report("AHCI: DMA engine should be off, but status bit =
"
>> +                     "indicates it is still running.");
>> +        return -1;
>> +    }
>> +    if (!(pr->cmd & PORT_CMD_FIS_RX) && (pr->cmd & PORT_CMD_FIS_ON)) =
{
>> +        error_report("AHCI: FIS RX engine should be off, but status b=
it "
>> +                     "indicates it is still running.");
>> +        return -1;
>> +    }
>> +
>> +    memory_region_set_enabled(&pci_dev->bus_master_enable_region, tru=
e);
>> +
>> +    /*
>> +     * After a migrate, the DMA/FIS engines are "off" and
>> +     * need to be conditionally restarted
>> +     */
>> +    pr->cmd &=3D ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
>> +    if (ahci_cond_start_engines(ad) !=3D 0) {
>> +        return -1;
>> +    }
>> +    memory_region_set_enabled(&pci_dev->bus_master_enable_region,
>> +                              pci_bus_master_enabled);
>> +
>> +    return 0;
>> +}
>> +
>>   static int ahci_state_post_load(void *opaque, int version_id)
>>   {
>>       int i, j;
>>       struct AHCIDevice *ad;
>>       NCQTransferState *ncq_tfs;
>> -    AHCIPortRegs *pr;
>>       AHCIState *s =3D opaque;
>>  =20
>>       for (i =3D 0; i < s->ports; i++) {
>>           ad =3D &s->dev[i];
>> -        pr =3D &ad->port_regs;
>> -
>> -        if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_O=
N)) {
>> -            error_report("AHCI: DMA engine should be off, but status =
bit "
>> -                         "indicates it is still running.");
>> -            return -1;
>> -        }
>> -        if (!(pr->cmd & PORT_CMD_FIS_RX) && (pr->cmd & PORT_CMD_FIS_O=
N)) {
>> -            error_report("AHCI: FIS RX engine should be off, but stat=
us bit "
>> -                         "indicates it is still running.");
>> -            return -1;
>> -        }
>>  =20
>> -        /* After a migrate, the DMA/FIS engines are "off" and
>> -         * need to be conditionally restarted */
>> -        pr->cmd &=3D ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
>> -        if (ahci_cond_start_engines(ad) !=3D 0) {
>> +        if (ahci_state_load_engines(s, ad)) {
>>               return -1;
>>           }
>>  =20
>>

