Received: from eggs.gnu.org ([2001:4830:134:3::10]:58167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5XB6-0006bF-O1
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5XB4-00070D-1k
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:17:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5XB3-0006zt-Ro
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:17:29 -0400
Date: Fri, 20 Oct 2017 14:17:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171020131724.GN21172@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171020130748.22983-1-berrange@redhat.com>
	<CAFEAcA-m8yK-L-OPOxv7+r_DC5qzqBYeB58A=oDw0xtJcNFa8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-m8yK-L-OPOxv7+r_DC5qzqBYeB58A=oDw0xtJcNFa8Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: don't throw away stderr when
 checking out git submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Oct 20, 2017 at 02:13:58PM +0100, Peter Maydell wrote:
> On 20 October 2017 at 14:07, Daniel P. Berrange <berrange@redhat.com> wrote:
> > The stderr from git is important if git fails to checkout modules
> > due to network problems, or other unexpected errors.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  scripts/git-submodule.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> > index d8fbc7e47e..08932a35f0 100755
> > --- a/scripts/git-submodule.sh
> > +++ b/scripts/git-submodule.sh
> > @@ -32,7 +32,7 @@ status)
> >      exit $?
> >      ;;
> >  update)
> > -    git submodule update --init $modules 1>/dev/null 2>&1
> > +    git submodule update --init $modules 1>/dev/null
> >      git submodule status $modules > "${substat}"
> >      ;;
> 
> Is there a reason why we say "1>/dev/null" rather than just ">/dev/null" ?

No special reason other than that was clearer when we had both 1> and 2>
at the same time. I can change it if you prefer ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
