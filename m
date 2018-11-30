Received: from eggs.gnu.org ([2001:4830:134:3::10]:60266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSk4p-0005Mm-Cq
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSk4l-000413-2W
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSk4k-00040c-Nt
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:26 -0500
Date: Fri, 30 Nov 2018 14:47:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130144721.GF9162@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543574620-17506-1-git-send-email-thuth@redhat.com>
	<20181130111555.GA9162@redhat.com>
	<2acf4de2-d826-c2a4-c826-8c966b5cce9e@redhat.com>
	<eb933208-6ee6-7f2a-dc14-bffbfa76cfad@redhat.com>
	<4f5aef94-3d6d-ebf2-f1ec-35467c8e29c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f5aef94-3d6d-ebf2-f1ec-35467c8e29c8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] compiler.h: Add an explicit check
 for the compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org

On Fri, Nov 30, 2018 at 01:52:05PM +0100, Thomas Huth wrote:
> On 2018-11-30 13:46, Paolo Bonzini wrote:
> > On 30/11/18 13:30, Thomas Huth wrote:
> >> Do we really want to artificially limit our support here without any
> >> further reasons? If the users want to compile QEMU on an older system,
> >> and one of the libraries does not quite match anymore, it's often easy
> >> enough to recompile a newer version of the library to get things going
> >> again. Recompiling a whole compiler is way more cumbersome, though...
> >>
> >> OTOH, we could get rid of some more #if QEMU_GNUC_PREREQ spots in the
> >> source code if we bump the minimum version to 4.8 ... so that might be a
> >> real reason to increase the minimum.
> > 
> > Of all of them, I think, if we bump to 4.7?
> > 
> > Older 4.6 and 4.7 version have the PR55489 bug that we're checking for
> > in configure, too ("we should be able to delete this at the end of 2013"
> > :)).  Bumping to 4.8 would let us remove TRANSLATE_OPT_CFLAGS for good.
> 
> Ok, sounds like bumping to 4.8 would really help to get rid of some
> legacy stuff ... so please drop this patch for compiler.h, I'll try to
> come up with some other patches for checking the GCC version and Clang
> version in the configure script already instead.

BTW, when checking clang version there's some strangeness with macOS
which reports completely different versions from the clang it was
derived from, so we'd require separate checks for normal clang vs
apple's clang.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
