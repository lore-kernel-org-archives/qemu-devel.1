Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA5C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB55622BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB55622BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZfu-0008JU-3i
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hqZfh-0007uj-5O
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hqZff-0004od-Sb
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hqZff-0004nl-JX
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8E4A6300CB2C;
 Thu, 25 Jul 2019 09:04:18 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87E7210021B2;
 Thu, 25 Jul 2019 09:04:12 +0000 (UTC)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-8-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Organization: Red Hat
Message-ID: <cbe08ddf-4552-3603-4d2c-49ea4282a47e@redhat.com>
Date: Thu, 25 Jul 2019 11:04:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725032321.12721-8-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 25 Jul 2019 09:04:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 07/19] fuzz: Modify libqtest to directly
 invoke qtest.c
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/2019 05.23, Oleinik, Alexander wrote:
> libqtest directly invokes the qtest client and exposes a function to
> accept responses.
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/libqtest.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++-
>  tests/libqtest.h |  6 ++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 3c5c3f49d8..a68a7287cb 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -30,12 +30,18 @@
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qstring.h"
> +#ifdef CONFIG_FUZZ
> +#include "sysemu/qtest.h"
> +#endif
>  
>  #define MAX_IRQ 256
>  #define SOCKET_TIMEOUT 50
>  #define SOCKET_MAX_FDS 16
>  
>  QTestState *global_qtest;
> +#ifdef CONFIG_FUZZ
> +static GString *recv_str;
> +#endif
>  
>  struct QTestState
>  {
> @@ -316,6 +322,20 @@ QTestState *qtest_initf(const char *fmt, ...)
>      va_end(ap);
>      return s;
>  }
> +#ifdef CONFIG_FUZZ
> +QTestState *qtest_init_fuzz(const char *extra_args, int *sock_fd)
> +{
> +    QTestState *qts;
> +    qts = g_new(QTestState, 1);
> +    qts->wstatus = 0;
> +    for (int i = 0; i < MAX_IRQ; i++) {
> +        qts->irq_level[i] = false;
> +    }
> +    qts->big_endian = qtest_query_target_endianness(qts);
> +
> +    return qts;
> +}
> +#endif
>  
>  QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
>  {
> @@ -379,9 +399,18 @@ static void socket_sendf(int fd, const char *fmt, va_list ap)
>  {
>      gchar *str = g_strdup_vprintf(fmt, ap);
>      size_t size = strlen(str);
> +#ifdef CONFIG_FUZZ
> +    // Directly call qtest_process_inbuf in the qtest server
> +    GString *gstr = g_string_new_len(str, size);
> +	/* printf(">>> %s",gstr->str); */

Please check your patches with scripts/checkpatch.pl - e.g. don't use
TABs for indentation like in the above line, don't use //-comments, etc.

> +    qtest_server_recv(gstr);
> +    g_string_free(gstr, true);
> +    g_free(str);
> +#else
>  
>      socket_send(fd, str, size);
>      g_free(str);
> +#endif
>  }
>  
>  static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt, ...)
> @@ -433,6 +462,12 @@ static GString *qtest_recv_line(QTestState *s)
>      size_t offset;
>      char *eol;
>  
> +#ifdef CONFIG_FUZZ
> +    eol = strchr(recv_str->str, '\n');
> +    offset = eol - recv_str->str;
> +    line = g_string_new_len(recv_str->str, offset);
> +    g_string_erase(recv_str, 0, offset + 1);
> +#else
>      while ((eol = strchr(s->rx->str, '\n')) == NULL) {
>          ssize_t len;
>          char buffer[1024];
> @@ -453,7 +488,7 @@ static GString *qtest_recv_line(QTestState *s)
>      offset = eol - s->rx->str;
>      line = g_string_new_len(s->rx->str, offset);
>      g_string_erase(s->rx, 0, offset + 1);
> -
> +#endif
>      return line;
>  }
>  
> @@ -797,6 +832,9 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
>  
>  const char *qtest_get_arch(void)
>  {
> +#ifdef CONFIG_FUZZ
> +    return "i386";
> +#endif

Hard-coding "i386" is quite ugly ... it's ok for an RFC patch, but I
think this should be fixed in the final version of the patches. Maybe
you could use TARGET_NAME instead?

>      const char *qemu = qtest_qemu_binary();
>      const char *end = strrchr(qemu, '/');
>  
> @@ -1339,3 +1377,16 @@ void qmp_assert_error_class(QDict *rsp, const char *class)
>  
>      qobject_unref(rsp);
>  }
> +#ifdef CONFIG_FUZZ
> +void qtest_clear_rxbuf(QTestState *s){

For functions, the curly brace should start on a new line.

> +    g_string_set_size(recv_str,0);
> +}

 Thomas

