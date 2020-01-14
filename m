Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB88CC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D91207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgU1d0Rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D91207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJLA-00037H-9c
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1irJJW-0001Tl-Sw
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1irJJS-0006K9-BO
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:20:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53895
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1irJJS-0006K0-6N
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578997241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUtGb9/k4oQ2myGnNcwaCS5oecgX08myZfyIda8wpr8=;
 b=VgU1d0RcsfRcTQrOYkoKSXph2sH+c+RtMFYhUa7RciTl64uU6MI44pS9zTkGO4MVAFcuBz
 5NN1wB57H5xr1Uw/fpcs34wuhhGV1BOt6O3U0UGZmUeDkJEvtoCuFDzUX0Y5FrPPeFXCz4
 R2yOiVsgpS8w3Bt4HdwjZGnzFvOixpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409--QQleTLJPzWMeBxXlyXYYw-1; Tue, 14 Jan 2020 05:20:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2779E10054E3;
 Tue, 14 Jan 2020 10:20:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 744895D9E5;
 Tue, 14 Jan 2020 10:20:34 +0000 (UTC)
Date: Tue, 14 Jan 2020 10:20:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] qemu-deprecated: Remove text about Python 2
Message-ID: <20200114102031.GE4071034@redhat.com>
References: <20200109095116.18201-1-thuth@redhat.com>
 <5883bc34-926e-70e3-6402-32dfb5d92ab2@redhat.com>
 <e1ae4e63-626c-cc6d-5117-4b4fbd1ad436@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e1ae4e63-626c-cc6d-5117-4b4fbd1ad436@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -QQleTLJPzWMeBxXlyXYYw-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 11:08:16AM +0100, Thomas Huth wrote:
> On 13/01/2020 23.36, John Snow wrote:
> >=20
> >=20
> > On 1/9/20 4:51 AM, Thomas Huth wrote:
> >> Python 2 support has been removed, so we should now also remove
> >> the announcement text for the deprecation.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >=20
> > Reviewed-by: John Snow <jsnow@redhat.com>
> >=20
> >> ---
> >>  qemu-deprecated.texi | 8 --------
> >>  1 file changed, 8 deletions(-)
> >>
> >> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> >> index 7033e531de..8b23e98474 100644
> >> --- a/qemu-deprecated.texi
> >> +++ b/qemu-deprecated.texi
> >> @@ -341,14 +341,6 @@ they have no effect when used with @option{-n} to=
 skip image creation.
> >>  Silently ignored options can be confusing, so this combination of
> >>  options will be made an error in future versions.
> >> =20
> >> -@section Build system
> >> -
> >> -@subsection Python 2 support (since 4.1.0)
> >> -
> >> -In the future, QEMU will require Python 3 to be available at
> >> -build time.  Support for Python 2 in scripts shipped with QEMU
> >> -is deprecated.
> >> -
> >>  @section Backwards compatibility
> >> =20
> >>  @subsection Runnability guarantee of CPU models (since 4.1.0)
> >>
> >=20
> > Genuine question, I'm sorry:
> >=20
> > Is it worth documenting things we recently removed?
>=20
> Basically yes. In case of Python 2, it's not a QEMU feature that we
> remove here, but a build requirement, and we tell the users that we need
> at least Python 3.5 when they run "configure", so I'm not sure whether
> that needs to be explicitely mentioned again the docs beside our ChangeLo=
g?

In general changed build pre-requisites such as new minimum software
versions are documented in the release notes:

   https://wiki.qemu.org/ChangeLog/5.0#Build_Information

We normally would not list build pre-requisites in the deprecation notes
at all, since they don't follow the deprecation process normally. We
just update minimum versions immediately that our supported OS build
platforms change due to an OS going end of life. So for example we
have in the past bumped gnutls, glib, nettle, gcc, etc min versions
with no warning.  So the fact that Python 2 was mentioned in the
deprecations at all was slightly unusual. This is mostly just to be
nice to users since the OS platforms here aren't going EOL and still
ship Python 2, we simply don't wish to support it any more, since
the distros also all have Py 3.


>=20
> > Right now, we don't
> > really have these docs hosted in a searchable way online in a
> > per-version format. Once the notice is gone, it's gone from the mirror.
> >=20
> > I removed some bitmap functionality not too long ago and I created a
> > "Recently Removed" section as a bit of a troubleshooting guide should i=
t
> > be needed.
> >=20
> > - Do we want this section?
> > - Should I remove it?
> > - Can we add historical docs to the website to see previous deprecated
> > docs in a searchable manner?
>=20
> I also once started a page in the Wiki here:
>=20
>  https://wiki.qemu.org/Features/RemovedFeatures
>=20
> ... but apparently, it did not get enough attention yet, otherwise you
> would have noticed it before introducing the new chapter into the
> qemu-doc ...
>=20
> We definitely need one spot where we can document removed features. I
> don't mind which way we do it, either the qemu-doc or the wiki, but we
> should unify on one of the two. I guess the qemu-doc is the better place
> since we are tracking the deprecated features there already and one more
> or less just has to move the text to the other chapter when things get
> finally removed?

Yeah, I've said in the past that we should not be deleting deprecations
from the docs entirely.

If you look at GTK docs for example, you'll see they keep a record of
all incompatible or noteworth changes between release:

  https://developer.gnome.org/gtk3/stable/gtk-migrating-3-x-to-y.html

IMHO, we should follow this and have an appendix of removed features,
with sub-sections per QEMU release listing each removed feature. Thus
deprecation docs just get moved to this appendix at the right time.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


