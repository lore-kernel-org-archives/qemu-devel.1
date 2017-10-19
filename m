Received: from eggs.gnu.org ([2001:4830:134:3::10]:51570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5DIb-0000B7-6X
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5DIX-0000W7-D5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5DIX-0000Vc-82
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:03:53 -0400
Date: Thu, 19 Oct 2017 17:03:46 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171019160346.GZ8408@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171019155146.30434-1-richard.henderson@linaro.org>
	<CAFEAcA_cP-L8=DygAdvjr5Eaz=p5vX50-Gw6fm2_h8PpsFHsgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_cP-L8=DygAdvjr5Eaz=p5vX50-Gw6fm2_h8PpsFHsgA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/9] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Oct 19, 2017 at 04:54:59PM +0100, Peter Maydell wrote:
> On 19 October 2017 at 16:51, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> > Changes since v5:
> >   * Rearranged how we choose git submodule vs system installed library.
> >     By default, the system library will be used, if present;
> >     Followed by git submodule, if present;
> >     Followed by not-git submodule, if for some reason a tarball contained it.
> 
> In general the tarball *should* contain it, because the tarball should
> work for users to build from source, same as git.

The 'make-release' script automatically checks out all submodules and includes
them in the dist, so that should work.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
