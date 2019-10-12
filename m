Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EBAC10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755FA20673
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755FA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAry-0005gV-KD
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJArE-0005Ec-K1
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJArC-0005Fx-Um
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJArC-0005FZ-Mu
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:26:26 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AEA1B83F42
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:26:25 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n18so5435402wro.11
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9MY5Y2ep2vgo7fuOuydwihDxN304oW/s2h/TPlziBto=;
 b=EnnuMbxNV4Q1ioW9tCcq7PPTzdq52NCj1Rzc+WQ8dGocoliacjkvxrvwOLa37QWL6M
 B2CTYbmiTDAvdUajYdAUD4r1PGwChGDkrl4MnuXrPmnNTgeHKcHoa0GDGvKcwR0szWdw
 0Y2oV3ArzkdeRn+31uzth1t/k5IA9utmL8kLwPC6C5UXAIosN5UnwjXDyxVQ6f3Byl4E
 QxeTPOuHXKqPcvV3HaNpCjaTs8BxLDdrxpS2aNubmqp8Br3DtIOYVXhRqG3pWFsgQKqa
 RJJv7o0EP5mSA+MWVL0JsnlCBhwVD4n4J9Vx0jE4bu3TPtcPgsuPaI1Z46pLnOG0lcHN
 oh9Q==
X-Gm-Message-State: APjAAAUgXK6Y08HtWI0TNrwK6PxZKVyJwEmT4ZVAtCdh2UFL4QxGS9pD
 BKMjzOn+E1r2IYGpc96LHQHjaS3/eg8ZZGV65B3YQ2YC6ZpK1GwUMjj9hFd6VTlFU0H81beywOY
 6/G6qoiplIJ11eFY=
X-Received: by 2002:a1c:770f:: with SMTP id t15mr5641899wmi.136.1570861584429; 
 Fri, 11 Oct 2019 23:26:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWk2P2VYbQv9FLwew5KjNILMQPxQCx91BEJzqwKtq8e/kpYes1+G5bq2Np71RzFqkJ4Dum5g==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr5641889wmi.136.1570861584212; 
 Fri, 11 Oct 2019 23:26:24 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id l9sm9810029wme.45.2019.10.11.23.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:26:23 -0700 (PDT)
Subject: Re: [RFC v5 084/126] SLIRP: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-85-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1282bbaa-dbf0-ce1f-f0ef-3e60a6a1538d@redhat.com>
Date: Sat, 12 Oct 2019 08:26:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-85-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jason Wang <jasowang@redhat.com>, armbru@redhat.com,
 Greg Kurz <groug@kaod.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>
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
>   net/slirp.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/slirp.c b/net/slirp.c
> index c4334ee876..cbde9ba2a9 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -941,6 +941,7 @@ static ssize_t guestfwd_write(const void *buf, size=
_t len, void *chr)
>  =20
>   static int slirp_guestfwd(SlirpState *s, const char *config_str, Erro=
r **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       /* TODO: IPv6 */
>       struct in_addr server =3D { .s_addr =3D 0 };
>       struct GuestFwd *fwd;
> @@ -979,7 +980,6 @@ static int slirp_guestfwd(SlirpState *s, const char=
 *config_str, Error **errp)
>               return -1;
>           }
>       } else {
> -        Error *err =3D NULL;
>           /*
>            * FIXME: sure we want to support implicit
>            * muxed monitors here?
> @@ -993,9 +993,8 @@ static int slirp_guestfwd(SlirpState *s, const char=
 *config_str, Error **errp)
>           }
>  =20
>           fwd =3D g_new(struct GuestFwd, 1);
> -        qemu_chr_fe_init(&fwd->hd, chr, &err);
> -        if (err) {
> -            error_propagate(errp, err);
> +        qemu_chr_fe_init(&fwd->hd, chr, errp);
> +        if (*errp) {
>               object_unparent(OBJECT(chr));
>               g_free(fwd);
>               return -1;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

