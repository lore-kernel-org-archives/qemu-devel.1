Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D2CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F215A2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3qKfNVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F215A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9Vc-0004Ag-0m
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9Um-0002nV-TM
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9Ul-0006K1-07
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gHRV6AmRp4A3g5q3egsMO9ZI/6r+vIQh3PjbohZqqjs=;
 b=L3qKfNVIO9bRSkzH88saiBOT9R7pLhGrGtY05QhPNf3RG+WdcZDwo+aTdDqjuADuoQsO8P
 UeeynyfNVSFGjAcxS39DM3UE7UMNp2F2c+lzO9WLxyZ0Q5JSJbduNOXlJecNMsRkEY+qrg
 jBrp4cbbsHpZLjEOpwv7ql0t9VRt2Jg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-E5htKLXQNEeYVFwGyeErNw-1; Fri, 05 Jun 2020 06:22:35 -0400
X-MC-Unique: E5htKLXQNEeYVFwGyeErNw-1
Received: by mail-wr1-f71.google.com with SMTP id a4so3594838wrp.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gHRV6AmRp4A3g5q3egsMO9ZI/6r+vIQh3PjbohZqqjs=;
 b=P6UqOSNQqTDEa85YndCaQPUTrbFCFdxcmRe+jwl16fc1PEWCSDIzECb8M8WLHMHsdR
 J6HV5LdTa8dO70FdedQPqSD1GW9efJsEbM7sAdw9LA5qAI0fBDNLzq9R7Tbfty+b2tOe
 oC60RH3wcwd4GSwZmjsvx4O5AIvdEBe3aEBKygi9yBQvSDQUKzJVnF/JDearg7+JWmBN
 CJAL+FIxU1cUV8JkpREiY3ZVxQD+U9o3OqwOhAR5ZCPo1GVB3KuJ2ZUqaIeixNLI4Qqs
 rpJtPl+QWxkQNcMDR/XzxwHXVkDDxnTM1lI3TUpTC+Fx2MinlGktmAhDQOcIT8qOi0KN
 /7aQ==
X-Gm-Message-State: AOAM531l9uTXOcc5Njdw7vnjI2LQuUJldk6gKgDpmkjkFE3SCLtpeitd
 27GowFkkpI4DWkz80uxrdRk6RwITvC4gxkxMum8TG+1QYsCp1BuXo1vnuCf2SJ/HOR6Vhjv2liI
 84FjqFgpxn22MZIw=
X-Received: by 2002:a1c:ed08:: with SMTP id l8mr1970335wmh.169.1591352552918; 
 Fri, 05 Jun 2020 03:22:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwszGYSZwr5xdaneI5D3TRJIb0nrReVgJgIndUgJcmjB4CwG5XEKX521nU4bF9Cevjeb1o5ag==
X-Received: by 2002:a1c:ed08:: with SMTP id l8mr1970314wmh.169.1591352552661; 
 Fri, 05 Jun 2020 03:22:32 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id w15sm10861047wmk.30.2020.06.05.03.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:22:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/11] hw/sd/sdcard: Fix CVE-2020-13253 & cleanups
Date: Fri,  5 Jun 2020 12:22:19 +0200
Message-Id: <20200605102230.21493-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patches 2 & 3 fix CVE-2020-13253.
The rest are (accumulated) cleanups.

Supersedes: <20200604182502.24228-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (11):
  MAINTAINERS: Cc qemu-block mailing list
  hw/sd/sdcard: Update coding style to make checkpatch.pl happy
  hw/sd/sdcard: Do not switch to ReceivingData if address is invalid
  hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
  hw/sd/sdcard: Update the SDState documentation
  hw/sd/sdcard: Simplify cmd_valid_while_locked()
  hw/sd/sdcard: Constify sd_crc*()'s message argument
  hw/sd/sdcard: Make iolen unsigned
  hw/sd/sdcard: Correctly display the command name in trace events
  hw/sd/sdcard: Display offset in read/write_data() trace events
  hw/sd/sdcard: Simplify realize() a bit

 hw/sd/sd.c         | 122 +++++++++++++++++++++++++++++----------------
 MAINTAINERS        |   1 +
 hw/sd/trace-events |   4 +-
 3 files changed, 83 insertions(+), 44 deletions(-)

-- 
2.21.3


