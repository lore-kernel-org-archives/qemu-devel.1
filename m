Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA451C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E7421721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="1afHzrjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E7421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41779 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAlg-0006qI-Q3
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:14:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVAh3-0003BK-M4
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVAh2-0005bq-HT
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:09:17 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:37682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hVAh1-0005YJ-PG
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:09:16 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id A0CDF2E0DC7;
	Mon, 27 May 2019 11:09:10 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	ZNkBlM54V7-9ApujB2D; Mon, 27 May 2019 11:09:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1558944550; bh=k3yud3imGdx6RPWhy2rOkWc8xATsBMl2uZZnsS3K/Jg=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=1afHzrjM2YUBZYJXgHpMFizrSmC0QSgDviuEh1pj86i6alis8+gO+HEfN6buWXu0M
	yR1jOjIJyRdss/MImi2yrZfcUR6Nm8Qmr7vlcE1idiaOlq/PLvIuIdRqFl9pIzk7zZ
	VR/lImN7hiJJh/psLwkJfm/QvPad9YOCwJTIhOV8=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[2a02:6b8:0:1619::162])
	by dlvcorp1p.mail.yandex.net with LMTP id 01oGvHO0yW-uRAfadDU
	for <yury-kotov@yandex-team.ru>; Mon, 27 May 2019 11:08:59 +0300
Received: by iva6-8a76e93b6298.qloud-c.yandex.net with HTTP;
	Mon, 27 May 2019 11:08:59 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
In-Reply-To: <20190523094433.30297-1-yury-kotov@yandex-team.ru>
References: <20190523094433.30297-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 27 May 2019 11:09:09 +0300
Message-Id: <1120521558944539@iva6-8a76e93b6298.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.45.199.163
Subject: Re: [Qemu-devel] [PATCH v3] monitor: Fix return type of
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

23.05.2019, 12:45, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> monitor_fdset_dup_fd_find_remove() and monitor_fdset_dup_fd_find()
> return mon_fdset->id which is int64_t. Downcasting from int64_t to int
> leads to a bug with removing fd from fdset with id >=3D 2^32.
> So, fix return types for these function.
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> =C2=A0include/monitor/monitor.h | 2 +-
> =C2=A0monitor.c | 4 ++--
> =C2=A0stubs/fdset.c | 2 +-
> =C2=A03 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 86656297f1..51f048d61f 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -45,6 +45,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdse=
t_id, int64_t fdset_id,
> =C2=A0int monitor_fdset_get_fd(int64_t fdset_id, int flags);
> =C2=A0int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
> =C2=A0void monitor_fdset_dup_fd_remove(int dup_fd);
> -int monitor_fdset_dup_fd_find(int dup_fd);
> +int64_t monitor_fdset_dup_fd_find(int dup_fd);
>
> =C2=A0#endif /* MONITOR_H */
> diff --git a/monitor.c b/monitor.c
> index 6428eb3b7e..a0e637f7d6 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -2602,7 +2602,7 @@ err:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> =C2=A0}
>
> -static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
> +static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remov=
e)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdset *mon_fdset;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdsetFd *mon_fdset_fd_dup;
> @@ -2630,7 +2630,7 @@ err:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> =C2=A0}
>
> -int monitor_fdset_dup_fd_find(int dup_fd)
> +int64_t monitor_fdset_dup_fd_find(int dup_fd)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return monitor_fdset_dup_fd_find_remove(d=
up_fd, false);
> =C2=A0}
> diff --git a/stubs/fdset.c b/stubs/fdset.c
> index 4f3edf2ea4..a1b8f41f62 100644
> --- a/stubs/fdset.c
> +++ b/stubs/fdset.c
> @@ -7,7 +7,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_=
fd)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> =C2=A0}
>
> -int monitor_fdset_dup_fd_find(int dup_fd)
> +int64_t monitor_fdset_dup_fd_find(int dup_fd)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> =C2=A0}
> --
> 2.21.0

