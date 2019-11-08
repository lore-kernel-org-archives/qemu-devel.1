Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6CEC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E3F2087E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzaNbULW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E3F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0r9-0002Hd-8z
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iT0pv-0001gy-NT
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iT0ps-0000s8-Ot
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:45:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iT0ps-0000qs-Bn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573206341;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdEnFjV552MIuPtWbgRwFpqgN8b40ao1Lq+/YZzu5q4=;
 b=OzaNbULW0VdL5M78NG7mB02uKyZ/0svjRjvnQUMsraMOj/9ESP38KkMtO/VOubhqW8D6Rq
 l/M6zSczuxZE/MH7cfcIgdow1vtO1mOS2gxquBN+mN9wq2gxyFWS2muDwChppfg/+YyD3B
 GWKyjb2yFvH9PZDwODl5EwE6UyC+zq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-Ok-VLQpbPAmN8Km88kPumQ-1; Fri, 08 Nov 2019 04:45:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 646F61800D7B;
 Fri,  8 Nov 2019 09:45:36 +0000 (UTC)
Received: from redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BE8E5DA70;
 Fri,  8 Nov 2019 09:45:28 +0000 (UTC)
Date: Fri, 8 Nov 2019 09:45:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: QEMU HTML documentation now on qemu.org
Message-ID: <20191108094525.GC182396@redhat.com>
References: <20191106161928.GA353373@stefanha-x1.localdomain>
 <20191107100606.GA120292@redhat.com>
 <CAJSP0QX6awKBSx_idYfXB85e09Tp6gKLRvO+zrk-+zrOiySC-w@mail.gmail.com>
 <20191107160142.GH120292@redhat.com>
 <20191108084130.GA375005@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191108084130.GA375005@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Ok-VLQpbPAmN8Km88kPumQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 09:41:30AM +0100, Stefan Hajnoczi wrote:
> On Thu, Nov 07, 2019 at 04:01:42PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Nov 07, 2019 at 04:44:34PM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Nov 7, 2019 at 11:07 AM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> > > >
> > > > On Wed, Nov 06, 2019 at 05:19:28PM +0100, Stefan Hajnoczi wrote:
> > > > > Hi,
> > > > > You can now access the latest QEMU HTML documentation built from
> > > > > qemu.git/master nightly at:
> > > > >
> > > > >   https://wiki.qemu.org/docs/qemu-doc.html
> > > > >   https://wiki.qemu.org/docs/qemu-qmp-ref.html
> > > > >   https://wiki.qemu.org/docs/qemu-ga-ref.html
> > > > >   ...as well as interop/ and specs/
> > > > >
> > > > > Feel free to link to the documentation from the QEMU website and/=
or
> > > > > wiki!
> > > >
> > > > What's the reason for putting on wiki.qemu.org URL ? It feels like
> > > > having it under www.qemu.org would be a more natural home, especial=
ly
> > > > if we can then make it pick up the jekyll theme around the pages.
> > > >
> > > > Ideally we should publish the docs under versioned URL when we
> > > > make a release. eg  /docs/latest/....  for current GIT master
> > > > which I presume the above is tracking, and then a /docs/$VERSION/..=
.
> > > > for each major release we cut.
> > > >
> > > > That way users can get an accurate view of features in the QEMU
> > > > they are actually using.
> > >=20
> > > Versioned release docs should be generated during the release process=
.
> > > I have CCed Mike Roth.  That way the docs are available as soon as th=
e
> > > release drops.  This container image only runs once a day and would
> > > leave a window when users cannot access the docs yet.
> > >=20
> > > Moving from wiki.qemu.org should be possible.  How does the jekyll
> > > theme you mentioned work?
> >=20
> > IIUC, when there's a push to the qemu-web.git repo, some git hook (?)
> > runs on the server which invokes jekyll to build the content, and
> > then publish it to the webroot.
> >=20
> > To integrate these docs into that we need something along the lines
> > of:
> >=20
> >   1. Generate the HTML files as you do now
> >   2. Copy them into the qemu-web.git in a /docs/ subdir
> >   3. Prepend a magic header to make jeykll process the file
> >=20
> >      ---
> >      permalink: /docs/qemu-doc
> >      ---
> >=20
> >   4. Trigger the jekyll builder to refresh the generated docs
> >   5. Publish the docs to the webroot
> >=20
> > You can see what I did here  as an example where I simply committed
> > the generated docs to qemu-web.git:
> >=20
> >   https://www.mail-archive.com/qemu-devel@nongnu.org/msg578110.html
> >=20
> > If we're not storing the generated docs in git, then when
> > pushing to qemu-web.git we need to ensure we preserve the
> > extra /docs dir content in some manner.
>=20
> For qemu.git/master the built docs might change every day.  Committing
> them to qemu-web.git seems like overkill.  I'll send a documentation.md
> patch for qemu-web.git instead that simply links to
> wiki.qemu.org/docs/.

Yeah, to be clear I wasn't suggesting committing them to qemu-web.git.
Really we just need to put the generated .html files into some scratch
directory on the web server where there qemu-web.git jekyll build can
automatically find them & process them in the same way it does for
content that is committed.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


