Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8BAC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064BC2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064BC2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7zE1-0001ML-6a
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i7zDA-0000tI-D2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i7zD8-0005UC-J3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:46:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i7zD8-0005TJ-BT
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:46:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 502BA30A00CF;
 Wed, 11 Sep 2019 09:46:49 +0000 (UTC)
Received: from work-vm (ovpn-117-243.ams2.redhat.com [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0846360852;
 Wed, 11 Sep 2019 09:46:46 +0000 (UTC)
Date: Wed, 11 Sep 2019 10:46:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190911094644.GD2894@work-vm>
References: <20190903162246.18524-1-yury-kotov@yandex-team.ru>
 <20190903162246.18524-3-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903162246.18524-3-yury-kotov@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 11 Sep 2019 09:46:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/3] tests/libqtest: Allow setting
 expected exit status
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Add qtest_set_expected_status function to set expected exit status of
> child process. By default expected exit status is 0.
> 
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/libqtest.c | 36 +++++++++++++++++++++---------------
>  tests/libqtest.h |  9 +++++++++
>  2 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 2713b86cf7..a79d4887ae 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -43,6 +43,7 @@ struct QTestState
>      int qmp_fd;
>      pid_t qemu_pid;  /* our child QEMU process */
>      int wstatus;
> +    int expected_status;
>      bool big_endian;
>      bool irq_level[MAX_IRQ];
>      GString *rx;
> @@ -113,6 +114,11 @@ bool qtest_probe_child(QTestState *s)
>      return false;
>  }
>  
> +void qtest_set_expected_status(QTestState *s, int status)
> +{
> +    s->expected_status = status;
> +}
> +
>  static void kill_qemu(QTestState *s)
>  {
>      pid_t pid = s->qemu_pid;
> @@ -126,24 +132,23 @@ static void kill_qemu(QTestState *s)
>      }
>  
>      /*
> -     * We expect qemu to exit with status 0; anything else is
> +     * Check whether qemu exited with expected exit status; anything else is
>       * fishy and should be logged with as much detail as possible.
>       */
>      wstatus = s->wstatus;
> -    if (wstatus) {
> -        if (WIFEXITED(wstatus)) {
> -            fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
> -                    "process but encountered exit status %d\n",
> -                    __FILE__, __LINE__, WEXITSTATUS(wstatus));
> -        } else if (WIFSIGNALED(wstatus)) {
> -            int sig = WTERMSIG(wstatus);
> -            const char *signame = strsignal(sig) ?: "unknown ???";
> -            const char *dump = WCOREDUMP(wstatus) ? " (core dumped)" : "";
> -
> -            fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
> -                    "from signal %d (%s)%s\n",
> -                    __FILE__, __LINE__, sig, signame, dump);
> -        }
> +    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != s->expected_status) {
> +        fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
> +                "process but encountered exit status %d (expected %d)\n",
> +                __FILE__, __LINE__, WEXITSTATUS(wstatus), s->expected_status);
> +        abort();
> +    } else if (WIFSIGNALED(wstatus)) {
> +        int sig = WTERMSIG(wstatus);
> +        const char *signame = strsignal(sig) ?: "unknown ???";
> +        const char *dump = WCOREDUMP(wstatus) ? " (core dumped)" : "";
> +
> +        fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
> +                "from signal %d (%s)%s\n",
> +                __FILE__, __LINE__, sig, signame, dump);
>          abort();
>      }
>  }
> @@ -248,6 +253,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>      g_test_message("starting QEMU: %s", command);
>  
>      s->wstatus = 0;
> +    s->expected_status = 0;
>      s->qemu_pid = fork();
>      if (s->qemu_pid == 0) {
>          setenv("QEMU_AUDIO_DRV", "none", true);
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 07ea35867c..c00bca94af 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -997,4 +997,13 @@ void qmp_assert_error_class(QDict *rsp, const char *class);
>   */
>  bool qtest_probe_child(QTestState *s);
>  
> +/**
> + * qtest_set_expected_status:
> + * @s: QTestState instance to operate on.
> + * @status: an expected exit status.
> + *
> + * Set expected exit status of the child.
> + */
> +void qtest_set_expected_status(QTestState *s, int status);
> +
>  #endif
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

