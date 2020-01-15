Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4775DC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121C12187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4lSQuYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121C12187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhNq-0003Lw-Tj
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1irhMq-0002In-Cr
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1irhMm-0003oH-T1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:01:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1irhMm-0003nn-P4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579089703;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNL7XQgd1dAdg58X2xci4SQJZmtzuDMfilC3kMoZ6YY=;
 b=i4lSQuYLiORURtitig6t+PIfqJ9ADXqMdO0RVi/t5NKLYrce3UW7OCwirKYrG1yKNqMpKa
 /idOnhoSIZNme9c/aRxzHjC8l8gwzQHGF99RaeV2oI0qvckzWLxy7Z5GHloO4JlY+f2lux
 T7amXTYks7WaKEaigibz+DByvH3Y7Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-QyRRUrAbOBaV3_Ho4391-w-1; Wed, 15 Jan 2020 07:01:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF3A18A6ECA;
 Wed, 15 Jan 2020 12:01:39 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B0B860BF4;
 Wed, 15 Jan 2020 12:01:37 +0000 (UTC)
Date: Wed, 15 Jan 2020 12:01:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
Message-ID: <20200115120134.GH93923@redhat.com>
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
 <87zhepkk6j.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87zhepkk6j.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QyRRUrAbOBaV3_Ho4391-w-1
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
Cc: pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 11:56:04AM +0000, Alex Benn=C3=A9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Tue, Jan 14, 2020 at 12:11:34PM +0100, Thomas Huth wrote:
> >> On 13/01/2020 11.35, Alex Benn=C3=A9e wrote:
> >> > ..and extemporise a little about their state.
> >> >=20
> >> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> > ---
> >> >  documentation.md | 9 ++++++---
> >> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >> >=20
> >> > diff --git a/documentation.md b/documentation.md
> >> > index f4ef9f4..55d5db6 100644
> >> > --- a/documentation.md
> >> > +++ b/documentation.md
> >> > @@ -3,9 +3,12 @@ title: QEMU documentation
> >> >  permalink: /documentation/
> >> >  ---
> >> > =20
> >> > -The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can =
be read online, courtesy of Stefan Weil.
> >> > -More documentation is found in the <a href=3D"https://git.qemu.org/=
?p=3Dqemu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
> >> > -directory of the QEMU git tree.
> >> > +The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can =
be
> >> > +read online, courtesy of Stefan Weil. There is a partial set of
> >> > +[developer documentation](https://qemu.readthedocs.io/en/latest/)
> >> > +which is generated from the QEMU git tree. The process of convertin=
g
> >> > +the rest of the [`docs`](https://git.qemu.org/?p=3Dqemu.git;a=3Dtre=
e;f=3Ddocs;hb=3Dmaster)
> >> > +directory is ongoing.
> >>=20
> >> This has a conflict with Stefan's patch to point to our documentation =
on
> >> www.qemu.org now instead:
> >>=20
> >>  https://patchwork.kernel.org/patch/11234545/
> >>=20
> >> ... Stefan, looks like the index.html page is still not there yet,
> >> although your other patch that includes index.html.in in the sources i=
s
> >> in the repository now? What's the status here?
> >
> > The qemu.git/master docs are built nightly here (index.html is now
> > visible!):
> > https://www.qemu.org/docs/master/
> >
> > qemu.org's docs are more useful at the moment since they include the
> > user documentation in addition to the developer documentation.
>=20
> And I think we want to continue hosting them on qemu.org. Is it possible
> to theme them under the website branding? Stefan's version includes a
> banner and background icon so it would be nice to at least fit in with
> the reset of the site.

I did a demo of this a while back:

  https://www.mail-archive.com/qemu-devel@nongnu.org/msg578110.html

Essentially you just need to strip the HTML header down to the
<body> content. Then add the jekyll header and run its site
generator which will add the new HTML header with theme.

In my patches above I committed the ref docs .html files to qemu-web.git
but this is not required. They just need to be placed in any directory
on the server where jekyll build process runs, so that we can access
them when building the static site content.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


