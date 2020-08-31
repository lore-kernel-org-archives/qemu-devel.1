Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1779CC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2EB20866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2EB20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCiH2-0005ZU-34
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kCiGF-0004jG-OX
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:46:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kCiGC-0005df-6F
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:46:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 12EF3AF00;
 Mon, 31 Aug 2020 11:46:02 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Subject: some mason warnings during latest master build
Message-ID: <ff4e5f09-fb36-8ab6-1c40-210193e2676b@suse.de>
Date: Mon, 31 Aug 2020 13:46:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 20:03:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hello Paolo,

just FYI I am getting a few WARNINGS on latest master with mason, not sure if you get them as well:

./configure --enable-tcg --disable-kvm --disable-hax

[...]

Found ninja-1.10.0 at /usr/bin/ninja
WARNING: custom_target 'shared QAPI source files' has more than one output! Using the first one.
WARNING: custom_target 'QGA QAPI files' has more than one output! Using the first one.
WARNING: custom_target 'QAPI files for qemu-storage-daemon' has more than one output! Using the first one.
WARNING: custom_target 'QAPI doc' has more than one output! Using the first one.
WARNING: custom_target 'dbus-vmstate description' has more than one output! Using the first one.
WARNING: custom_target 'tools man pages' has more than one output! Using the first one.
WARNING: custom_target 'system man pages' has more than one output! Using the first one.
Command line for building ['libcommon.fa'] is long, using a response file
Command line for building ['libqemu-aarch64-softmmu.fa'] is long, using a response file
Command line for building ['qemu-system-aarch64'] is long, using a response file

Thanks,

Claudio


-- 
Claudio Fontana
Engineering Manager Virtualization, SUSE Labs Core

SUSE Software Solutions Italy Srl

