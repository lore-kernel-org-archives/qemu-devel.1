Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CB1C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A746216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A746216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39191 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP1JC-0001KD-B7
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 04:55:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP1IR-000109-4G
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP1IQ-0000mc-3T
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:54:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP1IP-0000mM-U7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:54:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1986530832CD;
	Fri, 10 May 2019 08:54:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CC0295D6A9;
	Fri, 10 May 2019 08:54:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 0EC1CA1E1; Fri, 10 May 2019 10:54:24 +0200 (CEST)
Date: Fri, 10 May 2019 10:54:24 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Hou Qiming <hqm03ster@gmail.com>
Message-ID: <20190510085424.drf2e4hbfex5bacl@sirius.home.kraxel.org>
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrn073Y6UTbbgs00y5-DCdF1ROK9zAg5JURD4SoUZAk2Mw@mail.gmail.com>
	<20190510050139.jpxrghxzahejpteu@sirius.home.kraxel.org>
	<CABSdmrmU7FK90Bupq_ySowcc9Uk=8nQxNLHgzvDsNYdp_QLogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABSdmrmU7FK90Bupq_ySowcc9Uk=8nQxNLHgzvDsNYdp_QLogA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 10 May 2019 08:54:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] ramfb enhancement
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 02:41:36PM +0800, Hou Qiming wrote:
> > Only allow one resolution change per guest boot, which prevents a
> 
> > > crash when the guest writes garbage to the configuration space (e.g.
> > > when rebooting).
> >
> > Hmm?  Did you see that happen in practice?
> > It is not easy to write to fw_cfg by accident ...
> >
> >
> Yes, this does happen in practice. It's observed in KVMGT setups by another
> github user and me, when the guest Intel driver loads or when the guest
> reboots. Link:
> https://github.com/intel/gvt-linux/issues/23#issuecomment-483651476
> 
> Now that you mentioned it, I start to feel that it's not accidental. A
> closer look at the "garbage" in that post shows that the overwriting
> content are valid resolution values in the wrong endian. It could be a
> misguided attempt to "resize ramfb" by the guest Intel driver.

Hmm.  The intel driver certainly isn't supposed to do that ...

So, allow writing only once might be a good idea, to make clear this
*really* is meant to be used by the firmware only, for a boot display.

cheers,
  Gerd


