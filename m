Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D683BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1A520674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoXh0etP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1A520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuRb-0006VF-QU
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtCT-0006IF-Qe
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtCS-0000ac-CU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:06:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDtCS-0000LV-1q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:06:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id y2so6718715wrn.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+aehvrjy0SyV5NB78ZWbob8FS5DKF0bgZJt6g171eSY=;
 b=UoXh0etP7PAhMzIHl5pGI12K7jPec9AFOjNdemwBIYYDMhfgQ6322Se/kQyWJyvxj5
 nmwdatoehAxcBreu45kyRdtBAvSZe4o/YlgLVX5vtZANSJXl84gQ9Nc4QhyvhaaISy6/
 6NroTy5P0bjUAMwT8EQUHzZqJXq3hW7VkPjUHC3G+bkzhxtNBmN//5TnSxdvD4ey1ndW
 zadb16vz5T+nrsgKETGShINAkzqmS1GiCaAqRXSOieH6hB3BlcRixqmPEmU4gmn+bNvV
 TsnaZZmwpYB7jQi8ja8q1uE56NNdC6xiXQ822/+uqPmNswfeb5eib12Zxl/NSXHL376N
 NWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+aehvrjy0SyV5NB78ZWbob8FS5DKF0bgZJt6g171eSY=;
 b=mFg2N1a9w2cuTXjrlFFFuT0WrJAxBrFDkC4scUFXahZ8UUCbaTCsn7ovDF7cgbkq56
 UXV0MjnjiSqfadfKceiA5eVFKwf/NWPzxXo4mssNvOGc6Nox4nVNc7kPSgU64aBkg0Wm
 2qm1NRXlvJD7Pja0IiVeaqftUXNddvPGadXaTDX29NLyfWQokiXEyq9Lgwzv5LZpKdvB
 4wW5TLXCYtJBiVwiix/G/IsXXRm2NRwvN8RP2lD1tAGG3RDH+v59/FPz6BKcU+3B5SoZ
 TzsDcOfY/pmDbQYaEIKXM8CJ1EtY4fONBoDiJOuGdvskuMdSxHELSqAxgVOHoOafTBV+
 DH8g==
X-Gm-Message-State: ANhLgQ2LtY6Hm/tblXHFU9thHU6wHT9nk2U2bmOrLVfM9UblDOuayBky
 NHdPmSQZUGkrESFi/ah/XDu/m5+YuCNyEcHS+JU=
X-Google-Smtp-Source: ADFU+vu5P19/Qf7O1XND33l2+njh/AxqlvTEcl203lEmHVkSMeTVUkipcIrrAlntJIL8pCs09kQMPgvgC3F08ka5v1M=
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr384774wrv.2.1584378406871;
 Mon, 16 Mar 2020 10:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-19-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-19-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 18:06:35 +0100
Message-ID: <CAJ+F1C+NaANkyF7NVs5_XW=Gy0wR7Js_dwhsw8gSFi3kGqZ_aA@mail.gmail.com>
Subject: Re: [PATCH v3 18/34] qapi/schema: Rename QAPISchemaObjectType{Variant, 
 Variants}
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

On Sun, Mar 15, 2020 at 4:19 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> QAPISchemaObjectTypeVariants represents both object type and alternate
> type variants.  Rename to QAPISchemaVariants.
>
> Rename QAPISchemaObjectTypeVariant the same way.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/schema.py | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 0acf8b466f..033c84c4a0 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -338,7 +338,7 @@ class QAPISchemaObjectType(QAPISchemaType):
>              assert isinstance(m, QAPISchemaObjectTypeMember)
>              m.set_defined_in(name)
>          if variants is not None:
> -            assert isinstance(variants, QAPISchemaObjectTypeVariants)
> +            assert isinstance(variants, QAPISchemaVariants)
>              variants.set_defined_in(name)
>          self._base_name =3D base
>          self.base =3D None
> @@ -449,7 +449,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
>
>      def __init__(self, name, info, doc, ifcond, features, variants):
>          super().__init__(name, info, doc, ifcond, features)
> -        assert isinstance(variants, QAPISchemaObjectTypeVariants)
> +        assert isinstance(variants, QAPISchemaVariants)
>          assert variants.tag_member
>          variants.set_defined_in(name)
>          variants.tag_member.set_defined_in(self.name)
> @@ -512,7 +512,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
>              self.name, self.info, self.ifcond, self.features, self.varia=
nts)
>
>
> -class QAPISchemaObjectTypeVariants:
> +class QAPISchemaVariants:
>      def __init__(self, tag_name, info, tag_member, variants):
>          # Flat unions pass tag_name but not tag_member.
>          # Simple unions and alternates pass tag_member but not tag_name.
> @@ -522,7 +522,7 @@ class QAPISchemaObjectTypeVariants:
>          assert (isinstance(tag_name, str) or
>                  isinstance(tag_member, QAPISchemaObjectTypeMember))
>          for v in variants:
> -            assert isinstance(v, QAPISchemaObjectTypeVariant)
> +            assert isinstance(v, QAPISchemaVariant)
>          self._tag_name =3D tag_name
>          self.info =3D info
>          self.tag_member =3D tag_member
> @@ -572,8 +572,8 @@ class QAPISchemaObjectTypeVariants:
>              cases =3D {v.name for v in self.variants}
>              for m in self.tag_member.type.members:
>                  if m.name not in cases:
> -                    v =3D QAPISchemaObjectTypeVariant(m.name, self.info,
> -                                                    'q_empty', m.ifcond)
> +                    v =3D QAPISchemaVariant(m.name, self.info,
> +                                          'q_empty', m.ifcond)
>                      v.set_defined_in(self.tag_member.defined_in)
>                      self.variants.append(v)
>          if not self.variants:
> @@ -681,7 +681,7 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
>                                          self.describe)
>
>
> -class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
> +class QAPISchemaVariant(QAPISchemaObjectTypeMember):
>      role =3D 'branch'
>
>      def __init__(self, name, info, typ, ifcond=3DNone):
> @@ -987,7 +987,7 @@ class QAPISchema:
>              None))
>
>      def _make_variant(self, case, typ, ifcond, info):
> -        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
> +        return QAPISchemaVariant(case, info, typ, ifcond)
>
>      def _make_simple_variant(self, case, typ, ifcond, info):
>          if isinstance(typ, list):
> @@ -996,7 +996,7 @@ class QAPISchema:
>          typ =3D self._make_implicit_object_type(
>              typ, info, self.lookup_type(typ),
>              'wrapper', [self._make_member('data', typ, None, info)])
> -        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
> +        return QAPISchemaVariant(case, info, typ, ifcond)
>
>      def _def_union_type(self, expr, info, doc):
>          name =3D expr['union']
> @@ -1026,7 +1026,7 @@ class QAPISchema:
>          self._def_entity(
>              QAPISchemaObjectType(name, info, doc, ifcond, features,
>                                   base, members,
> -                                 QAPISchemaObjectTypeVariants(
> +                                 QAPISchemaVariants(
>                                       tag_name, info, tag_member, variant=
s)))
>
>      def _def_alternate_type(self, expr, info, doc):
> @@ -1040,7 +1040,7 @@ class QAPISchema:
>          tag_member =3D QAPISchemaObjectTypeMember('type', info, 'QType',=
 False)
>          self._def_entity(
>              QAPISchemaAlternateType(name, info, doc, ifcond, features,
> -                                    QAPISchemaObjectTypeVariants(
> +                                    QAPISchemaVariants(
>                                          None, info, tag_member, variants=
)))
>
>      def _def_command(self, expr, info, doc):
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

