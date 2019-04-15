Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E801C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 18:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC9E218A1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 18:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC9E218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG61q-0000Yb-1O
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 14:08:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG604-0007vK-T9
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG604-0004Q1-6E
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:36 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:35378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG603-0004Oa-Tn
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id F33F4BEEA;
	Mon, 15 Apr 2019 20:06:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OfXBDjmqrp_m; Mon, 15 Apr 2019 20:06:34 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 5476DBEE9;
	Mon, 15 Apr 2019 20:06:34 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG601-0000Ov-Cz; Mon, 15 Apr 2019 20:06:33 +0200
Date: Mon, 15 Apr 2019 20:06:33 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190415180633.pezyl3sxbkahvc6f@function>
References: <20190415121740.9881-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415121740.9881-1-dgilbert@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: Re: [Qemu-devel] [PATCH v3] slirp: Gcc 9 -O3 fix
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
Cc: jan.kiszka@siemens.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415180633.BZrty4hrwJ0vvAISVVK7l6q3jC7soDqKa3o0KMYUo4w@z>

Dr. David Alan Gilbert (git), le lun. 15 avril 2019 13:17:40 +0100, a ecrit:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Gcc 9 needs some convincing that sopreprbuf really is going to fill
> in iov in the call from soreadbuf, even though the failure case
> shouldn't happen.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Applied to my tree, thanks!

Samuel

