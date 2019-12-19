Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D289C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6759324672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZ1Y8/3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6759324672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40657 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvV2-0003TQ-3K
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ihuwf-00077t-Ce
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ihuwd-0005SC-R4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:30:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37753
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ihuwd-0005Nd-Co
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758618;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNwSKJD78rwK+EHWGg1sHT+Cu2BH3QWSwHo3oo9JqzM=;
 b=NZ1Y8/3rBld7MSeF/aZfFJL/PMORshnjHY2ML18zZu3bVL+MIFpJ7HXSkVO0xgFRgHu8Mw
 wc2MRuonYnLvGzqhhBtOGlqyLUkWE9G2rz5NnIJPRR3UXOzw326jKxj+0i4yOpTQhUNDYV
 6Nhh+5s4IcFdtb6poRCwuMm/Oqjyio8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-xR5MGyouPFmHE05V-QyhXw-1; Thu, 19 Dec 2019 07:30:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D365D184BEC0;
 Thu, 19 Dec 2019 12:30:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AEA260C18;
 Thu, 19 Dec 2019 12:30:04 +0000 (UTC)
Date: Thu, 19 Dec 2019 12:30:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v6 7/8] dockerfiles: add dbus-daemon to some of latest
 distributions
Message-ID: <20191219123002.GG1190276@redhat.com>
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
 <20191211134506.1803403-8-marcandre.lureau@redhat.com>
 <20191212120642.GK1829331@redhat.com>
 <CAJ+F1CK7KynVifnO_G7VOWURYyXQgyZX+jNzXwN6-m-Gh6SmhQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK7KynVifnO_G7VOWURYyXQgyZX+jNzXwN6-m-Gh6SmhQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: xR5MGyouPFmHE05V-QyhXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Juan Quintela <quintela@redhat.com>, Michal Privoznik <mprivozn@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 04:23:48PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Dec 12, 2019 at 4:07 PM Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > On Wed, Dec 11, 2019 at 05:45:05PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > > To get dbus-vmstate test covered.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  tests/docker/dockerfiles/centos7.docker  | 1 +
> > >  tests/docker/dockerfiles/debian10.docker | 1 +
> > >  tests/docker/dockerfiles/fedora.docker   | 1 +
> > >  tests/docker/dockerfiles/ubuntu.docker   | 1 +
> > >  4 files changed, 4 insertions(+)
> >
> > For docker
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> >
> > Does it need adding to travis, gitlab, shippable, etc CI configs
> > too ?
>=20
> Those are all good, only shippable has an issue with w64 build:
>=20
> backends/dbus-vmstate.c:313:22: error: format '%u' expects argument of
> type 'unsigned int', but argument 3 has type 'gsize {aka long long
> unsigned int}' [-Werror=3Dformat=3D]
> error_report("%s: Too large vmstate data to save: %" G_GSIZE_FORMAT,
>=20
> This seems to be a MXE build issue, since build correctly includes
> "/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0", and
> fedora mingw works. Philippe, any idea?

There was a bug with one release of glib where they changed the
printf function annotations, but messed up so G_*_FORMAT was
changed when built with meson, but not changed when built with
autotools.

So if MXE uses that broken glib version & builds mingw with
autotools instead of meson it will be impacted:

  https://gitlab.gnome.org/GNOME/glib/issues/1497

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


