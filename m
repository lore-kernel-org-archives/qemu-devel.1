Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02320C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA7220673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA7220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33213 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYtOD-0007wT-Ut
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 10:29:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYtNR-0007cV-LW
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYtNP-00045a-Gz
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:28:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hYtNJ-00035b-PS; Thu, 06 Jun 2019 10:28:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C414FC04B93D;
	Thu,  6 Jun 2019 14:27:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F64D7D66A;
	Thu,  6 Jun 2019 14:27:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 2124711386A0; Thu,  6 Jun 2019 16:27:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190530110255.16225-1-kwolf@redhat.com>
Date: Thu, 06 Jun 2019 16:27:53 +0200
In-Reply-To: <20190530110255.16225-1-kwolf@redhat.com> (Kevin Wolf's message
	of "Thu, 30 May 2019 13:02:49 +0200")
Message-ID: <871s06n5zq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 06 Jun 2019 14:27:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/6] file-posix: Add
 dynamic-auto-read-only QAPI feature
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

Kevin Wolf <kwolf@redhat.com> writes:

> This series adds optional feature lists to struct definitions in the
> QAPI schema and makes use of them to advertise the new behaviour of
> auto-read-only=on in file-posix.

PATCH 1-3,5-6 are ready.  PATCH 4 could use a bit of love, but I think I
don't need you to respin.  Let's review the issues briefly:

(a) I found a few comment nits to pick.

(b) QAPIDoc._check_named_section() confused me.  I proposed to replace
    it by ._is_section_tag().

(c) I proposed to replace QAPIDoc._part by ._append_line.  Matter of
    taste.  I find it simpler.

I'd like to proceed as follows.  Since my follow-up patch for (b) is
pretty trivial and you haven't expressed a dislike for it, I'll squash
it in.  Since you do dislike my follow-up patch for (c), I'll keep it
separate, so you don't get blamed for it.  Any comment nits that survive
the two follow-up patches I'll address in the first one.  I'll post the
result as v5.

Okay?

Since PATCH 4 isn't actually wrong, series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

