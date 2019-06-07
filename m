Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A4C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFB8207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFB8207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHxa-000831-BM
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZGUf-000288-2F
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZGUd-00055y-6L
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:09:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hZGUc-0004rH-Pm; Fri, 07 Jun 2019 11:09:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F02782E95B1;
 Fri,  7 Jun 2019 15:09:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEC227FEAD;
 Fri,  7 Jun 2019 15:09:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2825011386A0; Fri,  7 Jun 2019 17:09:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: <tony.nguyen@bt.com>
References: <430a9a42f7a34b799ee4d2f3d7ab2e23@tpw09926dag18e.domain1.systemhost.net>
Date: Fri, 07 Jun 2019 17:09:13 +0200
In-Reply-To: <430a9a42f7a34b799ee4d2f3d7ab2e23@tpw09926dag18e.domain1.systemhost.net>
 (tony nguyen's message of "Fri, 7 Jun 2019 14:07:11 +0000")
Message-ID: <87h891a0va.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 07 Jun 2019 15:09:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] test: Use g_strndup instead
 of plain strndup
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<tony.nguyen@bt.com> writes:

> Due to memory management rules. See HACKING.
>     
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
>
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index fa2afcc..07a773e 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -767,7 +767,7 @@ static void utf8_string(void)
>                      if (*end == ' ') {
>                          end++;
>                      }
> -                    in = strndup(tail, end - tail);
> +                    in = g_strndup(tail, end - tail);
>                      str = from_json_str(in, j, NULL);
>                      g_assert(!str);
>                      g_free(in);

This one is fine.

> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index 49a03aa..72c4012 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -104,7 +104,7 @@ static int get_command_arg_str(const char *name,
>      }
>  
>      if (end)
> -        *val = strndup(start, end - start);
> +        *val = g_strndup(start, end - start);
>      else
>          *val = strdup(start);
>      return 1;

This one isn't.  The caller passes *val to free().  You have to change
*both* allocations in get_command_arg_str() *and* the deallocation in
get_command_arg_ull().

