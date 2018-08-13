Received: from eggs.gnu.org ([2001:4830:134:3::10]:50576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fp8Ir-0005FB-VB
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fp8Io-0003wh-4U
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:34:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fp8In-0003wA-U3
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:34:14 -0400
Date: Mon, 13 Aug 2018 09:34:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180813083408.GG22904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <5B7054D9.9000209@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B7054D9.9000209@gmx.com>
Subject: Re: [Qemu-devel] QEMU  on Solaris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michele Denber <mdenber@gmx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On Sun, Aug 12, 2018 at 11:40:09AM -0400, Michele Denber wrote:
> After configuring QEMU on my Sun I got this message:
> 
> "Host OS SunOS support is not currently maintained.
> The QEMU project intends to remove support for this host OS in
> a future release if nobody volunteers to maintain it and to
> provide a build host for our continuous integration setup.
> configure has succeeded and you can continue to build, but
> if you care about QEMU on this platform you should contact
> us upstream at qemu-devel@nongnu.org."
> 
> Well I do care about QEMU on my platform so I'd like to volunteer to provide
> a host for support.  I can provide you with a free account on my Sun Oracle
> Enterprise M3000 quad-core 2.75 GHz. SPARC64 VII running Solaris 10 Update
> 11.  I've got plenty of spare CPU cycles and lots of free disk.  Please let
> me know.

Copying Peter, as he would need access to a Solaris host to do GIT pre-merge
build testing.

Then there's the question of what ordinary developers would use for their own
testing if they needed to work on some portability issue. We've got support
in tree for running builds against VM images for the various *BSDs, and have
mingw cross build toolchain for Windows. Is it possible to provide free-to-use
VM disk images for Solaris build testing, or are software licensing requirements
going to get in the way of developers using them ?

There is OpenIndiana that forked off OpenSolaris, but I'm unclear how far
OpenIndiana and commercial Solaris have diverged since then ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
