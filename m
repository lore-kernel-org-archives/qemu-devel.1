Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5941C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B303D20645
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B303D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57369 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMGxb-00056d-W1
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:01:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvP-0003UU-Ob
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvO-0002wl-QC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvM-0002vi-Bn; Thu, 02 May 2019 14:59:16 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1Mo7eX-1gxKIB0fbX-00pg1W; Thu, 02 May 2019 20:58:44 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:22 +0200
Message-Id: <20190502185835.15185-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZiwlMP6ohhS4/VzeHCBcCrMlxpj9iMlR9KSuv8WP3iijR7zULNr
	hB4mlB0Y/hV3yGNc3c/ixi2ivS9a5C4bGGpLzsAoRO18CnJ8PyYjyiIu3bhgJ/F0RKMjyjl
	vpcqWILOn4+EN8VuXNb4HN0w0zCb0VQvQNXApIZgq1cIDzqn7g4Pj8pMDoMl50gdFJS0lTR
	AgEvzWyHzG3HrjBKzCYZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uk4i9kj0Vs4=:vtHhtuIOSCANDdZdPnV6ae
	OvwRsZzrSzyLbUYbCdfio9WuJb6DBBNIOc0NdDCgnwZiLWCEyF1wjKRZIIj4BnAhIGgYq13oI
	yGDB0zeFgFZn47aIdTaWiWOyCkTP/0yLiz6poWWkdteyOvPAPuLq+XjwTeeS96NzBaNzLn7/W
	zRWUI3km7ooR5nzZwOvCx1uxCqu6kr1ycRGJuCtirFPTN+dpBuc0n5mteVvKaH4Rrx2hfiXvU
	xfhOnYTv2QhBmsgUbiXGuFjTvd2223ZsEqStvgdV3VheJVdaVjKEru8XQkILz/trt8J2TWfg9
	FqfX+fwU+22erWqB0o7tNWKOMJ0pswYkpWbxcOFIpx+WfOzRgz7mQOB1n6he3BvUigxtJKrAi
	E3BSUE9SzDYySFcFoYc7mzRkhaFv4Ck2oZAuu5Fh5E6NqWruu7xqBMArLoEhqiERHnMpyAsxD
	kQhDXU3QriGkcWfOK95DONpmHdoRwKt69Cc2vFf0hMBWWVg1LlrZjNu224oTbSWdiO47z90QE
	/Jrw+1GJsH8cAyBcGUHLIX4cwXrFSOcTeUu0fLT2T+Pu7NS9eqARyE4p9QOU62VVAJQ0Gflvg
	ySsoPEmMj7+zj2Pq0w1c+O5OfTUm7MqXPoqFMrjgSMaxZTbcnY9SjBFpHWTXLd7i+cpK4K7Ap
	0Ud4G1vGyVwMlz8wp1+10GDWlWbvUcYhFwTjBWhWhYRH9PlwHPx8CNVRwXTM/5HvnBSkHbClR
	/HnGo2t7vqcX+TvA+YMV4Fnr0nhQjYcr2FV49B2FfrXLU1cRV8+x3bsccsQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 00/13] Trivial branch patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
	Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502185822.Ox8kTfurIu0x5zEsFGPsHPD2pU4XQ-SSDmnc_O24W4E@z>

The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to f7c03a68b814254df414977ff299468fbf0fa1c0:

  sockets: avoid string truncation warnings when copying UNIX path (2019-05-02 20:50:47 +0200)

----------------------------------------------------------------
Pull request trivial branch 2019-05-02

----------------------------------------------------------------

Aruna Jayasena (1):
  Header cleanups

Daniel P. Berrangé (1):
  sockets: avoid string truncation warnings when copying UNIX path

Dr. David Alan Gilbert (1):
  configure: fix pam test warning

Marc-André Lureau (1):
  doc: fix the configuration path

Markus Armbruster (1):
  Clean up includes

Philippe Mathieu-Daudé (3):
  hw/net/pcnet: Use qemu_log_mask(GUEST_ERROR) instead of printf
  Makefile: Let the 'clean' rule remove qemu-ga.exe on Windows hosts
  hw/sparc/leon3: Allow load of uImage firmwares

Stefan Weil (1):
  Update configure

Thomas Huth (1):
  net: Print output of "-net nic, model=help" to stdout instead of
    stderr

Wei Yang (3):
  CODING_STYLE: specify the indent rule for multiline code
  CODING_STYLE: indent example code as all others
  qom: use object_new_with_type in object_new_with_propv

 qemu-ga.texi              |  4 ++--
 configure                 |  5 ++---
 Makefile                  | 11 +++++----
 hw/display/ati_int.h      |  1 -
 include/exec/cpu-common.h |  3 ---
 include/hw/cpu/cluster.h  |  1 -
 tests/fp/platform.h       |  1 -
 tests/libqos/qgraph.h     |  4 ----
 contrib/elf2dmp/main.c    |  3 +--
 contrib/elf2dmp/pdb.c     |  3 +--
 hw/display/ati.c          |  1 +
 hw/display/ati_2d.c       |  1 +
 hw/display/ati_dbg.c      |  1 +
 hw/net/pcnet.c            |  4 +++-
 hw/sparc/leon3.c          |  4 ++++
 net/net.c                 |  7 +++---
 qom/object.c              |  2 +-
 tests/qos-test.c          |  2 +-
 util/qemu-sockets.c       | 12 ++++++----
 CODING_STYLE              | 47 +++++++++++++++++++++++++++++++++++----
 20 files changed, 80 insertions(+), 37 deletions(-)

-- 
2.20.1


