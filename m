Received: from eggs.gnu.org ([2001:4830:134:3::10]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8k5i-0007DN-Gf
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8k5e-0001sF-IH
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:13:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f8k5e-0001rt-DE
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:13:26 -0400
Date: Wed, 18 Apr 2018 11:13:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180418101321.GD27579@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAMxP3BSFEuknshd05kSn8EjNuv8F8aPGuNFG3qUd0Ap6GbZFrQ@mail.gmail.com>
	<18e4de85-274e-54aa-e34e-4fd3f82e40e2@weilnetz.de>
	<CAMxP3BThUkaPWRq=D2AhecGgpmC-F=_fGbBQX-oyaqMs95s3Pw@mail.gmail.com>
	<CAMxP3BRXh8MLz2KQ_bG-v0KzrL9CxG7bCbtsEfijJ2DUFAbjUA@mail.gmail.com>
	<CAFEAcA-sGiZFdAa8Gnfbo_=o-ZZbChyDJAV9oGmMTBC8BNS3sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-sGiZFdAa8Gnfbo_=o-ZZbChyDJAV9oGmMTBC8BNS3sQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Latest v2.12.0-rc4 has compiling error, rc3 is OK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bob Chen <a175818323@gmail.com>, Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Apr 18, 2018 at 10:29:35AM +0100, Peter Maydell wrote:
> On 18 April 2018 at 09:09, Bob Chen <a175818323@gmail.com> wrote:
> > I found that it has nothing to do with the release version, but the github
> > one is just not able to work...
> >
> > So what github and qemu.org provide are totally different things?
> 
> The "tarballs" from github don't work and can't work, but
> github provides no mechanism for the project to say "don't
> create this page". You can complain to github about this
> if you like.
> 
> You're best off starting with the project's own web
> page: https://www.qemu.org/ -- we use github only as
> a sort of backup git server in case our own is down.

I sent a patch that adds a sanity check to configure to try to catch this
mistake - it would also affect people who created tarballs with a plain
"git archive" command

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
