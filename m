Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6AEC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 21:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B6320679
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 21:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B6320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0v3d-0003JA-Mm
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 17:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i0v2O-0002T7-QW
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i0v2M-0005d5-UO
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i0v2M-0005cp-NA
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:54:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CEF0300DA70;
 Thu, 22 Aug 2019 21:54:29 +0000 (UTC)
Received: from localhost (ovpn-116-73.gru2.redhat.com [10.97.116.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A50819C78;
 Thu, 22 Aug 2019 21:54:22 +0000 (UTC)
Date: Thu, 22 Aug 2019 18:54:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190822215420.GO7077@habkost.net>
References: <20181109150710.31085-1-crosa@redhat.com>
 <20181109150710.31085-2-crosa@redhat.com>
 <CAFEAcA86JT-3jLV=+aqLntoe1jJr77VYvg1dWn9OBVGA6cPZmQ@mail.gmail.com>
 <20190822211636.GA23027@dhcp-17-173.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822211636.GA23027@dhcp-17-173.bos.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 22 Aug 2019 21:54:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: keep track of Python version
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 05:19:26PM -0400, Cleber Rosa wrote:
> On Thu, Aug 22, 2019 at 05:48:46PM +0100, Peter Maydell wrote:
> > On Fri, 9 Nov 2018 at 15:09, Cleber Rosa <crosa@redhat.com> wrote:
> > >
> > > Some functionality is dependent on the Python version
> > > detected/configured on configure.  While it's possible to run the
> > > Python version later and check for the version, doing it once is
> > > preferable.  Also, it's a relevant information to keep in build logs,
> > > as the overall behavior of the build can be affected by it.
> > >
> > > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > ---
> > >  configure | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/configure b/configure
> > > index 74e313a810..67fff0290d 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -1740,6 +1740,9 @@ if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
> > >        "Use --python=/path/to/python to specify a supported Python."
> > >  fi
> > >
> > > +# Preserve python version since some functionality is dependent on it
> > > +python_version=$($python -V 2>&1 | sed -e 's/Python\ //')
> > > +
> > 
> > Hi. Somebody on IRC has just fallen over a problem where
> > their python's "-V" output prints multiple lines, which
> > means that "$python_version" here is multiple lines, which
> > means that the eventual config-host.mak has invalid syntax
> > because we assume here:
> >
> 
> We've tried a number of things, and just when I thought we wouldn't be
> able to make any sense out of it, I arrived at a still senseless but
> precise reproducer.  TL;DR: it has to do with interactive shells and
> that exact Python build.
> 
> Reproducer (docker may also do the trick here):
> 
>   $ podman run --rm -ti fedora:29 /bin/bash -c 'dnf -y install http://mirror.siena.edu/fedora/linux/releases/29/Everything/x86_64/os/Packages/p/python3-3.7.0-9.fc29.x86_64.rpm; python3 -V'
>   Python 3.7.0 (default, Aug 30 2018, 14:32:33) 
>   [GCC 8.2.1 20180801 (Red Hat 8.2.1-2)]
> 
> With an interactive shell instead:
> 
>   $ podman run --rm -ti fedora:29 /bin/bash -i -c 'dnf -y install http://mirror.siena.edu/fedora/linux/releases/29/Everything/x86_64/os/Packages/p/python3-3.7.0-9.fc29.x86_64.rpm; python3 -V'
>   Python 3.7.0
> 
> How this behavior came to be, baffles me.  But, it seems to be fixed
> on newer versions.
> 
> > > @@ -6823,6 +6826,7 @@ echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
> > >  echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
> > >  echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
> > >  echo "PYTHON=$python" >> $config_host_mak
> > > +echo "PYTHON_VERSION=$python_version" >> $config_host_mak
> > >  echo "CC=$cc" >> $config_host_mak
> > >  if $iasl -h > /dev/null 2>&1; then
> > >    echo "IASL=$iasl" >> $config_host_mak
> > 
> > that it's only one line, and will generate bogus makefile
> > syntax if it's got an embedded newline. (Problem system
> > seems to be Fedora 29.)
> >
> 
> The assumption could be guaranteed by a "head -1", and while
> it's not a failproof solution, it would at least not corrupt
> the makefile and the whole build system.
> 
> > I've reread this thread, where there seems to have been
> > some discussion about just running Python itself to
> > get the sys.version value (which is how we check for
> > "is this python too old" earlier in the configure script).
> > But I'm not really clear why trying to parse -V output is better:
> > it's definitely less reliable, as demonstrated by this bug.

Agreed.

> >
> > Given that the only thing as far as I can tell that we
> > do with PYTHON_VERSION is use it in tests/Makefile.inc
> > to suppress a bit of test functionality if we don't have
> > Python 3, could we stop trying to parse -V output and run
> > python to print sys.version_info instead, and/or just
> > have the makefile variable track "is this python 2",
> > since that's what we really care about and would mean we
> > don't have to then search the string for "v2"  ?
> 
> Because I've been bitten way too many times with differences in Python
> minor versions, I see a lot of value in keeping the version
> information in the build system.  But, the same information can
> certainly be obtained in a more resilient way.  Would you object something
> like:
> 
>   python_version=$($python -c 'import sys; print(sys.version().split()[0])')

Sounds much better, but why sys.version().split() instead of
sys.version_info?

  python_version=$($python -c 'import sys; print(sys.version_info[0])')

> 
> Or an even more paranoid version?  On my side, I understand the
> fragility of the current approach, but I also appreciate the
> information it stores.

We have only one place where $(PYTHON_VERSION) is used, and that
code will be removed once we stop supporting Python 2.  I don't
see the point of trying to store extra information that is not
used anywhere in our makefiles.

-- 
Eduardo

