Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984C7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21892246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dy9s4uJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21892246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7d0c-0001Bh-4T
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j7czc-00087K-7P
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j7cza-0000Q6-Sx
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:35:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j7cza-0000Pg-OD
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582886138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/Mf2NJUD9wQauMEhExSsVeDfUrUIjqWPPYz3rMDenY=;
 b=dy9s4uJEHcO6HZk12fcWPnWpgkVr4RizLo37BcL5kfncc5d2GdYC9Zsj95O4cJEWHvZi/C
 Hj7X8DTw6CzxqpvPlOIPfxxi3of4w7sj6qm1nWh4e9jBzrE2BrcAe14IeYskHR4B1GY/eb
 h0g0Cg746/nFAIhjGHQFe3SnRRla2YU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-qYlcrakOPIOy8_fyATVQxg-1; Fri, 28 Feb 2020 05:35:30 -0500
X-MC-Unique: qYlcrakOPIOy8_fyATVQxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD5D0107ACC5;
 Fri, 28 Feb 2020 10:35:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 529795C557;
 Fri, 28 Feb 2020 10:35:25 +0000 (UTC)
Date: Fri, 28 Feb 2020 10:35:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] qom/object: Comment to use g_slist_free on
 object_class_get_list result
Message-ID: <20200228103521.GC1657361@redhat.com>
References: <20200227190942.8834-1-philmd@redhat.com>
 <20200228094652.GB1657361@redhat.com>
 <CAJ+F1CL-fbX=dXpopMMT1o-WH1JhrqrzpM55J9cGoGDNpDq=AQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL-fbX=dXpopMMT1o-WH1JhrqrzpM55J9cGoGDNpDq=AQ@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 qemu trival <qemu-trivial@nongnu.org>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 28, 2020 at 11:06:38AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Feb 28, 2020 at 10:47 AM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 08:09:42PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > Document the list returned by object_class_get_list() must be
> > > released with g_slist_free() to avoid memory leaks.
> > >
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >  include/qom/object.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/include/qom/object.h b/include/qom/object.h
> > > index 29546496c1..5517b56508 100644
> > > --- a/include/qom/object.h
> > > +++ b/include/qom/object.h
> > > @@ -984,6 +984,9 @@ void object_class_foreach(void (*fn)(ObjectClass =
*klass, void *opaque),
> > >   * @include_abstract: Whether to include abstract classes.
> > >   *
> > >   * Returns: A singly-linked list of the classes in reverse hashtable=
 order.
> > > + *
> > > + * The returned list must be released with g_slist_free()
> > > + * when no longer required.
> >
> > I'd suggest
> >
> >   "The returned list, but not its elements, must be released with
> >    g_slist_free() or g_autoptr when no longer required"
>=20
> As gobject-introspection annotations: "Returns: (transfer container)
> (element-type ObjectClass): A list of #ObjectClass"

If we were using Gobject introspection and/or Gtk-Doc, then I'd certainly
suggest that syntax, but AFAIK this is not something that fits with our
intented docs tools. There might be sense in having our docs tools parse
these kind of annotations as it is useful to have it in standardized
format. I think we should decide on this before actually adding them to
the docs though.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


