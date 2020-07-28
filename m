Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20242C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3542065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cNmetgI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3542065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0VRO-0002m4-16
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 15:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0VOK-0001B8-A7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:36:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:58203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0VOI-0005hY-12
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595964952;
 bh=yYisnN+3X/4fYo9Avm2DToK3QitIvsmlB3WVJgHHjfw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=cNmetgI5/3FRtrRQD51Ff4g0uBPBpWVug8xbB0QK/2uILfEgjLEZiL7cz49S927pE
 dPpIBxsWoiEZ8pDxL8Gi5tzWGQxVMXj1UlO4XkBDMuNVVn9UjE9ZT83C2Yle8nIQgG
 7bw3mzzyqUxfF064LTfIH/hXQd5x6VhKdK6KlY9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.108]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1k8zyB3Frb-008c6g; Tue, 28
 Jul 2020 21:35:52 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 0/4] target-hppa fixes
Date: Tue, 28 Jul 2020 21:35:46 +0200
Message-Id: <20200728193550.3578-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BQ5tqAUBWD1/TNmBrFVoOxWkGdMxK/vcaNn1rC2cvRD14e1LLCp
 NIUaZPAb445kQqWBB7edWsgkxfZ5ByLy7rmtF8KvxyarN+VhhOm6r78bbXkHhgMoPAi3/mb
 a9EvaGKsqvwx2DtLV903bNFxKYgBqDEO7ef26X/g2GYVDr8TJGNEeAJL/nmvyiUGIVCqAuF
 xA/UvRuuQmerm7O+ReNtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tRnI10PJKAw=:h+3HGTw6G5O5o6KSAA+Yet
 mKlt7eyQHYrkfdoeabTr5GsXasJOakAW0Z3ClhyEJ2Gb4X5DNHAkP5Li3EaaKYPWf/StBNELY
 LmAVBFSlIWE5WyZyglafzUCcc7a+T55X4w01/gf+Y5x7BwUuAizbcsVMI1+/6fX+znoR5idz9
 oy56aO+17mqzsSq26xO6QQMc3j67zvjN82vvFcqhi2PKB0MpVtlZFv+bDm2QDYdU57dpzKkwR
 9Sg0xo76tGrUBh4+PnensNdISAelZ3ubxn9LDxBxzvrwLDK+FOJYRTLb0ZLYGfObG/Ts/pgcO
 lr/rgocsdj96ChX+i28D0A2fIg/rKBRGuuSd+F4efVonLb1bbAIZ3uWQsY8sLJJHCXerx6wGc
 LxmDMZ28HRAdmd1jZ9PxOeE41IKNDJQqcTcfYT+156N4w5i4h/scNDt5IwkRD8XYwSSHVdgcz
 C5m+uW7FAtOV8s5jvwM5gcleXHc+RDh/mVdS1MTjLMs6qM0MrWXjPEKyw5mJUtlwhgbEXIDNi
 mWj6cRR9N+Cy0Rijja8BfmN8eCFlXgg4+ytb0HvovY0njaqg2ijGDGz7upm+VbN18IDdF9tQ9
 oqztjVvhlsedLTGeCCQh3a3C0jOiCHEiZlLg5e0C0Izi74WurahhPBw33PNWJwa/AERrNgAOB
 Ghk08c5Vs1NfT1HnquAIJNVlIPzHJBwZ//mJ9vdyn0qk8v1IRqj//s7MIkR2S/qyI21XBCjWs
 ady0MvvlI6FswY3Kq2SaFrDQXuWrVf662RfDgJbkwvIcjBqny9TtxpXepdt9WmdAPIS/seHwb
 Yk+64RdfyKrpZGBFYJYq/JUbJUNSDXzsTBsKKgOnf5/jDyMB53fWgKJaGehpt2xepfevUUWrb
 2eIVDUXLrqU15zcZGAvth3LMy0av4Gtf5OQIyc5qAc3bNXx0oGOvf3GlKgI8MTcJoD/z5y3m/
 EeZBzAlhOnxpSffP2TN5Ju8tJ9o4ZTppdagdM01SuO0V9bdFM4Z34LZJhnNB5bv2WOptK8fWl
 86HFRRSQY700BRPS9ykQcBM5OIrUz4RfpD0+aWnBMpdT8HPmaVMOVd5PMZ/YONdqllzSs5Pt5
 DdXmU40e5QbPLAjVoDaDFzsv4wft4GNtiM35fVUITPHbHjO7WaZmTQZBmQl6qOHOzrQSA9/fT
 LiPoIUimQSIrvJo44yyweJrChjLsWYW10WYRXaAqmcXY4GWrBLhRRJTCA3iCPWBehgSFQzoZW
 098Z3ljlk9xfuzkMe
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 15:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please pull to fix those two bugs in target-hppa:

* Fix the SeaBIOS-hppa firmware build with gcc-10 on Debian

* Fix the following runtime warning with artist framebuffer:
  "write outside bounds: wants 1256x1023, max size 1280x1024"

in addition the SeaBIOS-hppa firmware now includes a version check to prev=
ent
starting when it's incompatible to the emulated qemu hardware.

Helge

=2D---------------------------------------------------------------

The following changes since commit 3461487523b897d324e8d91f3fd20ed55f84954=
4:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2020=
0727' into staging (2020-07-28 18:43:48 +0100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git target-hppa

for you to fetch changes up to 9aa10e5543566facf328e76d3b5a4aa9d2b79756:

  hw/display/artist.c: fix out of bounds check (2020-07-28 21:17:44 +0200)

=2D---------------------------------------------------------------

Helge Deller (3):
      hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
      seabios-hppa: Update to SeaBIOS hppa version 1
      hw/hppa: Implement proper SeaBIOS version check

Sven Schnelle (1):
      hw/display/artist.c: fix out of bounds check

 hw/display/artist.c       |  18 ++++++------------
 hw/hppa/hppa_hardware.h   |   6 ++++++
 hw/hppa/lasi.c            |   2 --
 hw/hppa/machine.c         |  22 ++++++++++++++++++++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783144 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 35 insertions(+), 15 deletions(-)
=2D-
2.21.3

Helge Deller (3):
  hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
  seabios-hppa: Update to SeaBIOS hppa version 1
  hw/hppa: Implement proper SeaBIOS version check

Sven Schnelle (1):
  hw/display/artist.c: fix out of bounds check

 hw/display/artist.c       |  18 ++++++------------
 hw/hppa/hppa_hardware.h   |   6 ++++++
 hw/hppa/lasi.c            |   2 --
 hw/hppa/machine.c         |  22 ++++++++++++++++++++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783144 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 35 insertions(+), 15 deletions(-)

=2D-
2.21.3


