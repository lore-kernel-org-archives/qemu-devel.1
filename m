Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4080BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A8D20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqHL175Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A8D20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuIW-0005BX-W0
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDsuV-000769-HY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDsuU-0004JI-Ca
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:48:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDsuQ-0004Bu-1c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:48:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id 11so18441376wmo.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=deJj+vvBHixf17+aV4bsjONR6VIn1aUycGcjFmJCu6Y=;
 b=SqHL175YW3tAFEVOMId9DGnhnA4aiwgwzXgyOrJfR76T9THhjDSCKs52mOsuAytANi
 G2UIhwLOCMH9Q9T++ahbNVpoBvmpHa4WVqUvjYOOGXhiJNWI2VJzTgdCq7JU9mDzuRT/
 bPNYFUyjm9H1c1YFTDvUl+Ni7CNYKwpD2fJwWFYwNPYcDsLH0voEwlYVggeHOTDktZPv
 MGpLebLQNKcAxA3nlgiqxmwrG8dm+nnEC6aVwM9jsISgHfU8ApenTOKe5WQD9OoYj3p0
 RQYi4xhFd0R2eM9bcf9h1lXw1DCezAqV4zSveBMAniJXidcn9W4V2yNclqSem3PNxdDQ
 bhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=deJj+vvBHixf17+aV4bsjONR6VIn1aUycGcjFmJCu6Y=;
 b=DGUog4TTUbVlDJbwMbcBNeXWX3oLqcnopYsHjY/llXnfwhIGAegXxEbTsmOOVpsoEQ
 sUkN7pmbIxh152NXUZnBE0/g91h15UrndWUcaN0jeaLR1/TugC+fPWmhujfEjqGcjzYy
 rifBVCdPuq7o3xcCrD1X4IC2q7NrmdjRdrLyR6ruGFua4BBvZ02FWXmkcnoKHRVMqk7y
 Wp8qmXd0nsDzBgSeQvRbaKWwi2lLp9d5IKsWRZzSVw2t9TuBSStl7BeOQAYIf/QRNgnb
 46xBv4Cp1u04B+mjNKuOkEJnCcPh2g3fmAeDg49kEarw6fK8+WZxGiKJCIpcfAO2tR5/
 mMwg==
X-Gm-Message-State: ANhLgQ2//3dp+KU3GJXLnPYTdObceypyvE0ZwbpJLhbjaVF22aPQC6PN
 MKlSgM/OCyi6vxm5m9fGnPJymfhRQrwDlR8JYoM=
X-Google-Smtp-Source: ADFU+vu4OpXZvOjFPBGorBMkZs1Ss35e45trs4x7BodfDV4bww3k+2RtstInRNPLWopRB8MxauW8wRQ7utgy4F6EYOQ=
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr70027wma.26.1584377288857;
 Mon, 16 Mar 2020 09:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-12-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-12-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 17:47:56 +0100
Message-ID: <CAJ+F1CKsBntx-W3k8Mb7XyVVRP3iSrAaiUxRco+uZgdmh-n1Ww@mail.gmail.com>
Subject: Re: [PATCH v3 11/34] qapi/schema: Clean up around
 QAPISchemaEntity.connect_doc()
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

On Sun, Mar 15, 2020 at 4:23 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> QAPISchemaEntity calls doc.connect_feature() in .check().  Improper
> since commit ee1e6a1f6c8 split .connect_doc() off .check().  Move the
> call.  Requires making the children call super().connect_doc() as they
> should.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/schema.py | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index d759308b4e..2a2b495987 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -53,13 +53,13 @@ class QAPISchemaEntity:
>          seen =3D {}
>          for f in self.features:
>              f.check_clash(self.info, seen)
> -            if self.doc:
> -                self.doc.connect_feature(f)
> -
>          self._checked =3D True
>
>      def connect_doc(self, doc=3DNone):
> -        pass
> +        doc =3D doc or self.doc
> +        if doc:
> +            for f in self.features:
> +                doc.connect_feature(f)
>
>      def check_doc(self):
>          if self.doc:
> @@ -250,6 +250,7 @@ class QAPISchemaEnumType(QAPISchemaType):
>              m.check_clash(self.info, seen)
>
>      def connect_doc(self, doc=3DNone):
> +        super().connect_doc(doc)
>          doc =3D doc or self.doc
>          if doc:
>              for m in self.members:
> @@ -392,6 +393,7 @@ class QAPISchemaObjectType(QAPISchemaType):
>              m.check_clash(info, seen)
>
>      def connect_doc(self, doc=3DNone):
> +        super().connect_doc(doc)
>          doc =3D doc or self.doc
>          if doc:
>              if self.base and self.base.is_implicit():
> @@ -667,6 +669,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
>                  types_seen[qt] =3D v.name
>
>      def connect_doc(self, doc=3DNone):
> +        super().connect_doc(doc)
>          doc =3D doc or self.doc
>          if doc:
>              for v in self.variants.variants:
> @@ -733,6 +736,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
>                          % self.ret_type.describe())
>
>      def connect_doc(self, doc=3DNone):
> +        super().connect_doc(doc)
>          doc =3D doc or self.doc
>          if doc:
>              if self.arg_type and self.arg_type.is_implicit():
> @@ -775,6 +779,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
>                      % self.arg_type.describe())
>
>      def connect_doc(self, doc=3DNone):
> +        super().connect_doc(doc)
>          doc =3D doc or self.doc
>          if doc:
>              if self.arg_type and self.arg_type.is_implicit():
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

