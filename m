Received: from eggs.gnu.org ([2001:4830:134:3::10]:51066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxr4E-0006dH-FB
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxr4B-0006XI-Cr
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxr4B-0006X1-3s
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 04:54:39 -0400
Date: Fri, 29 Sep 2017 09:54:27 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170929085427.GD6803@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <mailman.4614.1506600439.14748.qemu-devel@nongnu.org>
	<D2C519DD-C9FE-42FC-9418-CD13BC48238D@gmail.com>
	<20170928165333.GP12919@redhat.com>
	<CDDC4F21-36D9-4341-AE18-B12ABFA4AFBD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CDDC4F21-36D9-4341-AE18-B12ABFA4AFBD@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/6] Initial support for keycodemapdb
 GIT submodule
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Thu, Sep 28, 2017 at 08:20:09PM -0400, Programmingkid wrote:
> 
> > On Sep 28, 2017, at 12:53 PM, Daniel P. Berrange <berrange@redhat.com> wrote:
> > 
> > On Thu, Sep 28, 2017 at 12:47:51PM -0400, Programmingkid wrote:
> >> 
> >>> This patch series is an update to:
> >>> 
> >>> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
> >>> v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
> >>> v3: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02517.html
> >>> v4: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02708.html
> >>> v5: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02950.html
> >>> v6: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07673.html
> >> 
> >> <snip>
> >> 
> >> These error messages appears when compiling version 7 of this patch series:
> >> 
> >> /bin/sh: ./scripts/git-submodule.sh: Permission denied
> > 
> > The git diff sets execute permission:
> > 
> > diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> > new file mode 100755
> > index 0000000000..f8e7d44ce6
> > --- /dev/null
> > +++ b/scripts/git-submodule.sh
> > 
> > did you use "git am" to apply this series or just plain 'patch', because
> > the latter won't deal with permissions correctly and so would cause that
> > error message above.
> 
> I used the patch command. After trying again using 'git am' I was able to built QEMU. Even thought the build did succeed, this error message still appeared: 
> 
> config-host.mak is out-of-date, running configure
>   GIT     ui/keycodemapdb dtc
> make: *** No rule to make target `ui/input-keymap-linux-to-qcode.c', needed by `Makefile'.  Stop.
> make: *** Waiting for unfinished jobs....
> 
> I suggest adding a note to patch 0/7 that states this patch set is best
> applied using 'git am' instead of the patch command. That should help
> someone with testing out this patch set.

*All* patches sent to qemu-devel for review should be applied with
'git am', so there's no need to call it out specially.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
