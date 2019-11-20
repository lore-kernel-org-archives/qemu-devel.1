Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C421EC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9377520715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMYkP9NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9377520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTwP-0000g8-QF
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXTv7-0007yl-80
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXTv5-0004mX-OV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:37:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36312)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iXTv5-0004mH-Hj
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:37:35 -0500
Received: by mail-wm1-x343.google.com with SMTP id c22so550643wmd.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MlLBxyT8vyvOy9DrNe+YILPwmpJl4MrEN9iAs3nk9SA=;
 b=vMYkP9NOgqaaMJZLDO+1SUDJPtdjLtRdTKRsg7qlgk4JjyFALU4eethOOiq2aXlpcn
 J0C2j3ngy2SBHgLtOvmrNEC1fDu8q3tajsumGXwNf1KtNxDc1LE0D8JqHpUjL2+C/+x0
 zj5Ke+VRAbcRz9t4grvxduS0+WrobAxLaNI/6GWOGxOQsuM3yUdKwI3KUphXl9kHf3MW
 gbNu6tV+99626EWRZmtlMuGv/n0oP9tDDLgg9YnRTWOaLB9DiuGEHcVvcfOV/NbZfqXp
 cc1328K4awu76ueOYQOmHYw4so4SX9gDefTGG1gKaSGaIkVV1zl7zV4dCQbRqUMlGsnW
 ZAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MlLBxyT8vyvOy9DrNe+YILPwmpJl4MrEN9iAs3nk9SA=;
 b=uHghFl3G0rl5kq/3lDX8sKm8C31uaWQCZ/9KcGaQh/ap1fXZdJXeH3xtgrlEIw9aa/
 SJ9uer2cMGpr1CqPcCqwXqdBZFBCphlNenTq8Pvs69PqDEA1mD8oMKhjmsrGvPYT/Y5a
 2VpskotVHnbfgtcPgfKCr+noR+ckdgiWAtknR4beuywkSeM6/j0WTSHNkvShO0N0cae0
 f45MPcFJoBf+NgcrwveMAJTB8iwS0TR76JpmTuXogqW5MDWlpW5zsHiciWAS36TujNQY
 0GNMxv3XL9O+fT2G1QyQ71acDFT+SloGZ3haeg9IVgVKdF0LdKVajtQNEFyQkPaxagBD
 wjjw==
X-Gm-Message-State: APjAAAUrkSZrp65g95etsLevbs4srvFJeYXwom4cO7+KkEu6GJNEndN6
 zlaNn2sCyx/i8hMlY009LIFESSBw/UfDibx+7ag=
X-Google-Smtp-Source: APXvYqyqeEsXwIn/NHpyTs65c1GanziJGF3q+y0WXoHO+8k2+f1LYwun+O8DndqUQGaeA8CJTU/HB69E4PKWd+8hAgU=
X-Received: by 2002:a1c:453:: with SMTP id 80mr4712572wme.5.1574271454273;
 Wed, 20 Nov 2019 09:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20191120125444.31365-1-marcandre.lureau@redhat.com>
 <20191120170047.GN2785116@redhat.com>
In-Reply-To: <20191120170047.GN2785116@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Nov 2019 21:37:20 +0400
Message-ID: <CAJ+F1CLy+LvSOhhuZkGa=3+c33LWaP1sre05H730ardvH4GuWA@mail.gmail.com>
Subject: Re: [PATCH] RFC: CODING_STYLE: describe "self" variable convention
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 20, 2019 at 9:05 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Wed, Nov 20, 2019 at 04:54:44PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Following the discussion in thread "[PATCH v3 13/33] serial: start
> > making SerialMM a sysbus device", I'd like to recommend the usage of
> > "self" variable to reference to the OOP-style method instance, as
> > commonly done in various languages and in GObject world.
>
> Looking at glib codebase, I don't see 'self' used all that

Only gio in glib actually uses gobject. You would have to look at
other GNOME C projects to realize this is the most common pattern.

> widely or consistently - much of gio/ uses an abbreviation
> of the object type as the variable name.
>
> >
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  CODING_STYLE.rst | 38 ++++++++++++++++++++++++++++++++------
> >  1 file changed, 32 insertions(+), 6 deletions(-)
> >
> > diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> > index 427699e0e4..cb6635af71 100644
> > --- a/CODING_STYLE.rst
> > +++ b/CODING_STYLE.rst
> > @@ -102,12 +102,38 @@ Rationale:
> >  Naming
> >  =3D=3D=3D=3D=3D=3D
> >
> > -Variables are lower_case_with_underscores; easy to type and read.  Str=
uctured
> > -type names are in CamelCase; harder to type but standing out.  Enum ty=
pe
> > -names and function type names should also be in CamelCase.  Scalar typ=
e
> > -names are lower_case_with_underscores_ending_with_a_t, like the POSIX
> > -uint64_t and family.  Note that this last convention contradicts POSIX
> > -and is therefore likely to be changed.
> > +Variables are lower_case_with_underscores; easy to type and read.
> > +
> > +The most common naming for a variable is an abbreviation of the type
> > +name.  Some common examples:
> > +
> > +.. code-block:: c
> > +
> > +    Object *obj;
> > +    QVirtioSCSI *scsi;
> > +    SerialMM *smm;
> > +
> > +When writing QOM/OOP-style function, a "self" variable allows to refer
> > +without ambiguity to the instance of the method that is being
> > +implemented (this is not very common in QEMU code base, but it is
> > +often a good option to increase the readability and consistency,
> > +making further refactoring easier as well).  Example:
>
> For me the first "sniff test" for a new coding style guideline is
> whether QEMU actually follows the rule to any significant extent
> already. If not, then I think the benefit would have to be very
> significant to justify defining it as a rule. We've historically

It's not a strict rule.

> be quite reluctant to do bulk updates of existing code to apply
> new coding styles. Without planning a bulk update, you end up
> with a coding style that is followed by 1% of the code and ignored
> by the other 99%.

We won't do a bulk update (that was never my intention, that would be
ridiculous).

Adding "self" to the zoo of variable names to refer to the
implentation instance isn't going to make a revolution, but is a good
pattern. I didn't think we would need to argue about it or modify
CODING_STYLE. But I should have known better ;)

>
> As noted above, the common case in QEMU is for the variable to be an
> abbreviation of the type name. The number of places using "*self" is
> almost single digits. So I think the idea of standardizing on "self"
> is already questionable for QEMU.
>
>
> I think the reason for the current pattern of abbreviated type name
> is that when we're inventing OOP features in C the impl of inheritance
> is always sub-optimal, such that you frequently find a need to cast to
> parent types.  So in any single method it is common to have multiple
> variables all refering to the object "self", each cast to a different
> type. To pick one simple example
>
>     QIOChannelFile fioc =3D qio_channel_file_new(...)
>     QIOChannel *ioc =3D QIO_CHANNEL(fioc)
>     Object *obj =3D OBJECT(fioc)
>
>     qio_channel_read_all(ioc, buf, len, erro);
>     object_unref(obj);

This code is probably not a OOP-style "method" (a method associated to
an instnace). I can't imagine what would be "self" here.

>
>
> I think that using the object type abbreviation for the variable name
> is a good thing.  Arbitrarily picking "self" for one of those variables
> is unhelpful, as you have to then look back to the declaration of "self"
> to remind yourself whether "self" is an QOIChannelFile or a QIOChannel
> or an Object.

Is "s" or "ss" or "ioc", "fioc" more readable?

self is of the type being implemented. Usually it is inside a
my_foo_method() in my-foo.c, so you know that self is of MyFoo type
without effort.

>
> Constrast with C++ / Java, where I think the use of "self" is a good
> thing, because the language has built-in  OOP concepts, such that
> you can call a method on any parent class without having to first
> cast "self" to the parent type. IOW, in those languages you don't
> have to care about the particular types in the class hierarchy when
> operating on "self".  This isn't true of C / QEMU's QOM.
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

