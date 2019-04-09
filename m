Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD4C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A286E20651
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A286E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmlv-0004bN-PG
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:10:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDml7-0004JB-ED
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDml5-0003Rg-FK
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>)
	id 1hDml1-0003Oc-4q; Tue, 09 Apr 2019 05:09:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D4A0C04D295;
	Tue,  9 Apr 2019 09:09:29 +0000 (UTC)
Received: from work-vm (ovpn-117-233.ams2.redhat.com [10.36.117.233])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 41F985D719;
	Tue,  9 Apr 2019 09:09:25 +0000 (UTC)
Date: Tue, 9 Apr 2019 10:09:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190409090922.GC2964@work-vm>
References: <20190409085245.31548-1-thuth@redhat.com>
	<20190409085245.31548-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190409085245.31548-5-thuth@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 09 Apr 2019 09:09:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 4/5] tests/test-hmp: Use
 qtest_init() instead of qtest_start()
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
Cc: lvivier@redhat.com, Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, armbru@redhat.com,
	Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409090922.CQQqpm_xz2VqNf0kWzxma9-NBk7n_5RQuloaViAuF9A@z>

* Thomas Huth (thuth@redhat.com) wrote:
> qtest_start() + qtest_end() should be avoided, since they use the
> global_qtest variable that we want to get rid of in the long run
> Use qtest_init() and qtest_quit() instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/test-hmp.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 54a01824dc..f0d843e34a 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -72,13 +72,13 @@ static const char *hmp_cmds[] = {
>  };
>  
>  /* Run through the list of pre-defined commands */
> -static void test_commands(void)
> +static void test_commands(QTestState *qts)
>  {
>      char *response;
>      int i;
>  
>      for (i = 0; hmp_cmds[i] != NULL; i++) {
> -        response = hmp("%s", hmp_cmds[i]);
> +        response = qtest_hmp(qts, "%s", hmp_cmds[i]);
>          if (verbose) {
>              fprintf(stderr,
>                      "\texecute HMP command: %s\n"
> @@ -91,11 +91,11 @@ static void test_commands(void)
>  }
>  
>  /* Run through all info commands and call them blindly (without arguments) */
> -static void test_info_commands(void)
> +static void test_info_commands(QTestState *qts)
>  {
>      char *resp, *info, *info_buf, *endp;
>  
> -    info_buf = info = hmp("help info");
> +    info_buf = info = qtest_hmp(qts, "help info");
>  
>      while (*info) {
>          /* Extract the info command, ignore parameters and description */
> @@ -107,7 +107,7 @@ static void test_info_commands(void)
>          if (verbose) {
>              fprintf(stderr, "\t%s\n", info);
>          }
> -        resp = hmp("%s", info);
> +        resp = qtest_hmp(qts, "%s", info);
>          g_free(resp);
>          /* And move forward to the next line */
>          info = strchr(endp + 1, '\n');
> @@ -124,14 +124,15 @@ static void test_machine(gconstpointer data)
>  {
>      const char *machine = data;
>      char *args;
> +    QTestState *qts;
>  
>      args = g_strdup_printf("-S -M %s", machine);
> -    qtest_start(args);
> +    qts = qtest_init(args);
>  
> -    test_info_commands();
> -    test_commands();
> +    test_info_commands(qts);
> +    test_commands(qts);
>  
> -    qtest_end();
> +    qtest_quit(qts);
>      g_free(args);
>      g_free((void *)data);
>  }
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

