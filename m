Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600C1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF0A20727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF0A20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZe8R-0003Bj-Cu
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani.sinha@ani-sinha1.localdomain>)
 id 1jZe7b-0002TY-Js
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:27:43 -0400
Received: from [192.146.154.243] (port=36064 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@ani-sinha1.localdomain>)
 id 1jZe7a-0000y4-HX
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:27:43 -0400
Received: from ani-sinha1.localdomain (ani-sinha1.dev.nutanix.com
 [10.41.71.199])
 by mcp01.nutanix.com (Postfix) with ESMTP id 8E4A81018F82;
 Fri, 15 May 2020 17:27:41 +0000 (UTC)
Received: by ani-sinha1.localdomain (Postfix, from userid 16671)
 id 88AB06BCD; Fri, 15 May 2020 17:27:41 +0000 (UTC)
From: Ani Sinha <ani.sinha@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2] Add a new PIIX option to control global PCI hot-plugging 
Date: Fri, 15 May 2020 17:27:29 +0000
Message-Id: <1589563650-70820-1-git-send-email-ani.sinha@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <[PATCH] Add a new PIIX option to control global PCI hot-plugging>
References: <[PATCH] Add a new PIIX option to control global PCI hot-plugging>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.146.154.243 (failed)
Received-SPF: none client-ip=192.146.154.243;
 envelope-from=ani.sinha@ani-sinha1.localdomain; helo=mcp01.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 13:27:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_05=-0.5,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NO_DNS_FOR_FROM=0.001,
 RDNS_NONE=0.793 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, ani@anisinha.ca,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed the build breakage. Sorry for breaking the build.


