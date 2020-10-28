Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80D6C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1409D2475E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UL9kOO8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1409D2475E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmG8-0007io-VT
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kXmEh-0006ku-AT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:15:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kXmEf-0006Hc-5B
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:15:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SEEmhL001761
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=G8z/Iz/lhYF2LNYIGT6KwQiRJ6oZD6FEy8iWCcApOJQ=;
 b=UL9kOO8sAaes6Nky2ElmkumQuR0/dqvpOIZebftkNmZxHdHaOwzct2AzBVfP8AK5kfPW
 ZWSZAQYlHxXiVVzEwZ1nTPo1ujCzO8vA95FuzBXizNwp0X2cFf9euagOjQQj0N2ikLK4
 pDEE7z91MXjwR3i8M6lpFkiamAzZfvhwZzrOPeSFU0d2pcTKEjGDs4GBBCeuhv78hCE6
 zV7J2dxKj2aXzdT1R858xMwmU4MRZgCwjX/dBCiTqEW6z152ZTQ7wwpIrJpEz2BC8lkn
 XQWtyK2RNEkAG1B0nNmKaLeH8lR9TKTzsiaSvek8TT2CIsG16DxFudHhlvDu5bGauar0 ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 34dgm458sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SEATdw007291
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 34cwunn27p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:27 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09SEFQIm012058
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 14:15:27 GMT
Received: from mihai.localdomain (/10.153.73.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 28 Oct 2020 07:15:26 -0700
From: Mihai Carabas <mihai.carabas@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Add support for pvpanic pci device
Date: Wed, 28 Oct 2020 15:32:53 +0200
Message-Id: <1603891979-11961-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=1 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280097
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=mihai.carabas@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 10:15:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Mihai Carabas <mihai.carabas@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset adds support for pvpanic pci device. The patchset was assembled
from chuncks from some old patches [1] from 2018 which were left unmerged and
some additions from me.

How to test this:
/usr/bin/qemu-system-aarch64 \
        -machine virt,gic-version=3 -device pvpanic-pci

After that you need to run a Linux kernel as guest, but you have to also apply
the patches I will send for adding pci support for the pvpanic driver.

[1] http://patchwork.ozlabs.org/project/qemu-devel/cover/1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn/

Mihai Carabas (1):
  pvpanic: break dependency on ISA_BUS adding PCI

Peng Hao (3):
  hw/misc/pvpanic: Add the PCI interface
  hw/arm/virt: Use the pvpanic pci device
  pvpanic : update pvpanic document

Philippe Mathieu-Daudé (2):
  hw/misc/pvpanic: Build the pvpanic device for any machine
  hw/misc/pvpanic: Cosmetic renaming

 default-configs/devices/arm-softmmu.mak |  1 +
 docs/specs/pvpanic.txt                  | 12 ++++-
 hw/misc/Kconfig                         |  2 +-
 hw/misc/meson.build                     |  2 +-
 hw/misc/pvpanic.c                       | 96 +++++++++++++++++++++++++++------
 include/hw/misc/pvpanic.h               |  3 +-
 include/hw/pci/pci.h                    |  1 +
 7 files changed, 97 insertions(+), 20 deletions(-)

-- 
1.8.3.1


