Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A15C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CE02184E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CE02184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyJ7-000495-5w
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Chris.Friesen@windriver.com>) id 1hpyIf-0002hD-J5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Chris.Friesen@windriver.com>) id 1hpyIQ-0002bv-4w
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:10:00 -0400
Received: from mail5.windriver.com ([192.103.53.11]:32884 helo=mail5.wrs.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
 id 1hpyIP-0002Xl-Pa
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:09:49 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x6NGIEkU025087
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 09:18:24 -0700
Received: from [172.25.39.5] (172.25.39.5) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 23 Jul
 2019 09:18:03 -0700
To: <qemu-devel@nongnu.org>
From: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <c6d83f1f-50e2-60e1-38d7-4e622ac71a8c@windriver.com>
Date: Tue, 23 Jul 2019 10:18:01 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.39.5]
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 192.103.53.11
Subject: [Qemu-devel] high-level view of packet processing for virtio NIC?
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

Hi,

I'm looking for information on what the qemu architecture looks like for 
processing virtio network packets in a two-vCPU guest.

It looks like there's an IO thread doing a decent fraction of the work, 
separate from the vCPU threads--is that correct?  There's no disk 
involved in this case, purely network packet processing.

Chris

