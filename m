Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD8EC10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 21:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F6320674
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 21:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SXcuUP/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F6320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAKmE-000101-M1
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 16:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAKlR-0008W1-49
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 16:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAKlN-0002Qx-Hx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 16:44:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAKlM-0002H3-Ra; Fri, 06 Mar 2020 16:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583531052; x=1615067052;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Xu7ZQXxZKBNcbuefVMDIZxBfH6HcAA4fvZNTV9Zyxlg=;
 b=SXcuUP/Jqd+eJ7lJiaHltj34nbmrIMCceJe0k+0gSSGvCZ2ht1FQM1Bw
 ISYbMSANLHgZNbDW9kmzrdiBS0s1png1Gv/VkyxQgN1JV6rSOpfOUy67x
 aIsICYtv4t1X0KPewFi6OtXZKmON1MxzgHHpcwTdoyNpvmZLQP7D5EM7J
 nrsdxlXizrXyO8zVEV0WtLXnpeX/doC1UdcEqkuFSzqLHb5bc4tJFIbvQ
 EPqr12tACEgSj4OKEKRC/vK6FF2kwDyzq76XJPfPiBva4+fu+kf+jAL6D
 wXbho9WWPQMfOukEOCx3/aZGMRYi4kLrO5FnYvf8/unuaoPc5ciRJyShw w==;
IronPort-SDR: sWHfgZnXkr3wWR2IeoUx2snKgxDwWTqsnbmsmvxHHX5d0Ugni8/kMZM2ioUoxis2ukai+ZAss+
 pK7vXKMoCbexFnQhIaDnP90bmV5yzsqdOPnV4xOS0ce+REzyBIVythwZ8RTCodtQfR0X9C74Nx
 i5+jCDlv9wr9vjhpNohlH8co8j9MeCjSRCTBi4eYtw8r9xtWNH9MWQpU79HSvxdxwTurH31b8D
 5HExLqHOZO+HMqp9PcOnSG0kf0pR7YlrjL9k4p6PmFA8vnHWFdqC9LP5OrLiGBr59lA+wqF2YS
 xO8=
X-IronPort-AV: E=Sophos;i="5.70,523,1574092800"; d="scan'208";a="233784263"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2020 05:44:04 +0800
IronPort-SDR: bH45fE5edUIGsQZeWM0dQvX/wmbtmpwRLhvjWqxjLVGp5CsyMxG0whwhgl01pxBvedhSuErE5a
 pgrRQQiBe8ITFSZn2C47AZmBTWyp6CFD57i4rRGqGQvhcG5NmiYYyAtMCAIj6swaIFn5Ks7fOu
 Ptk0YKHfHsQPm4lhjBVtAgUQfu+gaQguG5d0gARXG1NQFNWu0KisFKwRXH2IuoMlS0+XJWdVqt
 stykKDWf1IXcvWcdFQCBySiqcqQJyKxy52T1TfHdLsGFMJqk5gGImMN0M4ibi7QA86A86YmH9w
 JKwmr6b8YobSW6DY3iLQIuBQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 13:35:50 -0800
IronPort-SDR: tb5MNtBWajHG9wlnS8+KejSi5GPTpLwS6ACXHvF6D1IMliMXFhpYTAOYUlLdyk6AfMIa/QFvXy
 PI/ykd/vinuz4IbIss6vNyC+KGAQ6qZURESZMMcDlCR5J7aAImGBqaM04Nh00KQiibtOfbyxFU
 xlgobOsbB3snG2+80w8HNOaeMddxKGFpwBo4P7BSE1/emKhJOVdQ1wWtvKFi5D2bmX7xvwiIJf
 atqoAkJVL2YdPAg/3lfqa/DJ2mpmHxIdLYWEX5tOkrqk2qyNXHy3A+9DQaccmvtOEoYWtVP2DZ
 EE4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Mar 2020 13:44:04 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 0/3] hw/riscv: Add a serial property to sifive_u
Date: Fri,  6 Mar 2020 13:36:45 -0800
Message-Id: <cover.1583530528.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At present the board serial number is hard-coded to 1, and passed
to OTP model during initialization. Firmware (FSBL, U-Boot) uses
the serial number to generate a unique MAC address for the on-chip
ethernet controller. When multiple QEMU 'sifive_u' instances are
created and connected to the same subnet, they all have the same
MAC address hence it creates a unusable network.

A new "serial" property is introduced to specify the board serial
number. When not given, the default serial number 1 is used.

v3:
 - Improve machine function names
v2:
 - Fix the serial setting so it correctly sets

Alistair Francis (2):
  riscv/sifive_u: Fix up file ordering
  riscv/sifive_u: Add a serial property to the sifive_u SoC

Bin Meng (1):
  riscv/sifive_u: Add a serial property to the sifive_u machine

 hw/riscv/sifive_u.c         | 137 +++++++++++++++++++++---------------
 include/hw/riscv/sifive_u.h |   3 +
 2 files changed, 85 insertions(+), 55 deletions(-)

-- 
2.25.1


