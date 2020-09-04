Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23693C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA3120665
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA3120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFbB-000485-V8
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kEFZd-0003bW-AI
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:32:29 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:37249)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kEFZa-0006An-TB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:32:28 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 084HV6tw071097;
 Fri, 4 Sep 2020 19:31:06 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 084HV6Gj028456; Fri, 4 Sep 2020 19:31:06 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 084HV5ck028448;
 Fri, 4 Sep 2020 19:31:05 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/7] CTU CAN FD core support - patchew problem
Date: Fri, 4 Sep 2020 19:31:05 +0200
User-Agent: KMail/1.9.10
References: <cover.1599168753.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1599168753.git.pisa@cmp.felk.cvut.cz>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202009041931.05173.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 084HV6tw071097
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-2.501, required 6, autolearn=not spam, BAYES_00 -0.50,
 KHOP_HELO_FCRDNS 0.40, NICE_REPLY_A -2.40, SPF_HELO_NONE 0.00,
 SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1599845469.6108@Y5CJgmYNj2tOx+B7GOglNw
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 13:32:23
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Marek Vasut <marex@denx.de>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Jiri Novak <jnovak@fel.cvut.cz>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Deniz Eren <deniz.eren@icloud.com>, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ondrej Ille <ondrej.ille@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello everybody,

On Thursday 03 of September 2020 23:37:17 pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>
> CTU CAN FD is an open source soft core written in VHDL.
> It originated in 2015 as Ondrej Ille's project at the
> Department of Measurement of FEE at CTU.

It seems that there has been problem with QEMU CI
run by patchew

   No space left on device

It seems it is resolved for later patches

Please, can somebody restart pipe for our CAN FD series

  https://patchew.org/QEMU/cover.1599168753.git.pisa@cmp.felk.cvut.cz/

Please, is there somebody willing to look and apply series
to mainline if it passes CI OK?

Changes are only in CAN subsystem so if there is no
problem with breaking build on some system then
patches can break only the subsystem which I have planned,
found funding for initial CAN implementation provided
by RTEMS GSoC slot and where I have tutor our university
studnet to work on CAN FD support. If something is wrong
then it break only this subsystem, all functionality is
activated only when explicitly selected by command line option.

It seems that subsystem has users at Xilinx, Pengutronix
and more.

I have some longer time plans how to implement back-pressure
from SocketCAN, prioritization of the bus transfers when
multiple controllers are active at one and even emulate
bus tansmittion delay and blocking when message is on its way.
But these are more intrusive changes and would require time
or some other student work and I do not invest my time
before I would know that there is no more request for
series on which future work is based on.

Thanks much in advance,

Pavel

