Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A5C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28478206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28478206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGoD8-0004Pa-Du
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 13:19:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGoB6-00038y-BI
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGoB5-0004UU-Dr
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGoB5-0004Ti-4t
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 626B4C066455;
	Wed, 17 Apr 2019 17:16:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 309F71001E8C;
	Wed, 17 Apr 2019 17:16:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E88871138648; Wed, 17 Apr 2019 19:16:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190415142519.73060-1-vsementsov@virtuozzo.com>
Date: Wed, 17 Apr 2019 19:16:52 +0200
In-Reply-To: <20190415142519.73060-1-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Mon, 15 Apr 2019 17:25:19 +0300")
Message-ID: <877ebswnzv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 17 Apr 2019 17:16:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] util/error: do not free error on
 error_abort
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417171652.g2JKbEsjZPOxpC4B-r39eEcBtsy7TnSoZhoCkbZKGzE@z>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> It would be nice to have Error object not freed away when debugging a
> coredump.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>
> v2: don't change error output format
>
>  util/error.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/util/error.c b/util/error.c
> index 934a78e1b1..22f8a7924f 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -34,7 +34,10 @@ static void error_handle_fatal(Error **errp, Error *err)
>      if (errp == &error_abort) {
>          fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
>                  err->func, err->src, err->line);
> -        error_report_err(err);
> +        error_report("%s", error_get_pretty(err));
> +        if (err->hint) {
> +            error_printf_unless_qmp("%s", err->hint->str);
> +        }
>          abort();
>      }
>      if (errp == &error_fatal) {

We've since found out that the hint should be printed with
error_printf(), see "[PATCH] error: Fix error_report_err(),
warn_report_err() hint printing".  With that:

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Queued with this change.  Thanks!

