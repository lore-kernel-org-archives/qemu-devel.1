Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC0C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF23206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF23206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44673 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbVU-00057u-6u
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:57:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMbUV-0004ZV-9Y
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMbUR-0006pz-M0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:56:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hMbUQ-0006lg-IZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:56:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8A93C05681F;
	Fri,  3 May 2019 16:56:47 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0246E5D9C4;
	Fri,  3 May 2019 16:56:44 +0000 (UTC)
Date: Fri, 3 May 2019 17:56:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190503165641.GM17905@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-20-ehabkost@redhat.com>
	<40c4d236-ed76-e433-51d5-c9feabb4374a@redhat.com>
	<20190503165435.GL17905@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190503165435.GL17905@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 03 May 2019 16:56:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 19/19] configure: automatically pick python3
 is available
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503165641.8S0HHWlhv4XWNaup2qyhMfIEB4nOTQJ-wVUQrSmfWd8@z>

On Fri, May 03, 2019 at 05:54:35PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, May 03, 2019 at 06:41:43PM +0200, Thomas Huth wrote:
> > On 03/05/2019 02.41, Eduardo Habkost wrote:
> > > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > >=20
> > > Unless overridden via an env var or configure arg, QEMU will only l=
ook
> > > for the 'python' binary in $PATH. This is unhelpful on distros whic=
h
> > > are only shipping Python 3.x (eg Fedora) in their default install a=
s,
> > > if they comply with PEP 394, the bare 'python' binary won't exist.
> > >=20
> > > This changes configure so that by default it will search for all th=
ree
> > > common python binaries, preferring to find Python 3.x versions.
> > >=20
> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Message-Id: <20190327170701.23798-1-berrange@redhat.com>
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  configure | 18 +++++++++++++++---
> > >  1 file changed, 15 insertions(+), 3 deletions(-)
> >=20
> > I haven't bisected it, but I think this patch here broke the gitlab-c=
i tests:
> >=20
> >  https://gitlab.com/huth/qemu/-/jobs/206806257
> >=20
> > Seems like the test is now failing when you don't have an UTF-8 local=
e:
> >=20
> >  LANG=3DC make check-qapi-schema
> >  [...]
> >  TEST    tests/qapi-schema/union-base-empty.out
> >  --- /builds/huth/qemu/tests/qapi-schema/unicode-str.err	2019-05-03 1=
5:21:39.000000000 +0000
> >  +++ -	2019-05-03 15:42:01.561762978 +0000
> >  @@ -1 +1 @@
> >  -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=
=C3=A9'
> >  +tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=
\xe9'
> >  /builds/huth/qemu/tests/Makefile.include:1105: recipe for target 'ch=
eck-tests/qapi-schema/unicode-str.json' failed
> >  make: *** [check-tests/qapi-schema/unicode-str.json] Error 1
> >=20
> > Any ideas how to fix this?
>=20
> python3 is basically doomed if you use the C locale for LC_CTYPE, as
> it is not 8-bit clean.
>=20
> If a python3 program is liable to see UTF-8 input data, the following
> env should generally be set when running python:
>=20
>    LC_ALL=3D LANG=3DC LC_CTYPE=3Den_US.UTF-8

Oh, actually I forgot we did that and then changed approach in QEMU,
see these:

commit 0d6b93deeeb3cc190692d629f5927befdc8b1fb8
Author: Matthias Maier <tamiko@43-1.org>
Date:   Mon Jun 18 19:59:58 2018 +0200

    Revert commit d4e5ec877ca
   =20
    This commit removes the PYTHON_UTF8 workaround. The problem with sett=
ing
   =20
      LC_ALL=3D LANG=3DC LC_CTYPE=3Den_US.UTF-8
   =20
    is that the en_US.UTF-8 locale might not be available. In this case
    setting above locales results in build errors even though another UTF=
-8
    locale was originally set [1]. The only stable way of fixing the
    encoding problem is by specifying the encoding in Python, like the
    previous commit does.
   =20
    [1] https://bugs.gentoo.org/657766
   =20
    Signed-off-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmai=
l.com>
    Signed-off-by: Matthias Maier <tamiko@43-1.org>
    Message-Id: <20180618175958.29073-3-armbru@redhat.com>
    Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>
    [Commit message tweaked]
    Signed-off-by: Markus Armbruster <armbru@redhat.com>

commit de685ae5e9a4b523513033bd6cadc8187a227170
Author: Markus Armbruster <armbru@redhat.com>
Date:   Mon Jun 18 19:59:57 2018 +0200

    qapi: Open files with encoding=3D'utf-8'
   =20
    Python 2 happily reads UTF-8 files in text mode, but Python 3 require=
s
    either UTF-8 locale or an explicit encoding passed to open().  Commit
    d4e5ec877ca fixed this by setting the en_US.UTF-8 locale.  Falls apar=
t
    when the locale isn't be available.
   =20
    Matthias Maier and Arfrever Frehtes Taifersar Arahesis proposed to us=
e
    binary mode instead, with manual conversion from bytes to str.  Works=
,
    but opening with an explicit encoding is simpler, so do that.
   =20
    Since Python 2's open() doesn't support the encoding parameter, we
    need to suppress it with a version check.
   =20
    Reported-by: Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.=
com>
    Reported-by: Matthias Maier <tamiko@43-1.org>
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Message-Id: <20180618175958.29073-2-armbru@redhat.com>
    Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

