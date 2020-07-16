Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21254C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF91A20739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJQGlZDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF91A20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6eI-0003v0-5n
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jw6dL-00033O-8u
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:21:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jw6dJ-0002A4-Gl
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:21:19 -0400
Received: by mail-oi1-x242.google.com with SMTP id t4so5517972oij.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7v1rEu2z1JElygPVDplx04nFbLHvlJOrfDxlEQux3Mw=;
 b=bJQGlZDVvjWrDH4TX6tKbO7I1w8QXTP4fnUK/5xZcbaV12gy6bOR5kc8pekS5cmtR/
 qYDnqcDkoe3yJOivLIkbOwMW+I+tjf+vFYO5HZJg48bwS41+ewDUOIGXN/OU+x6CVQew
 DxTHUs0GDUhKz1XoIXhWyV1Vc44kcDZOS8ld5Ny2JQ2b+y/JylwlCoUkjsBOcKy1HK9O
 OPT+Y3ttRe5Hk6oYG05YqO37T7y4CykM1tVJ29k9XgfOVA5m9iFl9bPpI234qTtreKpS
 sJxwC+7mmj9ZoliTG4eqKxPlSAe3w+JF2b56WU1quk5dhnxAxgro3lUh+vAwx2nOV0rx
 Krzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7v1rEu2z1JElygPVDplx04nFbLHvlJOrfDxlEQux3Mw=;
 b=L9iSioV2dv3aV1c/elU9U6pBVWVTx/KFJlveFF9wKq7QWLEtusF6+dNE3/ZiQfUSO9
 BVa0l3gQXAD3TIWCxccfNlxmQHoO5f/6InDo4n6NAeNCocESmRtsr/4MJ1uTJOyN+ruU
 CcAMk53hjGYrZqdDRwwDaXRHjTFBrOPN/QX63kgqxI0/aAgWyu4q3izqrF/YQc6DLNMD
 Sga63gOfiR1STLdYQwh0Q4aL+3eqt0FI6kjmsgxvyB1EAfnToeR2uPwxA/tPAGUTO1Ih
 a5DD0/fZQa/oOzENnGexeY8s1lLYZiIg1crsf1xIaUSZNnIxhYdBv3nqo1hS6hIVOO3v
 jktw==
X-Gm-Message-State: AOAM533eqmice8jT7t8eEt0aQi8Abf+RGxblgD6BD8M4nLRiTQvEfuJU
 CymrsAgn0j0XQ0i5a+e5mtW4aUJbTorLaeKFKSU=
X-Google-Smtp-Source: ABdhPJzlkiZORKR4eg5S02xDrRnfjPreq/NBJy+Eplz6ve9nBNPi5RxmcMmpr8JEzLAM4n1/PN0JNQc4L0ZgyXgnXS8=
X-Received: by 2002:aca:524c:: with SMTP id g73mr4356010oib.150.1594916475880; 
 Thu, 16 Jul 2020 09:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200716150617.4027356-1-armbru@redhat.com>
In-Reply-To: <20200716150617.4027356-1-armbru@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 17 Jul 2020 00:20:37 +0800
Message-ID: <CAKXe6S+BKQtmPfciz5f5NoWnw=PT-wgB1t447=eFgPCjsONkKQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1] qapi: Fix visit_type_STRUCT() not to fail for
 null object
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:07=E5=86=99=E9=81=93=EF=BC=9A
>
> To make deallocating partially constructed objects work, the
> visit_type_STRUCT() need to succeed without doing anything when passed
> a null object.
>
> Commit cdd2b228b9 "qapi: Smooth visitor error checking in generated
> code" broke that.  To reproduce, run tests/test-qobject-input-visitor
> with AddressSanitizer:
>
>     =3D=3D4353=3D=3DERROR: LeakSanitizer: detected memory leaks
>
>     Direct leak of 16 byte(s) in 1 object(s) allocated from:
>         #0 0x7f192d0c5d28 in __interceptor_calloc (/usr/lib/x86_64-linux-=
gnu/libasan.so.4+0xded28)
>         #1 0x7f192cd21b10 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib=
-2.0.so.0+0x51b10)
>         #2 0x556725f6bbee in visit_next_list qapi/qapi-visit-core.c:86
>         #3 0x556725f49e15 in visit_type_UserDefOneList tests/test-qapi-vi=
sit.c:474
>         #4 0x556725f4489b in test_visitor_in_fail_struct_in_list tests/te=
st-qobject-input-visitor.c:1086
>         #5 0x7f192cd42f29  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x=
72f29)
>
>     SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).
>
> Test case /visitor/input/fail/struct-in-list feeds a list with a bad
> element to the QObject input visitor.  Visiting that element duly
> fails, and aborts the visit with the list only partially constructed:
> the faulty object is null.  Cleaning up the partially constructed list
> visits that null object, fails, and aborts the visit before the list
> node gets freed.
>
> Fix the the generated visit_type_STRUCT() to succeed for null objects.
>
> Fixes: cdd2b228b973d2a29edf7696ef6e8b08ec329019
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Oh, I also sent this too.
Not matter, just ignore my patch.

Tested-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  scripts/qapi/visit.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 3fb2f30510..cdabc5fa28 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -249,6 +249,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
>      if (!*obj) {
>          /* incomplete */
>          assert(visit_is_dealloc(v));
> +        ok =3D true;
>          goto out_obj;
>      }
>      if (!visit_type_%(c_name)s_members(v, *obj, errp)) {
> --
> 2.26.2
>
>

