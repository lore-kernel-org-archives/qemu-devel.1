Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A64C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD6320866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD6320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60518 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsLq-00014E-O0
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:22:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hYsL1-0000jN-5L
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hYsL0-00016A-0Y
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:21:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hYsKx-0000ql-Vd; Thu, 06 Jun 2019 09:21:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CD443092671;
	Thu,  6 Jun 2019 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-165.ams2.redhat.com
	[10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE4786839E;
	Thu,  6 Jun 2019 13:21:40 +0000 (UTC)
Date: Thu, 6 Jun 2019 15:21:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190606132139.GC9241@localhost.localdomain>
References: <20190530110255.16225-1-kwolf@redhat.com>
	<20190530110255.16225-5-kwolf@redhat.com>
	<87blzbhs48.fsf@dusky.pond.sub.org>
	<87muiuhqh6.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muiuhqh6.fsf_-_@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 06 Jun 2019 13:21:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 4.5/6] qapi: Replace QAPIDoc._part by
 ._append_line, and rework comments
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.06.2019 um 14:01 hat Markus Armbruster geschrieben:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> This is on top of the fixup I appended to my review of v4.  I'd squash
> all three patches together.
> 
> The next patch needs to be updated for this.
> 
> Unsquashed branch at git://repo.or.cz/qemu/armbru.git branch
> qapi-features.
> 
> Let me know what you think.

As you know, I don't like the self._append_line function pointer and
think it makes the code less readable. However, I also hope that I'll
never have to touch this code again, whereas you as the maintainer will
probably have to. So your taste is more imporant than mine.

So for all I care, go ahead and squash in your changes.

Kevin

