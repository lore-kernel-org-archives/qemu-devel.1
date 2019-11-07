Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E88C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE91218AE
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZuqbPEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE91218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkGJ-0002Ly-3s
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iSkEY-0000ak-5l
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iSkET-0004va-K4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:02:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22152
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iSkET-0004un-06
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573142519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xp5PnxbjGejhDCWIak3FzMinAVHKUPQydrotwKcj/dE=;
 b=YZuqbPEfXxVVw9PybN2b5cqSWAjJTausoTT8SGzUkGYre+UUbrk6Rp5cSKwhtfN4gYV9Ml
 Bj1G4Vwq4TOLtSqhiamrYabRwGlYXlfUbMMPlfeYBkEI0qrKeLICSu7IDiT/0x77wYdr0b
 kMVW8v8xy/VaOERqgso6CZIxFXmubWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-5eV6MiDWN6ST88Un1LtDew-1; Thu, 07 Nov 2019 11:01:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2E9C8017DD;
 Thu,  7 Nov 2019 16:01:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EA6E600D1;
 Thu,  7 Nov 2019 16:01:44 +0000 (UTC)
Date: Thu, 7 Nov 2019 16:01:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: QEMU HTML documentation now on qemu.org
Message-ID: <20191107160142.GH120292@redhat.com>
References: <20191106161928.GA353373@stefanha-x1.localdomain>
 <20191107100606.GA120292@redhat.com>
 <CAJSP0QX6awKBSx_idYfXB85e09Tp6gKLRvO+zrk-+zrOiySC-w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QX6awKBSx_idYfXB85e09Tp6gKLRvO+zrk-+zrOiySC-w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5eV6MiDWN6ST88Un1LtDew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 04:44:34PM +0100, Stefan Hajnoczi wrote:
> On Thu, Nov 7, 2019 at 11:07 AM Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > On Wed, Nov 06, 2019 at 05:19:28PM +0100, Stefan Hajnoczi wrote:
> > > Hi,
> > > You can now access the latest QEMU HTML documentation built from
> > > qemu.git/master nightly at:
> > >
> > >   https://wiki.qemu.org/docs/qemu-doc.html
> > >   https://wiki.qemu.org/docs/qemu-qmp-ref.html
> > >   https://wiki.qemu.org/docs/qemu-ga-ref.html
> > >   ...as well as interop/ and specs/
> > >
> > > Feel free to link to the documentation from the QEMU website and/or
> > > wiki!
> >
> > What's the reason for putting on wiki.qemu.org URL ? It feels like
> > having it under www.qemu.org would be a more natural home, especially
> > if we can then make it pick up the jekyll theme around the pages.
> >
> > Ideally we should publish the docs under versioned URL when we
> > make a release. eg  /docs/latest/....  for current GIT master
> > which I presume the above is tracking, and then a /docs/$VERSION/...
> > for each major release we cut.
> >
> > That way users can get an accurate view of features in the QEMU
> > they are actually using.
>=20
> Versioned release docs should be generated during the release process.
> I have CCed Mike Roth.  That way the docs are available as soon as the
> release drops.  This container image only runs once a day and would
> leave a window when users cannot access the docs yet.
>=20
> Moving from wiki.qemu.org should be possible.  How does the jekyll
> theme you mentioned work?

IIUC, when there's a push to the qemu-web.git repo, some git hook (?)
runs on the server which invokes jekyll to build the content, and
then publish it to the webroot.

To integrate these docs into that we need something along the lines
of:

  1. Generate the HTML files as you do now
  2. Copy them into the qemu-web.git in a /docs/ subdir
  3. Prepend a magic header to make jeykll process the file

     ---
     permalink: /docs/qemu-doc
     ---

  4. Trigger the jekyll builder to refresh the generated docs
  5. Publish the docs to the webroot

You can see what I did here  as an example where I simply committed
the generated docs to qemu-web.git:

  https://www.mail-archive.com/qemu-devel@nongnu.org/msg578110.html

If we're not storing the generated docs in git, then when
pushing to qemu-web.git we need to ensure we preserve the
extra /docs dir content in some manner.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


