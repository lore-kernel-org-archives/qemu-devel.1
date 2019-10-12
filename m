Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29A3C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F40D20673
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F40D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAv0-0007qx-VH
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJAu1-0007Ow-Ft
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJAu0-00068l-1t
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJAtz-00068Y-Q3
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:29:19 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE65936955
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:29:18 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id n3so4993621wmf.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F/Re1LtalC/hfshbOT6DreKgpgwSaDkzXGcjNo6f+ZM=;
 b=mTbJdUvNvVgAUGcGlTPSrT7ScxYUQNGhReKXEwmWBdgxscAf8CRwFEFCrkEbzX3Mtv
 4o9w25n8csBOs+GDJp394vDC3BnK9oxvWG/kSTUi1S/zozUxcSFrg+CIJmD/RxyH67ms
 k2jZTP0w9uLLUpxgITk7AcbUnGlVfkBpm5hgT6JGJT5wrzh6WCXosIc6VJTOXsUDYj3e
 yZdmJbDvZwHvJ6NJPcBQCLvQM8sNS/myjCLt/icmxNoPptkgjzRTn0fWpguKB713smHn
 uXQBJVHGHKwkILJ06F381TwrUgWfl8LIKcPMn43oSqHdDp0kxt2FS3eXD4HY4oXzAlOZ
 iFjA==
X-Gm-Message-State: APjAAAUokycmq3aipiuI+/U39QncK3VTpdVVubPLBEqnIPbsEXn10exR
 FxXFsFERIsj/Y0azxGoyhV/Wpnzq2Njls1U7xhoHlC9kqT9pg/7BAzMd0T8N7mIhgR0mUhbdne5
 rUje2GhrSGpTv9UQ=
X-Received: by 2002:adf:fad1:: with SMTP id a17mr17216210wrs.148.1570861757333; 
 Fri, 11 Oct 2019 23:29:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwV7IbJ6pU1RuQTVvrX33VzSBeVOKWpK3iVFW+RyO3/NtSlfUBQl3ocZYxWt9znE/5GTlbyig==
X-Received: by 2002:adf:fad1:: with SMTP id a17mr17216194wrs.148.1570861757043; 
 Fri, 11 Oct 2019 23:29:17 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id z13sm572430wrm.64.2019.10.11.23.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:29:16 -0700 (PDT)
Subject: Re: [RFC v5 119/126] hw/core/bus.c: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-120-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a665d34c-b465-5966-e44a-c836643a3c26@redhat.com>
Date: Sat, 12 Oct 2019 08:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-120-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com,
 Greg Kurz <groug@kaod.org>
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
>   hw/core/bus.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 7f3d2a3dbd..0a1e508963 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -146,14 +146,14 @@ static bool bus_get_realized(Object *obj, Error *=
*errp)
>  =20
>   static void bus_set_realized(Object *obj, bool value, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       BusState *bus =3D BUS(obj);
>       BusClass *bc =3D BUS_GET_CLASS(bus);
>       BusChild *kid;
> -    Error *local_err =3D NULL;
>  =20
>       if (value && !bus->realized) {
>           if (bc->realize) {
> -            bc->realize(bus, &local_err);
> +            bc->realize(bus, errp);
>           }
>  =20
>           /* TODO: recursive realization */
> @@ -161,18 +161,17 @@ static void bus_set_realized(Object *obj, bool va=
lue, Error **errp)
>           QTAILQ_FOREACH(kid, &bus->children, sibling) {
>               DeviceState *dev =3D kid->child;
>               object_property_set_bool(OBJECT(dev), false, "realized",
> -                                     &local_err);
> -            if (local_err !=3D NULL) {
> +                                     errp);

You can add it at the end of the previous line.

Regardless:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +            if (*errp) {
>                   break;
>               }
>           }
> -        if (bc->unrealize && local_err =3D=3D NULL) {
> -            bc->unrealize(bus, &local_err);
> +        if (bc->unrealize && *errp =3D=3D NULL) {
> +            bc->unrealize(bus, errp);
>           }
>       }
>  =20
> -    if (local_err !=3D NULL) {
> -        error_propagate(errp, local_err);
> +    if (*errp) {
>           return;
>       }
>  =20
>=20

