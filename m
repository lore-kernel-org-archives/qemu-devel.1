Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280E1C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F172070A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3cBZ5qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F172070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaHe4-0005l7-Um
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 07:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaHcR-0004Vi-9p
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:38:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaHcQ-0001Gx-0g
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:38:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1so8485067wrt.5
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 04:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iZQKN0pc0b5g9xhtt8kSxwYDHXfpHBXNle9DvZFVGfQ=;
 b=o3cBZ5qk9pdkKQ5WVQQil+MGMJdsMQzoYZpV/ChFMZnlbBvjF2QC3TeXAS42Ohg20b
 GBh90hE29AToauGiqHMcilr1KVU6QQBe62WmKxxNr9V6DP215O5xcUpinUQwcwlTQYCo
 3j83zuaeg6BMUA0sFCwxbrbdy7WKhwi6Dc7OngfglxG+LzUgiiKfue+NVffbYICJrMxh
 TiSnk5H24EvJZN90Sp9WMw5hsdAydslSDqnQQFhAXOR0zjXLD8RInaxP0k7VwUZJd3xs
 zZIphl0LPV95yXWXksqxEMhkCvx56W566MB2LKXPMezRVM1//Xzx6UDBSlkU8TfntpLn
 aizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=iZQKN0pc0b5g9xhtt8kSxwYDHXfpHBXNle9DvZFVGfQ=;
 b=TV2IIgY6hFnVbkvjl4gr0dfstdiWpIlGnUfTR66IChtIC5aKTcxwbYmkBZJu32aFtB
 fbhBKPB020f4/PZaRXZWhPnPKyGWiTbxipzcG3NzJrH8EmzyNSEj3WWPtHsvAu4Bxn7d
 av9qrvw0ZBlqVok/acK6QI5ncCIFkAVarMciaNvgcValie60mLAp11G32Az1vebWhIRf
 yz+byzU5rDc1KIqpggs+oMuOT8LUyt2f0YcmSbjLrE873solAlhpzqraWCkzwQnwSIOO
 HA4stQEamvLnRPsfYFSqrqnnts8G/5+0RRrjIzaiX/i+wnoaT8tJSEeRHb79Q6ZB6/rr
 4VMw==
X-Gm-Message-State: AOAM532yUqI13gH5ZPcL8mHOC+PtyfnzYu9kOEHD5xDdvCVNX7hyjoKo
 xTnBlUZmb3//5UIisrC6m3XwJXMXXqk=
X-Google-Smtp-Source: ABdhPJywbQGLtOFM51FMTgcuro+RGUxLPXdtGlsRU1eszeV1IPclrdIGqd5kcWsDQsBFha4fzRoTZg==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr13290977wrr.337.1589715488443; 
 Sun, 17 May 2020 04:38:08 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id u10sm11660451wmc.31.2020.05.17.04.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 04:38:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/2] exec: Fix (too) short device accesses
Date: Sun, 17 May 2020 13:38:02 +0200
Message-Id: <20200517113804.9063-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Xu <peterx@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Something noticed while debugging Alexander's bug report
"Hang with high CPU usage in sdhci_data_transfer":
https://bugs.launchpad.net/qemu/+bug/1878054

The flatview ignores the MemoryRegion minimum access size.

It seems related to a similar issue Julia had with PCI
devices.

Not sure it is safe enough, have performance penalties
and so on, so RFC.

Philippe Mathieu-Daudé (2):
  exec: Let memory_access_size() consider minimum valid access size
  exec: Do not let flatview_read/write_continue do (too) short accesses

 exec.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

-- 
2.21.3


