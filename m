Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3816CC282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 08:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EED218D3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 08:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EED218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38069 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJDUB-00078T-5v
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 04:42:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJDLt-00083L-ER
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJD7D-0006qa-5n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hJD7C-0006fr-OZ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:18:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4520330832CB;
	Wed, 24 Apr 2019 08:18:49 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A239F2C8FB;
	Wed, 24 Apr 2019 08:18:40 +0000 (UTC)
Date: Wed, 24 Apr 2019 09:18:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190424081837.GA28615@redhat.com>
References: <20190417053225.27505-1-richard.henderson@linaro.org>
	<20190417053225.27505-2-richard.henderson@linaro.org>
	<fb4917eb-4ff3-7a93-cbcd-39d1800827e8@redhat.com>
	<20190423100101.GD6022@redhat.com>
	<cc1481bc-5f80-2792-2a36-a31a42357825@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <cc1481bc-5f80-2792-2a36-a31a42357825@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 24 Apr 2019 08:18:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/1] util/path: Do not cache all filenames
 at startup
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, evgreen@chromium.org, laurent@vivier.eu,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424081837.C-nnbpJ5Lkctvu867LArhRpCvzcsFSWhgf0vEo2v_68@z>

On Tue, Apr 23, 2019 at 08:30:55PM +0200, David Hildenbrand wrote:
> On 23.04.19 12:01, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Apr 23, 2019 at 11:54:53AM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> >> Hi Richard, Daniel,
> >>
> >> On 4/17/19 7:32 AM, Richard Henderson wrote:
> >>> If one uses -L $PATH to point to a full chroot, the startup time
> >>> is significant.  In addition, the existing probing algorithm fails
> >>> to handle symlink loops.
> >>>
> >>> Instead, probe individual paths on demand.  Cache both positive
> >>> and negative results within $PATH, so that any one filename is
> >>> probed only once.
> >>>
> >>> Use glib filename functions for clarity.
> >>>
> >>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>> ---
> >>>  util/path.c | 211 ++++++++++++++----------------------------------=
----
> >>>  1 file changed, 57 insertions(+), 154 deletions(-)
> >=20
> >=20
> >>> +#if GLIB_CHECK_VERSION(2, 58, 0)
> >>
> >> Should we raise GLIB_VERSION_MAX_ALLOWED in "glib-compat.h"?
> >>
> >> Currently it is:
> >>
> >>   /* Ask for warnings if code tries to use function that did not
> >>    * exist in the defined version. These risk breaking builds
> >>    */
> >>   #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40
> >=20
> > Use of 2.40 is set in accordance with our targetted platform support
> > policy. If Peter has stopped using the Ubuntu 14.04 build host, we
> > could bump it to 2.42. Once our dev tree opens up we could in fact
> > drop Jessie since we'll be supporting Buster by the time next QEMU
> > is released. That would still only take us upto perhaps Glib 2.48
> >=20
> > Glib 2.58 is waaaay to new to rely on.
> >=20
> > commit e7b3af81597db1a6b55f2c15d030d703c6b2c6ac
> > Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Date:   Fri May 4 15:34:46 2018 +0100
> >=20
> >     glib: bump min required glib library version to 2.40
> >    =20
> >     Per supported platforms doc[1], the various min glib on relevant =
distros is:
> >    =20
> >       RHEL-7: 2.50.3
> >       Debian (Stretch): 2.50.3
> >       Debian (Jessie): 2.42.1
> >       OpenBSD (Ports): 2.54.3
> >       FreeBSD (Ports): 2.50.3
> >       OpenSUSE Leap 15: 2.54.3
> >       SLE12-SP2: 2.48.2
> >       Ubuntu (Xenial): 2.48.0
> >       macOS (Homebrew): 2.56.0
> >    =20
> >     This suggests that a minimum glib of 2.42 is a reasonable target.
> >    =20
> >     The GLibC compile farm, however, uses Ubuntu 14.04 (Trusty) which=
 only
> >     has glib 2.40.0, and this is needed for testing during merge. Thu=
s an
> >     exception is made to the documented platform support policy to al=
low for
> >     all three current LTS releases to be supported.
> >    =20
> >     Docker jobs that not longer satisfy this new min version are remo=
ved.
> >    =20
> >     [1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-pl=
atforms
> >    =20
> >     Reviewed-by: Thomas Huth <thuth@redhat.com>
> >     Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >=20
> >=20
> >>
> >> From commit e71e8cc035558eabd6b3e19f6d3254c754c027ef:
> >>
> >>  glib: enforce the minimum required version and warn about old APIs
> >>
> >>  There are two useful macros that can be defined before including
> >>  glib.h that are related to the min required glib version
> >>
> >>   - GLIB_VERSION_MIN_REQUIRED
> >>
> >>     When this is defined, if code uses an API that was deprecated
> >>     in this version, or older, a compiler warning will be emitted.
> >>     This alerts maintainers to update their code to whatever new
> >>     replacement API is now recommended best practice.
> >>
> >>   - GLIB_VERSION_MAX_ALLOWED
> >>
> >>     When this is defined, if code uses an API that was introduced
> >>     in a version that is newer than the declared version, a compiler
> >>     warning will be emitted. This alerts maintainers if new code
> >>     accidentally uses functionality that won't be available on some
> >>     supported platforms.
> >>
> >>  The GLIB_VERSION_MAX_ALLOWED constant makes it a bit harder to opt
> >>  in to using specific new APIs with a GLIB_CHECK_VERSION conditional=
.
> >>  To workaround this Pragmas can be used to temporarily turn off the
> >>  -Wdeprecated-declarations compiler warning, while a static inline
> >>  compat function is implemented. This workaround is illustrated with=
 the
> >>  implementation of the g_strv_contains method to satisfy the test su=
ite.
> >>
> >>> +    base =3D g_canonicalize_filename(prefix, NULL);
> >>> +#else
> >>> +    if (prefix[0] !=3D '/') {
> >>> +        char *cwd =3D g_get_current_dir();
> >>> +        base =3D g_build_filename(cwd, prefix, NULL);
> >>> +        g_free(cwd);
> >>> +    } else {
> >>> +        base =3D g_strdup(prefix);
> >>> +    }
> >>> +#endif
> >=20
> > To use functionality from newer glib releases we can't put the #ifdef
> > conditionals inline in the main source files.
> >=20
> > They have to be put into glib-compat.h instead. There's a detailed
> > comment in that file illustrating how todo this without triggering
> > the compile warnings about deprecations.
> >=20
> >=20
> > Regards,
> > Daniel
> >=20
>=20
> Trying to build (Richard's tcg-vec-next branch) on Fedora29 I get
>=20
> util/path.c: In function 'init_paths':
> util/path.c:24:5: error: 'g_canonicalize_filename' is deprecated: Not
> available before 2.58 [-Werror=3Ddeprecated-declarations]
>      base =3D g_canonicalize_filename(prefix, NULL);
>      ^~~~

[snip]

This is exactly why the compat code needs to go into glib-compat.h.
There is a special mechanism in that file for avoiding triggering
the deprecation warnings from glib.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

