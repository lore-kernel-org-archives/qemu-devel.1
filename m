Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B673AC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C04C206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C04C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38349 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWFl-0000rF-Pp
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:21:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWDp-000832-Rv
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWDo-00012K-Rj
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:21 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:39871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWDo-00010S-Is; Fri, 03 May 2019 07:19:20 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1M4384-1hMWDQ3I3M-0006tJ; Fri, 03 May 2019 13:18:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:18:20 +0200
Message-Id: <20190503111832.30316-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oF4eB/eiUU74kK7uJJHtrGiB6zVz+E7dOmC5/9PXAC0QCkSa7nS
	Rt5WCpOz1Nv3JetaLJ09lpB8Wkaj7tMqqBK8UCtVLxr/PwLtfxWKyGQJVL764e+A3lFTSEE
	2Twh88F5MdXcy+io2jg21sK1ZyDPjnpmCHw2E71htSJkjaLnEqIdCgMRy9y1ZStP/+IHeOZ
	ZKbDGY92Q4pOM5a3FMS2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eQdT8VKM/OY=:PX1p5N04E4WSpf+iRLcsD6
	npl95+0WcDG0x/ZjHU0Th7x+gfOulIAo7yaoTzPZNMroiqiuYIvexhReHgFLfDnNFv/4p8L2l
	Uph2GVHsub316HXlYtx05uUp1I1b4wkT10QSpYkci30pLJrQo/o3tE0L3AjzgOwt7LxTVAIYK
	i7IODN+fjBC94Hpeu7Id/fH527HsK0gH5veln1UW9QDFuZ+sFInAFZj+07Z+fHpOELW/s0yER
	7jRWFAf5xJvR9nlIvcMbizBl8EY20DvmiV+1TJvNceQBK1kVCzs8dS3ecvzP9bQsGeWsTSiek
	0LHT41Lp/VvvLewwFc4z7cnBvFPtFjXlQbqQ5XfMHK0QeYKP/Tqwj8MC6DhLehRslNYH6qp+V
	trcJ5SR2ykwovGNHBOwRFUkUIL7xPvTYWmkayQZ9P2HO0RLNnElN+tfrWpiXkYmuKBeutM/dg
	bc48qLLQuFEVEAgOP1HU7nJBqBvWHykH7UheE3yA0vtuFwCsrZDFUkHynIuLj9pfPlLWPcnxa
	570ELq21yjPlt2BbEu3TZcYaNT+jCqUOU1HQBEoeov8tr3NRh21Qzb915W+G4wcIXTvJTb518
	mlVec4sAbZAZHcguvdbXHSRE6vNLmspq0WfSFHA/q6gYxjIUHD3qTXqi06a8PBquQrnpD0UQe
	GZGuVKQcyZQomLXN3dNvROT1UVHeP2u3x1WZpyaxPfo3D/OkfHcbh4Ko1d91qO6Q4Ka8/0S7O
	uDlOVdQpa41+n6N8de8P2fK2e0PJKTHj9rRUULUqRGVvDgLmDmvFy/NzHU8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Message-ID: <20190503111820.UmZd08U2x2eItHdvqlM2jRqLIqPiZRmj2cN1AbEVIYE@z>

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


