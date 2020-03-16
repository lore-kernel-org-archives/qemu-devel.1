Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D56C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A008A2071C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZghqREJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A008A2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuTc-0001q4-Qe
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtXr-0003px-1e
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtXo-0002Tw-Er
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDtXo-0002NW-1e
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id z13so2549942wml.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EPnkFehuoY8i9HEKpPlDslyHYZfmul1u7YpuP2BpokM=;
 b=ZghqREJzaSEtrozbZV7tluTdr+QkgyxjfdoH5vyOi5FLUkY2Z648wGoAIXA29vzrHr
 fmbkAfIXJiGX4Ic/c7n9B0D55/7Z8vXk3KK32wmP3hR1glGxemZYtHv/8X18tiyh91ai
 q3JeEVPfyVgs31/euZpQ76YRQUxfHgRmpGHE66oavFx+sznx/g+Y5uc5gGZKYswGtrta
 9fb1kheRE/0xb+0QPm59lu9XaK9kzLyQV7Xh6ibyjA6avdesTjkA03sKuhpum/tY1aGR
 v6/fGqsKtTTcMEAdhWo+nwsZsW2YToj2RCDH8Jf8n4Y4xUFBgmXxmXns6s3jMnxfgPO6
 17sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EPnkFehuoY8i9HEKpPlDslyHYZfmul1u7YpuP2BpokM=;
 b=jrQKT/NuzdTp/Bjfl8XogzHR5pTAUd9PZlqmox066uUF8Mt4/0BcTRpL46+5Bs8eNE
 V0sZxMnF2S/aSooE2idlUYxhWzN4Bm+w6J/NDLsG4OOI+TZkyHpgHAZbC90D3o2oqjNq
 2tGpD0e/6ms/tFAlDK3IJpUghn7trK/QajTCnw3n5xRrY+mSYvbNcobQl1Ok2Vmd0Urg
 4qK9m0hU8mU7/wQ5iREtN0w3sjPjOGHPZ6Mb2N5qs55BggeAUhSdbhftUgiIdk5BPOZq
 dgnC6gSEZbEWuAC5Y0Vw4lRWfhkgybST/0e0h16kLkHOJez/d/AvKNxl9jwiUdj9+sdY
 vWiw==
X-Gm-Message-State: ANhLgQ2dzWhgInfykz+msaRA+g9WBgizghLKrBWt9OnYaHURsawpx1pX
 mAdkCT4BPJQXg7b8zZAtXI8SmcfU7aJNOBFmLCY=
X-Google-Smtp-Source: ADFU+vt6TGZYv/yqRZBrAzcXuCIEiuhwu1UwExmaurjGJg1CtAQPmEHVUzT2Neocln/w9lWCsXT8BrZbOL6neCS4GQ0=
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr224991wma.26.1584379731060;
 Mon, 16 Mar 2020 10:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-23-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-23-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 18:28:25 +0100
Message-ID: <CAJ+F1CKD_hfU3XWLjTPHh4xkNCU6MokbL6yz5-LVEtBbfkTMAg@mail.gmail.com>
Subject: Re: [PATCH v3 22/34] qapi: Simplify how qmp_dispatch() deals with
 QCO_NO_SUCCESS_RESP
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 15, 2020 at 3:51 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qapi/qmp-dispatch.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index a588072523..550d1fe8d2 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -106,7 +106,7 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *re=
quest,
>      QDict *dict =3D qobject_to(QDict, request);
>      QObject *id =3D dict ? qdict_get(dict, "id") : NULL;
>      QObject *ret =3D NULL;
> -    QDict *rsp;
> +    QDict *rsp =3D NULL;
>
>      dict =3D qmp_dispatch_check_obj(request, allow_oob, &err);
>      if (!dict) {
> @@ -151,31 +151,32 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *=
request,
>          args =3D qdict_get_qdict(dict, "arguments");
>          qobject_ref(args);
>      }
> -
>      cmd->fn(args, &ret, &err);
> +    qobject_unref(args);
>      if (err) {
> -        ;
> -    } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
> +        goto out;
> +    }
> +
> +    if (cmd->options & QCO_NO_SUCCESS_RESP) {
>          g_assert(!ret);
> +        return NULL;
>      } else if (!ret) {
>          /* TODO turn into assertion */
>          ret =3D QOBJECT(qdict_new());
>      }
>
> -    qobject_unref(args);
> +    rsp =3D qdict_new();
> +    qdict_put_obj(rsp, "return", ret);
>
>  out:
>      if (err) {
> +        assert(!rsp);
>          rsp =3D qmp_error_response(err);
> -    } else if (ret) {
> -        rsp =3D qdict_new();
> -        qdict_put_obj(rsp, "return", ret);
> -    } else {
> -        /* Can only happen for commands with QCO_NO_SUCCESS_RESP */
> -        rsp =3D NULL;
>      }
>
> -    if (rsp && id) {
> +    assert(rsp);
> +
> +    if (id) {
>          qdict_put_obj(rsp, "id", qobject_ref(id));
>      }
>
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

