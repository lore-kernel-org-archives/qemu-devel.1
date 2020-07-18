Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF617C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 06:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1552073A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 06:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1552073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx3Fh-0000YO-Ts
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 02:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcarlier@openindiana.local>)
 id 1jx3F5-000066-6g
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 02:56:11 -0400
Received: from [79.97.74.135] (port=56134 helo=openindiana.local)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcarlier@openindiana.local>)
 id 1jx3F3-0006dU-PL
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 02:56:10 -0400
Received: from openindiana.local (openindiana [127.0.0.1])
 by openindiana.local (8.15.2+Sun/8.15.2) with ESMTP id 06ICaXoM003376;
 Sat, 18 Jul 2020 13:36:33 +0100 (IST)
Received: (from dcarlier@localhost)
 by openindiana.local (8.15.2+Sun/8.15.2/Submit) id 06ICaWlE003375;
 Sat, 18 Jul 2020 13:36:32 +0100 (IST)
From: David Carlier <devnexen@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] build: fix for SunOS systems.
Date: Sat, 18 Jul 2020 13:36:22 +0100
Message-Id: <20200718123625.3331-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 79.97.74.135 (failed)
Received-SPF: none client-ip=79.97.74.135;
 envelope-from=dcarlier@openindiana.local; helo=openindiana.local
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 02:56:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 48
X-Spam_score: 4.8
X-Spam_bar: ++++
X-Spam_report: (4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, NML_ADSP_CUSTOM_MED=0.9,
 NO_DNS_FOR_FROM=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 SPOOFED_FREEMAIL=1, SPOOFED_FREEMAIL_NO_RDNS=1 autolearn=no autolearn_force=no
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
Cc: David Carlier <devnexen@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Carlier (3):
  configure: fix for SunOS based systems.
  exec: posix_madvise usage on SunOS.
  contrib: ivshmem client and server build fix for SunOS.

 configure                               |  2 +-
 contrib/ivshmem-client/ivshmem-client.c | 12 ++++++------
 contrib/ivshmem-server/ivshmem-server.c | 12 ++++++------
 exec.c                                  |  8 ++++++++
 4 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.25.4


