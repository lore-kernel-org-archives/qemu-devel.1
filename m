Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D1C2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 02:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8EB20730
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 02:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="YNB6PYJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8EB20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMizU-0004DU-MC
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 22:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jMiyp-0003my-SG
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 22:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dereksu@qnap.com>) id 1jMiyo-0005hU-T7
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 22:01:15 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dereksu@qnap.com>) id 1jMiyo-0005hB-Gj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 22:01:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id n13so358697pgp.11
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 19:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=c/33Py62M7Xn8XKMcboW+p7UjaygNrGrVbdCb/e9EIs=;
 b=YNB6PYJt33AeNXohaHM3z2WFEzEe8d0NagDshBeywf0KQEutQnDwtks2LEhHbpMlLT
 s5uJ6cQkBiV+5USq/M1aBn0Rl+t5DSfmvqqG0kLRPcuYD+HFHwWci8Y4p08lp2ryDUR9
 3pwbh8HtuGm9LZb3yBQNl4KTRHqYO6U2MaoUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=c/33Py62M7Xn8XKMcboW+p7UjaygNrGrVbdCb/e9EIs=;
 b=Az0b994vHZAIMLzIlnXRl5mImoxHE3FK9St2CfhJ2Xj8IWCzhmFDFlWv9C1By9l9EZ
 JPy/22POtUq5QzI0DrZCkuqfRkGRe0h5MmwmhQnCFDPNftRf9HKCKryimAEw2vhC8bRm
 gU7k5W9E0b+HdYM/2GgYAHo2mFvkwEoRG/aQ8bWMr4UstQq19+u2fZCi20m5w72oZLT8
 TNl2Yjh9r9a1Yc4gArwOvVBFih6c4HfU9e/0Nbw1nSshKUgXqGKiGNC+WhoyxUl5jOcl
 Kb2VExV9THJPLzsVAGlIxL11S3DU63Tj+kHbJAf0Day/pOjhMuChwoNsb3joMUewm9fC
 QF1g==
X-Gm-Message-State: AGi0PuZGVYzUAX6QyJbtLdRTbY5kb51cSxlGALshisiBMmxzzRnQUWKm
 61ly+iYqKVY/hzr5FmdxbOpJLdAmz8U=
X-Google-Smtp-Source: APiQypJ9/IPOXkOcIuRNqDxs6jdbB1CrZXhi5spOKWv9xlEOqFY4mn99ibSpiy217ap1/naCT+DjXw==
X-Received: by 2002:a05:6a00:2d0:: with SMTP id
 b16mr2836565pft.241.1586484072781; 
 Thu, 09 Apr 2020 19:01:12 -0700 (PDT)
Received: from localhost.localdomain (202-39-79-13.HINET-IP.hinet.net.
 [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id l15sm360884pgk.59.2020.04.09.19.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 19:01:11 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/1] COLO: handling of the full primary or secondary queue
Date: Fri, 10 Apr 2020 10:00:55 +0800
Message-Id: <20200410020056.12104-1-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

Fix the "pkt" memory leak in packet_enqueue().
Reproduce steps:
1. Setup PVM and SVM both with NIC e1000 by the steps descripted
   in the wiki qemu/COLO
2. Run "iperf3 -s" in PVM
3. Run "iperf3 -c <PVM-IP> -t 7200" in client

The memory usage of qemu-system-x86_64 increases as the PVM's QMP
shows "qemu-system-x86_64: colo compare secondary queue size too big,
drop packet".

Please help to review, thanks.

V5:
 - Replace the error_report of full queue with a trace event
 - Remove handling of the full primary or secondary queue which hurt
   network throughput too much

V4:
 - Remove redundant flush of packets

V3:
 - handling of the full primary or secondary queue according to the
   suggestion from Zhang Chen
V2:
 - Fix incorrect patch format

Derek Su (1):
  colo-compare: Fix memory leak in packet_enqueue()

 net/colo-compare.c | 23 +++++++++++++++--------
 net/trace-events   |  1 +
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.17.1


