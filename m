Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B18C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB3124249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB3124249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icugs-0003UW-N5
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1icuXl-0003N3-Kw
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1icuXf-0007Ao-V0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:03:55 -0500
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:45508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1icuXc-00070Y-BL
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:03:49 -0500
Received: from player791.ha.ovh.net (unknown [10.108.42.142])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 15C29142779
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 18:03:44 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id 3D3F9CD54F46;
 Thu,  5 Dec 2019 17:03:40 +0000 (UTC)
Date: Thu, 5 Dec 2019 18:03:38 +0100
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 03/21] error: rename errp to errp_in where it is
 IN-argument
Message-ID: <20191205180338.5fb28c0e@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191205152019.8454-4-vsementsov@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-4-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4066750465223399763
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekuddgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.43.131
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Dec 2019 18:20:01 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Error **errp is almost always OUT-argument: it's assumed to be NULL, or
> pointer to NULL-initialized pointer, or pointer to error_abort or
> error_fatal, for callee to report error.
> 
> But very few functions instead get Error **errp as IN-argument:
> it's assumed to be set (or, maybe, NULL), and callee should clean it,
> or add some information.
> 
> In such cases, rename errp to errp_in.
> 

This is no longer what the patch does. The subject needs to be amended too.

> This patch updates only error API functions. There still a few
> functions with errp-in semantics, they will be updated in further
> commits.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qapi/error.h | 6 +++---
>  util/error.c         | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 3f95141a01..ad5b6e896d 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -233,13 +233,13 @@ void error_propagate_prepend(Error **dst_errp, Error *local_err,
>   * Prepend some text to @errp's human-readable error message.
>   * The text is made by formatting @fmt, @ap like vprintf().
>   */
> -void error_vprepend(Error **errp, const char *fmt, va_list ap);
> +void error_vprepend(Error *const *errp, const char *fmt, va_list ap);
>  
>  /*
>   * Prepend some text to @errp's human-readable error message.
>   * The text is made by formatting @fmt, ... like printf().
>   */
> -void error_prepend(Error **errp, const char *fmt, ...)
> +void error_prepend(Error *const *errp, const char *fmt, ...)
>      GCC_FMT_ATTR(2, 3);
>  
>  /*
> @@ -256,7 +256,7 @@ void error_prepend(Error **errp, const char *fmt, ...)
>   * May be called multiple times.  The resulting hint should end with a
>   * newline.
>   */
> -void error_append_hint(Error **errp, const char *fmt, ...)
> +void error_append_hint(Error *const *errp, const char *fmt, ...)
>      GCC_FMT_ATTR(2, 3);
>  
>  /*
> diff --git a/util/error.c b/util/error.c
> index d4532ce318..b6c89d1412 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -121,7 +121,7 @@ void error_setg_file_open_internal(Error **errp,
>                                "Could not open '%s'", filename);
>  }
>  
> -void error_vprepend(Error **errp, const char *fmt, va_list ap)
> +void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
>  {
>      GString *newmsg;
>  
> @@ -136,7 +136,7 @@ void error_vprepend(Error **errp, const char *fmt, va_list ap)
>      (*errp)->msg = g_string_free(newmsg, 0);
>  }
>  
> -void error_prepend(Error **errp, const char *fmt, ...)
> +void error_prepend(Error *const *errp, const char *fmt, ...)
>  {
>      va_list ap;
>  
> @@ -145,7 +145,7 @@ void error_prepend(Error **errp, const char *fmt, ...)
>      va_end(ap);
>  }
>  
> -void error_append_hint(Error **errp, const char *fmt, ...)
> +void error_append_hint(Error *const *errp, const char *fmt, ...)
>  {
>      va_list ap;
>      int saved_errno = errno;


