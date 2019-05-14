Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E28DC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDA22147A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDA22147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQY0R-0000zw-FQ
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 10:02:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQXz1-0008GL-NW
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQXz0-00081D-GQ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:00:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hQXz0-0007yz-8D; Tue, 14 May 2019 10:00:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C84818124F;
	Tue, 14 May 2019 14:00:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 651531975F;
	Tue, 14 May 2019 14:00:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id CDA6D11385E4; Tue, 14 May 2019 16:00:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
References: <20190514131552.15832-1-yury-kotov@yandex-team.ru>
Date: Tue, 14 May 2019 16:00:19 +0200
In-Reply-To: <20190514131552.15832-1-yury-kotov@yandex-team.ru> (Yury Kotov's
	message of "Tue, 14 May 2019 16:15:52 +0300")
Message-ID: <8736lhf85o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 14 May 2019 14:00:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RESEND] monitor: Fix return type of
 monitor_fdset_dup_fd_find
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yury Kotov <yury-kotov@yandex-team.ru> writes:

> monitor_fdset_dup_fd_find_remove() and monitor_fdset_dup_fd_find()
> returns mon_fdset->id which is int64_t. Downcast from int64_t to int leads to

Grammar nits:

    s/returns/return/
    s/Downcast/Downcasting/

> a bug with removing fd from fdset which id >= 2^32.

s/which/with/

> So, fix return types for these function.
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---

If I feed your message to git-am, I get

    Applying: monitor: Fix return type of monitor_fdset_dup_fd_find
    error: corrupt patch at line 12
    Patch failed at 0001 monitor: Fix return type of monitor_fdset_dup_fd_find
    [...]

Did you use git-send-email?

>  include/monitor/monitor.h | 2 +-
>  monitor.c                 | 4 ++--
>  stubs/fdset.c             | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index c1b40a9cac..2872621afd 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -46,7 +46,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_=
> id, int64_t fdset_id,
>  int monitor_fdset_get_fd(int64_t fdset_id, int flags);
>  int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
>  void monitor_fdset_dup_fd_remove(int dup_fd);
> -int monitor_fdset_dup_fd_find(int dup_fd);
> +int64_t monitor_fdset_dup_fd_find(int dup_fd);
> =20

Looks mime-damaged.

>  void monitor_vfprintf(FILE *stream,
>                        const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
> diff --git a/monitor.c b/monitor.c
> index 4807bbe811..50e6e820d6 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -2585,7 +2585,7 @@ err:
>      return -1;
>  }
> =20
> -static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
> +static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
>  {
>      MonFdset *mon_fdset;
>      MonFdsetFd *mon_fdset_fd_dup;
> @@ -2613,7 +2613,7 @@ err:
>      return -1;
>  }
> =20
> -int monitor_fdset_dup_fd_find(int dup_fd)
> +int64_t monitor_fdset_dup_fd_find(int dup_fd)
>  {
>      return monitor_fdset_dup_fd_find_remove(dup_fd, false);
>  }
> diff --git a/stubs/fdset.c b/stubs/fdset.c
> index 4f3edf2ea4..a1b8f41f62 100644
> --- a/stubs/fdset.c
> +++ b/stubs/fdset.c
> @@ -7,7 +7,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd=
> )
>      return -1;
>  }
> =20
> -int monitor_fdset_dup_fd_find(int dup_fd)
> +int64_t monitor_fdset_dup_fd_find(int dup_fd)
>  {
>      return -1;
>  }
> --=20
> 2.21.0

The patch is complete because:

* monitor_fdset_dup_fd_find_remove() is used only by
  monitor_fdset_dup_fd_find(), which you fix as well, and
  monitor_fdset_dup_fd_remove(), which ignores the return value.

* monitor_fdset_dup_fd_find() is used only by qemu_close(), which stores
  the return value in an int64_t.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

