Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70309C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4018B21556
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyveNwjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4018B21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JE0-0001H0-Ah
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j7JDD-0000kM-Dl
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j7JDC-0004ml-6L
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:28:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j7JDC-0004mF-1Y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582810101;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sV8QBNGz00Me5HBeTKSqaEjjbQTx+PMZWeofGO6oIE=;
 b=IyveNwjTnH+UipxbJ5x2H2eCw/PgtRIy7IIsVOCM/qZREoVu5k3reZd9kWu0T37wG68OYC
 0PfdNtN8Z30clX5eMxbpJWEfvRKmLZi3AByHXP/1ttaYzn7uH9Fh2d3H7uPKHTS8ddA0G0
 QnbrM9CfXMmJ+/5dacLl3k7v/qBUbe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-JtzwNU9oPTKhS0OmSXy1pA-1; Thu, 27 Feb 2020 08:28:13 -0500
X-MC-Unique: JtzwNU9oPTKhS0OmSXy1pA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94D0918A8C80;
 Thu, 27 Feb 2020 13:28:12 +0000 (UTC)
Received: from redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8634277945;
 Thu, 27 Feb 2020 13:28:11 +0000 (UTC)
Date: Thu, 27 Feb 2020 13:28:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 13/18] docs/system: put qemu-block-drivers body in an
 included file
Message-ID: <20200227132808.GJ1645630@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-14-pbonzini@redhat.com>
 <CAFEAcA_qWUY19ubmSaNoqbwjf8N8d1Dw=vMMD7j5yH8TSwK35A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qWUY19ubmSaNoqbwjf8N8d1Dw=vMMD7j5yH8TSwK35A@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 11:58:27AM +0000, Peter Maydell wrote:
> On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > This removes the "only" directives, and lets us use the conventional
> > "DESCRIPTION" section in the manpage.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  docs/system/index.rst                  |   2 -
> >  docs/system/qemu-block-drivers.rst     | 987 +------------------------
> >  docs/system/qemu-block-drivers.rst.inc | 954 ++++++++++++++++++++++++
> >  3 files changed, 966 insertions(+), 977 deletions(-)
> >  create mode 100644 docs/system/qemu-block-drivers.rst.inc
> >
> > diff --git a/docs/system/index.rst b/docs/system/index.rst
> > index f66e6ea585..21b5a18b67 100644
> > --- a/docs/system/index.rst
> > +++ b/docs/system/index.rst
> > @@ -13,5 +13,3 @@ Contents:
> >
> >  .. toctree::
> >     :maxdepth: 2
> > -
> > -   qemu-block-drivers
>=20
> Why do you drop the documentation from the HTML manual ?
>=20
> Is the changing in the underline styles for section
> headings necessary? It's non-obvious in the diff format
> the patch in the email has, but with my local git diff
> settings (algorithm=3Dhistogram) it shows up better:
>=20
> > Secure Shell (ssh) disk images
> >-------------------------------
> >+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Given that rST figures out subsection depth automatically
> rather than based on which particular character is used
> maybe we could avoid the noise in the diff?
>=20
> (OTOH, we should probably pick a rST style guide for which
> characters to use for which section headings and follow
> it here to avoid unnecessarily confusing ourselves...)

Yes, I'd encourage explicitly documenting the required section
heading chars in particular, as otherwise we get a free for all
which becomes confusing, especially if we need to move
text from one doc into another doc.

For libvirt we chose:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D
  Heading 1
  =3D=3D=3D=3D=3D=3D=3D=3D=3D

  Heading 2
  =3D=3D=3D=3D=3D=3D=3D=3D=3D

  Heading 3
  ---------

  Heading 4
  ~~~~~~~~~

  Heading 5
  .........

  Heading 6
  ^^^^^^^^^


Heading 6 looks a bit odd, but on the flipside it should almost never
need to be used.  https://libvirt.org/styleguide.html


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


