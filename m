Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141B7C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF5221473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF5221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDX49-0000RC-Mw
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:24:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDX3O-00006o-4V
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDX3N-0003iA-7K
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hDX3M-0003hQ-Su
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:23:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E61983082B66
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 16:23:23 +0000 (UTC)
Received: from work-vm (ovpn-117-240.ams2.redhat.com [10.36.117.240])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F72A1001E7D;
	Mon,  8 Apr 2019 16:23:22 +0000 (UTC)
Date: Mon, 8 Apr 2019 17:23:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190408162320.GH2687@work-vm>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-12-armbru@redhat.com>
	<87pnpwpre1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <87pnpwpre1.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 08 Apr 2019 16:23:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 11/15] monitor error: Make printf()-like
 functions return a value
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
Message-ID: <20190408162320.BzxXQXLhFqMYd26vdbykzjcl3jB9PhDX5THIifcl4oM@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > printf() & friends return the number of characters written on success,
> > negative value on error.
> >
> > monitor_printf(), monitor_vfprintf(), monitor_vprintf(),
> > error_printf(), error_printf_unless_qmp(), error_vprintf(), and
> > error_vprintf_unless_qmp() return void.  Some of them carry a TODO
> > comment asking for int instead.
> >
> > Improve them to return int like printf() does.
> >
> > This makes our use of monitor_printf() as fprintf_function slightly
> > less dirty: the function cast no longer adds a return value that isn't
> > there.  It still changes a parameter's pointer type.  That will be
> > addressed in a future commit.
> >
> > monitor_vfprintf() always returns zero.  Improve it to return the
> > proper value.
> >
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> [...]
> > diff --git a/stubs/error-printf.c b/stubs/error-printf.c
> > index 99c6406668..537298209d 100644
> > --- a/stubs/error-printf.c
> > +++ b/stubs/error-printf.c
> > @@ -2,19 +2,19 @@
> >  #include "qemu-common.h"
> >  #include "qemu/error-report.h"
> >  
> > -void error_vprintf(const char *fmt, va_list ap)
> > +int error_vprintf(const char *fmt, va_list ap)
> >  {
> >      if (g_test_initialized() && !g_test_subprocess() &&
> >          getenv("QTEST_SILENT_ERRORS")) {
> >          char *msg = g_strdup_vprintf(fmt, ap);
> >          g_test_message("%s", msg);
> >          g_free(msg);
> > -    } else {
> > -        vfprintf(stderr, fmt, ap);
> > +        return strlen(msg);
> 
> Use after free.  Obvious fixup appended.
> 
> >      }
> > +    return vfprintf(stderr, fmt, ap);
> >  }
> >  
> > -void error_vprintf_unless_qmp(const char *fmt, va_list ap)
> > +int error_vprintf_unless_qmp(const char *fmt, va_list ap)
> >  {
> > -    error_vprintf(fmt, ap);
> > +    return error_vprintf(fmt, ap);
> >  }
> [...]
> 
> diff --git a/stubs/error-printf.c b/stubs/error-printf.c
> index 537298209d..1f9d3b3714 100644
> --- a/stubs/error-printf.c
> +++ b/stubs/error-printf.c
> @@ -4,12 +4,15 @@
>  
>  int error_vprintf(const char *fmt, va_list ap)
>  {
> +    int ret;
> +
>      if (g_test_initialized() && !g_test_subprocess() &&
>          getenv("QTEST_SILENT_ERRORS")) {
>          char *msg = g_strdup_vprintf(fmt, ap);
>          g_test_message("%s", msg);
> +        ret = strlen(msg);
>          g_free(msg);
> -        return strlen(msg);
> +        return ret;
>      }
>      return vfprintf(stderr, fmt, ap);
>  }

Yeh, with the fixup:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

