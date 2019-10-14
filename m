Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F329EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C758120663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C758120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJx5S-0004tf-0k
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 05:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iJx4h-0004Kh-5m
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iJx4g-00023i-7u
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:55:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iJx4d-0001zW-7P; Mon, 14 Oct 2019 05:55:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 708894E924;
 Mon, 14 Oct 2019 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E2825C299;
 Mon, 14 Oct 2019 09:55:26 +0000 (UTC)
Date: Mon, 14 Oct 2019 11:55:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] vl: Split off user_creatable_print_help()
Message-ID: <20191014095525.GC7173@localhost.localdomain>
References: <20191011205551.32149-1-kwolf@redhat.com>
 <20191011205551.32149-2-kwolf@redhat.com>
 <f1b7efeb-6ce5-2943-76fc-12b6d0f09215@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b7efeb-6ce5-2943-76fc-12b6d0f09215@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 14 Oct 2019 09:55:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.10.2019 um 23:35 hat Eric Blake geschrieben:
> On 10/11/19 3:55 PM, Kevin Wolf wrote:
> > Printing help for --object is something that we don't only want in the
> 
> s/don't/not/

Can someone send a fix for the English grammar? It's obviously broken
and doesn't know what it wants. Actually, maybe do-support was a bad
idea and we should just revert it and restore consistent use of proper
verb-second word order?

(Hm, actually, since this seems to negate "only" rather than the verb,
does "...that we want not only in..." work without patching the
grammar?)

(Thanks for the correction.)

Kevin

> > system emulator, but also in tools that support --object. Move it into a
> > separate function in qom/object_interfaces.c to make the code accessible
> > for tools.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

