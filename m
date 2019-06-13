Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEC7C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAEE2173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAEE2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQDK-0005ZF-G9
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37703)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hbOyD-0004aD-3W
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hbOyC-0004wt-6R
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hbOy8-0004uX-9B
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1BFF230F1BB7;
 Thu, 13 Jun 2019 12:36:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78F4C78387;
 Thu, 13 Jun 2019 12:36:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B49B411AA3; Thu, 13 Jun 2019 14:36:28 +0200 (CEST)
Date: Thu, 13 Jun 2019 14:36:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190613123628.brwmtr7rfg55zz2v@sirius.home.kraxel.org>
References: <20190520124716.30472-1-kraxel@redhat.com>
 <878suo5ls0.fsf@zen.linaroharston>
 <87pnniemgo.fsf@zen.linaroharston>
 <d32b4c47-4f46-474c-3c4d-54250a29960a@gmx.com>
 <87muileshz.fsf@zen.linaroharston>
 <20190613095249.hpwaoyfo6ndqr5ae@sirius.home.kraxel.org>
 <87lfy5en1l.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfy5en1l.fsf@zen.linaroharston>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 13 Jun 2019 12:36:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console
 autoinstall, misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 Kamil Rytarowski <n54@gmx.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> If you do a re-spin then could you consider including:
> 
>   Subject: [PATCH] tests/vm: favour the locally built QEMU for bootstrapping
>   Date: Fri,  7 Jun 2019 19:53:37 +0100
>   Message-Id: <20190607185337.14524-1-alex.bennee@linaro.org>

Local seabios is enough, and that'll more reliable work better because
we don't have to compile something for that.  ubuntu 18.04 seabios lacks
serial console support, which is one of the problems found so far.

> Also your scripts and python3 fixes are already merged.

Yep, saw that.

cheers,
  Gerd


