Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1403BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21773206D5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21773206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6nt-0006km-0r
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kb6lX-0005sz-Lb
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:47:15 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:19893)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kb6lV-0007ab-6G
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:47:15 -0500
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 0A6IkAQ5049534;
 Fri, 6 Nov 2020 19:46:10 +0100 (CET)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 0A6IkA9f026420; Fri, 6 Nov 2020 19:46:10 +0100
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 0A6Ik9lH026419;
 Fri, 6 Nov 2020 19:46:09 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: "Philippe =?utf-8?q?Mathieu-Daud=C3=A9?=" <f4bug@amsat.org>
Subject: Re: [PATCH for-5.2 3/4] hw/net/can/ctucan_core: Handle big-endian
 hosts
Date: Fri, 6 Nov 2020 19:46:09 +0100
User-Agent: KMail/1.9.10
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-4-peter.maydell@linaro.org>
 <51da5abd-bb51-2ee0-d1e8-dd3f0c93e2fa@amsat.org>
In-Reply-To: <51da5abd-bb51-2ee0-d1e8-dd3f0c93e2fa@amsat.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202011061946.09189.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 0A6IkAQ5049534
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.223, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.28,
 NICE_REPLY_A -0.00, SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1605293171.92689@gIiWOTYExOOHVSoItE2SYQ
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 12:48:26
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Friday 06 of November 2020 19:29:27 Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/6/20 6:11 PM, Peter Maydell wrote:
> > The ctucan driver defines types for its registers which are a union
> > of a uint32_t with a struct with bitfields for the individual
> > fields within that register. This is a bad idea, because bitfields
> > aren't portable. The ctu_can_fd_regs.h header works around the
> > most glaring of the portability issues by defining the
> > fields in two different orders depending on the setting of the
> > __LITTLE_ENDIAN_BITFIELD define. However, in ctucan_core.h this
> > is unconditionally set to 1, which is wrong for big-endian hosts.
> >
> > Set it only if HOST_WORDS_BIGENDIAN is not set. There is no need
> > for a "have we defined it already" guard, because the only place
> > that should set it is ctucan_core.h, which has the usual
> > double-inclusion guard.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Ideally all that bitfield-using code would be rewritten to use
> > extract32 and deposit32 instead, IMHO.
> > ---
> >  hw/net/can/ctucan_core.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/hw/net/can/ctucan_core.h b/hw/net/can/ctucan_core.h
> > index f21cb1c5ec3..bbc09ae0678 100644
> > --- a/hw/net/can/ctucan_core.h
> > +++ b/hw/net/can/ctucan_core.h
> > @@ -31,8 +31,7 @@
> >  #include "exec/hwaddr.h"
> >  #include "net/can_emu.h"
> >
> > -
> > -#ifndef __LITTLE_ENDIAN_BITFIELD
> > +#ifndef HOST_WORDS_BIGENDIAN
> >  #define __LITTLE_ENDIAN_BITFIELD 1
> >  #endif
>
> Alternatively s/#ifdef __LITTLE_ENDIAN_BITFIELD/#ifndef
> HOST_WORDS_BIGENDIAN/ the codebase and remove this here...

But then we cannot have same generated, untouch header file
common for Linux kernel and QEMU. Each uses different defines.
Or at least it was the goal, but after mainline Linux review
we switch in longer run to defines with use of BIT, GENMASK
=46IELD_GET and FIELD_PREP.

But even GENMASK does not seem to be defined in QEMU headers
even that it is referenced in include/hw/usb/dwc2-regs.h
and include/standard-headers/asm-x86/kvm_para.h

So idea to have nice common generated headers which can
be checked for consistency and right version by diff
for Linux kernel, QEMU and even userspace tests
and other OSes (there with Linux defines substitution)
seems to be only dream.

Anyway, we switch to solution which is matching requirements
of each project if it is suggested. But it takes time.

Best wishes,

Pavel


