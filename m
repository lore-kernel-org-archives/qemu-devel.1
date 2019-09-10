Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E81DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A56D2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synology.com header.i=@synology.com header.b="rFs8rN5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A56D2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Zib-0003u5-BY
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andychiu@synology.com>) id 1i7Zhl-0003Sb-PN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andychiu@synology.com>) id 1i7Zhf-0005cd-PZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:32:45 -0400
Received: from mail.synology.com ([211.23.38.101]:55787 helo=synology.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andychiu@synology.com>)
 id 1i7ZhQ-0005IP-Ls; Tue, 10 Sep 2019 02:32:26 -0400
Received: from Mail (localhost [127.0.0.1])
 by synology.com (Postfix) with ESMTPA id 630987E86D71;
 Tue, 10 Sep 2019 14:32:19 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
 t=1568097139; bh=40tz3Y/HMUfCsH5USENJboAffHYOPSAro2kRnbdKfo4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=rFs8rN5TRJC8MdOizCy3X70vmCZK1KkkAuxlOc+dViDxAHIEtZ7XrxkXdoX0g9hv5
 ihp+6CGHWsXRG+GMCBkDS2vW6tYpDGSa3ZEVO3nB/wPzJJbf8C2ENQXVza/OIOIUOr
 gro1vOPrml+lz5AR0JTRN7Z3paWfvt+b2H/4WFPM=
Date: Tue, 10 Sep 2019 14:32:19 +0800
To: "John Snow" <jsnow@redhat.com>
Message-ID: <0e4181b5-2e0c-4664-8e1a-be030a258d44@Mail>
In-Reply-To: <6eb1dbda-85fe-de7c-613c-a6871fc2d28f@redhat.com>
References: <1568049517-10261-1-git-send-email-andychiu@synology.com>
 <6eb1dbda-85fe-de7c-613c-a6871fc2d28f@redhat.com>
MIME-Version: 1.0
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 211.23.38.101
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
From: andychiu via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: andychiu <andychiu@synology.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi John, This issue can only be reproduced on Windows 10. I've observed a=
nd compared the behavior of Windows 10 and Windows 7. It seems Windows 7 =
wouldn't disable the PCI=5FCOMMAND=5FMASTER flag when disabling ahci devi=
ces. That's why this issue won't happen on Win7. Here's the trace log on =
both guest OS, on disabling and re-engaging SATA disk: Windows 10, disabl=
ing SATA disk: ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port writ=
e =5Breg:PxCI=5D =40 0x38: 0x00040000 handle=5Fcmd=5Ffis=5Fdump ahci(0x7f=
6da4eb1400)=5B0=5D: =46IS: 0x00: 27 80 ea 00 00 00 00 a0 00 00 00 00 00 0=
0 00 00 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x20: 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x30: 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x60: 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 0x70: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 ahci=5Fcmd=5Fdone ahci(0x7f6da4eb1400)=5B0=5D: cmd d=
one ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:Px=
IS=5D =40 0x10: 0x00000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400)=
 write4 =5Breg:IS=5D =40 0x8: 0x0000000000000001 ahci=5Fport=5Fwrite ahci=
(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxCI=5D =40 0x38: 0x00080000 h=
andle=5Fcmd=5Ffis=5Fdump ahci(0x7f6da4eb1400)=5B0=5D: =46IS: 0x00: 27 80 =
e0 00 00 00 00 a0 00 00 00 00 00 00 00 00 0x10: 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x40: 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 0x50: 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ahci=5Fcmd=5Fdone =
ahci(0x7f6da4eb1400)=5B0=5D: cmd done ahci=5Fport=5Fwrite ahci(0x7f6da4eb=
1400)=5B0=5D: port write =5Breg:PxIS=5D =40 0x10: 0x00000001 ahci=5Fmem=5F=
write=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:IS=5D =40 0x8: 0x00000000=
00000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:GHC=
=5D =40 0x4: 0x0000000080000000 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =400x4 <=
- 0x507 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =400x82 <- 0x80 pci=5Fcfg=5Fwrit=
e ich9-ahci 26:0 =400x4 <- 0x500 pci=5Fupdate=5Fmappings=5Fdel d=3D0x7f6d=
a4eb0b20 00:1a.0 4,0xc0a0+0x20 pci=5Fupdate=5Fmappings=5Fdel d=3D0x7f6da4=
eb0b20 00:1a.0 5,0xfebf1000+0x1000 --------------------------------------=
--------------------------------------------------- Windows 10, re-engagi=
ng SATA disk: pci=5Fcfg=5Fwrite ich9-ahci 26:0 =400x14 <- 0x0 pci=5Fcfg=5F=
write ich9-ahci 26:0 =400x18 <- 0x0 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =400=
x1c <- 0x0 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =400x20 <- 0xc0a0 pci=5Fcfg=5F=
write ich9-ahci 26:0 =400x24 <- 0xfebf1000 pci=5Fcfg=5Fwrite ich9-ahci 26=
:0 =400x30 <- 0x0 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =400x3c <- 0x0 pci=5Fc=
fg=5Fwrite ich9-ahci 26:0 =400xc <- 0x0 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =
=400xd <- 0x0 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =400x4 <- 0x500 pci=5Fcfg=5F=
write ich9-ahci 26:0 =400x4 <- 0x507 pci=5Fupdate=5Fmappings=5Fadd d=3D0x=
7f6da4eb0b20 00:1a.0 4,0xc0a0+0x20 pci=5Fupdate=5Fmappings=5Fadd d=3D0x7f=
6da4eb0b20 00:1a.0 5,0xfebf1000+0x1000 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =40=
0x6 <- 0xf900 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =400x4 <- 0x507 pci=5Fcfg=5F=
write ich9-ahci 26:0 =400x82 <- 0x80 pci=5Fcfg=5Fwrite ich9-ahci 26:0 =40=
0x84 <- 0xfee0100c pci=5Fcfg=5Fwrite ich9-ahci 26:0 =400x88 <- 0x0 pci=5F=
cfg=5Fwrite ich9-ahci 26:0 =400x8c <- 0x49a1 pci=5Fcfg=5Fwrite ich9-ahci =
26:0 =400x82 <- 0x81 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write=
4 =5Breg:GHC=5D =40 0x4: 0x0000000080000002 ahci=5Fport=5Fwrite ahci(0x7f=
6da4eb1400)=5B1=5D: port write =5Breg:PxCLB=5D =40 0x0: 0x7fe9f000 ahci=5F=
port=5Fwrite ahci(0x7f6da4eb1400)=5B1=5D: port write =5Breg:PxCLBU=5D =40=
 0x4: 0x00000000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B1=5D: port wr=
ite =5Breg:Px=46B=5D =40 0x8: 0x7fe9f400 ahci=5Fport=5Fwrite ahci(0x7f6da=
4eb1400)=5B1=5D: port write =5Breg:Px=46BU=5D =40 0xc: 0x00000000 ahci=5F=
port=5Fwrite ahci(0x7f6da4eb1400)=5B1=5D: port write =5Breg:PxCMD=5D =40 =
0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B2=5D: port wr=
ite =5Breg:PxCLB=5D =40 0x0: 0x7fea5000 ahci=5Fport=5Fwrite ahci(0x7f6da4=
eb1400)=5B2=5D: port write =5Breg:PxCLBU=5D =40 0x4: 0x00000000 ahci=5Fpo=
rt=5Fwrite ahci(0x7f6da4eb1400)=5B2=5D: port write =5Breg:Px=46B=5D =40 0=
x8: 0x7fea5400 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B2=5D: port writ=
e =5Breg:Px=46BU=5D =40 0xc: 0x00000000 ahci=5Fport=5Fwrite ahci(0x7f6da4=
eb1400)=5B2=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fpo=
rt=5Fwrite ahci(0x7f6da4eb1400)=5B3=5D: port write =5Breg:PxCLB=5D =40 0x=
0: 0x7feab000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B3=5D: port write=
 =5Breg:PxCLBU=5D =40 0x4: 0x00000000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb=
1400)=5B3=5D: port write =5Breg:Px=46B=5D =40 0x8: 0x7feab400 ahci=5Fport=
=5Fwrite ahci(0x7f6da4eb1400)=5B3=5D: port write =5Breg:Px=46BU=5D =40 0x=
c: 0x00000000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B3=5D: port write=
 =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb=
1400)=5B4=5D: port write =5Breg:PxCLB=5D =40 0x0: 0x7feb1000 ahci=5Fport=5F=
write ahci(0x7f6da4eb1400)=5B4=5D: port write =5Breg:PxCLBU=5D =40 0x4: 0=
x00000000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B4=5D: port write =5B=
reg:Px=46B=5D =40 0x8: 0x7feb1400 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400=
)=5B4=5D: port write =5Breg:Px=46BU=5D =40 0xc: 0x00000000 ahci=5Fport=5F=
write ahci(0x7f6da4eb1400)=5B4=5D: port write =5Breg:PxCMD=5D =40 0x18: 0=
x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B5=5D: port write =5B=
reg:PxCLB=5D =40 0x0: 0x7feb7000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=
=5B5=5D: port write =5Breg:PxCLBU=5D =40 0x4: 0x00000000 ahci=5Fport=5Fwr=
ite ahci(0x7f6da4eb1400)=5B5=5D: port write =5Breg:Px=46B=5D =40 0x8: 0x7=
feb7400 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B5=5D: port write =5Bre=
g:Px=46BU=5D =40 0xc: 0x00000000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=
=5B5=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwr=
ite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxCLB=5D =40 0x0: 0x7f=
e99000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg=
:PxCLBU=5D =40 0x4: 0x00000000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B=
0=5D: port write =5Breg:Px=46B=5D =40 0x8: 0x7fe99400 ahci=5Fport=5Fwrite=
 ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:Px=46BU=5D =40 0xc: 0x000=
00000 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:=
PxCMD=5D =40 0x18: 0x0000c016 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B=
0=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00004006 ahci=5Fport=5Fwrite=
 ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PXIE=5D =40 0x14: 0x7d000=
00f ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:Px=
SCTL=5D =40 0x2c: 0x00000001 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=
=5D: port write =5Breg:PxSCTL=5D =40 0x2c: 0x00000000 ahci=5Freset=5Fport=
 ahci(0x7f6da4eb1400)=5B0=5D: reset port ide=5Freset IDEstate 0x7f6da4eb3=
9f0 ide=5Freset IDEstate 0x7f6da4eb3dc0 ahci=5Fset=5Fsignature ahci(0x7f6=
da4eb1400)=5B0=5D: set signature sector:0x01 nsector:0x01 lcyl:0x00 hcyl:=
0x00 (cumulatively: 0x00000101) ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B=
0=5D: port write =5Breg:PXIE=5D =40 0x14: 0x7d40004f ahci=5Fport=5Fwrite =
ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxSERR=5D =40 0x30: 0xffff=
ffff ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:P=
xCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=
=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000016 ahci=5Fport=5Fwrite =
ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxIS=5D =40 0x10: 0x000000=
01 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:IS=5D =40=
 0x8: 0x0000000000000001 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D:=
 port write =5Breg:PxSERR=5D =40 0x30: 0xffffffff ahci=5Fport=5Fwrite ahc=
i(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxIS=5D =40 0x10: 0xffffffff =
ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:IS=5D =40 0x=
8: 0x0000000000000001 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: po=
rt write =5Breg:PXIE=5D =40 0x14: 0x7d40004f ahci=5Fport=5Fwrite ahci(0x7=
f6da4eb1400)=5B0=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00004017 ahci=
=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxCI=5D =40=
 0x38: 0x00000001 handle=5Fcmd=5Ffis=5Fdump ahci(0x7f6da4eb1400)=5B0=5D: =
=46IS: 0x00: 27 80 ef 66 00 00 00 a0 00 00 00 00 00 00 00 00 0x10: 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x20: 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x50: 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 0x60: 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 ahci=5Fcmd=5Fdone ahci(0x7f6da4eb1400)=5B0=5D: cmd done ahci=5Fport=5Fwr=
ite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxIS=5D =40 0x10: 0x00=
000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:IS=5D=
 =40 0x8: 0x0000000000000001 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=
=5D: port write =5Breg:PxCI=5D =40 0x38: 0x00000001 handle=5Fcmd=5Ffis=5F=
dump ahci(0x7f6da4eb1400)=5B0=5D: =46IS: 0x00: 27 80 ef 66 00 00 00 a0 00=
 00 00 00 00 00 00 00 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x30: 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 0x40: 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x70: 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 ahci=5Fcmd=5Fdone ahci(0x7f6da4eb1400)=
=5B0=5D: cmd done ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port w=
rite =5Breg:PxIS=5D =40 0x10: 0x00000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0=
x7f6da4eb1400) write4 =5Breg:IS=5D =40 0x8: 0x0000000000000001 ahci=5Fpor=
t=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxCI=5D =40 0x38=
: 0x00000001 handle=5Fcmd=5Ffis=5Fdump ahci(0x7f6da4eb1400)=5B0=5D: =46IS=
: 0x00: 27 80 f5 00 00 00 00 a0 00 00 00 00 00 00 00 00 0x10: 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 0x20: 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x50: 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 0x60: 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ahci=
=5Fcmd=5Fdone ahci(0x7f6da4eb1400)=5B0=5D: cmd done ahci=5Fport=5Fwrite a=
hci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxIS=5D =40 0x10: 0x0000000=
1 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:IS=5D =40 =
0x8: 0x0000000000000001 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: =
port write =5Breg:PxCI=5D =40 0x38: 0x00000001 handle=5Fcmd=5Ffis=5Fdump =
ahci(0x7f6da4eb1400)=5B0=5D: =46IS: 0x00: 27 80 ef 02 00 00 00 a0 00 00 0=
0 00 00 00 00 00 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x=
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x30: 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 0x40: 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x60:=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x70: 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 ahci=5Fcmd=5Fdone ahci(0x7f6da4eb1400)=5B0=5D=
: cmd done ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port write =5B=
reg:PxIS=5D =40 0x10: 0x00000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4e=
b1400) write4 =5Breg:IS=5D =40 0x8: 0x0000000000000001 ahci=5Fport=5Fwrit=
e ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxCI=5D =40 0x38: 0x0010=
0000 handle=5Fcmd=5Ffis=5Fdump ahci(0x7f6da4eb1400)=5B0=5D: =46IS: 0x00: =
27 80 42 00 00 00 00 e0 00 00 00 00 01 00 00 00 0x10: 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x40: 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x50: 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ahci=5Fcmd=5F=
done ahci(0x7f6da4eb1400)=5B0=5D: cmd done ahci=5Fport=5Fwrite ahci(0x7f6=
da4eb1400)=5B0=5D: port write =5Breg:PxIS=5D =40 0x10: 0x00000001 ahci=5F=
mem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:IS=5D =40 0x8: 0x00=
00000000000001 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port writ=
e =5Breg:PxCI=5D =40 0x38: 0x00200000 handle=5Fcmd=5Ffis=5Fdump ahci(0x7f=
6da4eb1400)=5B0=5D: =46IS: 0x00: 27 80 b0 d8 01 4f c2 a0 00 00 00 00 01 0=
0 00 00 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x20: 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x30: 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x60: 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 0x70: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 ahci=5Fcmd=5Fdone ahci(0x7f6da4eb1400)=5B0=5D: cmd d=
one ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:Px=
IS=5D =40 0x10: 0x00000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400)=
 write4 =5Breg:IS=5D =40 0x8: 0x0000000000000001 ahci=5Fport=5Fwrite ahci=
(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxCI=5D =40 0x38: 0x00400000 h=
andle=5Fcmd=5Ffis=5Fdump ahci(0x7f6da4eb1400)=5B0=5D: =46IS: 0x00: 27 80 =
ec 00 00 00 00 a0 00 00 00 00 00 00 00 00 0x10: 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x40: 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 0x50: 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ahci=5Fpopulate=5F=
sglist ahci(0x7f6da4eb1400)=5B0=5D ahci=5Fdma=5Fprepare=5Fbuf ahci(0x7f6d=
a4eb1400)=5B0=5D: prepare buf limit=3D512 prepared=3D512 ahci=5Fstart=5Ft=
ransfer ahci(0x7f6da4eb1400)=5B0=5D: reading 512 bytes on ata w/ sglist a=
hci=5Fcmd=5Fdone ahci(0x7f6da4eb1400)=5B0=5D: cmd done ahci=5Fport=5Fwrit=
e ahci(0x7f6da4eb1400)=5B0=5D: port write =5Breg:PxIS=5D =40 0x10: 0x0000=
0003 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:IS=5D =40=
 0x8: 0x0000000000000001 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B5=5D:=
 port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci=
(0x7f6da4eb1400)=5B4=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 =
ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B3=5D: port write =5Breg:PxCMD=5D=
 =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B2=5D: po=
rt write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x=
7f6da4eb1400)=5B1=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahc=
i=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B1=5D: port write =5Breg:PxCMD=5D =
=40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B2=5D: por=
t write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7=
f6da4eb1400)=5B3=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=
=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B4=5D: port write =5Breg:PxCMD=5D =40=
 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B5=5D: port w=
rite =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6d=
a4eb1400)=5B5=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5F=
port=5Fwrite ahci(0x7f6da4eb1400)=5B4=5D: port write =5Breg:PxCMD=5D =40 =
0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B3=5D: port wr=
ite =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da=
4eb1400)=5B2=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fp=
ort=5Fwrite ahci(0x7f6da4eb1400)=5B1=5D: port write =5Breg:PxCMD=5D =40 0=
x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B1=5D: port wri=
te =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4=
eb1400)=5B1=5D: port write =5Breg:PxSERR=5D =40 0x30: 0xffffffff ahci=5Fp=
ort=5Fwrite ahci(0x7f6da4eb1400)=5B1=5D: port write =5Breg:PxIS=5D =40 0x=
10: 0xffffffff ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write4 =5Br=
eg:IS=5D =40 0x8: 0x0000000000000002 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1=
400)=5B1=5D: port write =5Breg:PXIE=5D =40 0x14: 0x7d40004f ahci=5Fport=5F=
write ahci(0x7f6da4eb1400)=5B2=5D: port write =5Breg:PxCMD=5D =40 0x18: 0=
x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B2=5D: port write =5B=
reg:PxSERR=5D =40 0x30: 0xffffffff ahci=5Fport=5Fwrite ahci(0x7f6da4eb140=
0)=5B2=5D: port write =5Breg:PxIS=5D =40 0x10: 0xffffffff ahci=5Fmem=5Fwr=
ite=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:IS=5D =40 0x8: 0x0000000000=
000004 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B2=5D: port write =5Breg=
:PXIE=5D =40 0x14: 0x7d40004f ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B=
3=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite=
 ahci(0x7f6da4eb1400)=5B3=5D: port write =5Breg:PxSERR=5D =40 0x30: 0xfff=
fffff ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B3=5D: port write =5Breg:=
PxIS=5D =40 0x10: 0xffffffff ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb140=
0) write4 =5Breg:IS=5D =40 0x8: 0x0000000000000008 ahci=5Fport=5Fwrite ah=
ci(0x7f6da4eb1400)=5B3=5D: port write =5Breg:PXIE=5D =40 0x14: 0x7d40004f=
 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B4=5D: port write =5Breg:PxCMD=
=5D =40 0x18: 0x00000006 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B4=5D:=
 port write =5Breg:PxSERR=5D =40 0x30: 0xffffffff ahci=5Fport=5Fwrite ahc=
i(0x7f6da4eb1400)=5B4=5D: port write =5Breg:PxIS=5D =40 0x10: 0xffffffff =
ahci=5Fmem=5Fwrite=5Fhost ahci(0x7f6da4eb1400) write4 =5Breg:IS=5D =40 0x=
8: 0x0000000000000010 ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B4=5D: po=
rt write =5Breg:PXIE=5D =40 0x14: 0x7d40004f ahci=5Fport=5Fwrite ahci(0x7=
f6da4eb1400)=5B5=5D: port write =5Breg:PxCMD=5D =40 0x18: 0x00000006 ahci=
=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B5=5D: port write =5Breg:PxSERR=5D =
=40 0x30: 0xffffffff ahci=5Fport=5Fwrite ahci(0x7f6da4eb1400)=5B5=5D: por=
t write =5Breg:PxIS=5D =40 0x10: 0xffffffff ahci=5Fmem=5Fwrite=5Fhost ahc=
i(0x7f6da4eb1400) write4 =5Breg:IS=5D =40 0x8: 0x0000000000000020 ahci=5F=
port=5Fwrite ahci(0x7f6da4eb1400)=5B5=5D: port write =5Breg:PXIE=5D =40 0=
x14: 0x7d40004f ---------------------------------------------------------=
-------------------------------- Windows 7, disabling SATA disk: ahci=5Fp=
ort=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:PxCI=5D =40 0x=
38: 0x00020000 handle=5Fcmd=5Ffis=5Fdump ahci(0x7fcc4e19b4a0)=5B0=5D: =46=
IS: 0x00: 27 80 ea 00 00 00 00 a0 00 00 00 00 00 00 00 00 0x10: 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 0x20: 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x50: 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 0x60: 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ah=
ci=5Fcmd=5Fdone ahci(0x7fcc4e19b4a0)=5B0=5D: cmd done ahci=5Fport=5Fwrite=
 ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:PxSERR=5D =40 0x30: 0xfff=
fffff ahci=5Fport=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:=
PxIS=5D =40 0x10: 0x00000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7fcc4e19b4a=
0) write4 =5Breg:IS=5D =40 0x8: 0x0000000000000001 ahci=5Fport=5Fwrite ah=
ci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:PxCI=5D =40 0x38: 0x00040000=
 handle=5Fcmd=5Ffis=5Fdump ahci(0x7fcc4e19b4a0)=5B0=5D: =46IS: 0x00: 27 8=
0 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 0x10: 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x40: 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 0x50: 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ahci=5Fcmd=5Fdon=
e ahci(0x7fcc4e19b4a0)=5B0=5D: cmd done ahci=5Fport=5Fwrite ahci(0x7fcc4e=
19b4a0)=5B0=5D: port write =5Breg:PxSERR=5D =40 0x30: 0xffffffff ahci=5Fp=
ort=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:PxIS=5D =40 0x=
10: 0x00000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7fcc4e19b4a0) write4 =5Br=
eg:IS=5D =40 0x8: 0x0000000000000001 ------------------------------------=
----------------------------------------------------- Windows 7, re-engag=
ing SATA disk: ahci=5Fport=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port writ=
e =5Breg:PxCI=5D =40 0x38: 0x00002000 handle=5Fcmd=5Ffis=5Fdump ahci(0x7f=
cc4e19b4a0)=5B0=5D: =46IS: 0x00: 27 80 ef 66 00 00 00 a0 00 00 00 00 00 0=
0 00 00 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x20: 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x30: 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x60: 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 0x70: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 ahci=5Fcmd=5Fdone ahci(0x7fcc4e19b4a0)=5B0=5D: cmd d=
one ahci=5Fport=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:Px=
SERR=5D =40 0x30: 0xffffffff ahci=5Fport=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=
=5D: port write =5Breg:PxIS=5D =40 0x10: 0x00000001 ahci=5Fmem=5Fwrite=5F=
host ahci(0x7fcc4e19b4a0) write4 =5Breg:IS=5D =40 0x8: 0x0000000000000001=
 ahci=5Fport=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:PxCI=5D=
 =40 0x38: 0x00004000 handle=5Fcmd=5Ffis=5Fdump ahci(0x7fcc4e19b4a0)=5B0=5D=
: =46IS: 0x00: 27 80 f5 00 00 00 00 a0 00 00 00 00 00 00 00 00 0x10: 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x20: 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 0x40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x50: 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 0x60: 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 ahci=5Fcmd=5Fdone ahci(0x7fcc4e19b4a0)=5B0=5D: cmd done ahci=5Fport=5F=
write ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:PxSERR=5D =40 0x30: =
0xffffffff ahci=5Fport=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5B=
reg:PxIS=5D =40 0x10: 0x00000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7fcc4e1=
9b4a0) write4 =5Breg:IS=5D =40 0x8: 0x0000000000000001 ahci=5Fport=5Fwrit=
e ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:PxCI=5D =40 0x38: 0x0000=
8000 handle=5Fcmd=5Ffis=5Fdump ahci(0x7fcc4e19b4a0)=5B0=5D: =46IS: 0x00: =
27 80 ef 02 00 00 00 a0 00 00 00 00 00 00 00 00 0x10: 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x40: 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x50: 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ahci=5Fcmd=5F=
done ahci(0x7fcc4e19b4a0)=5B0=5D: cmd done ahci=5Fport=5Fwrite ahci(0x7fc=
c4e19b4a0)=5B0=5D: port write =5Breg:PxSERR=5D =40 0x30: 0xffffffff ahci=5F=
port=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:PxIS=5D =40 0=
x10: 0x00000001 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7fcc4e19b4a0) write4 =5B=
reg:IS=5D =40 0x8: 0x0000000000000001 ahci=5Fport=5Fwrite ahci(0x7fcc4e19=
b4a0)=5B0=5D: port write =5Breg:PxCI=5D =40 0x38: 0x00010000 handle=5Fcmd=
=5Ffis=5Fdump ahci(0x7fcc4e19b4a0)=5B0=5D: =46IS: 0x00: 27 80 ec 00 00 00=
 00 a0 00 00 00 00 00 00 00 00 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x30: 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x40: 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0x70: 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ahci=5Fpopulate=5Fsglist ahci=
(0x7fcc4e19b4a0)=5B0=5D ahci=5Fdma=5Fprepare=5Fbuf ahci(0x7fcc4e19b4a0)=5B=
0=5D: prepare buf limit=3D512 prepared=3D512 ahci=5Fstart=5Ftransfer ahci=
(0x7fcc4e19b4a0)=5B0=5D: reading 512 bytes on ata w/ sglist ahci=5Fcmd=5F=
done ahci(0x7fcc4e19b4a0)=5B0=5D: cmd done ahci=5Fport=5Fwrite ahci(0x7fc=
c4e19b4a0)=5B0=5D: port write =5Breg:PxSERR=5D =40 0x30: 0xffffffff ahci=5F=
port=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port write =5Breg:PxIS=5D =40 0=
x10: 0x00000001 ahci=5Fport=5Fwrite ahci(0x7fcc4e19b4a0)=5B0=5D: port wri=
te =5Breg:PxIS=5D =40 0x10: 0x00000002 ahci=5Fmem=5Fwrite=5Fhost ahci(0x7=
fcc4e19b4a0) write4 =5Breg:IS=5D =40 0x8: 0x0000000000000001 ------------=
-------------------------------------------------------------------------=
---- -- Best regards, Andy Chiu John Snow <jsnow=40redhat.com> =E6=96=BC =
2019-09-10 02:13 =E5=AF=AB=E9=81=93=EF=BC=9A > > > > On 9/9/19 1:18 PM, a=
ndychiu via Qemu-devel wrote: > > If Windows 10 guests have enabled 'turn=
 off hard disk after idle' > > option in power settings, and the guest ha=
s a SATA disk plugged in, > > the SATA disk will be turned off after a sp=
ecified idle time. > > If the guest is live migrated or saved/loaded with=
 its SATA disk > > turned off, the following error will occur: > > > > qe=
mu-system-x86=5F64: AHCI: =46ailed to start =46IS receive engine: bad =46=
IS receive buffer address > > qemu-system-x86=5F64: =46ailed to load ich9=
=5Fahci:ahci > > qemu-system-x86=5F64: error while loading state for inst=
ance 0x0 of device '0000:00:1a.0/ich9=5Fahci' > > qemu-system-x86=5F64: l=
oad of migration failed: Operation not permitted > > > > Oof. That can't =
have been fun to discover. > > > Observation from trace logs shows that a=
 while after Windows 10 turns off > > a SATA disk (IDE disks don't have t=
he following behavior), > > it will disable the PCI=5FCOMMAND=5FMASTER fl=
ag of the pci device containing > > the ahci device. When the the disk is=
 turning back on, > > the PCI=5FCOMMAND=5FMASTER flag will be restored fi=
rst. > > But if the guest is migrated or saved/loaded while the disk is o=
ff, > > the post=5Fload callback of ahci device, ahci=5Fstate=5Fpost=5Flo=
ad(), will fail > > at ahci=5Fcond=5Fstart=5Fengines() if the MemoryRegio=
n > > pci=5Fdev->bus=5Fmaster=5Fenable=5Fregion is not enabled, with pci=5F=
dev pointing > > to the PCIDevice struct containing the ahci device. > > =
> > This patch enables pci=5Fdev->bus=5Fmaster=5Fenable=5Fregion before c=
alling > > ahci=5Fcond=5Fstart=5Fengines() in ahci=5Fstate=5Fpost=5Fload(=
), and restore the > > MemoryRegion to its original state afterwards.> > =
> This looks good to me from an AHCI perspective, but I'm not as clear on=
 > the implications of toggling the MemoryRegion, so I have some doubts. =
> > > MST, can you chime in and clear my confusion=3F > > I suppose when =
the PCI=5FCOMMAND=5FMASTER bit is turned off, we disable the > memory reg=
ion, as a guest would be unable to establish a new mapping in > this time=
, so it makes sense that the attempt to map it fails. > > What's less cle=
ar to me is what happens to existing mappings when a > region is disabled=
. Are they invalidated=3F If so, does it make sense that > we are trying =
to establish a mapping here at all=3F Maybe it's absolutely > correct tha=
t this fails. > > (I suppose, though, that the simple toggling of the reg=
ion won't be a > guest-visible event, so it's probably safe to do. Right=3F=
) > > What I find weird for AHCI is this: We try to engage the CLB mappin=
g > before the =46IS mapping, but we fail at the =46IS mapping. So why is=
 > PORT=5FCMD=5F=46IS=5FRX set while PORT=5FCMD=5FSTART is unset=3F > > I=
t kind of looks like we only half-heartedly stopped the AHCI device. > Ma=
ybe that's just what Windows does, but I wonder if there's a bug where > =
we're erroneously leaving PORT=5FCMD=5F=46IS=5FRX set when we've been dis=
abled. > It seems like the guest would need to re-set the mappings anyway=
, so > maybe trying to restore a stale mapping is not the right thing to =
do. > > > > Andy, if you have traces left over: What AHCI registers does =
Windows > touch when it disables the AHCI device=3F What registers does i=
t touch > when it re-engages it=3F > > I just want to make sure I'm not l=
eaving something dangling by accident. > > --js > > > Signed-off-by: andy=
chiu <andychiu=40synology.com> > > --- > > hw/ide/ahci.c =7C 53 +++++++++=
+++++++++++++++++++++++++++----------------- > > 1 file changed, 36 inser=
tions(+), 17 deletions(-) > > > > diff --git a/hw/ide/ahci.c b/hw/ide/ahc=
i.c > > index d45393c..83f8c30 100644 > > --- a/hw/ide/ahci.c > > +++ b/h=
w/ide/ahci.c > > =40=40 -1649,33 +1649,52 =40=40 static const VMStateDesc=
ription vmstate=5Fahci=5Fdevice =3D =7B > > =7D, > > =7D; > > > > +static=
 int ahci=5Fstate=5Fload=5Fengines(AHCIState *s, AHCIDevice *ad) > > +=7B=
 > > + AHCIPortRegs *pr =3D &ad->port=5Fregs; > > + DeviceState *dev=5Fst=
ate =3D s->container; > > + PCIDevice *pci=5Fdev =3D (PCIDevice *) object=
=5Fdynamic=5Fcast(OBJECT(dev=5Fstate), > > + TYPE=5FPCI=5FDEVICE); > > + =
bool pci=5Fbus=5Fmaster=5Fenabled =3D pci=5Fdev->bus=5Fmaster=5Fenable=5F=
region.enabled; > > + > > + if (=21(pr->cmd & PORT=5FCMD=5FSTART) && (pr-=
>cmd & PORT=5FCMD=5FLIST=5FON)) =7B > > + error=5Freport(=22AHCI: DMA eng=
ine should be off, but status bit =22 > > + =22indicates it is still runn=
ing.=22); > > + return -1; > > + =7D > > + if (=21(pr->cmd & PORT=5FCMD=5F=
=46IS=5FRX) && (pr->cmd & PORT=5FCMD=5F=46IS=5FON)) =7B > > + error=5Frep=
ort(=22AHCI: =46IS RX engine should be off, but status bit =22 > > + =22i=
ndicates it is still running.=22); > > + return -1; > > + =7D > > + > > +=
 memory=5Fregion=5Fset=5Fenabled(&pci=5Fdev->bus=5Fmaster=5Fenable=5Fregi=
on, true); > > + > > + /* > > + * After a migrate, the DMA/=46IS engines =
are =22off=22 and > > + * need to be conditionally restarted > > + */ > >=
 + pr->cmd &=3D =7E(PORT=5FCMD=5FLIST=5FON =7C PORT=5FCMD=5F=46IS=5FON); =
> > + if (ahci=5Fcond=5Fstart=5Fengines(ad) =21=3D 0) =7B > > + return -1=
; > > + =7D > > + memory=5Fregion=5Fset=5Fenabled(&pci=5Fdev->bus=5Fmaste=
r=5Fenable=5Fregion, > > + pci=5Fbus=5Fmaster=5Fenabled); > > + > > + ret=
urn 0; > > +=7D > > + > > static int ahci=5Fstate=5Fpost=5Fload(void *opa=
que, int version=5Fid) > > =7B > > int i, j; > > struct AHCIDevice *ad; >=
 > NCQTransferState *ncq=5Ftfs; > > - AHCIPortRegs *pr; > > AHCIState *s =
=3D opaque; > > > > for (i =3D 0; i < s->ports; i++) =7B > > ad =3D &s->d=
ev=5Bi=5D; > > - pr =3D &ad->port=5Fregs; > > - > > - if (=21(pr->cmd & P=
ORT=5FCMD=5FSTART) && (pr->cmd & PORT=5FCMD=5FLIST=5FON)) =7B > > - error=
=5Freport(=22AHCI: DMA engine should be off, but status bit =22 > > - =22=
indicates it is still running.=22); > > - return -1; > > - =7D > > - if (=
=21(pr->cmd & PORT=5FCMD=5F=46IS=5FRX) && (pr->cmd & PORT=5FCMD=5F=46IS=5F=
ON)) =7B > > - error=5Freport(=22AHCI: =46IS RX engine should be off, but=
 status bit =22 > > - =22indicates it is still running.=22); > > - return=
 -1; > > - =7D > > > > - /* After a migrate, the DMA/=46IS engines are =22=
off=22 and > > - * need to be conditionally restarted */ > > - pr->cmd &=3D=
 =7E(PORT=5FCMD=5FLIST=5FON =7C PORT=5FCMD=5F=46IS=5FON); > > - if (ahci=5F=
cond=5Fstart=5Fengines(ad) =21=3D 0) =7B > > + if (ahci=5Fstate=5Fload=5F=
engines(s, ad)) =7B > > return -1; > > =7D > > > >
