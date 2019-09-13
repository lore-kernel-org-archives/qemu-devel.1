Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC5C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1AD206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1AD206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lnB-00077t-CT
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8li8-0002C2-Jb
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8li4-0002AI-Pb
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28885)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8li2-00028k-VG
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:34:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8E7B44FCC9
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 13:33:55 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 386695D9E5;
 Fri, 13 Sep 2019 13:33:45 +0000 (UTC)
Date: Fri, 13 Sep 2019 14:33:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190913133343.GD2682@work-vm>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190912122514.22504-5-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 13 Sep 2019 13:33:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/6] tests: add
 qtest_expect_exit_status()
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
Cc: mprivozn@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Modify the behaviour of qtest_quit() to check against the expected
> exit status value. The default remains 0.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

This looks similar to the one in the current pending migration pull
by Yury Kotov:
   'tests/libqtest: Allow setting expected exit status'

Dave

> ---
>  tests/libqtest.c | 41 ++++++++++++++++++++++-------------------
>  tests/libqtest.h |  9 +++++++++
>  2 files changed, 31 insertions(+), 19 deletions(-)
>=20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 0a6b91737e..1f7910e583 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -44,6 +44,7 @@ struct QTestState
>      bool big_endian;
>      bool irq_level[MAX_IRQ];
>      GString *rx;
> +    int exit_status;
>  };
> =20
>  static GHookList abrt_hooks;
> @@ -123,27 +124,29 @@ static void kill_qemu(QTestState *s)
>          assert(pid =3D=3D s->qemu_pid);
>      }
> =20
> -    /*
> -     * We expect qemu to exit with status 0; anything else is
> -     * fishy and should be logged with as much detail as possible.
> -     */
>      wstatus =3D s->wstatus;
> -    if (wstatus) {
> -        if (WIFEXITED(wstatus)) {
> -            fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEM=
U "
> -                    "process but encountered exit status %d\n",
> -                    __FILE__, __LINE__, WEXITSTATUS(wstatus));
> -        } else if (WIFSIGNALED(wstatus)) {
> -            int sig =3D WTERMSIG(wstatus);
> -            const char *signame =3D strsignal(sig) ?: "unknown ???";
> -            const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped)"=
 : "";
> -
> -            fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
> -                    "from signal %d (%s)%s\n",
> -                    __FILE__, __LINE__, sig, signame, dump);
> +    if (WIFEXITED(wstatus)) {
> +        if (WEXITSTATUS(wstatus) =3D=3D s->exit_status) {
> +            return;
>          }
> -        abort();
> +        fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
> +                "process but encountered exit status %d\n",
> +                __FILE__, __LINE__, WEXITSTATUS(wstatus));
> +    } else if (WIFSIGNALED(wstatus)) {
> +        int sig =3D WTERMSIG(wstatus);
> +        const char *signame =3D strsignal(sig) ?: "unknown ???";
> +        const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped)" : "=
";
> +
> +        fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
> +                "from signal %d (%s)%s\n",
> +                __FILE__, __LINE__, sig, signame, dump);
>      }
> +    abort();
> +}
> +
> +void qtest_expect_exit_status(QTestState *s, int status)
> +{
> +    s->exit_status =3D status;
>  }
> =20
>  static void kill_qemu_hook_func(void *s)
> @@ -213,7 +216,7 @@ QTestState *qtest_init_without_qmp_handshake(const =
char *extra_args)
>      gchar *command;
>      const char *qemu_binary =3D qtest_qemu_binary();
> =20
> -    s =3D g_new(QTestState, 1);
> +    s =3D g_new0(QTestState, 1);
> =20
>      socket_path =3D g_strdup_printf("/tmp/qtest-%d.sock", getpid());
>      qmp_socket_path =3D g_strdup_printf("/tmp/qtest-%d.qmp", getpid())=
;
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index c8cffe5d68..d41229d7fd 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -82,6 +82,15 @@ QTestState *qtest_init_with_serial(const char *extra=
_args, int *sock_fd);
>   */
>  void qtest_quit(QTestState *s);
> =20
> +/**
> + * qtest_expect_exit_status:
> + * @s: #QTestState instance to operate on.
> + * @status: the expected exit status
> + *
> + * Set the expected exit status when calling qtest_quit().
> + */
> +void qtest_expect_exit_status(QTestState *s, int status);
> +
>  /**
>   * qtest_qmp_fds:
>   * @s: #QTestState instance to operate on.
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

