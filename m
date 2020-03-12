Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB4DC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674DC20674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674DC20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCPbp-0003d2-Kz
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCPYW-0005yA-C7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCPYV-0001BV-4b
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:15:28 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46405)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jCPYU-0001Au-Iv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:15:27 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZkxd-1irBox0ELf-00WirU; Thu, 12 Mar 2020 16:15:24 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Q800 for 5.0 patches
Date: Thu, 12 Mar 2020 16:15:20 +0100
Message-Id: <20200312151521.38902-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S6Z8manpFWaWmR1ifFWpTepc+I7seXBPPhZ11aCE07m+L+keXZW
 zKaPbqy8f2aeKRGNT0QUAoBwuNH9l3TmrnEVHBPipRZNB5Ay6Sg/+K8XzqA6clZT0zbNCR5
 Tge1m0XtzWAofCs75v1JIgfusIcBlPAUFig8MRdNFzMrtHHbygJi62ix+SJI4w9o7IgJbxC
 N8alPiXNh1AUmiTQtZPqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MXiY7Yd6f8s=:dLOJILr+Sivkkf2c93d+AD
 Nk4/sDu4vXzfgH2GOU8NZrA//vYEdmG5c+kksu9hfCltof/wvpP1ZcHP1t65DV0SMOwKHmCGX
 XG2ahhG/NzCNUnQpl1b5wn3/2JpI/fOwVxbIm9eMuENnZjiCp1VG52Uy1gAAesiVt8a4dx6rI
 iQGGmKvVea9HKW68sTeYSo9/4/k/+ptHRU3++rD2s2fr2syRyH0Fo+FzhWbost/V2v2RWd0ta
 o6/LnN5m4Lhhl57LXIqOxxTkrQqpr/yM8T41NNhYPJLzcdxu/oexXHNuvX2Ku30s1yKpQ+5yo
 Ci67NwnvRo0JPM5axM+GeMX4nS3Y6QUf0c8shtTyosPXj4ebvxp7HNqSmCNpsuMciWrmVVtjE
 owrBeI/qL+4rI38BHNXm5GuyXLoCfhA/uyb7S7reOmqiSzNE+mFt2xJ8eDFhF3a2L1LhgmwdM
 NStRr0oV2UnnQs++rXPW1RX2axk1RRWE25dTgl11jgCHGtA/2QmJ/JzZXrGddgy3ROXvkjBA1
 mzuSAGs+86d5Zgy0dexV0B5qDw45D84rRolukDOyQPY8OAhpM0DEVajsQeCEN3kKrVI7tbxit
 vFzcIIPHOB+pU2S38T4FacgVdZ7ckMgsvArlBZ6uy8OIXzdVRmkzydYmE/g6z6gMi1QpXPjM/
 /SqOtiwL5RJHxBhH9JZSpSbJy5K8y2HjFRnI8Tbha05O3wPemSCAIwV7LhYhTvyp4YmPdX3bj
 AE5ROg3ep6NHsHEy9K+mBT+LoHihfBzbsExl5Zbi+RiqQNKMpJvG6kqDL+A4q9PfWgGYdev4c
 bgqFX8d/MeJ3rjXoVQ1JBYfi34rgFofiImcWBY7MzvBzQ/8Un0zRvsev8sLL0caejnrsWif
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 104933c4a973960dea605b06fcd5d0d478255d77:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2020-03-03 12:03:59 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/q800-for-5.0-pull-request

for you to fetch changes up to 80aab795f8a6d53cdeb55cc6ffac50b5e5ce9dc2:

  q800: fix coverity warning CID 1412799 (2020-03-12 16:05:48 +0100)

----------------------------------------------------------------
Fix Coverity CID 1412799 (Error handling issues)

----------------------------------------------------------------

Laurent Vivier (1):
  q800: fix coverity warning CID 1412799

 hw/misc/mac_via.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.24.1


