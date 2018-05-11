Received: from eggs.gnu.org ([2001:4830:134:3::10]:56908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fH7O6-00021M-Ch
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fH7O3-0004s2-AR
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:43:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fH7O3-0004qn-6D
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:43:03 -0400
Date: Fri, 11 May 2018 13:42:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180511124253.GH22098@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9gG5aSPr7KmqMvgP4OZ9zOC5Z5_UnS_pP+eujDiQmZHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9gG5aSPr7KmqMvgP4OZ9zOC5Z5_UnS_pP+eujDiQmZHw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/30] Misc patches for 2018-05-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, May 11, 2018 at 01:19:51PM +0100, Peter Maydell wrote:
> On 8 May 2018 at 23:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > The following changes since commit cc8f8ba754bba17eea9791d67b572eb26e30b4ce:
> >
> >   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-05-08 15:25:17 +0100)
> >
> > are available in the git repository at:
> >
> >
> >   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 3c128df2ec239f5c1abd0aa59254c433a779a347:
> >
> >   rename included C files to foo.inc.c, remove osdep.h (2018-05-09 00:13:41 +0200)
> >
> > ----------------------------------------------------------------
> > * Don't silently truncate extremely long words in the command line
> > * bump min required glib library version to 2.42
> > * dtc configure fixes
> > * MemoryRegionCache second try
> > * Deprecated option removal
> > * add support for Hyper-V reenlightenment MSRs
> >
> > ----------------------------------------------------------------
> 
> Some of my build setups barf on the new glib version requirement:
> 
>  * my aarch64 build host (a gcc compile farm machine which is running
>    Ubuntu 14.04.5 LTS and has glib 2.40.2)

That is expected - per the policy we only aim to support the most recent,
and most recent but one for 2 years overlap. Since LTS releases are two
years apart, this basically means always just 2 most recent LTS releases
for Ubuntu. Since we Ubuntu 18.04 LTS came out last month, we don't
need to continue 14.04 LTS

>  * my windows cross compile setups (which have glib 2.34.3)

Presumably you're using a Debian host for that ?

The debian-win64-cross.docker job seems to pull in packages from

  deb http://pkg.mxe.cc/repos/apt/debian jessie main

And mxe claims to have glib 2.54

Alternativel Fedora has new mingw packags too

> The latter could probably be fixed, but it will be a pain because
> gtk.org don't distribute prebuilt glib &c zipfiles usable for cross
> compile any more. For the former, that LTS is apparently still
> in support for another year.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
