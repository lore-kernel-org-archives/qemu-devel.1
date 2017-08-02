Received: from eggs.gnu.org ([2001:4830:134:3::10]:55287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dct3H-0006Km-Or
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dct3G-00081j-T2
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:47:03 -0400
Date: Wed, 2 Aug 2017 13:46:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170802124651.GP4098@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728164708.12202-1-eblake@redhat.com>
	<20170728164708.12202-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170728164708.12202-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] maint: Include bug-reporting info
 in --help output.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, mreitz@redhat.com, pbonzini@redhat.com

On Fri, Jul 28, 2017 at 11:47:08AM -0500, Eric Blake wrote:
> These days, many programs are including a bug-reporting address,
> or better yet, a link to the project web site, at the tail of
> their --help output.  However, we were not very consistent at
> doing so: only qemu-nbd and qemu-qa mentioned anything, with the
> latter pointing to an individual person instead of the project.
> 
> Add a new #define that sets up a uniform string, mentioning both
> bug reporting instructions and overall project details, and which
> a downstream vendor could tweak if they want bugs to go to a
> downstream database.  Then use it in all of our binaries which
> have --help output.
> 
> The canned text intentionally references http:// instead of https://
> because our https website currently causes certificate errors in
> some browsers.  That can be tweaked later once we have resolved the
> web site issued.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v2: tweak text to capitalize QEMU and use consistent trailing .
> 
>  include/qemu-common.h | 5 +++++
>  vl.c                  | 4 +++-
>  bsd-user/main.c       | 2 ++
>  linux-user/main.c     | 4 +++-
>  qemu-img.c            | 2 +-
>  qemu-io.c             | 5 +++--
>  qemu-nbd.c            | 2 +-
>  qga/main.c            | 2 +-
>  8 files changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
