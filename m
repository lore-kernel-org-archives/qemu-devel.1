Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C60C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF71421670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF71421670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABq3-0008U8-19
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iABoo-00081P-Cs
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iABon-0007Jv-CH
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:38:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iABon-0007JW-67
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:38:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A05118C891D;
 Tue, 17 Sep 2019 11:38:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 211D81018A2E;
 Tue, 17 Sep 2019 11:38:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2291A16E05; Tue, 17 Sep 2019 13:38:42 +0200 (CEST)
Date: Tue, 17 Sep 2019 13:38:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Message-ID: <20190917113842.aa36erbcmc7tes7h@sirius.home.kraxel.org>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
 <20190912102007.73bch4avvmx3ugpe@sirius.home.kraxel.org>
 <9e32e611-ccf3-7cce-8a08-3d05bac65f0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e32e611-ccf3-7cce-8a08-3d05bac65f0c@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 17 Sep 2019 11:38:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/24] Audio: Mixeng-free 5.1/7.1 audio
 support
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> * oss - works, but it looks like I have to specify both in.dev and out.dev
> if the default /dev/dsp does not exist, otherwise I just get a generic
> "Could not init `oss' audio driver".  We need a better error message here
> IMHO.

Yes, we basically have to add a Error* arg to the init callback so the
drivers can return error messages.  I've started looking into this a
while back, will try to resume the effort once we have this series
finally merged.

> * sdl - works
> * spice - yes, it's broken now, I'll fix it in the next update.  I've also
> found a second bug (SIGSEGV if the guest starts playing while no client is
> connected).
> 
> > What about windows+macos?
> 
> No idea, I don't have a windows or mac computer.  I could try it in a
> windows VM though, if I figure out how to compile qemu on windows.

debian and fedora have cross compilers for windows (mingw project)
which is supported by qemu and is probably easier than getting things
built on windows.

macos does at least build, but I have macos only in a vm without
sound support so I can't test whenever it actually works ...

Peter, any chance you can give this a try?

cheers,
  Gerd


