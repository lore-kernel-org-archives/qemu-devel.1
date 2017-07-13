Received: from eggs.gnu.org ([2001:4830:134:3::10]:40863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVfok-0004ts-MG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVfog-0005CT-EL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:14:14 -0400
Date: Thu, 13 Jul 2017 16:14:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170713151405.GS4011@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499955697-28045-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499955697-28045-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] configure: Drop ancient Solaris 9 and
 earlier support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, patches@linaro.org

On Thu, Jul 13, 2017 at 03:21:37PM +0100, Peter Maydell wrote:
> Solaris 9 was released in 2002, its successor Solaris 10 was
> released in 2005, and Solaris 9 was end-of-lifed in 2014.
> Nobody has stepped forward to express interest in supporting
> Solaris of any flavour, so removing support for the ancient
> versions seems uncontroversial.
> 
> In particular, this allows us to remove a use of 'uname'
> in configure that won't work if you're cross-compiling.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not a big thing, but it's a start on cleaning out some
> of the untested and untestable cruft from configure...
> 
>  configure               | 21 ---------------------
>  include/fpu/softfloat.h |  5 -----
>  2 files changed, 26 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
