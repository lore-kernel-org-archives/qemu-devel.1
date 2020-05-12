Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF40CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE29420740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xc0BvxEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE29420740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZmY-0003jt-Vu
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masahiroy@kernel.org>)
 id 1jYZjA-0001BK-MQ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:34:04 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:65279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <masahiroy@kernel.org>)
 id 1jYZj9-0002QK-6R
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:34:04 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 04CIXXSf012726
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 03:33:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 04CIXXSf012726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1589308414;
 bh=r2IuFyoAYs8oH8XqqCqe4IsY9J5IPs8rDV5kMHvqKrY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xc0BvxEW0r9vkIxCL6gpsOjQvWOtRThpt1+/E9oCWOYuzvvqZptCRUTtKRmBjDTT4
 cfRoYVZAhRhTDnRsySW7lzqHlw4ZckXkAO41BPqpVx+iaSqG/1QJIso9eFgeHo8DKZ
 /qydKK7Y7AiGw7KypcEmS579yLcAfKipiLzTmuW60GAQM8B3xwrZlY+nqyY4La4nQx
 QQBXFUdrZ4nzvGgtH7bqrj6uFYO1XH2pgqgkSCrOywUhCDDaHM1xoq3aascHMMKhaN
 Hcpoix9PuvWviw7nODIdEWlbA9PJnQzFBo+smWNLze2j02Fq2K7i+kc7lEOMqBSGTg
 rIGCqTkS1ye9w==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id g35so5106669uad.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:33:33 -0700 (PDT)
X-Gm-Message-State: AGi0PuZGi57Z9CyQwad/Y0NK4FdCsjd31K15xrePKZLJXZgkAzE4uM5R
 T0TJxy97cL47bAtZCuqBUubpqgWiW03Ohw60TgI=
X-Google-Smtp-Source: APiQypLJcfWwL435eFa/MlpVsdA3IlV67Vmc4dAv/W+n6uGqnnpxSv+iZT5fRgIK+Z4zNNA+9WmmV3f+NUXDoFriIBw=
X-Received: by 2002:ab0:4ac9:: with SMTP id t9mr17631030uae.40.1589308412680; 
 Tue, 12 May 2020 11:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200512173104.2293073-1-masahiroy@kernel.org>
 <8f3abc47-30d0-612e-4d8a-9a861d5c2a48@redhat.com>
In-Reply-To: <8f3abc47-30d0-612e-4d8a-9a861d5c2a48@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 13 May 2020 03:32:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7nfnaAuRS0H786V6cMSp-a7OvAHwRQs6_c+-eprnzEA@mail.gmail.com>
Message-ID: <CAK7LNAR7nfnaAuRS0H786V6cMSp-a7OvAHwRQs6_c+-eprnzEA@mail.gmail.com>
Subject: Re: [PATCH] qom/object: pass (Object *) to
 object_initialize_with_type()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=210.131.2.82;
 envelope-from=masahiroy@kernel.org; helo=conssluserg-03.nifty.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 14:33:59
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 13, 2020 at 3:17 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 5/12/20 7:31 PM, Masahiro Yamada wrote:
> > object_new_with_type() already passes (Object *) pointer.
> > Avoid casting back and forth.
>
> But object_initialize() doesn't...

That is no problem.

A caller can pass an opaque pointer
to a function that takes (Object *).

There is no explicit cast for it.






>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >   qom/object.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/qom/object.c b/qom/object.c
> > index e4085d8ae2..9d1a918e42 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -495,10 +495,8 @@ static void object_class_property_init_all(Object =
*obj)
> >       }
> >   }
> >
> > -static void object_initialize_with_type(void *data, size_t size, TypeI=
mpl *type)
> > +static void object_initialize_with_type(Object *obj, size_t size, Type=
Impl *type)
> >   {
> > -    Object *obj =3D data;
> > -
> >       type_initialize(type);
> >
> >       g_assert(type->instance_size >=3D sizeof(Object));
> >
>


--
Best Regards
Masahiro Yamada

