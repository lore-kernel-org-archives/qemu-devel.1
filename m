Received: from eggs.gnu.org ([2001:4830:134:3::10]:42969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPQKL-0002pM-Rn
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPQKG-0005OA-GD
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:05:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gPQKG-0005LR-4i
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:05:44 -0500
Date: Wed, 21 Nov 2018 11:05:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181121110538.GL26577@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <mailman.23054.1542721275.1282.qemu-devel@nongnu.org>
	<36E62A3F-7402-418F-AB88-9B597E437C69@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36E62A3F-7402-418F-AB88-9B597E437C69@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on
 macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Wed, Nov 21, 2018 at 05:53:50AM -0500, Programmingkid wrote:
> 
> > On 13 November 2018 at 12:12, Programmingkid <programmingkidx@gmail.com> wrote:
> >>> On Nov 11, 2018, at 4:35 PM, Berkus Decker wrote:
> >>> These changes are ought to work on OSX 10.6, although I don?t have a machine handy to test it.
> >> 
> >> I have Mac OS 10.6 available for testing.
> > 
> > This is perhaps a good point to ask the question: is retaining
> > support for 10.6 still worth the effort ? It was released 9
> > years ago and has been unsupported by Apple for nearly 5 years.
> > 
> > qemu-doc.texi's "Supported build platforms" section says:
> > # The project supports building with the two most recent versions
> > # of macOS, with the current homebrew package set available.
> > 
> > which would be High Sierra (10.13) and Mojave (10.14) only. If you
> > widened that to "all versions still supported by Apple" it would add
> > Sierra (10.13) to the list.
> > 
> > Given how few upstream developers we have who care about OSX,
> > I think it is not very useful to spend that effort on trying
> > to retain support for ancient versions of it.
> > 
> > thanks
> > -- PMM
> 
> Mac OS 10.6 is a very good operating system. I much rather we simplify
> the patch rather than drop support for this excellent operation system
> just because it is a few years old. I suspect rewriting the the patch
> to use performSelectorOnMainThread:withObject:waitUntilDone: would be
> a simpler and better patch.

Whether 10.6 is a good OS or not is not really relevant. There are a great
many good operating systems that are no longer supported by either QEMU
or their vendors. It isn't a sensible use of limited project resources
to support an ever growing set of old OS versions. 

This is why we formalized our intentions wrt support for old operating
systems to limit it to a reasonable number of versions that are currently
supported by their respective vendors. We achieve a balance of keeping
enough platforms supported to suit 90+% of our expected users, while
keeping the set of platforms small enough that we can reasonably expect
to test them well & be able to utilize new features in a timely manner.

The goal of the support statement is further to stop endless debates
about whether we can use new features that aren't available in certain
old OS releases. The answer is now that we can use whatever features
provide the best solution for the OS versions that we explicitly
target. If that causes us to drop an old OS as a side-effect that is
entirely fine.

> I have tried the patch out already on Mac OS 10.12 and it did not work.
> The firmware never runs and the Machine menu does not populate. I do
> not believe this patch is worth dropping the support of many versions
> of Mac OS X.

Of course I'm not suggesting merging the patch if it doens't even work
for modern macOS versions. We should clearly fix the patch to work as
needed on our supported versions of macOS.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
