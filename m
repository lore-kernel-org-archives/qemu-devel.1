Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29053C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99DBE20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSGGxUoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DBE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAzH-0002HI-Da
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <otubo@redhat.com>) id 1kI8j7-0005K7-LP
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:02:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20292
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <otubo@redhat.com>) id 1kI8j5-0006dm-7M
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600167737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LjDfMO3ZJELi55t3tBILfjdpFBlz9uotKXi/pqx/7mE=;
 b=fSGGxUoJOmST5M57HvC3Y3ND3P2w26RHDBE8m/pWcdq1cydWQohm2Kq209gXSLx+1EHPh7
 547DURolzmXP++/mlzWrI3cm0v/PJjxg+DscOrW+YJ4UuEfbuY3krFaEs5nN2fJYdPXaaP
 3CgyDHUAP2qnbxTF2uaP6/gnWqseiP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-otch3Tg0Mlu6qBdI_pD44g-1; Tue, 15 Sep 2020 07:02:15 -0400
X-MC-Unique: otch3Tg0Mlu6qBdI_pD44g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF535802B70;
 Tue, 15 Sep 2020 11:02:14 +0000 (UTC)
Received: from genji.redhat.com (ovpn-115-97.ams2.redhat.com [10.36.115.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26CCC60BE2;
 Tue, 15 Sep 2020 11:02:10 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 0/1] seccomp branch queue
Date: Tue, 15 Sep 2020 13:01:54 +0200
Message-Id: <20200915110155.15362-1-otubo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=otubo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=otubo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Sep 2020 09:15:36 -0400
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
Cc: Eduardo Otubo <otubo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2d2c73d0e3d504a61f868e46e6abd5643f38091b:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200914-1' into staging (2020-09-14 16:03:08 +0100)

are available in the Git repository at:

  git://github.com/otubo/qemu.git tags/pull-seccomp-20200915

for you to fetch changes up to e474e3aacf4276eb0781d11c45e2fab996f9dc56:

  seccomp: fix killing of whole process instead of thread (2020-09-15 12:56:26 +0200)

----------------------------------------------------------------
pull-seccomp-20200915

----------------------------------------------------------------
Daniel P. Berrangé (1):
      seccomp: fix killing of whole process instead of thread

 qemu-seccomp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.18.1


