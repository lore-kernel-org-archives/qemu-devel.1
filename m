Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA8C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779982081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779982081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWHu-0002nM-Lc
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:23:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEu-0000V4-Jm
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEt-0002Iq-KY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:28 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWEr-0002Er-4V; Fri, 03 May 2019 07:20:25 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1Mgefy-1goaWw11RM-00h9Xq; Fri, 03 May 2019 13:20:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:19:46 +0200
Message-Id: <20190503111958.30825-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VLC2nYBrkjmbatT2BGIKTRTbelccNOeaNRaXwJ0FkPvCVCeo9wS
	KAJI3u6Ghht9nUoOllejRh2DHOh2PNoV5lVynAohD4mGDgbE7CDUKuCR+Err7LgqMYYHDwQ
	iekAwPV/5jBoPeZw9sCKuQYqZmJtjPaNPPeIOs0mvGaezPcq8GsP+hcyWG+0Risn/WoWS40
	OxIa+dQTjuJBYObw1PD4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qhodq9ZSZv4=:NgsNSsKetDzeTfPLHR6Kl+
	Yi25m/LvBVcQmCcJfGHE1VpqSW6oTNfhysqufV2RpcvBghvRWXThavwZ3qIDlSPG7A1/nZCZE
	HSmvvJICdVqSqTWx0NX69rb6gsurnCnDCRqNKy9iiVk+ZDYcoH1wy4VhQdtrB7oxlDueFnzBP
	7TpRf/r2Yr/TWzQlyJoMb8xHJmubxcHjgNZ8Z7SrSp8ucMV3Lu3arxR0QkCvd7292pz/sEhg8
	9+e3K8F05ntR24ak1qhtoAP9+X/daKwVmyoQzCcNOJyJoI/ZHDI6uD2djOSyGpvyPMVjIsf3l
	m4PcWaT6HKrN4KMvutoXSetEtX1qE6VtMjv6zjApCtpnPGrLLvZi6wiWgDPuli2FF9MODgWV5
	MSwMRd7EL1xrJa/0YRKB9njrhuCia/G42mXJDKZJhbYaZdD+ubvH31idA3co8j6ObDJOHrkcR
	Yzu+Fhp6MDnN0lYGEOHlRWgXRz4qN1kCLCI3pjroiNJPS5m9uBGZxUqEJN/k8L5Es/toASrYV
	1+GMkP91aITvtoZHj/2zF/U7p9rjW9eqJoiJrBo+ttv2eccDlqY1olJo0owXU7z8yEjQeZ1Ua
	XHjdur94GGoia3coNe4dvt5RIivEnPUnP2dDaDTGcrswGtonYcpt+VriN0EhgpaTCzHkqyN+e
	e+OOSmJ4/do7CbSsmpfxSK45qAoDUm129YCL+zHHeZvEKrb8/OlCFSanuu1+y4vGl4o5uC6xU
	LRkIrZy3WlV9j5FE5mSVHEf0rYJ3SXJbhwtE3cqWoVKIwCTvsyufbuMcozc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL v2 00/12] Trivial branch patches
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503111946.nX06b8yzQsyUmzfAs6vHzjcFf3NiH3cl7K5w7ASzIbA@z>

The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 2d2023c3b99edb33ad4bb9791f70456ea1a1c049:

  sockets: avoid string truncation warnings when copying UNIX path (2019-05-03 13:03:04 +0200)

----------------------------------------------------------------
Pull request trivial branch 2019-05-03

----------------------------------------------------------------

Aruna Jayasena (1):
  Header cleanups

Daniel P. Berrangé (1):
  sockets: avoid string truncation warnings when copying UNIX path

Dr. David Alan Gilbert (1):
  configure: fix pam test warning

Marc-André Lureau (1):
  doc: fix the configuration path

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
 include/exec/cpu-common.h |  3 ---
 hw/net/pcnet.c            |  4 +++-
 hw/sparc/leon3.c          |  4 ++++
 net/net.c                 |  7 +++---
 qom/object.c              |  2 +-
 util/qemu-sockets.c       | 12 ++++++----
 CODING_STYLE              | 47 +++++++++++++++++++++++++++++++++++----
 10 files changed, 74 insertions(+), 25 deletions(-)

-- 
2.20.1


