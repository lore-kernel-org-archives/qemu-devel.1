Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4088C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DE520679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m6R5sRMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd33j-0000Et-0E
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40874)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd307-0006cE-IY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd306-0008Rd-9H
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17535)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd305-0008Hk-LK; Mon, 17 Jun 2019 21:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821645; x=1592357645;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VmGxSZu2OAxIKwoKC8W86AgX2GSTqwQYmrBcod7vB1A=;
 b=m6R5sRMyxhfFeXhdYkSV0Gvzie/QJOXa1/c+VnCOLQTehXbpIeWsw4G7
 WOPufEcncKKua+Spi2vr+mif0JLWEspLDhYLYJG4BAazipo87ELMC/3Jd
 tpgtO1EmikIj1CORoNEvvY4ryzaAWMjfnRueJB7aJakTjBaVlSHc2lnS9
 GdFmu9pRvMLKyqx2w+opfhJOZlNhml/H8cKlKWOdmr/V5U37LorgPdwDu
 kA5J/fNpupgqsdGYUXPkLdoUs42buM/UtItPy1HJoObXCT2F2x5y7s3t4
 +0ukPao5r3x+lq/Z1RqGG85sJtiDkjteZ8KxLp2UK4SGG9Er3vl3czcUp Q==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="210540262"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:51 +0800
IronPort-SDR: 5MKGmG1QIDCv4vkM20SAZBEdU0Xl+4dqnt1Lcoeu0w4A359vI1cxaESfbDLLfyYirXfM5lE53i
 bi0b9ZQYyXuINdAJpfcrligf8y1CI+YhyU6BSwYf2BsjfBcJuPpJaSVqaaRrs77P14IVURZOFB
 YO0oI8n4c3XBhtjJcDDeKQPxNhuKEggCUFVOfpCJUEP7ljpqoj25Ns+T2mL0to+pfCPg6iyLTT
 mpe1L4fvHF6UQhJjLbjFUqimigQpmZjMl4h4F3cO5veNbCk6MzclkNXJjP5uMq9iGyu889jDAJ
 L99vrWmjeq2OReFstqk/3Oc8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 18:32:50 -0700
IronPort-SDR: DRbmEtDbUGRlAjF4zkMZracLsSiQ3IQJrXVIq45rhYHh8Nrsq+N6JxmiXtGuXdtCwzagcbroO9
 og7kdqBEFDfMdyY6G+9izgqvaRcE+Nk7MVV9CLl3RNxBuxm7HPF2ujoU1p8+p5TEDOUgPHmEoa
 cFLZ4HLkV12IbArrwFrsJqvG47mBUJhS/Ut8HADuBEz4OHJjhZTHjNk0h89JlVZYbp+EaYdETj
 74Co8VFyVYxrjoHsp2K/o8OVNC1nqt7O/AfJvJckNHd1DdDJ5xPnr5GsfAaK7yDhSpMdZOLyh3
 1Hs=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 18:33:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:00 -0700
Message-Id: <cover.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 0/9] Update the RISC-V specification versions
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <cover.1555726824.git.alistair.francis@wdc.com>

Now that the RISC-V spec has started to be ratified let's update our
QEMU implementation. There are a few things going on here:
 - Add priv version 1.11.0 to QEMU
    - This is the ratified version of the Privledge spec
    - There are almost no changes to 1.10
 - Mark the 1.09.1 privledge spec as depreated
     - Let's aim to remove it in two releases
 - Set priv version 1.11.0 as the default
 - Remove the user_spec version
     - This doesn't really mean anything so let's remove it
 - Add support for the "Counters" extension
 - Add command line options for Zifencei and Zicsr

We can remove the spec version as it's unused and has never been exposed
to users. The idea is to match the specs in specifying the version. To
handle versions in the future we can extend the extension props to
handle version information.

For example something like this: -cpu rv64,i=2.2,c=2.0,h=0.4,priv_spec=1.11

NOTE: This isn't supported today as we only have one of each version.

This will be a future change if we decide to support multiple versions
of extensions.

The "priv_spec" string doesn't really match, but I don't have a better
way to say "Machine ISA" and "Supervisor ISA" which is what is included
in "priv_spec".

For completeness I have also added the Counters, Zifencei and Zicsr
extensions.

Everything else seems to match the spec names/style.

Please let me know if I'm missing something. QEMU 4.1 is the first
release to support the extensions from the command line, so we can
easily change it until then. After that it'll take more work to change
the command line interface.

Alistair Francis (9):
  target/riscv: Restructure deprecatd CPUs
  target/riscv: Add the privledge spec version 1.11.0
  target/riscv: Comment in the mcountinhibit CSR
  target/riscv: Set privledge spec 1.11.0 as default
  qemu-deprecated.texi: Deprecate the RISC-V privledge spec 1.09.1
  target/riscv: Require either I or E base extension
  target/riscv: Remove user version information
  target/riscv: Add support for disabling/enabling Counters
  target/riscv: Add Zifencei and Zicsr as command line options

 qemu-deprecated.texi                          |  8 +++
 target/riscv/cpu.c                            | 72 ++++++++++---------
 target/riscv/cpu.h                            | 19 ++---
 target/riscv/cpu_bits.h                       |  1 +
 target/riscv/csr.c                            | 13 +++-
 .../riscv/insn_trans/trans_privileged.inc.c   |  2 +-
 6 files changed, 71 insertions(+), 44 deletions(-)

-- 
2.22.0


