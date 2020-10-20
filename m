Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB681C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E5122247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7ZEMjWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E5122247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtkn-0007zn-Ip
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUtjl-0006al-CO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUtji-0001Q0-D3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603208380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=TtIu8YBvVoyfhRPP6OkK9QJqKZ1HwKQD2QaAF7d1S/4=;
 b=i7ZEMjWJHGdrx671b/feGFwB1ql7QnYg6iQmxC+2H83KvK4Pjq22zucVl1W0V3FGJvtLHA
 V5Src579+tdEWLyxhCH15ev+vMQLqD5MnQrc+iRuw3OQlhztahC6W1pbZ0Cbo7Qb3yIXi3
 TnO87SkQLZo+eL91NqI4T9pEPpp1boE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-iAaM3qhPMiamqcYR5Nd6Ag-1; Tue, 20 Oct 2020 11:39:39 -0400
X-MC-Unique: iAaM3qhPMiamqcYR5Nd6Ag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5A2B18A8223;
 Tue, 20 Oct 2020 15:39:37 +0000 (UTC)
Received: from thuth.com (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D92A55B4A1;
 Tue, 20 Oct 2020 15:39:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] sh4: Trivial clean-ups for sh_timer.c
Date: Tue, 20 Oct 2020 17:39:32 +0200
Message-Id: <20201020153935.54315-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix coding style, add fallthrough anonotations and remove superfluous
break statements in hw/timer/sh_timer.c.

Thomas Huth (3):
  hw/timer/sh_timer: Coding style clean-up
  hw/timer/sh_timer: Silence warnings about missing fallthrough
    statements
  hw/timer/sh_timer: Remove superfluous "break" statements

 hw/timer/sh_timer.c | 90 +++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 32 deletions(-)

-- 
2.18.2


