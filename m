Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67512C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7FA207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7FA207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5spT-0007nh-G6
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 11:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5sot-0007Fg-UM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:37:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5sos-0004Cb-JS
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:37:39 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-hVx6tSswOl63GUCFEhl_iw-1; Wed, 12 Aug 2020 11:37:34 -0400
X-MC-Unique: hVx6tSswOl63GUCFEhl_iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A6718B9EC2;
 Wed, 12 Aug 2020 15:37:33 +0000 (UTC)
Received: from bahia.lan (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 523CC49F7;
 Wed, 12 Aug 2020 15:37:32 +0000 (UTC)
Subject: [PATCH] mailmap: Add entry for Greg Kurz
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Wed, 12 Aug 2020 17:37:31 +0200
Message-ID: <159724665142.75339.817685642171828648.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I had stopped using gkurz@linux.vnet.ibm.com a while back already but
this email address was shutdown last June when I quit IBM. It's about
time to map it to groug@kaod.org.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 .mailmap |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 81c2ce09370c..896e2d195d86 100644
--- a/.mailmap
+++ b/.mailmap
@@ -48,6 +48,7 @@ Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.c=
om>
 Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
+Greg Kurz <groug@kaod.org> <gkurz@linux.vnet.ibm.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
 Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>



