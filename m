Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FCBC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F87420674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbfT9kzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F87420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtVN-0007gm-BY
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrRl-00012d-Bg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDrRk-0006We-80
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:14:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDrRk-0006O8-0L
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:14:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id g62so18513293wme.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vBOJRsRvVO3wJPXXvFhNbaVuIx9vh/F/w8uXer5AY28=;
 b=kbfT9kzgLfzL9hsLEiG+SeRwqiNMU4iUmrCt61jWEGxCuFSQueQOdJB6G1Tegp7din
 Et9+utysC1YQCtwwdrG5Cu4TUvbxp7JVhTfB2IvJ9llh9AqXrOHMQjlS5v2c/EcLx3PD
 GCBer5FnTc/6IvSJ76zpocyDLJurE534ujVEukcMZ63kiY9yBppX93v06JlV5kB49Dy0
 O94g0lTV3ixFvcJ3CqlqCPq6/TgvJut6K7XF3RXXzTSf/g9NRrgQVnJsXuUIHi83Hi6d
 kCyjSvKsXXoRrDeapoHZfrUEk3KkMy9nnw+seHGM2M3145wAqEU8tZCU4NgB3wzIMQI7
 KW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vBOJRsRvVO3wJPXXvFhNbaVuIx9vh/F/w8uXer5AY28=;
 b=HjZzkd4qAywCP9eC/gekD1FOTTFZNbw6M3pW1WQEaAuzp64gb/R/kmyt+77UlFHbKr
 x8NU6n8oZXpqb911C7l+8L2yAUFN44NLsdeq+OenyY95cvjfpqd1nxCQTvd85ia7GXJX
 0Gi3nqVgyI/iBkdIOvuO647Ax++R8Q+viPthsnvDUoknNrHoXwlVyjvC8D0ulQJXm1vj
 1Cq5CjFDdH8KRUB4uLb9VJk5ZTnLsg2zFKWQ+zbkLcKu2sSVcGXcGSLpo77gQ072pk6J
 xnUOhLCJfjVXm6yBExCAQoq8Bwvft7NXsKah19sgZHsmVM3+DB9lZunLvqlmheSCZGWK
 AGkw==
X-Gm-Message-State: ANhLgQ1evzwcMf3HvqYmSd6g0eW5LawGLC2TIaKBKtaQvSG9onj4vpMP
 5t2kqcTfPto6nXYp3s/0q4NBEmjyAijJ1MkzokA=
X-Google-Smtp-Source: ADFU+vsqSYCUglt3wxCDTVIkOI8Y2sO4fhlXZapg017PcBUdU37NVEVwK2h4U6DK7+pPruEGDi4y6FXIn56naqpPHto=
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr29131782wmf.4.1584371667016; 
 Mon, 16 Mar 2020 08:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-11-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-11-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 16:14:14 +0100
Message-ID: <CAJ+F1CK8+O_aN-OQUxJkS2+j+ALv6vCp7rRFMAkoBAD9keibBQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/34] tests/test-qmp-event: Check event is actually
 emitted
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

On Sun, Mar 15, 2020 at 3:55 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/test-qmp-event.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
> index d64066139c..7dd0053190 100644
> --- a/tests/test-qmp-event.c
> +++ b/tests/test-qmp-event.c
> @@ -26,6 +26,7 @@
>
>  typedef struct TestEventData {
>      QDict *expect;
> +    bool emitted;
>  } TestEventData;
>
>  TestEventData *test_event_data;
> @@ -52,7 +53,7 @@ void test_qapi_event_emit(test_QAPIEvent event, QDict *=
d)
>      qdict_del(d, "timestamp");
>
>      g_assert(qobject_is_equal(QOBJECT(d), QOBJECT(test_event_data->expec=
t)));
> -
> +    test_event_data->emitted =3D true;
>  }
>
>  static void event_prepare(TestEventData *data,
> @@ -87,6 +88,7 @@ static void test_event_a(TestEventData *data,
>  {
>      data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'EVENT_A' }");
>      qapi_event_send_event_a();
> +    g_assert(data->emitted);
>      qobject_unref(data->expect);
>  }
>
> @@ -95,6 +97,7 @@ static void test_event_b(TestEventData *data,
>  {
>      data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'EVENT_B' }");
>      qapi_event_send_event_b();
> +    g_assert(data->emitted);
>      qobject_unref(data->expect);
>  }
>
> @@ -107,6 +110,7 @@ static void test_event_c(TestEventData *data,
>          "{ 'event': 'EVENT_C', 'data': {"
>          " 'a': 1, 'b': { 'integer': 2, 'string': 'test1' }, 'c': 'test2'=
 } }");
>      qapi_event_send_event_c(true, 1, true, &b, "test2");
> +    g_assert(data->emitted);
>      qobject_unref(data->expect);
>  }
>
> @@ -132,6 +136,7 @@ static void test_event_d(TestEventData *data,
>          "  'string': 'test2', 'enum2': 'value2' },"
>          " 'b': 'test3', 'enum3': 'value3' } }");
>      qapi_event_send_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VAL=
UE3);
> +    g_assert(data->emitted);
>      qobject_unref(data->expect);
>  }
>
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

