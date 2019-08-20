Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B9C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0358F22CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0358F22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06EA-0001dX-Ol
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i06DO-0000pf-QH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i06DN-0008Cy-Ps
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:38:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i06DN-0008CS-KD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:38:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2A70C050DEC
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 15:38:28 +0000 (UTC)
Received: from work-vm (ovpn-117-33.ams2.redhat.com [10.36.117.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBC031D2;
 Tue, 20 Aug 2019 15:38:27 +0000 (UTC)
Date: Tue, 20 Aug 2019 16:38:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190820153825.GN2867@work-vm>
References: <20190820150116.29173-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820150116.29173-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 20 Aug 2019 15:38:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/migration: Do not use functions
 anymore that rely on global_qtest
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Thomas Huth (thuth@redhat.com) wrote:
> The migration tests deal with multiple test states, so we really should
> not use functions here that rely on the single global_qtest variable.
> Switch from qtest_start() to qtest_init() to make sure that global_qtest
> is not set anymore. This also revealed a regression in the migrate()
> function: It has once been converted to use the qtest_qmp() function,
> but commit b5bbd3f315d686bd511 ("Clean up string interpolation into QMP,
> part 2") accidentally reverted it back to qmp().
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/migration-test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index b87ba99a9e..a9f81cc185 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -490,7 +490,7 @@ static void migrate(QTestState *who, const char *uri, const char *fmt, ...)
>      g_assert(!qdict_haskey(args, "uri"));
>      qdict_put_str(args, "uri", uri);
>  
> -    rsp = qmp("{ 'execute': 'migrate', 'arguments': %p}", args);
> +    rsp = qtest_qmp(who, "{ 'execute': 'migrate', 'arguments': %p}", args);

It took me some time to figure out what %p really meant since libqtest.h
tells me to see the non-existent parse_escape, which is actually
parse_interpolation.

Dave

>      g_assert(qdict_haskey(rsp, "return"));
>      qobject_unref(rsp);
> @@ -625,7 +625,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          cmd_dst = tmp;
>      }
>  
> -    *from = qtest_start(cmd_src);
> +    *from = qtest_init(cmd_src);
>      g_free(cmd_src);
>  
>      *to = qtest_init(cmd_dst);
> @@ -715,7 +715,7 @@ static void test_deprecated(void)
>  {
>      QTestState *from;
>  
> -    from = qtest_start("-machine none");
> +    from = qtest_init("-machine none");
>  
>      deprecated_set_downtime(from, 0.12345);
>      deprecated_set_speed(from, 12345);
> -- 
> 2.18.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

