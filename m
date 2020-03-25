Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF2C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AF620771
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="JwaImhKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AF620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2bo-0006m9-97
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jH2aP-0005Xr-EG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dereksu@qnap.com>) id 1jH2aO-0005If-BW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:33 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dereksu@qnap.com>) id 1jH2aN-0005HL-Ri
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:32 -0400
Received: by mail-pg1-x541.google.com with SMTP id d17so914844pgo.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=pYVIINF29pTuO7XMDO0+WKNP3sqdPDtyI+zm9KKkUws=;
 b=JwaImhKYeM12Yzn+zKFQL0edCk7na2oZSTp1hjHn+mxv4o24th0SQ+49/baSqRIl4s
 hM78LgAm9ADZ5/OvC3QurC06YJ39x2Ok28ZyNuELT0r1+YcdFW1ouwMivu0UtQF6QlDU
 xk1m9wJB+5lgweaG2CFOkddPhf95T3uNgGR/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=pYVIINF29pTuO7XMDO0+WKNP3sqdPDtyI+zm9KKkUws=;
 b=pFMlK0Vgthtu7clY2ZsOvKwyxgXp6OLkfB8V8YvF+SviviHMvlZ3HhTz+33XOqMwDA
 zgbLq7Hk/X9Zk+QxLogdMrI3mJqRuKuIvzuR5Jbfs4F0DZyHAT+E6ix/XsAY4z/6unGh
 WrGEJWS5aRxggn1Mz8auuA0IpJUGxYUxF48kbdqx+hR5Hw/o46vvbCiJtrzSXLrc2WPa
 vE/gTYcwjuL68OXGMRtMoP3me/WWq3DzPg9AvJEYZPwlAfFAevVMN9auDErqJQYiTD88
 v/fO5K4zejipZkURgX2WFfULrNTqXzD55UC/5SRAurlgp0iBKUugdau9DjFeRgPQXANX
 iWKA==
X-Gm-Message-State: ANhLgQ1Ia3caQNgzIrPD0vZ2EKS0/GFw+mPFgjuGcnEKh16s/uD2OMRx
 vPRnrKrUWY4IVT3Ptc1iyLC3dvWgyHU=
X-Google-Smtp-Source: ADFU+vvbrXGFapFl1GZJV95yBpB4mIG7CF5QAFEr6OzcZ5p4tZjj/+/r+cJ2DqFsaEnJ4Yje5cAUMg==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr2261226pgi.259.1585129469932; 
 Wed, 25 Mar 2020 02:44:29 -0700 (PDT)
Received: from localhost.localdomain (202-39-79-13.HINET-IP.hinet.net.
 [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id j126sm18090602pfg.60.2020.03.25.02.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 02:44:29 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] COLO: handling of the full primary or secondary queue
Date: Wed, 25 Mar 2020 17:43:52 +0800
Message-Id: <20200325094354.19677-1-dereksu@qnap.com>
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
    until next checkpoint, and therefore slow down the service.

    This patch drops the packet firstly. Then, send all queued primary
    packets, remove all queued secondary packets and do checkpoint.

Please review, thanks.

V3:
 - handling of the full primary or secondary queue according to the
   suggestion Zhang Chen
V2:
 - Fix incorrect patch format

Derek Su (2):
  net/colo-compare.c: Fix memory leak in packet_enqueue()
  net/colo-compare.c: handling of the full primary or secondary queue

 net/colo-compare.c | 64 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 19 deletions(-)

-- 
2.17.1


