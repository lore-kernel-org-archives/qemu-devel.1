Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F3C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4395208E0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3s7I/IW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4395208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7Ft-00056h-NT
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jH7Et-0003bx-CZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jH7Es-0005SZ-Ac
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:39 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jH7Ep-0005Pt-UY; Wed, 25 Mar 2020 10:42:36 -0400
Received: by mail-pj1-x1044.google.com with SMTP id q16so2344069pje.1;
 Wed, 25 Mar 2020 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ybJNhwTs4hcuyCloEUZpI15gh8XakkuQg56/8GwxtK0=;
 b=F3s7I/IWN/gJMoGrqgg6JVZsfJFoyzvEh7q9j8haqxvpTwcf1h+aBoKmMAddVyCWK9
 aLMPKNrjA2LRqpeGeqpGqXL4gm582uKKji5dB01akLtm63kY+1brgoIPsQOAS1IJGTso
 oeRO8NoeUyl6gFz9uTzXuqpRgvujxz1QDLVwq71bybuOjmj8xsJFN2LZIXCUs//YyeDB
 JmOTGnM0N17LAZEoJPMBohCC/kcihuHiQFUHHu1JvNrgZuQD8Kt4noFpX0SU0wqWUl3m
 Deq4JEvfAH6lD6ixM0sE3xVNHBhyw27/54yVPe22QqQuLWGrL0z7FA6PWhFYAnf7cxAw
 xcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ybJNhwTs4hcuyCloEUZpI15gh8XakkuQg56/8GwxtK0=;
 b=kLWv95VzPCxHLjhY1FnmY8h4z7v0NuQLiHpJCRtaMr2SPjScLn0jVaRbGawTmvpEDe
 yRKclYKV4AshslFO3MxzKqYoKRhp5zxc1Cbz7K6gjlhcxsIzn2obezvRrdGHA4ag4EGh
 Heu9cfvmNmxV0EnWhujjyrLviIjmwh5au4ujU9h7C/cBh70GlOPkIEzu9s3ytnFYHiRS
 hJOJSUzRzagkqry2b5EwwKRvtAkH1gb+zqQjgOWE643qUMqysSEa6rNWSrXj4Nf9UXZa
 F9TWgNEus0udX4hUXwpaSB76VzQVs/zcE4Itlz7uSWWhC1wILNI5GVi7xGV/3OKaMEq8
 o7Qg==
X-Gm-Message-State: ANhLgQ0rD1sSNhy+lrr39JLNNXqSlDX9OCLQziYTyJFIWqKhkg8tCFgU
 whLoJENCSXBgTeLTfLYm4CtXMyQZ
X-Google-Smtp-Source: ADFU+vvOlle3eizRMEAorKEFAfeYcuag56glbUMbMerk7FJsG5ykbckc5fF/+xDPbkfbMeqZPpJN7g==
X-Received: by 2002:a17:90a:c790:: with SMTP id
 gn16mr4147840pjb.146.1585147354485; 
 Wed, 25 Mar 2020 07:42:34 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id 93sm4609599pjo.43.2020.03.25.07.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:42:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 0/5] ppc: sreset and machine check injection
Date: Thu, 26 Mar 2020 00:41:42 +1000
Message-Id: <20200325144147.221875-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds nmi injection for pnv, and similar mce injection for
spapr and pnv. The mce injection has already uncovered quite a
few bugs in Linux papr guest and one in pnv host code, so it
has been already very useful. The mambo simulator can do similar
injection but it's a bit more clunky and needs to run KVM and
QEMU in the sim to test papr guests, which is quite slow.

HMIs like timebase corruption would be another good candidate
for error injection.

Thanks,
Nick

Nicholas Piggin (5):
  ppc/spapr: tweak change system reset helper
  ppc/pnv: Add support for NMI interface
  nmi: add MCE class for implementing machine check injection commands
  ppc/spapr: Implement mce injection
  ppc/pnv: Implement mce injection

 hmp-commands.hx              | 20 ++++++++-
 hw/core/nmi.c                | 61 ++++++++++++++++++++++++++
 hw/ppc/pnv.c                 | 85 +++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr.c               | 63 ++++++++++++++++++++++++--
 include/hw/nmi.h             | 20 +++++++++
 include/hw/ppc/spapr.h       |  3 ++
 include/monitor/hmp-target.h |  1 -
 include/monitor/hmp.h        |  1 +
 monitor/hmp-cmds.c           |  1 +
 target/ppc/cpu.h             |  3 +-
 target/ppc/excp_helper.c     | 17 ++++++--
 target/ppc/monitor.c         | 11 +++++
 12 files changed, 275 insertions(+), 11 deletions(-)

-- 
2.23.0


