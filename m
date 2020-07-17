Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074B3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C731420717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="jwPmQ1Rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C731420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMn5-0002lH-1e
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jwMm4-0001U7-EY
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:35:24 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:36928 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jwMm2-0005WN-Lt
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:35:24 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id CA7DB4C91B;
 Fri, 17 Jul 2020 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1594978519; x=
 1596792920; bh=Tf9KBHLOHs+MQbwmblmYxrqD9OWkzldHGBFrdeablg8=; b=j
 wPmQ1RcSHZfCXGOyb0+Vpphcmfj8ejAh20ceS57Es77iNh/hAFzxKkYKQxGJ7a1K
 44YIxW7/qm4xdbHSTBQ1IdMlbeRobAwDvITBQRPhWbaM7UDF11NLNdkK5zIDe9Gl
 MSkATx80GWzRDh0jfjj7OEHehSSNc4IV61ZnxP2lPI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YfqTvGQbxtwa; Fri, 17 Jul 2020 12:35:19 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 770B24C911;
 Fri, 17 Jul 2020 12:35:19 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 17
 Jul 2020 12:35:19 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/4] Add dtrace support on macOS
Date: Fri, 17 Jul 2020 12:35:13 +0300
Message-ID: <20200717093517.73397-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:35:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is a small series that enables dtrace tracing backend on macOS.
Whether or not it should go to 5.1 is up to discretion of tracing
maintainers.

Thanks,
Roman

Changes since v1:
 - Fixed a typo ANSI C to C99, wrt to _Bool in the first patch.
 - Prevented a few [-Wpointer-sign] warnings by converting int8_t * to
   signed char * in static probe definitions.
 - Moved COLO packet dump under #ifdef DEBUG_COLO_PACKETS (Daniel).
 - Separated tracepoints in net/filter-rewriter.c to use matching
   is-enabled probe (Daniel).

Roman Bolshakov (4):
  scripts/tracetool: Fix dtrace generation for macOS
  scripts/tracetool: Use void pointer for vcpu
  build: Don't make object files for dtrace on macOS
  net/colo: Match is-enabled probe to tracepoint

 Makefile.objs                 |  2 ++
 net/colo-compare.c            | 42 ++++++++++++++++++-----------------
 net/filter-rewriter.c         | 10 +++++++--
 net/trace-events              |  2 --
 scripts/tracetool/format/d.py | 15 ++++++++++++-
 scripts/tracetool/vcpu.py     |  2 +-
 6 files changed, 47 insertions(+), 26 deletions(-)

-- 
2.26.1


