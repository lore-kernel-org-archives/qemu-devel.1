Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC558C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FA420737
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FA420737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDiYT-0003mx-LZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kDiVP-00020H-Tu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:13:55 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:53230)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kDiVN-0001o3-NB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:13:55 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 0836ChbW000520;
 Thu, 3 Sep 2020 08:12:44 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 0836Chwp015296; Thu, 3 Sep 2020 08:12:43 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 0836Ch1F015294;
 Thu, 3 Sep 2020 08:12:43 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v1 3/6] net/can: Add can_dlc2len and can_len2dlc for CAN
 FD.
Date: Thu, 3 Sep 2020 08:12:42 +0200
User-Agent: KMail/1.9.10
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
 <30758547c49f254b3965fc12500735bea8265c97.1594725647.git.pisa@cmp.felk.cvut.cz>
 <20200903054329.GA405867@xilinx.com>
In-Reply-To: <20200903054329.GA405867@xilinx.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202009030812.42855.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 0836ChbW000520
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.423, required 6, autolearn=not spam, BAYES_00 -0.50,
 KHOP_HELO_FCRDNS 0.40, NICE_REPLY_A -0.32, SPF_HELO_NONE 0.00,
 SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1599718371.40146@NCJ2UfHw6kJhIqGN+XqcRw
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 02:13:49
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.324,
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
Cc: Marek Vasut <marex@denx.de>, Jiri Novak <jnovak@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Deniz Eren <deniz.eren@icloud.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ondrej Ille <ondrej.ille@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Vikram,

On Thursday 03 of September 2020 07:43:34 Vikram Garhwal wrote:
> On Tue, Jul 14, 2020 at 02:20:16PM +0200, pisa@cmp.felk.cvut.cz wrote:
> Hi Pavel,
>
> > From: Jan Charvat <charvj10@fel.cvut.cz>
> >
> > Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
> > Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> > ---
> >  include/net/can_emu.h |  4 ++++
> >  net/can/can_core.c    | 36 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/include/net/can_emu.h b/include/net/can_emu.h
> > index c6164dcfb4..7d395fbb9b 100644
> > --- a/include/net/can_emu.h
> > +++ b/include/net/can_emu.h
> > @@ -127,4 +127,8 @@ int can_bus_client_set_filters(CanBusClientState *,
> >                                 const struct qemu_can_filter *filters,
> >                                 size_t filters_cnt);
> >
> > +uint8_t can_dlc2len(uint8_t can_dlc);
> > +
> > +uint8_t can_len2dlc(uint8_t len);
> > +
>
> These function are aimed for canfd. Perhaps rename these to canfd_dlc2len
> and canfd_len2dlc for better distinction?
> Rest of the patch looks good to me.

I do not insits on name. But function correspond 1:1 to the Linux
kernel ones

https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev.c#L34

These functions/tables are very short, but may it be, we should add comment
about their origin. This part of original file is Oliver Hartkopp
contribution

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/can/dev.c?h=v5.9-rc3&id=1e0625facab2e871472472b7df87d8fbe6caf75a

some other helpers are from Wolfgang Grandegger and me.

Best wishes,

Pavel

