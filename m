Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD11C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2152054F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2152054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44354 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNxel-0006Ti-FI
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 06:49:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNxdp-0006At-Jk
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNxdn-0005ph-5s
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hNxdl-0005oG-HQ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:48:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AA8A7FD45;
	Tue,  7 May 2019 10:48:03 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F1B4611D6;
	Tue,  7 May 2019 10:47:58 +0000 (UTC)
Date: Tue, 7 May 2019 11:47:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190507104754.GL27205@redhat.com>
References: <20190503193721.18459-1-ehabkost@redhat.com>
	<20190507103814.GF5808@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190507103814.GF5808@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 07 May 2019 10:48:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Deprecate Python 2 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 12:38:14PM +0200, Kevin Wolf wrote:
> Am 03.05.2019 um 21:37 hat Eduardo Habkost geschrieben:
> > Python 2 will reach end of life in January 1 2020.  Declare it as
> > deprecated.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  configure            | 8 ++++++++
> >  qemu-deprecated.texi | 8 ++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/configure b/configure
> > index 5b183c2e39..50385061ed 100755
> > --- a/configure
> > +++ b/configure
> > @@ -6461,6 +6461,14 @@ if test "$supported_os" = "no"; then
> >      echo "us upstream at qemu-devel@nongnu.org."
> >  fi
> >  
> > +# Note that if the Python conditional here evaluates True we will exit
> > +# with status 1 which is a shell 'false' value.
> > +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
> > +  echo
> > +  echo "WARNING: Python 2 support is deprecated" >&2
> > +  echo "WARNING: Python 3 will be required for building future versions of QEMU" >&2
> > +fi
> 
> While it's clear that we want to get rid of Python 2, did we actually
> discuss how to decide what the new minimum Python version is? I don't
> think any major distribution uses 3.0, which was released in 2008, so
> this doesn't seem to make a lot of sense to me as the new minimum.
> 
> Currently, 3.6 seems to be a commonly available version. It looks like
> Debian stable is at 3.5 still, though it might become oldstable before
> the next QEMU release. Do we need to support anything older than that?

Per our support build platform doc, the oldest distros we care about will
be RHEL-7 and Debian Jessie.  Except we can drop Jessie 2 years after
Stretch was released. IOW, we can drop Jessie in June this year, which
is before our next releasee. So we don't need to care about the 3.4
version in Jessie.

RHEL-7 doesn't have py3 at all in standard distros, but it can be obtained
via software collections and this has 3.6

Debian Strech has 3.5.3, so 3.5 looks like our min viable version.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

