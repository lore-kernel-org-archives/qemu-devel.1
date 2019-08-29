Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AA7C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA442173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 12:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA442173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3JHb-0002AV-SS
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 08:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i3JGc-0001jG-K7
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i3JGb-0008VQ-Al
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:11:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i3JGb-0008UE-3w
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 08:11:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4A6B308123B;
 Thu, 29 Aug 2019 12:11:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33DF7451D;
 Thu, 29 Aug 2019 12:11:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A672F1165361; Thu, 29 Aug 2019 14:10:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
References: <f307829a5e64121b5cb8ad1aefff09f41cac9699.1567070002.git.mprivozn@redhat.com>
Date: Thu, 29 Aug 2019 14:10:59 +0200
In-Reply-To: <f307829a5e64121b5cb8ad1aefff09f41cac9699.1567070002.git.mprivozn@redhat.com>
 (Michal Privoznik's message of "Thu, 29 Aug 2019 11:14:14 +0200")
Message-ID: <87v9ugrx2k.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 29 Aug 2019 12:11:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qapi: Reintroduce CommandDisabled error
 class
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, lcapitulino@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michal Privoznik <mprivozn@redhat.com> writes:

> If there was a disabled command, then qemu-ga used to report
> CommandDisabled error class (among with human readable
> description). This changed in v1.2.0-rc0~28^2~16 in favor of
> GenericError class.

Really?  I believe it was slightly earlier in the same series:

93b91c59db qemu-ga: switch to the new error format on the wire
de253f1491 qmp: switch to the new error format on the wire

The commit you mention (df1e608a01e) is merely follow-up simplification.

>                     While the change might work for other
> classes, this one should not have been dropped because it helps
> callers distinguish the root cause of the error.
>
> A bit of background: up until very recently libvirt used qemu-ga
> in all or nothing way. It didn't care why a qemu-ga command
> failed. But very recently a new API was introduced which
> implements 'best effort' approach (in some cases) and thus
> libvirt must differentiate between: {CommandNotFound,
> CommandDisabled} and some generic error. While the former classes
> mean the API can issue some other commands the latter raises a
> red flag causing the API to fail.

Why do you need to distinguish CommandNotFound from CommandDisabled?

> This reverts df1e608a01 partially.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

