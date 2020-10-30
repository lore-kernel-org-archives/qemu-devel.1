Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD2C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 04:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9884B20706
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 04:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9884B20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fennosys.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYLgE-0000nI-QW
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 00:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <reader@fennosys.fi>)
 id 1kYLcW-0000HV-6S
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 00:02:32 -0400
Received: from smtp.fennosys.fi ([62.241.241.27]:45662 helo=mail.fennosys.fi)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <reader@fennosys.fi>)
 id 1kYLcT-0005CI-NL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 00:02:31 -0400
Received: (qmail 9371 invoked by uid 210); 30 Oct 2020 04:02:22 -0000
Received: from 49.158.119.22 (antti@fennosys.fi@49.158.119.22) by
 mail01-fennosys (envelope-from <reader@fennosys.fi>,
 uid 201) with qmail-scanner-2.08st 
 (clamdscan: 0.98.7/25972. spamassassin: 3.4.0. perlscan: 2.08st.  
 Clear:RC:1(49.158.119.22):. 
 Processed in 0.035032 secs); 30 Oct 2020 04:02:22 -0000
Received: from unknown (HELO gail) (antti@fennosys.fi@49.158.119.22)
 by 10.200.232.5 with ESMTPA; 30 Oct 2020 04:02:22 -0000
Date: Fri, 30 Oct 2020 12:02:18 +0800
From: Antti Antinoja <reader@fennosys.fi>
To: qemu-devel@nongnu.org
Subject: Live migration not possible from 5.0 to 5.1?
Message-Id: <20201030120218.57ce841be22970274491be08@fennosys.fi>
X-Mailer: Sylpheed 3.7.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=62.241.241.27; envelope-from=reader@fennosys.fi;
 helo=mail.fennosys.fi
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 00:02:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

I couldn't find any mention about live migration incompatibility between 5.0 and 5.1 in the release notes but at least on our AMD based platform live migration from 5.0 to 5.1 is not possible.

The upgraded host had identical versions with it's pair before the upgrade was started:
* qemu 5.0.0-r2
* kernel 5.7.17

After upgrade:
* qemu 5.1.0-r1
* kernel 5.8.16

After reverting qemu back to 5.0.0-r2 migration worked normally.

On the sending end "info migrate" shows:
(qemu) info migrate
info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
clear-bitmap-shift: 18
Migration status: failed (Unable to write to socket: Broken pipe)
total time: 0 milliseconds

At least once the receiving end died (while running 5.1.0-r1). All attempts resulted a "Broken pipe" error on the sending (5.0.0-r2) end.

Cheers,
Antti

-- 
Antti Antinoja <reader@fennosys.fi>

