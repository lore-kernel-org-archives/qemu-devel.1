Received: from eggs.gnu.org ([2001:4830:134:3::10]:53820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS2Le-0003od-Vp
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS2LT-0002wL-RG
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:05:52 -0500
Date: Wed, 28 Nov 2018 16:05:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181128160525.GP24355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543399094-2260-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543399094-2260-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1?] target/arm/sve_helper: Fix
 compilation with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Nov 28, 2018 at 10:58:14AM +0100, Thomas Huth wrote:
> Clang 3.4 does not know the "flatten" attribute yet. We've already
> introduced the QEMU_FLATTEN macro for this in commit 97ff87c0ed020c2,
> so use this macro now here, too, to fix this issue.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Although we currently only aim to support CLang and GCC, we don't have
any checks for a minimum version of these two tools in configure.

So I was wondering if we actually still need to support CLang 3.4 at all
in QEMU, given our targetted build platforms.

Unfortunately repology.org is failing me in reporting clang versions
for most distros, so I don't have an answer yet. I do see that Debian
Jessie however ships clang == 3.5 and that's usually the oldest distro
if RHEL hasn't got something older.

If we did explicitly check min gcc + clang versions, we could sanitize
stuff such as hacks for ancient clang 3.2 which lacks int128 support.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
