Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0580EC4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3982821556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3982821556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZt5H-0004AY-8j
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 04:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kZt3p-00038M-6s
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:57:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kZt3m-0007CZ-7h
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:57:04 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQQDP3SDZz15Nq5;
 Tue,  3 Nov 2020 17:56:53 +0800 (CST)
Received: from [10.174.186.51] (10.174.186.51) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 17:56:52 +0800
Subject: Re: [Bug 1902470] Re: migration with TLS-MultiFD is stuck when the
 dst-libvirtd service restarts
To: Bug 1902470 <1902470@bugs.launchpad.net>, <qemu-devel@nongnu.org>
References: <160428587851.31102.18083040677647005532.malonedeb@gac.canonical.com>
 <160439574055.8291.500207291911115466.malone@soybean.canonical.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <8d2f6993-5826-ed10-f9be-c6c2369af934@huawei.com>
Date: Tue, 3 Nov 2020 17:56:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <160439574055.8291.500207291911115466.malone@soybean.canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.51]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:56:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2020/11/3 17:29, Daniel Berrange wrote:
> This looks to me like a significant implementation flaw in the QEMU
> code. Both src and dst QEMU appear to be running code from the main
> event loop, and they appear to be doing blocking I/O operations. This is
> very bad as we should never have anything running in the main event loop
> thread that is able to block on I/O.
> 
Well, the tls handshake seems to be blocking I/O.

> So to solve this something needs to be done to make sure the I/O is
> either non-blocking, or if it has to be blocking, then it needs to be
> offloaded to a background thread.
> 
Yes, i agree.
Since we do multifd tls handshake in main thread through multifd_save_setup(), maybe
we need to make socket_send_channel_create() to be a background thread other
than qio_channel_socket_connect_async()?

Besides，the hang problem itself still need to be figured out and solved...

-- 
Regards.
Chuan

