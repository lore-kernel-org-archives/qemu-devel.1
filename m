Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A57EC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9BA2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RcUo0EST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9BA2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzXU-0001Je-99
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyr-0004G8-7B
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyo-0001YB-41
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466865; x=1635002865;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gTEfrXW5JVAxrBtTkMoI4Wb6sqYHxkqYEIKLyrikXqY=;
 b=RcUo0ESTfoTZrjjmGGiyQDbW0PbRdI8pM4GXax7ngKNDcdPNuS7Z+utV
 5bwmimL1E8rAUjm9N3CJAuGRStSRsw+OLrmu5O6huEowor5p0AvWSxC64
 uwq+x27gt28fMZASBV8Ub+0fq1oh7z/X87E1qj2Wnj6rBkHSQJXhOWVm7
 53Q1Z+T0tZs3s4SJrnDTRwmbB1HNJuVX7L85sErJ8UTjWK6/7STVmpgHN
 4TQsIU2CbzTuJKSTl2qBn3G9AwDo7nq+mg7mCvoidaGjzpO3uJvPCfVtr
 LpJ1BOvun3PUmQFa2sddKUJ6pr0EZWWh0oWs5VHJbeDsfXtLC4345BQu0 w==;
IronPort-SDR: 9XE2FkgRVEeSSzT/bHvQ76F5YYa6GNQTHsWq4AgVHGRlRcUYAHGs2jmyIPok347QW74Azl6/oi
 Jne5Qi124NEACVTf/B9EgnpnyIw3vFiLganDxeWoBPl0wgBoTt/g24tblk9GGpJeKpaQxuAbFD
 KZoWUvU5LsL5oRcGE/wvj3KeoMmMwTsIIkRo5c+gXbOSV4/Sp8fvQuOT4sYFDCea1wDQ9lJ6Wd
 kqjspdkT+E5KO6knc403RBHHIyBUO0w6GshTxmfj+aPcjMsgW3piEZgnk3+o1qea2Q1ZeFgJCn
 lHo=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652318"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:42 +0800
IronPort-SDR: BFn+mHuNlHWPrcVDRF/na2Hje5ir7qZROgU3rgnWp2T4z0fjgiw3RShRVvdJG6vXjz7Em2xGYS
 Xw2xTwT5F2GJQBHVmadZqCLbEuG90cf1ohN19yyaY8Lfc6hvIlbkaBUjQMP4F/OtXDKBwXoHu+
 u7tdXsLTkcQqnNZ+cZgzj5Ki7JIZhCR0iI3uwZkBcPZuOvb1dOG3X19Rb/ZE9+/xrFM1AY++Dv
 kEB9WbsKkf1oODJTKgOAZHazIDCaK4GU7I2pwT7EDJ+wsxDkJLJOyfXs9HlNxQalp3uZNa2tNy
 6usWTdjR/bQDXO14N1AoFyEu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:12:58 -0700
IronPort-SDR: mXk7XxhqUrURQbP+DlG/JSGNgtY6i1yHtx90tqn55oz7bca5KmnRQyZZKvSc5UdttZAoZvCQAr
 5O3QjjibBPmwFothlsYOm6ZeU7BCfUmdhLTQ6l32/09ZRWHiowRmzPWGPWuX0ryWx+aEhtAF8E
 SZTtxhp/ZGBDhBU3FYVwl56F367bBNLBhpJ9rbRXQNetv7lx1fnTrW4a0JY/1KGvpeiAAtyBa5
 +Y/ei3lTypYjlvN3PMgGJLDWsNY2k+hRrAjh3L25KJvLXbABQ5qoFm1fH2JkGi0Nzqy8uf60qT
 qTI=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 02/12] hw/intc: Move sifive_plic.h to the include directory
Date: Fri, 23 Oct 2020 08:16:09 -0700
Message-Id: <20201023151619.3175155-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Since sifive_plic.h is used by hw/intc/sifive_plic.c,
it has to be in the public include directory. Move it.

Fixes: 84fcf3c15111 ("hw/riscv: Move sifive_plic model to hw/intc")
Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1602578033-68384-1-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 {hw => include/hw}/intc/sifive_plic.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {hw => include/hw}/intc/sifive_plic.h (100%)

diff --git a/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
similarity index 100%
rename from hw/intc/sifive_plic.h
rename to include/hw/intc/sifive_plic.h
-- 
2.28.0


