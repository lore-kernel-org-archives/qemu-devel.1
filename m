Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5CBC4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 17:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C63206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 17:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/lvuw6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C63206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG4ij-0000bf-CN
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 13:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jwsu1986@gmail.com>) id 1jG4hk-0008It-IB
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jwsu1986@gmail.com>) id 1jG4hj-0005tw-Jj
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:48:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:41451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jwsu1986@gmail.com>) id 1jG4hj-0005sA-F5
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:48:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id t16so4854930plr.8
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Tw6TZag1rN3xcTxLCUtj/Pzrexg2kHttRCpB9ZuYSJU=;
 b=H/lvuw6VagsZT15cAbfwJfQm02FTo8s6ytH3CxI0uxESL1oaPHsAboG/BObZlgBk5s
 vYTtLe+7qlkjpNsr/0SrY6ByDot9J2PB8edUqY/vvYFXK7vDl6x/c4DWj/5h+Fcql8/u
 P0OPAo3ZDqXhGU16UM7uaNnUMJr4tyiDwQi2wC33JmGgCRzLthvEWpSs4XoDuw1Da2K1
 AXw2xQcRkSeg7oHrvqv8272vYCNQ+tMRZyMj8YngPva4+N5uJXHCrfIUkU2TFxcRA4+M
 fomHrUKexoiymtZaQRTPe142JnEx9iQPVIgoE4++QGojN2TywoiHhZ+htgHlrycecxUr
 T/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Tw6TZag1rN3xcTxLCUtj/Pzrexg2kHttRCpB9ZuYSJU=;
 b=Wg/2QtPjT2WoRpE+ywtwP3jFNjgqDlXPs1hQ4UrBxidq75nmJnwdVNiUZSg3+uSvGK
 mpANIYwUUr6i5J6Ix8AwvLPzaaBBjFQVv6ggeaheGkrRUP5cXe/K98kgZI5dzh5aBCWn
 /STUO9bFN70LhFuKfh7tns4rroNPdx0HqoJzHijAPefk5BjXZfn1tftVbXpvFuxkm8mD
 JrXnhEwGRolhNGmzG9y9+w8hZ7hAAEIg5UD1hEQ3oMe0ewxGwZa9YfifVM9Yb/qdkR05
 xgLKfBvg3TzFIja3vHzNC1jRuh4mJ+5yoEtEN/Im2w3lm9DqICkgPZoTDOa65D7KaHax
 SPpw==
X-Gm-Message-State: ANhLgQ2udC1QdAirNOwCG6/9doacPI9jqj4/DDodQX47+jPugAQaCPbY
 S5lGriJxoDrOQjRfFIOXU8hQKvXuro1wIg==
X-Google-Smtp-Source: ADFU+vtcAJSqioCL74PWMe4+exAAQ8pcb97mgj29M2SGW9VS/ozWzOE16xS/jRLVtUXXJzZ1AY1NTQ==
X-Received: by 2002:a17:90a:ba17:: with SMTP id
 s23mr20241782pjr.162.1584899285930; 
 Sun, 22 Mar 2020 10:48:05 -0700 (PDT)
Received: from localhost.localdomain (1-161-253-93.dynamic-ip.hinet.net.
 [1.161.253.93])
 by smtp.gmail.com with ESMTPSA id w19sm10460410pgm.27.2020.03.22.10.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 10:48:05 -0700 (PDT)
From: Derek Su <jwsu1986@gmail.com>
X-Google-Original-From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] COLO: Fix memory leak in packet_enqueue()
Date: Mon, 23 Mar 2020 01:47:50 +0800
Message-Id: <20200322174751.12559-1-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
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
Cc: dereksu@qnap.com, chen.zhang@intel.com, jasowang@redhat.com,
 lizhijian@cn.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch is to fix the memory leak in packet_enqueue().
The allocated "pkt" needs to be freed if the colo compare
primary or secondary queue is too big to insert.

Reproduce steps:
(1) Setup PVM and SVM both with NIC e1000 by the steps descripted
    in the wiki qemu/COLO
(2) Run "iperf3 -s" in PVM
(3) Run "iperfs -c <PVM-IP> -t 7200"

The memory usage of qemu-system-x86_64 increases as the PVM's QMP 
shows "qemu-system-x86_64: colo compare secondary queue size too big,
drop packet".

Please review, thanks.

V2:
 - Fix incorrect patch format

Derek Su (1):
  net/colo-compare.c: Fix memory leak in packet_enqueue()

 net/colo-compare.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

-- 
2.17.1


