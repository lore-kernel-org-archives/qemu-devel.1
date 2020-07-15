Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3618C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A798D20672
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A798D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvjwR-0002qC-Rm
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 12:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1jvjvC-0001D4-5z
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 12:06:14 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83]:51234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1jvjvA-0005iN-Fo
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 12:06:13 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 27977A00D9; Wed, 15 Jul 2020 17:58:05 +0200 (CEST)
Date: Wed, 15 Jul 2020 17:58:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Re: TB Cache size grows out of control with qemu 5.0
In-Reply-To: <CAATJJ0JDs78irZYRA7-wBefZhmTFK7SpCecuq79Ub-8n1jfy3A@mail.gmail.com>
Message-ID: <alpine.LMD.2.03.2007151755360.31652@eik.bme.hu>
References: <CAATJJ0JDs78irZYRA7-wBefZhmTFK7SpCecuq79Ub-8n1jfy3A@mail.gmail.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 11:58:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

See commit 47a2def4533a2807e48954abd50b32ecb1aaf29a and the next two 
following it.

