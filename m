Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734DEC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 05:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BED2083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 05:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BED2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYOj5-0007zC-8J
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 01:44:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYOiK-0007g1-Ep
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 01:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYOiH-0004aN-Mx
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 01:43:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hYOi3-0004Qi-IY; Wed, 05 Jun 2019 01:43:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B4627FDFF;
	Wed,  5 Jun 2019 05:43:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 54B8D5D6A9;
	Wed,  5 Jun 2019 05:43:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C164011386A0; Wed,  5 Jun 2019 07:43:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
References: <20190603202236.1342-1-mreitz@redhat.com>
	<20190603202236.1342-2-mreitz@redhat.com>
Date: Wed, 05 Jun 2019 07:43:35 +0200
In-Reply-To: <20190603202236.1342-2-mreitz@redhat.com> (Max Reitz's message of
	"Mon, 3 Jun 2019 22:22:35 +0200")
Message-ID: <877ea0ege0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 05 Jun 2019 05:43:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qapi/block-core: Overlays are not
 snapshots
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> A snapshot is something that reflects the state of something at a
> certain point in time.  It does not change.
>
> The file our snapshot commands create (or the node they install) is not
> a snapshot, as it does change over time.  It is an overlay.  We cannot
> do anything about the parameter names,

We certainly could: add new parameter, default to the old one, error out
when both are given, deprecate the old one.  Way more trouble than it's
worth.

If the QAPI machinery made such renames as simple as

    'overlay-file': {'type': 'str', 'alias': 'snapshot-file'}

we could consider it.  Of course, whether enhancing the machinery that
way would be worthwhile depends on complexity and on use.  I think we
got bigger fish to fry.

>                                        but we can at least adjust the
> descriptions to reflect that fact.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Since you already got competent review, I merely glanced at the patches,
and didn't check for completeness.  No objections.

