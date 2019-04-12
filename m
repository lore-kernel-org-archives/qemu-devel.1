Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D392FC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9725520818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9725520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF0Nw-0005SY-TO
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 13:54:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF0N9-00059P-IY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF0N7-0007ma-Hx
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hF0N7-0007ln-A3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:53:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AEDA3B77F
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:53:51 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D83BE19C65;
	Fri, 12 Apr 2019 17:53:50 +0000 (UTC)
Date: Fri, 12 Apr 2019 18:53:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190412175347.GP2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-14-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-14-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 12 Apr 2019 17:53:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 13/17] qemu-print: New qemu_fprintf(),
 qemu_vfprintf()
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
Message-ID: <20190412175348.V7Lrb6lD-cj7GcZxJFnaNWDn-7BmrlMc1evAVGrOv3A@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> Code that doesn't want to know about current monitor vs. stdout
> vs. stderr takes an fprintf_function callback and a FILE * argument to
> pass to it.  Actual arguments are either fprintf() and stdout or
> stderr, or monitor_fprintf() and the current monitor cast to FILE *.
> monitor_fprintf() casts it right back, and is otherwise identical to
> monitor_printf().  The type-punning is ugly.
> 
> New qemu_fprintf() and qemu_vprintf() address this need without type
> punning: they are like fprintf() and vfprintf(), except they print to
> the current monitor when passed a null FILE *.  The next commits will
> put them to use.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/qemu/qemu-print.h |  4 ++++
>  util/qemu-print.c         | 27 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/qemu/qemu-print.h b/include/qemu/qemu-print.h
> index 8fed32bf42..40b596262f 100644
> --- a/include/qemu/qemu-print.h
> +++ b/include/qemu/qemu-print.h
> @@ -16,4 +16,8 @@
>  int qemu_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
>  int qemu_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  
> +int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
> +    GCC_FMT_ATTR(2, 0);
> +int qemu_fprintf(FILE *stream, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
> +
>  #endif
> diff --git a/util/qemu-print.c b/util/qemu-print.c
> index 86f9417af8..e79d6b8396 100644
> --- a/util/qemu-print.c
> +++ b/util/qemu-print.c
> @@ -40,3 +40,30 @@ int qemu_printf(const char *fmt, ...)
>      va_end(ap);
>      return ret;
>  }
> +
> +/*
> + * Print like vfprintf()
> + * Print to @stream if non-null, else to current monitor.
> + */
> +int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
> +{
> +    if (!stream) {
> +        return monitor_vprintf(cur_mon, fmt, ap);
> +    }
> +    return vfprintf(stream, fmt, ap);
> +}
> +
> +/*
> + * Print like fprintf().
> + * Print to @stream if non-null, else to current monitor.
> + */
> +int qemu_fprintf(FILE *stream, const char *fmt, ...)
> +{
> +    va_list ap;
> +    int ret;
> +
> +    va_start(ap, fmt);
> +    ret = qemu_vfprintf(stream, fmt, ap);
> +    va_end(ap);
> +    return ret;
> +}
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

