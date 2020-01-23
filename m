Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA78C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21C92253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/rpVbN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21C92253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaqZ-00049T-U6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuapp-0003iG-KW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuapo-0002te-Id
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:39:41 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iuapo-0002t5-CF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:39:40 -0500
Received: by mail-wm1-x341.google.com with SMTP id b19so2201771wmj.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 03:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n0tMWs3StmJUjvh7UqoyhGYJQxb3xLIGGA3i9fUY/xQ=;
 b=A/rpVbN7ci9y/rAwYBdiM3xQfRP+5lmzG5O5/YG5ac1QbalrnhmwpBVMaNGePxn81H
 nlVRvX/kuKrb8Tdp8ZA5B70GTGl9RFjeO08IvF5wO8A+Prg5W8jhJ9dtP4ptgnXMWfvo
 9WPYHtYPwB4u4LhpK4ePgECSVpLCzDXlHactZQY0wzZXfZhgcHpxpokO/4YKDjxU5JnJ
 tLJIIao6zoSjqwi2AAJv3Au5fy8aupiKoomBWs/PrxfdfzpqYRBbMILtb7tHV1BJ/7KZ
 kwU0vnSENElNCwgaVoLaRXxbUNTp/ttLzerH8xNfYLbjCD7hldw2/xIUz7q1VzXSfdRS
 /SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n0tMWs3StmJUjvh7UqoyhGYJQxb3xLIGGA3i9fUY/xQ=;
 b=hsXwdiN20lTVf8SfQyWcQltnpfgSr3NYG5R3HZOqUBY6ID/LhtZQs17Xyw2Zx31TL1
 K5vBw6qdKB78n1QvKhClKr/FfAntZlVBTLg43Av1OCcklKji1ZSAuksz1pQ3qeHbnDVd
 uw28rsIgQYkKXGXmvwlRX7p6OBuQYNgbUTlWWJgPmy5QILXtFRE/kbGbBORQniPbCBvn
 H8QAxZLw3kguoU41bp89SeKrELMW4NHj6raqMtSgUfNaPcb4z8ZmjFSJxuJFm50K1utj
 YRdTKlw8bqW05OT9TpR3TgnO8z+arT/PCQHqU/ZKE4bCISTeO9o7ZkdceRSRChLvdSCH
 LQ0A==
X-Gm-Message-State: APjAAAW5Dv6wh6tC6IHsSZq4+ial9BtZN62fVREy+2KvtL+pAfXknJvp
 Th6269d97bwRLHCt2uPTRqpxDbwuy2XF3sfxQPA=
X-Google-Smtp-Source: APXvYqzkiHUhXXwgz19jq0VXJs8bScrM2f/VU721+VulEkF+BybtSOtCQ9t2Qh56FqGo0zOYYq/2uphn4KoU045Ce68=
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr3950059wme.26.1579779579260; 
 Thu, 23 Jan 2020 03:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
 <20200110153039.1379601-11-marcandre.lureau@redhat.com>
 <2a3b0024-fb80-c34d-16fd-78f8bc722807@redhat.com>
In-Reply-To: <2a3b0024-fb80-c34d-16fd-78f8bc722807@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Jan 2020 15:39:27 +0400
Message-ID: <CAJ+F1CJBFT7j6qenmD-C053dN4p3YgXFzi3ed=e9vXzr4Hr_ng@mail.gmail.com>
Subject: Re: [PATCH 10/26] object: add object_property_set_defaut_{bool, str, 
 int, uint}()
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Jan 23, 2020 at 3:29 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This patch caught my attention because of the typo in the function, but

Ah! a french "d=C3=A9faut".

> I also noticed that get_default is never set to anything but
> object_property_get_defval.
>
> What do you think about removing the method and just relying on defval?
> In practice there would be a new patch that squashes 7, 10 and the thing
> after my signature.

Indeed, we could remove the get_default callback. I can't find the
reason I added it now.

Are you resending the series then?

>
> Paolo
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 1ea5c8c..035e41c 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -367,13 +367,6 @@ typedef void (ObjectPropertyRelease)(Object *obj,
>   */
>  typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
>
> -/**
> - * ObjectPropertyGetDefault:
> - *
> - * Get an allocated string representation of the default value.
> - */
> -typedef char *(ObjectPropertyGetDefault)(ObjectProperty *prop);
> -
>  struct ObjectProperty
>  {
>      gchar *name;
> @@ -384,7 +377,6 @@ struct ObjectProperty
>      ObjectPropertyResolve *resolve;
>      ObjectPropertyRelease *release;
>      ObjectPropertyInit *init;
> -    ObjectPropertyGetDefault *get_default;
>      void *opaque;
>      QObject *defval;
>  };
> diff --git a/qom/object.c b/qom/object.c
> index 2464a9f..aa6cf19 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1444,15 +1444,6 @@ int64_t object_property_get_int(Object *obj, const=
 char *name,
>      return retval;
>  }
>
> -char *object_property_get_default(ObjectProperty *prop)
> -{
> -    if (!prop->get_default) {
> -        return NULL;
> -    }
> -
> -    return prop->get_default(prop);
> -}
> -
>  static void object_property_init_defval(Object *obj, ObjectProperty *pro=
p)
>  {
>      Visitor *v =3D qobject_input_visitor_new(prop->defval);
> @@ -1463,8 +1454,12 @@ static void object_property_init_defval(Object *ob=
j, ObjectProperty *prop)
>      visit_free(v);
>  }
>
> -static char *object_property_get_defval(ObjectProperty *prop)
> +char *object_property_get_default(ObjectProperty *prop)
>  {
> +    if (!prop->defval) {
> +        return NULL;
> +    }
> +
>      return qstring_free(qobject_to_json(prop->defval), TRUE);
>  }
>
> @@ -1472,11 +1467,9 @@ static void object_property_set_default(ObjectProp=
erty *prop, QObject *defval)
>  {
>      assert(!prop->defval);
>      assert(!prop->init);
> -    assert(!prop->get_default);
>
>      prop->defval =3D defval;
>      prop->init =3D object_property_init_defval;
> -    prop->get_default =3D object_property_get_defval;
>  }
>
>  void object_property_set_default_bool(ObjectProperty *prop, bool value)
> @@ -2610,8 +2603,7 @@ void object_property_add_alias(Object *obj, const c=
har *name,
>          goto out;
>      }
>      op->resolve =3D property_resolve_alias;
> -    if (target_prop->get_default) {
> -        op->get_default =3D target_prop->get_default;
> +    if (target_prop->defval) {
>          op->defval =3D qobject_ref(target_prop->defval);
>      }
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

