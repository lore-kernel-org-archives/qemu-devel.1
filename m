Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1252FC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 12:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA645206E6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 12:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="FKR5bqJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA645206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIAt7-0006uV-Ud
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 08:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jIAsA-00066y-8b
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 08:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dereksu@qnap.com>) id 1jIAs7-0007vs-UU
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 08:47:34 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dereksu@qnap.com>) id 1jIAs6-0007ue-OS
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 08:47:31 -0400
Received: by mail-pj1-x1043.google.com with SMTP id l36so5089585pjb.3
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=5SlRk6rBZ8dnymGltJ4hZn7qF34vW3XQCC+Jy2yQvqo=;
 b=FKR5bqJ10EiSObiSwmloriWAv4VhLPOBYyC3q17NLfYxmPCgCbmvV0f+zgnutwVgV+
 OaISIUGURZJraXAOVN8XWDxHvBWLEHpvM1/5vjlSaUsR+D9upmPujUTjRd4T4CdpC+5g
 Mv0bDAgoN/0RRl90O+RKrzuK4CMHSExdyS0ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5SlRk6rBZ8dnymGltJ4hZn7qF34vW3XQCC+Jy2yQvqo=;
 b=ZeV3izc9RMc1NIEo6/nBv13ZiJr7NSGYkb8ITVgextw72gucapWW963+TDmwd8Rddx
 x1aP6yGUvvzifQ1G0J/9U9jqPQAjK9AJdQH5UOn0swcUtECsurfZH+gpXLUxBTBf58RR
 3sP6nimWMrt1G1AxOAFUkf1ZCl4W1xxqxCcBYLHP7dP7IDiNL6VfcZKx9UA2k4Os9cYV
 8ygawdiTVwqJZ1DeZTKl9XjLBFGEtUbO6tQurOCb2gHJc4HgWPn8EfXmtITya3jlf/he
 FXJTffMMIrE/AxkL+UT3zvELIFCodnGQ/W3cRvlJslLyPb1+atYdWCkEZPRLfU/mJrQc
 j/AQ==
X-Gm-Message-State: ANhLgQ0xSuCAGhfhWY9UqJfHN437q78qDhD3pTczR6p/E12YM8k1Nn6y
 q6/OYujD+rbYkLNxTG0SIxw/Kd2Kwb0=
X-Google-Smtp-Source: ADFU+vuiMnl4BWuLOo8yXl+qa1NbAzZutkNoodvSMfZGdUky1xbrJ2W32a7OZm40xsf+iT69sYBhcA==
X-Received: by 2002:a17:90a:7185:: with SMTP id i5mr5014171pjk.2.1585399648589; 
 Sat, 28 Mar 2020 05:47:28 -0700 (PDT)
Received: from localhost.localdomain (202-39-79-13.HINET-IP.hinet.net.
 [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id k14sm10176468pje.3.2020.03.28.05.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2020 05:47:27 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] COLO: handling of the full primary or secondary queue
Date: Sat, 28 Mar 2020 20:46:44 +0800
Message-Id: <20200328124646.7778-1-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: lizhijian@cn.fujitsu.com, chyang@qnap.com, Derek Su <dereksu@qnap.com>,
 jasowang@redhat.com, ctcheng@qnap.com, chen.zhang@intel.com,
 jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The series is to handle the full primary or secondary queue in colo-compare.

(1) fix the "pkt" memory leak in packet_enqueue().
    Reproduce steps:
    1. Setup PVM and SVM both with NIC e1000 by the steps descripted
       in the wiki qemu/COLO
    2. Run "iperf3 -s" in PVM
    3. Run "iperf3 -c <PVM-IP> -t 7200" in client

    The memory usage of qemu-system-x86_64 increases as the PVM's QMP 
    shows "qemu-system-x86_64: colo compare secondary queue size too big,
    drop packet".

(2) The pervious handling of the full primary or queue is only dropping
    the packet. If there are lots of clients to the guest VM,
    the "drop" will lead to the lost of the networking connection
    until next checkpoint, and therefore decrease the response of service.

    This patch drops the packet firstly. Then, send all queued primary
    packets, remove all queued secondary packets (flush packets) and
    do checkpoint.

Please help to review, thanks.

V4:
 - Remove redundant flush of packets

V3:
 - handling of the full primary or secondary queue according to the
   suggestion from Zhang Chen
V2:
 - Fix incorrect patch format

Derek Su (2):
  net/colo-compare.c: Fix memory leak in packet_enqueue()
  net/colo-compare.c: handling of the full primary or secondary queue

 net/colo-compare.c | 62 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 19 deletions(-)

-- 
2.17.1


