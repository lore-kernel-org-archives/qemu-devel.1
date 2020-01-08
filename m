Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DA6C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0660206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0660206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip78p-0000rJ-3j
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 03:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <postmaster@kaiser.cx>) id 1ip787-0008Bq-BT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <postmaster@kaiser.cx>) id 1ip786-0001Ce-GD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:55:55 -0500
Received: from viti.kaiser.cx ([2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f]:35644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <postmaster@kaiser.cx>)
 id 1ip784-00016u-Jj; Wed, 08 Jan 2020 03:55:52 -0500
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
 (envelope-from <martin@viti.kaiser.cx>)
 id 1ip77y-00083A-10; Wed, 08 Jan 2020 09:55:46 +0100
Date: Wed, 8 Jan 2020 09:55:46 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] i.MX: add an emulation for RNGC
Message-ID: <20200108085545.7jnhxvcxwh6ycqej@viti.kaiser.cx>
References: <20191226175132.28116-1-martin@kaiser.cx>
 <CAFEAcA-JTxqGid8EW=Vu=xePrEVgxD9pZRNAg0BehFVhYKfebw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-JTxqGid8EW=Vu=xePrEVgxD9pZRNAg0BehFVhYKfebw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

thanks for reviewing my patch. I just sent a v2 where I fixed the issues
that you found. 

Thus wrote Peter Maydell (peter.maydell@linaro.org):

> > +#include "qemu/main-loop.h"

> Do you really need main-loop.h ?

Without main-loop.h, I get compiler errors about missing prototypes for
qemu_bh_schedule and qemu_bh_new. Other emulators that call qemu_bh_...
functions include main-loop.h as well.

Best regards,
Martin

