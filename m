Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13536C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2902082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FJchp/Z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2902082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd33w-0000T8-5J
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40969)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30C-0006hL-EV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30B-00005z-AT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30A-0008QF-Uf; Mon, 17 Jun 2019 21:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821615; x=1592357615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tqX0fYHQddrpY4KXEEAbz2+C779KVIJCqxSKXh0arRw=;
 b=FJchp/Z01A5fmDXCvNKYqOX/3R2AiWMy5qApG0DT/vEHHHjPoFOhXZ8V
 b5+jabbP0b0snfIk6LLw7ASCw/0OjjzvXD+aDNK4vF5fxzr07YnvWzXkV
 vgE9Gb5WOf8XQTxj69A2kFrDKHRD8oP83zRs0b8JO4+eVdArM1kpQx60z
 bC6tFT8lUE6U9tLv2cNzAD2FULisskfiR7f3J57AS/m/N5PKT1+PJYCMt
 VJJBCIEdCn7CLlR7/jsbOFgO22xvxnbYG9FVaZALJi8/CQV/cNPQ3mDsc
 5SxmWG5NanayFReXDvj21xANCyLVNSUJQPktsjcW0zu0hu9DB1kL+2RJ2 g==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="115717034"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:34 +0800
IronPort-SDR: cp9ajpirFhe8vkpB/SRmOQGjypRngaLzn/Qu8ZpYkjVt9vT8hxP0pUfuN2OExOnVQdi28+nKx1
 DkAdFdu+p4Iv5qjjL7eyC7rHAya4Glouj4/ARKNy6g316SVmGmGmUF0bpkOnhg5/VptCVoNIr1
 0BpbRsN1x3A9kW+vrrsnXDPxvhdybwqE5lmO7/zKSkcoSzCRMYnnwVVyAnw+IyzGzOQvSZY7ea
 GPGyWvb2ygi4C6mri144HMSFRgQ3ZhD2N+7X1DUHXmByrPPGW+enqJcXlTU8ko0TjroPMHOq2Q
 yfJeseQoraBko+hUmBZifApe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 17 Jun 2019 18:33:07 -0700
IronPort-SDR: nL3S6vzMVwNY/N+ThlmOTPSJdMsRn9vKFmo6aWI4e84Mye16/5V6GAKGBKc++GOilzDaqdCfEA
 qOr0g4i5eICi6QMa92qz5Y8yCfo3n2zkBWJ580PQfssCjFKoUHYWAT8HCt483oaGcufTQ1WpQo
 wcO64g2W/gFTPYfiujwPJs10zhqpESjPTcN+sLNwL5oGBuNQT4wr0uQu6nkq5S6Zkr5lGxiarN
 qqeDUYOAh5AAeKbVZ9xuEoBs/1cc6mz8lOmb0Q7PfQhZjKcRqPMwbauzaADOWd3aPtbl2V979o
 H+w=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 18:33:34 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:13 -0700
Message-Id: <6a7392df062afc1d7b4914d92da43f0711ec14ec.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
References: <cover.1560821342.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 5/9] qemu-deprecated.texi: Deprecate the
 RISC-V privledge spec 1.09.1
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

Deprecate the RISC-V privledge spec version 1.09.1 in favour of the new
1.10.0 and the ratified 1.11.0.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 qemu-deprecated.texi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 50292d820b..b1111debf7 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -138,6 +138,14 @@ The ``acl_show'', ``acl_reset'', ``acl_policy'', ``acl_add'', and
 ``acl_remove'' commands are deprecated with no replacement. Authorization
 for VNC should be performed using the pluggable QAuthZ objects.
 
+@section Guest Emulator ISAs
+
+@subsection RISC-V ISA privledge specification version 1.09.1 (since 4.1)
+
+The RISC-V ISA privledge specification version 1.09.1 has been deprecated.
+QEMU supports both the newer version 1.10.0 and the ratified version 1.11.0, these
+should be used instead of the 1.09.1 version.
+
 @section System emulator CPUS
 
 @subsection RISC-V ISA CPUs (since 4.1)
-- 
2.22.0


