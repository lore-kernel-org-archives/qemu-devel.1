Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ECCC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3B920872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3B920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYkxE-0005Fb-0U
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 01:28:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkwV-0004x2-TQ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkwU-0003hl-Cr
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:28:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYkwP-0003aq-K8
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:27:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 856D959461;
	Thu,  6 Jun 2019 05:27:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B61563B85;
	Thu,  6 Jun 2019 05:27:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id B1D7511386A0; Thu,  6 Jun 2019 07:27:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Lidong Chen <lidong.chen@oracle.com>
References: <cover.1559761541.git.lidong.chen@oracle.com>
	<cover.1559761541.git.lidong.chen@oracle.com>
	<00742cd052c0b66e8da0b6b684cd460d6a051175.1559761541.git.lidong.chen@oracle.com>
Date: Thu, 06 Jun 2019 07:27:48 +0200
In-Reply-To: <00742cd052c0b66e8da0b6b684cd460d6a051175.1559761541.git.lidong.chen@oracle.com>
	(Lidong Chen's message of "Wed, 5 Jun 2019 15:15:21 -0400")
Message-ID: <87imtjjnaj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 06 Jun 2019 05:27:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-devel PATCH v2 2/2] util/main-loop: Fix
 incorrect assertion
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, liq3ea@gmail.com,
	qemu-devel@nongnu.org, armbru@redhat.com,
	darren.kenny@oracle.com, liran.alon@oracle.com,
	amarkovic@wavecomp.com, Paolo Bonzini <pbonzini@redhat.com>,
	marcandre.lureau@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You neglected to cc: the file's maintainer.  I'm doing that for you now.
In the future, use scripts/get_maintainer.pl to find maintainers you
might want to cc:.

Lidong Chen <lidong.chen@oracle.com> writes:

> The check for poll_fds in g_assert() was incorrect. The correct assertion
> should check "n_poll_fds + w->num <= ARRAY_SIZE(poll_fds)" because the
> subsequent for-loop is doing access to poll_fds[n_poll_fds + i] where i
> is in [0, w->num).
>
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> ---
>  util/main-loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/main-loop.c b/util/main-loop.c
> index e1e349c..a9f4e8d 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -422,7 +422,7 @@ static int os_host_main_loop_wait(int64_t timeout)
>      g_main_context_prepare(context, &max_priority);
>      n_poll_fds = g_main_context_query(context, max_priority, &poll_timeout,
>                                        poll_fds, ARRAY_SIZE(poll_fds));
> -    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
> +    g_assert(n_poll_fds + w->num <= ARRAY_SIZE(poll_fds));
>  
>      for (i = 0; i < w->num; i++) {
>          poll_fds[n_poll_fds + i].fd = (DWORD_PTR)w->events[i];

