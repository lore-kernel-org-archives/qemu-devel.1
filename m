Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83692C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3F02078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3F02078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAELy-0005j8-Ih
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAEKv-0004RU-JM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:24:41 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAEKt-0003ds-Vx
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:24:41 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGQWr-1kQSwX46gP-00GtPK; Mon, 24 Aug 2020 17:24:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] meson: avoid compiling qemu-keymap by default
Date: Mon, 24 Aug 2020 17:24:28 +0200
Message-Id: <20200824152430.1844159-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QE+3SrKPa3g76j+BLl2ZkmABC85r4N67qwfvPZI2tE5TiA26qgl
 c28hxHXHGPDb4Tzdt3YjjyPWdjvifaovk6rDqoG+6Ir6O/K4t/bmv6v+uo1n4ARCH2ILKiX
 FO56W/tYCmggOlTXkujAlwyERZtsbmX9GGqUw3a/QBIa52LEFQAa0Y7Wtu70ctq1UvYSNzW
 kTYTPRFqQQiYf6HFdvpZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+KL5dZfqzfI=:edVeTjCXHtmt+O/oQEy2UE
 jmMMXunNBMUlmtN70kVlnJ3lPa3X9N2oGT4OWWYd9LoAd68jRarjQOTEtO98JSDKkK3+wRFMJ
 gR3+84wAzNIqXT2riUVngvp1CoVWXn29w/uyEH9098qXgWOfRu/sHjbJ7K59rni5g88k8HgmE
 9DcruFNko6FLkE7CGlZuAqaPGC8hf5OIHloenpV4pGvKBtl5reu51oHlDCIwWufWE6LR0Wh5j
 OzVukcpwz//JFtdxzpXttQ4dq1isl1TsFso4jyia1zy3vfYgiYgmeVuTeexV65LxFaC1BRvlm
 7qTgIyr3tdPwpqJDwnzREHsYiRUy03C6V7JAglYmUDuMduhLBt/fT4AxhOzNbigluGS+VLUo8
 Ndy8++oRO2/ILRylDJnqG1B3VUWJLEyNAoIy0rrOZpIzaTui3+XSkwUQ9DJSRKrBqcF4P7+NH
 W+OnMPOyQUqeMcVdTLeKrCs44v1sNXECuZc3/6/XA/dXJ82u9zPGwUNHUFNZZIhwQkePu6vSz
 JfywIBPglxFf4GH+EwgNv8cm8I6HdAD3JQaDrXy3Pfi9StUiUCiuEqp9Anyl43NyzfXgjCrZB
 UgF3NiPoW6flXJ/XtRHSCQebAEDwKRI9LqPA+L1HzngPNab+o6oDyQTFpC8+/bnHDykJLFFBA
 aDTVo07C8Oq9FjrxhZay/bsJqUCfoGHcyryEzEqRCoXyzHH6+DnZ6maJo+Sk/w8zYRQybtVPH
 cl823DZ21IqD71u+B8XdewwiLtvAvoyCbR16rI7ryy9x6rH1befzUW4ujzYfCsSmqM2CEqs06
 pYT7gYH+yRuMZLhj2HmkaBqCqfgv1vvox8g79Vu+8TJEIfCPFtI8vOanJojR3sDqvrnRCiO
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 11:24:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need it with linux-user only build, and if xkbcommon dynamic=0D
library is detected it can break the build of static only binaries.=0D
=0D
So disable it if it is no explicitly asked by the user when neither=0D
system or tools are built.=0D
=0D
build qemu-keymap:=0D
  configure --disable-system --disable-tools --disable-user --enable-xkbcom=
mon=0D
  configure --disable-system --enable-tools --disable-user=0D
  configure --enable-system --disable-tools --disable-user=0D
=0D
don't build qemu-keymap:=0D
  configure --disable-system --disable-tools --disable-user=0D
  configure --disable-system --disable-tools --enable-user=0D
=0D
Laurent Vivier (2):=0D
  meson: move xkbcommon to meson=0D
  meson: avoid compiling qemu-keymap by default=0D
=0D
 configure         | 29 ++++-------------------------=0D
 meson.build       | 16 +++++++++++-----=0D
 meson_options.txt |  1 +=0D
 ui/meson.build    |  2 +-=0D
 4 files changed, 17 insertions(+), 31 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

