Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E55C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8AC206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8AC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGoC7-0003ah-Je
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 13:17:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGoAm-0002y0-0B
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGoAl-0004BO-4M
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGoAk-00049o-ST
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D272A3097035;
	Wed, 17 Apr 2019 17:16:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A1AB71001DD5;
	Wed, 17 Apr 2019 17:16:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 21E361138648; Wed, 17 Apr 2019 19:16:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
References: <20190416153850.5186-1-armbru@redhat.com>
Date: Wed, 17 Apr 2019 19:16:31 +0200
In-Reply-To: <20190416153850.5186-1-armbru@redhat.com> (Markus Armbruster's
	message of "Tue, 16 Apr 2019 17:38:50 +0200")
Message-ID: <878sw8wo0g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 17 Apr 2019 17:16:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] error: Fix error_report_err(),
 warn_report_err() hint printing
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
Cc: vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417171631.Nc4lQMjPs1ig5XFtldPRjWbn6SDzqULoMZ6Tadmx5Ww@z>

Markus Armbruster <armbru@redhat.com> writes:

> Before the from qerror_report() to error_setg(), hints looked like
> this:
>
>     qerror_report(QERR_MACRO, ... arguments ...);
>     error_printf_unless_qmp(... hint ...);
>
> error_printf_unless_qmp() made perfect sense: it printed exactly when
> qerror_report() did.
>
> After the conversion to error_setg():
>
>     error_setg(errp, QERR_MACRO, ... arguments ...);
>     error_printf_unless_qmp(... hint ...);
>
> The "unless QMP part" still made some sense; in QMP context, the
> caller generally uses the error as QMP response instead of printing
> it.
>
> However, everything else is wrong.  If the caller handles the error,
> the hint gets printed anyway (unless QMP).  If the caller reports the
> error, the hint gets printed *before* the report (unless QMP) or not
> at all (if QMP).
>
> Commit 50b7b000c91 fixed this by making hints a member of Error.  It
> kept printing hints with error_printf_unless_qmp():
>
>      void error_report_err(Error *err)
>      {
> 	 error_report("%s", error_get_pretty(err));
>     +    if (err->hint) {
>     +        error_printf_unless_qmp("%s\n", err->hint->str);
>     +    }
> 	 error_free(err);
>      }
>
> This is wrong.  We should (and now can) print the hint exactly when we
> print the error.
>
> The mistake has since been copied to warn_report_err().
>
> Fix both to use error_printf().
>
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Queued.

