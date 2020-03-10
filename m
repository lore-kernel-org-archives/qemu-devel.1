Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C664C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B8D2467F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B8D2467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBclN-0000Fb-3G
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBckC-0007F5-MF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBckB-0002Ew-BW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:08:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44803)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBckB-0002Ad-2I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:08:15 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N7zNt-1jO17y3CBn-0155H8; Tue, 10 Mar 2020 12:08:01 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] linux-user: generate syscall_nr.h from linux unistd.h
Date: Tue, 10 Mar 2020 12:07:55 +0100
Message-Id: <20200310110759.3331020-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UFFP/OXAJmlBGPbARCQzW4v4p50jpPWmf/t1Xg2Rctv94QBd2AC
 VXJu0ssHL06yHS4nLrBU4Wkc4Tlhnlo7hcslVPIkMdu1BdkER3K+TJWhrh2hMo9xC0YEXBL
 zKzfwQ5awqiTOOCJdK7i+cx8PBE8oOQ6AR1u5LqD2vKQTYkUTGoNkGFF4p5OlGzU2JE2j5G
 sTCExT74aRSPKhK2PfxZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J9fk6/9ZeeQ=:Mz+j6zPsFFe5rOMg/uIonA
 btotU+GRphOoSyyD+gMiXG0j3OZZ179ZuoOGtY1ZJzh+EOfxD4csndfSjfb97BpOnp0t7YIE6
 1sRSDRhYD+iYEFYWUqnGzVw6xIEGep3lOaxlTPHKR/mfCcT4v9W2wPrueqie8ouZ3Q17Bl88e
 a+KOmwB/zlycDiRDc58CjsPJ3g+ft+d11QilljzYbrzQcvLNJb0MJecqrnZ8ZkfzShUMERpy3
 N/gWagApX7e3K/8wtI3habVNFcC+J62tyfQOkRuYwynpNhXt91CPPVHtoFQPk3db8Qa5O6Lh+
 8bXn5YOX8f3i3ZZryDivOZn9wUTDmMHsGXObxfM23qonLuKxRRU6c20/HllQHeBHS0B9wR3OE
 T+Uv2KQm+wEl1liobioyhWpSEwZ2inimuXH0+S3lTbwa/PrJvKD7yebwlQylB3Yr1FrxyocuI
 w9i5oOi7OdzzU2aldjUAbpT0nwScxZsngRsLThzDBmnVZ7diSYkGlu7nK9VTmmXVLHpsJw0sl
 YK9JvAVLLOqcAEQ/oeZQCTloRAU8qX/ZHsQZP9uMc+dguO/1XKKxMG3Sdz0nD25U6i8U7zJhm
 Mu1z/unDvWZSa0Mu9D9HiYe1LqpX8DUNDXFEP3eWZzRhBARZNv34HIulLT8WEw3s3nUC0DBdT
 voZCirhJ7P+Jaa9y0+WnNr1h4bwqkDJNOjrdnHVBrjHBKJOk19VjfpOrJiypsFiQR1abqzNuh
 ETTY2PQSV6SFM+WopEExB7iCDr/3nwR+ZO/sWYLSZCg0AdjvRNiPRLEx198KuEgcussrMWahm
 FrRQvtzJpKsMonOMK8aASC6zHK43tzXSnh3w+YISng0TdcRV4KX5kVr7Aed+mRJKuP075TP
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Jia Liu <proljc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a script to generate syscall_nr.h for
architectures that don't use syscall.tbl but asm-generic/unistd.h

The script uses several cpp passes and filters result with a grep/sed/tr sequence.
The result must be checked before being used, so it's why the script is not
automatically run.

I have run the script, checked and added new files for arm64, nios2, openrisc.

I don't include result for riscv as Alistair is already working on a series
for this architecture and it needs some changes in syscall.c as some
syscalls are not defined.

We also need to add the _time64 variant of syscalls added by the update of the
syscall_nr.h.

Based-on: <20200310103403.3284090-1-laurent@vivier.eu>

Laurent Vivier (4):
  scripts: add a script to generate syscall_nr.h
  linux-user,aarch64: sync syscall numbers with kernel v5.5
  linux-user,nios2: sync syscall numbers with kernel v5.5
  linux-user,openrisc: sync syscall numbers with kernel v5.5

 linux-user/aarch64/syscall_nr.h  |  32 +-
 linux-user/nios2/syscall_nr.h    | 648 +++++++++++++++----------------
 linux-user/openrisc/syscall_nr.h | 307 +++------------
 scripts/gensyscalls.sh           |  94 +++++
 4 files changed, 499 insertions(+), 582 deletions(-)
 create mode 100755 scripts/gensyscalls.sh

-- 
2.24.1


