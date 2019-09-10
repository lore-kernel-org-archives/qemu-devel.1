Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046BEC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96A42089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96A42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hjD-0002u2-NQ
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i7hSE-0001AT-Le
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i7hSA-0006xm-Re
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:49:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i7hS1-0006s8-9r; Tue, 10 Sep 2019 10:49:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98B7588384B;
 Tue, 10 Sep 2019 14:49:00 +0000 (UTC)
Received: from [10.10.120.64] (ovpn-120-64.rdu2.redhat.com [10.10.120.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C6F55DC18;
 Tue, 10 Sep 2019 14:48:53 +0000 (UTC)
To: Andy <andychiu@synology.com>, qemu-devel@nongnu.org, mst@redhat.com
References: <1568049517-10261-1-git-send-email-andychiu@synology.com>
 <6eb1dbda-85fe-de7c-613c-a6871fc2d28f@redhat.com>
 <2c725a24-1da4-f46f-7811-06cb1e533a78@synology.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9f1c2d09-e521-3a27-d345-8fa5a8662b7c@redhat.com>
Date: Tue, 10 Sep 2019 10:48:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2c725a24-1da4-f46f-7811-06cb1e533a78@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 10 Sep 2019 14:49:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/10/19 3:20 AM, Andy wrote:
> Hi John,
>=20
> Sorry I'm re-sending this mail due to format issue in the last one.
>=20

No problem at all. Thank you for the detailed logs, it's really helpful.

> This issue can only be reproduced on Windows 10.
> I've observed and compared the behavior of Windows 10 and Windows 7.
> It seems Windows 7 wouldn't disable the PCI_COMMAND_MASTER flag
> when disabling ahci devices. That's why this issue won't happen on Win7=
.
>=20
> Here's the trace log on both guest OS, on disabling and re-engaging SAT=
A
> disk:
>=20
> Windows 10, disabling SATA disk:
>=20
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:
> 0x00040000
> handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
> 0x00: 27 80 ea 00 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:
> 0x00080000
> handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
> 0x00: 27 80 e0 00 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:GHC] @ 0x4:
> 0x0000000080000000
> pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x507
> pci_cfg_write ich9-ahci 26:0 @0x82 <- 0x80
> pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x500
> pci_update_mappings_del d=3D0x7f6da4eb0b20 00:1a.0 4,0xc0a0+0x20
> pci_update_mappings_del d=3D0x7f6da4eb0b20 00:1a.0 5,0xfebf1000+0x1000

! It doesn't look like windows changes the PxCMD registers at all, it's
trying to clear AHCI Enable (AE) instead.

GHC's bits are:

0: HBA Reset (HR), RW1
1: Interrupt Enable (IE), RW
2: MSI Revert to Single Message (MSRM), Read Only
31: AHCI Enable (AE)


It looks like it's trying to disable the AHCI device in this manner, but
I'm not sure that makes sense; it's not really a spin-down or sleep comma=
nd.

Our implementation for AHCI sets HOST_CAP_AHCI, which is CAP.SAM in the
spec -- "Supports AHCI-mode Only" -- which means that AHCI Enable is
supposed to be RO and set to '1'. I'm not sure what Windows is trying to
do here -- it might assume that this is a true-blue ICH9 and it can
switch off the AHCI engine with a quirk.

It's not immediately clear to me what QEMU should do when it sees this
behavior.

> -------------------------------------------------------------------
>=20
> Windows 10, re-engaging SATA disk:
>=20
> pci_cfg_write ich9-ahci 26:0 @0x14 <- 0x0
> pci_cfg_write ich9-ahci 26:0 @0x18 <- 0x0
> pci_cfg_write ich9-ahci 26:0 @0x1c <- 0x0
> pci_cfg_write ich9-ahci 26:0 @0x20 <- 0xc0a0
> pci_cfg_write ich9-ahci 26:0 @0x24 <- 0xfebf1000
> pci_cfg_write ich9-ahci 26:0 @0x30 <- 0x0
> pci_cfg_write ich9-ahci 26:0 @0x3c <- 0x0
> pci_cfg_write ich9-ahci 26:0 @0xc <- 0x0
> pci_cfg_write ich9-ahci 26:0 @0xd <- 0x0
> pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x500
> pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x507
> pci_update_mappings_add d=3D0x7f6da4eb0b20 00:1a.0 4,0xc0a0+0x20
> pci_update_mappings_add d=3D0x7f6da4eb0b20 00:1a.0 5,0xfebf1000+0x1000
> pci_cfg_write ich9-ahci 26:0 @0x6 <- 0xf900
> pci_cfg_write ich9-ahci 26:0 @0x4 <- 0x507
> pci_cfg_write ich9-ahci 26:0 @0x82 <- 0x80
> pci_cfg_write ich9-ahci 26:0 @0x84 <- 0xfee0100c
> pci_cfg_write ich9-ahci 26:0 @0x88 <- 0x0
> pci_cfg_write ich9-ahci 26:0 @0x8c <- 0x49a1
> pci_cfg_write ich9-ahci 26:0 @0x82 <- 0x81
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:GHC] @ 0x4:
> 0x0000000080000002

Not sure what that 8 is. Some vendor-specific thing that the real ICH9
might implement.

> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCLB] @ 0x0:
> 0x7fe9f000
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCLBU] @ 0x4:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxFB] @ 0x8:
> 0x7fe9f400
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxFBU] @ 0xc:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCLB] @ 0x0:
> 0x7fea5000
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCLBU] @ 0x4:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxFB] @ 0x8:
> 0x7fea5400
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxFBU] @ 0xc:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCLB] @ 0x0:
> 0x7feab000
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCLBU] @ 0x4:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxFB] @ 0x8:
> 0x7feab400
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxFBU] @ 0xc:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCLB] @ 0x0:
> 0x7feb1000
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCLBU] @ 0x4:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxFB] @ 0x8:
> 0x7feb1400
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxFBU] @ 0xc:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCLB] @ 0x0:
> 0x7feb7000
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCLBU] @ 0x4:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxFB] @ 0x8:
> 0x7feb7400
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxFBU] @ 0xc:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCLB] @ 0x0:
> 0x7fe99000
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCLBU] @ 0x4:
> 0x00000000
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxFB] @ 0x8:
> 0x7fe99400
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxFBU] @ 0xc:
> 0x00000000

So it does rewrite the mappings when it re-engages anyway. Might be safe
to ignore the mapping failures and just turn off the engines and see
what windows does.

> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:
> 0x0000c016

0xc016 ...

1100 0000 0001 0110

0: ~PORT_CMD_START
1: PORT_CMD_SPIN_UP
2: PORT_CMD_POWER_ON
3: ~PORT_CMD_CLO
4: PORT_CMD_FIS_RX
...
14: PORT_CMD_FIS_ON
15: PORT_CMD_LIST_ON


Turning FIS RX on but not engaging the CLB yet.

> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:
> 0x00004006

0100 0000 0000 0110

1: PORT_CMD_SPIN_UP
2: PORT_CMD_POWER_ON
14: PORT_CMD_FIS_ON

We're requesting FIS RX off.

> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PXIE] @ 0x14:

(Just now noticing I typo'd PxIE as PXIE. Oops.)



Well, I'd love to have a conclusion for you but I don't right now. Maybe
it's best to just fudge it for now with something like this:

post-migrate, if PCI_COMMAND_MASTER is off, skip trying to re-map
FIS/CLB addresses. If we do so, toggle the related engage and status
bits off.

It's a hack, but I don't know what the right thing to do is and don't
have the time presently to investigate more deeply.

> 0x7d00000f
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxSCTL] @ 0x2c=
:
> 0x00000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxSCTL] @ 0x2c=
:
> 0x00000000
> ahci_reset_port ahci(0x7f6da4eb1400)[0]: reset port
> ide_reset IDEstate 0x7f6da4eb39f0
> ide_reset IDEstate 0x7f6da4eb3dc0
> ahci_set_signature ahci(0x7f6da4eb1400)[0]: set signature sector:0x01
> nsector:0x01 lcyl:0x00 hcyl:0x00 (cumulatively: 0x00000101)
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PXIE] @ 0x14:
> 0x7d40004f
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:
> 0x00000016
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0xffffffff
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PXIE] @ 0x14:
> 0x7d40004f
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCMD] @ 0x18:
> 0x00004017
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:
> 0x00000001
> handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
> 0x00: 27 80 ef 66 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:
> 0x00000001
> handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
> 0x00: 27 80 ef 66 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:
> 0x00000001
> handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
> 0x00: 27 80 f5 00 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:
> 0x00000001
> handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
> 0x00: 27 80 ef 02 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:
> 0x00100000
> handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
> 0x00: 27 80 42 00 00 00 00 e0 00 00 00 00 01 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:
> 0x00200000
> handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
> 0x00: 27 80 b0 d8 01 4f c2 a0 00 00 00 00 01 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxCI] @ 0x38:
> 0x00400000
> handle_cmd_fis_dump ahci(0x7f6da4eb1400)[0]: FIS:
> 0x00: 27 80 ec 00 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_populate_sglist ahci(0x7f6da4eb1400)[0]
> ahci_dma_prepare_buf ahci(0x7f6da4eb1400)[0]: prepare buf limit=3D512
> prepared=3D512
> ahci_start_transfer ahci(0x7f6da4eb1400)[0]: reading 512 bytes on ata w=
/
> sglist
> ahci_cmd_done ahci(0x7f6da4eb1400)[0]: cmd done
> ahci_port_write ahci(0x7f6da4eb1400)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000003
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PxIS] @ 0x10:
> 0xffffffff
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000002
> ahci_port_write ahci(0x7f6da4eb1400)[1]: port write [reg:PXIE] @ 0x14:
> 0x7d40004f
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PxIS] @ 0x10:
> 0xffffffff
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000004
> ahci_port_write ahci(0x7f6da4eb1400)[2]: port write [reg:PXIE] @ 0x14:
> 0x7d40004f
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PxIS] @ 0x10:
> 0xffffffff
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000008
> ahci_port_write ahci(0x7f6da4eb1400)[3]: port write [reg:PXIE] @ 0x14:
> 0x7d40004f
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PxIS] @ 0x10:
> 0xffffffff
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000010
> ahci_port_write ahci(0x7f6da4eb1400)[4]: port write [reg:PXIE] @ 0x14:
> 0x7d40004f
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxCMD] @ 0x18:
> 0x00000006
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PxIS] @ 0x10:
> 0xffffffff
> ahci_mem_write_host ahci(0x7f6da4eb1400) write4 [reg:IS] @ 0x8:
> 0x0000000000000020
> ahci_port_write ahci(0x7f6da4eb1400)[5]: port write [reg:PXIE] @ 0x14:
> 0x7d40004f
> -------------------------------------------------------------------
>=20
> Windows 7, disabling SATA disk:
>=20
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:
> 0x00020000
> handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
> 0x00: 27 80 ea 00 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:
> 0x00040000
> handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
> 0x00: 27 80 e0 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> -------------------------------------------------------------------
>=20
> Windows 7, re-engaging SATA disk:
>=20
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:
> 0x00002000
> handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
> 0x00: 27 80 ef 66 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:
> 0x00004000
> handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
> 0x00: 27 80 f5 00 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:
> 0x00008000
> handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
> 0x00: 27 80 ef 02 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxCI] @ 0x38:
> 0x00010000
> handle_cmd_fis_dump ahci(0x7fcc4e19b4a0)[0]: FIS:
> 0x00: 27 80 ec 00 00 00 00 a0 00 00 00 00 00 00 00 00
> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> ahci_populate_sglist ahci(0x7fcc4e19b4a0)[0]
> ahci_dma_prepare_buf ahci(0x7fcc4e19b4a0)[0]: prepare buf limit=3D512
> prepared=3D512
> ahci_start_transfer ahci(0x7fcc4e19b4a0)[0]: reading 512 bytes on ata w=
/
> sglist
> ahci_cmd_done ahci(0x7fcc4e19b4a0)[0]: cmd done
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxSERR] @ 0x30=
:
> 0xffffffff
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000001
> ahci_port_write ahci(0x7fcc4e19b4a0)[0]: port write [reg:PxIS] @ 0x10:
> 0x00000002
> ahci_mem_write_host ahci(0x7fcc4e19b4a0) write4 [reg:IS] @ 0x8:
> 0x0000000000000001
> -------------------------------------------------------------------
>=20
>=20
> --=20
> Best regards,
> Andy Chiu
>=20
> On 2019/9/10 =E4=B8=8A=E5=8D=882:13, John Snow wrote:
>> On 9/9/19 1:18 PM, andychiu via Qemu-devel wrote:
>>> If Windows 10 guests have enabled 'turn off hard disk after idle'
>>> option in power settings, and the guest has a SATA disk plugged in,
>>> the SATA disk will be turned off after a specified idle time.
>>> If the guest is live migrated or saved/loaded with its SATA disk
>>> turned off, the following error will occur:
>>>
>>> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS
>>> receive buffer address
>>> qemu-system-x86_64: Failed to load ich9_ahci:ahci
>>> qemu-system-x86_64: error while loading state for instance 0x0 of
>>> device '0000:00:1a.0/ich9_ahci'
>>> qemu-system-x86_64: load of migration failed: Operation not permitted
>>>
>> Oof. That can't have been fun to discover.
>>
>>> Observation from trace logs shows that a while after Windows 10 turns
>>> off
>>> a SATA disk (IDE disks don't have the following behavior),
>>> it will disable the PCI_COMMAND_MASTER flag of the pci device contain=
ing
>>> the ahci device. When the the disk is turning back on,
>>> the PCI_COMMAND_MASTER flag will be restored first.
>>> But if the guest is migrated or saved/loaded while the disk is off,
>>> the post_load callback of ahci device, ahci_state_post_load(), will f=
ail
>>> at ahci_cond_start_engines() if the MemoryRegion
>>> pci_dev->bus_master_enable_region is not enabled, with pci_dev pointi=
ng
>>> to the PCIDevice struct containing the ahci device.
>>>
>>> This patch enables pci_dev->bus_master_enable_region before calling
>>> ahci_cond_start_engines() in ahci_state_post_load(), and restore the
>>> MemoryRegion to its original state afterwards.>
>> This looks good to me from an AHCI perspective, but I'm not as clear o=
n
>> the implications of toggling the MemoryRegion, so I have some doubts.
>>
>>
>> MST, can you chime in and clear my confusion?
>>
>> I suppose when the PCI_COMMAND_MASTER bit is turned off, we disable th=
e
>> memory region, as a guest would be unable to establish a new mapping i=
n
>> this time, so it makes sense that the attempt to map it fails.
>>
>> What's less clear to me is what happens to existing mappings when a
>> region is disabled. Are they invalidated? If so, does it make sense th=
at
>> we are trying to establish a mapping here at all? Maybe it's absolutel=
y
>> correct that this fails.
>>
>> (I suppose, though, that the simple toggling of the region won't be a
>> guest-visible event, so it's probably safe to do. Right?)
>>
>> What I find weird for AHCI is this: We try to engage the CLB mapping
>> before the FIS mapping, but we fail at the FIS mapping. So why is
>> PORT_CMD_FIS_RX set while PORT_CMD_START is unset?
>>
>> It kind of looks like we only half-heartedly stopped the AHCI device.
>> Maybe that's just what Windows does, but I wonder if there's a bug whe=
re
>> we're erroneously leaving PORT_CMD_FIS_RX set when we've been disabled=
.
>> It seems like the guest would need to re-set the mappings anyway, so
>> maybe trying to restore a stale mapping is not the right thing to do.
>>
>>
>>
>> Andy, if you have traces left over: What AHCI registers does Windows
>> touch when it disables the AHCI device? What registers does it touch
>> when it re-engages it?
>>
>> I just want to make sure I'm not leaving something dangling by acciden=
t.
>>
>> --js
>>
>>> Signed-off-by: andychiu<andychiu@synology.com>
>>> ---
>>> =C2=A0 hw/ide/ahci.c | 53
>>> ++++++++++++++++++++++++++++++++++++-----------------
>>> =C2=A0 1 file changed, 36 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>>> index d45393c..83f8c30 100644
>>> --- a/hw/ide/ahci.c
>>> +++ b/hw/ide/ahci.c
>>> @@ -1649,33 +1649,52 @@ static const VMStateDescription
>>> vmstate_ahci_device =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> =C2=A0 };
>>> =C2=A0 +static int ahci_state_load_engines(AHCIState *s, AHCIDevice *=
ad)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 AHCIPortRegs *pr =3D &ad->port_regs;
>>> +=C2=A0=C2=A0=C2=A0 DeviceState *dev_state =3D s->container;
>>> +=C2=A0=C2=A0=C2=A0 PCIDevice *pci_dev =3D (PCIDevice *)
>>> object_dynamic_cast(OBJECT(dev_state),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> TYPE_PCI_DEVICE);
>>> +=C2=A0=C2=A0=C2=A0 bool pci_bus_master_enabled =3D
>>> pci_dev->bus_master_enable_region.enabled;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & POR=
T_CMD_LIST_ON)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("AHCI: DMA e=
ngine should be off, but status bit "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "indicates it is stil=
l running.");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!(pr->cmd & PORT_CMD_FIS_RX) && (pr->cmd & PO=
RT_CMD_FIS_ON)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("AHCI: FIS R=
X engine should be off, but status
>>> bit "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "indicates it is stil=
l running.");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 memory_region_set_enabled(&pci_dev->bus_master_en=
able_region,
>>> true);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * After a migrate, the DMA/FIS engines are =
"off" and
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * need to be conditionally restarted
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 pr->cmd &=3D ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON=
);
>>> +=C2=A0=C2=A0=C2=A0 if (ahci_cond_start_engines(ad) !=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 memory_region_set_enabled(&pci_dev->bus_master_en=
able_region,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_bus_master_enabled);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> =C2=A0 static int ahci_state_post_load(void *opaque, int version_id)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, j;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct AHCIDevice *ad;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NCQTransferState *ncq_tfs;
>>> -=C2=A0=C2=A0=C2=A0 AHCIPortRegs *pr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AHCIState *s =3D opaque;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s->ports; i++=
) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad =3D &s->dev=
[i];
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr =3D &ad->port_regs;
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(pr->cmd & PORT_CMD_=
START) && (pr->cmd &
>>> PORT_CMD_LIST_ON)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("AHCI: DMA engine should be off, but status
>>> bit "
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "indicates it is still running.");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -1;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(pr->cmd & PORT_CMD_=
FIS_RX) && (pr->cmd &
>>> PORT_CMD_FIS_ON)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("AHCI: FIS RX engine should be off, but
>>> status bit "
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "indicates it is still running.");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -1;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* After a migrate=
, the DMA/FIS engines are "off" and
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * need to be condit=
ionally restarted */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr->cmd &=3D ~(PORT_CMD_L=
IST_ON | PORT_CMD_FIS_ON);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ahci_cond_start_engin=
es(ad) !=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ahci_state_load_engin=
es(s, ad)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0

--=20
=E2=80=94js

