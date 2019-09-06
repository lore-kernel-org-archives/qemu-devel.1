Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A63EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F482081B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F482081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6CDZ-0003iV-Cw
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 07:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1i6CCX-0002n9-QJ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1i6CCW-0007wv-W3
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:14:49 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1i6CCW-0007tx-NE
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:14:48 -0400
X-IronPort-AV: E=Sophos;i="5.64,472,1559512800"; d="scan'208";a="318515797"
Received: from unknown (HELO function) ([193.50.111.121])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384;
 06 Sep 2019 13:14:25 +0200
Received: from samy by function with local (Exim 4.92.1)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1i6CC8-00081e-Sl; Fri, 06 Sep 2019 13:14:24 +0200
Date: Fri, 6 Sep 2019 13:14:24 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Chris Heinze <c.heinze@precibake.com>
Message-ID: <20190906111424.jufsgie3fi66bk5d@function>
References: <0115e29c-2254-09c3-13d5-6dfb5307d968@precibake.com>
 <20190906095905.44hrurx3vlbqidkq@function>
 <68838709-01f9-3bf6-ac5d-461e76a1585e@precibake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68838709-01f9-3bf6-ac5d-461e76a1585e@precibake.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.134.164.104
Subject: Re: [Qemu-devel] slirp, incoming packets get truncated
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chris Heinze, le ven. 06 sept. 2019 12:54:24 +0200, a ecrit:
> i'm not aware of any (canonical) parameters to set a max size for received packets

Ah, right.

> i found no way to configure slirp (in qemu) itself except for the DEFINEs in the if.h.

Yes, that's where it is to be configured atm. IF_MRU is however only
used for setting the TCP mss, there is no code that is supposed to
truncate packets etc., that's why I'm really surprised that there is
such truncation happening.

Samuel

