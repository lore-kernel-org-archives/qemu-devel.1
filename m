Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886A5C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5631020673
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5631020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAqd-0004ks-Fj
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJApn-00048w-Dw
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJApm-0004aW-22
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:24:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJApl-0004a8-N1
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:24:57 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0735E83F3D
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:24:56 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k184so4996886wmk.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EBdz5y3l5y/7J5gJrorUUepao7a7QloICLHT4/a3AM4=;
 b=kpDQ/rr835KkxO48FEq/+sbKM0+qPeCk/8m3UulNtkZROW4XDSfB02VBX6BUsnTJ26
 5JZcGPhkKnB8Bunl/0H6mbAlkMUMRyOOx6gBW8NG0vO8Pbw60G0lPRlOzSKqHsAHNFfa
 2b5OjOte82DzoVdhTBDCqCO/T6ZtYoG7x3lR2GNEKIkkruxPn7DMsYAjRK1xdI6Df3XR
 XoFHY+onLBOapbtcBCyZVecaoF6wHQwDlfy5nA0RpZxdow7AF/SHwcSOH8TXDt0dRlQF
 VL/M+oOg3VKp883Ld8aE5yUjntvADYt3LACQrX65tM5VQPiJBGnuPUR4VT34bAEv2RJ7
 B62g==
X-Gm-Message-State: APjAAAUU5QsCicWwBwLDl/6iR/4LN0Firx9RplLK944gu57NOiSKfbIL
 yvZq8QOUcYuhVX1CvgChabggr13eJuJ45CgaZUbGFsxVch2ShTEAw2OFjv5IeU0+7Lp5x8CQj0x
 PFnZTjrv2lJvGjf0=
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr2728307wmi.47.1570861494655; 
 Fri, 11 Oct 2019 23:24:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJBBVg26zw2x7Ns7bpYQSDk/xeStDDbvRfJLyrKI3w9yFZfpQ27jCKzyD34qMSmcStHnTSTw==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr2728290wmi.47.1570861494372; 
 Fri, 11 Oct 2019 23:24:54 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id y3sm20878579wmg.2.2019.10.11.23.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:24:53 -0700 (PDT)
Subject: Re: [RFC v5 075/126] Main loop: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-76-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5d6d11d-1cae-952c-7c76-9cbaad57fb5d@redhat.com>
Date: Sat, 12 Oct 2019 08:24:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-76-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 armbru@redhat.com, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 6:05 PM, Vladimir Sementsov-Ogievskiy wrote:
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp =3D=3D &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>=20
> If we want to check error after errp-function call, we need to
> introduce local_err and than propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>     &error_fatel, this means that we don't break error_abort
>     (we'll abort on error_set, not on error_propagate)
>=20
> This commit (together with its neighbors) was generated by
>=20
> for f in $(git grep -l errp \*.[ch]); do \
>      spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>      --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff =
$f; \
> done;
>=20
> then fix a bit of compilation problems: coccinelle for some reason
> leaves several
> f() {
>      ...
>      goto out;
>      ...
>      out:
> }
> patterns, with "out:" at function end.
>=20
> then
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>=20
> (auto-msg was a file with this commit message)
>=20
> Still, for backporting it may be more comfortable to use only the first
> command and then do one huge commit.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   util/main-loop.c |  5 ++---
>   vl.c             | 14 ++++++--------
>   2 files changed, 8 insertions(+), 11 deletions(-)
>=20
> diff --git a/util/main-loop.c b/util/main-loop.c
> index e3eaa55866..fdd7f50fc8 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -145,9 +145,9 @@ static GArray *gpollfds;
>  =20
>   int qemu_init_main_loop(Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       int ret;
>       GSource *src;
> -    Error *local_error =3D NULL;
>  =20
>       init_clocks(qemu_timer_notify_cb);
>  =20
> @@ -156,9 +156,8 @@ int qemu_init_main_loop(Error **errp)
>           return ret;
>       }
>  =20
> -    qemu_aio_context =3D aio_context_new(&local_error);
> +    qemu_aio_context =3D aio_context_new(errp);
>       if (!qemu_aio_context) {
> -        error_propagate(errp, local_error);
>           return -EMFILE;
>       }
>       qemu_notify_bh =3D qemu_bh_new(notify_event_cb, NULL);
> diff --git a/vl.c b/vl.c
> index 002bf4919e..7499ff5691 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2213,11 +2213,10 @@ static int device_init_func(void *opaque, QemuO=
pts *opts, Error **errp)
>  =20
>   static int chardev_init_func(void *opaque, QemuOpts *opts, Error **er=
rp)
>   {
> -    Error *local_err =3D NULL;
> +    ERRP_AUTO_PROPAGATE();
>  =20
> -    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +    if (!qemu_chr_new_from_opts(opts, NULL, errp)) {
> +        if (*errp) {
>               return -1;
>           }
>           exit(0);
> @@ -2613,8 +2612,8 @@ static int machine_set_property(void *opaque,
>                                   const char *name, const char *value,
>                                   Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       Object *obj =3D OBJECT(opaque);
> -    Error *local_err =3D NULL;
>       char *p, *qom_name;
>  =20
>       if (strcmp(name, "type") =3D=3D 0) {
> @@ -2628,11 +2627,10 @@ static int machine_set_property(void *opaque,
>           }
>       }
>  =20
> -    object_property_parse(obj, value, qom_name, &local_err);
> +    object_property_parse(obj, value, qom_name, errp);
>       g_free(qom_name);
>  =20
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (*errp) {
>           return -1;
>       }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

