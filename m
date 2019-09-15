Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03744C4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 18:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE58320830
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 18:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE58320830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ZcQ-0006Cl-W6
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 14:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i9Zbh-0005kZ-BY
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 14:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i9Zbg-0005oG-3t
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 14:50:45 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:37869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i9Zbf-0005jI-Un
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 14:50:44 -0400
Received: from player716.ha.ovh.net (unknown [10.108.54.87])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id F1889784F5
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 20:50:34 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player716.ha.ovh.net (Postfix) with ESMTPSA id 36C169C42EFF;
 Sun, 15 Sep 2019 18:50:33 +0000 (UTC)
Date: Sun, 15 Sep 2019 20:50:32 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190915205032.475e79b8@bahia.lan>
In-Reply-To: <87o8zm3dr1.fsf@dusky.pond.sub.org>
References: <156839258306.2228854.8411024885973295628.stgit@bahia.lan>
 <87o8zm3dr1.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9798143942519921038
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddugddufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.49.171
Subject: Re: [Qemu-devel] [PATCH] 9p: Print error hints if option parsing
 fails
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

On Sat, 14 Sep 2019 20:59:46 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Greg Kurz <groug@kaod.org> writes:
> 
> > Option parsing fonctions are called with &error_fatal, which
> 
> functions
> 
> > causes error_setg() to call exit() and the hints are never
> > printed.
> >
> > Use an intermediate error object so that exit() happens in
> > error_propagate() after error_append_hint() could be called.
> 
> Hmm.
> 
> Code that creates error objects should not need to know how they are
> handled.
> 

Agreed.

> Your patch shows that error_append_hint() requires error_propagate() to
> work regardless of how the error is handled.  We should amend
> error_append_hint()'s contract in error.h to spell this out, and search
> the tree for more misuse of error_append_hint().

Sure. I'll take care of that.

Cheers,

--
Greg

