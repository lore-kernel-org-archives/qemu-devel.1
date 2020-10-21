Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CAFC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 08:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484A921789
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 08:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484A921789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV9ga-0000Ee-VZ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 04:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <likejun6@huawei.com>)
 id 1kV8dn-0002n4-Po; Wed, 21 Oct 2020 03:34:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5710 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <likejun6@huawei.com>)
 id 1kV8dk-0004Jf-W1; Wed, 21 Oct 2020 03:34:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0EFC9E016ABEDCB894A8;
 Wed, 21 Oct 2020 15:34:19 +0800 (CST)
Received: from DESKTOP-IB00AOP.china.huawei.com (10.174.184.163) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 21 Oct 2020 15:34:12 +0800
From: <likejun6@huawei.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH 0/4] Test qemu-img with different options
Date: Wed, 21 Oct 2020 15:33:51 +0800
Message-ID: <20201021073355.2499-1-likejun6@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.163]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=likejun6@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 03:34:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 21 Oct 2020 04:40:11 -0400
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, mreitz@redhat.com, likejun <likejun6@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: likejun <likejun6@huawei.com>

This patch set add those iotests:
308: Test thick image creation, size and rw;
309: Test raw thin provisioned image creation, size and rw;
310: Test falloc image creation, size and rw;
311: Test backing file is raw;

likejun (4):
  qemu-iotest: add 308 testcase
  qemu-iotest: add 309 testcase
  qemu-iotest: add 310 testcase
  qemu-iotest: add 311 testcase

 tests/qemu-iotests/308     | 104 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/308.out |  21 ++++++++
 tests/qemu-iotests/309     | 102 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/309.out |  21 ++++++++
 tests/qemu-iotests/310     | 104 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/310.out |  21 ++++++++
 tests/qemu-iotests/311     |  70 +++++++++++++++++++++++++
 tests/qemu-iotests/311.out |  30 +++++++++++
 tests/qemu-iotests/group   |   4 ++
 9 files changed, 477 insertions(+)
 create mode 100755 tests/qemu-iotests/308
 create mode 100644 tests/qemu-iotests/308.out
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out
 create mode 100755 tests/qemu-iotests/310
 create mode 100644 tests/qemu-iotests/310.out
 create mode 100755 tests/qemu-iotests/311
 create mode 100644 tests/qemu-iotests/311.out

-- 
2.19.1



