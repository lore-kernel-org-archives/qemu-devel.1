Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E52EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D61F207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D61F207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNbA-0003z7-JC
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 03:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kDNZa-00036y-VB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:52:50 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:48343)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kDNZY-00088b-If
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:52:50 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 0827ppxW054785;
 Wed, 2 Sep 2020 09:51:51 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 0827pkhf027036; Wed, 2 Sep 2020 09:51:51 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 0827pjeE027035;
 Wed, 2 Sep 2020 09:51:45 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Subject: Re: [PATCH v1 1/6] net/can: Initial host SocketCan support for CAN FD.
Date: Wed, 2 Sep 2020 09:51:44 +0200
User-Agent: KMail/1.9.10
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
 <b401e976ac9c73cf1582bca95442a255676ce940.1594725647.git.pisa@cmp.felk.cvut.cz>
 <20200901200119.GA152258@xilinx.com>
In-Reply-To: <20200901200119.GA152258@xilinx.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202009020951.44751.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 0827ppxW054785
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-2.228, required 6, autolearn=not spam, BAYES_00 -0.50,
 KHOP_HELO_FCRDNS 0.40, NICE_REPLY_A -2.13, SPF_HELO_NONE 0.00,
 SPF_NONE 0.00, URIBL_BLOCKED 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1599637912.19444@0i/2MwfACLXCCfAYKLbzVA
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:52:44
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
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

thanks much for the patches review.

On Tuesday 01 of September 2020 22:01:26 Vikram Garhwal wrote:
> Hi Jan,
> A couple of comments on this patch.
>
> On Tue, Jul 14, 2020 at 02:20:14PM +0200, pisa@cmp.felk.cvut.cz wrote:
> > From: Jan Charvat <charvj10@fel.cvut.cz>
> > @@ -185,13 +204,34 @@ static void can_host_socketcan_connect(CanHostState
> > *ch, Error **errp) addr.can_family = AF_CAN;
> >      memset(&ifr.ifr_name, 0, sizeof(ifr.ifr_name));
> >      strcpy(ifr.ifr_name, c->ifname);
> > +    /* check if the frame fits into the CAN netdevice */
> >      if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
> >          error_setg_errno(errp, errno,
> > -                         "SocketCAN host interface %s not available",
> > c->ifname); +                         "SocketCAN host interface %s not
> > available", +                         c->ifname);
>
> May be this formatting change in a different patch? As this is not related
> to CANFD.
> > @@ -232,7 +272,8 @@ static char *can_host_socketcan_get_if(Object *obj,
> > Error **errp) return g_strdup(c->ifname);
> >  }
> >
> > -static void can_host_socketcan_set_if(Object *obj, const char *value,
> > Error **errp) +static void can_host_socketcan_set_if(Object *obj, const
> > char *value,
> > +                                      Error **errp) 
>
> This one also not relevant change for CANFD. Rest of the patch looks good.


I am responsible for mentioned lines change in net/can/can_socketcan.c.
When I have reviewed patches after Jan Charvat theses submittion,
I have done another bunch of rounds to check that the patches as well
as the whole net/can and hw/net/can are checkpatch clean. I am not sure
if the incorrect formatting sneaked in in my 2018 submission or patcheck
became more strict last years.

I can separate these changes changes into separate patch if required.

By the way, if you or other of your colleagues is willing to participate
in net/can and or  hw/net/can patches reviews, I would be happy if you
join my attempt and we can record that we are available to take care
abut these in MAINTAINERS file.

Best wishes,

Pavel
 


