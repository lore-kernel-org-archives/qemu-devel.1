Received: from eggs.gnu.org ([2001:4830:134:3::10]:38405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coY5C-0007x2-Rm
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coY59-0006Bj-2a
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:16:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coY58-0006BT-Sv
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:16:54 -0400
Date: Thu, 16 Mar 2017 16:16:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170316161649.GZ15193@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
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

On Thu, Mar 16, 2017 at 03:23:45PM +0000, Peter Maydell wrote:
> OK, here's a concrete proposal for deprecating/dropping out of
> date host OS and architecture support.
> 
> We'll put this in the ChangeLog 'Future incompatible changes'
> section:
> -----
> * Removal of support for untested host OS and architectures:
> 
> The QEMU Project intends to drop support in a future release for any
> host OS or architecture which we do not have access to a build and test
> machine for. This affects the following host OSes:
>  * Native CYGWIN building
>  * GNU/kFreeBSD
>  * FreeBSD
>  * DragonFly BSD
>  * NetBSD
>  * OpenBSD
>  * Solaris
>  * AIX
>  * Haiku
> and the following host CPU architectures:
>  * ia64
>  * sparc
> 
> Specifically, if we do not have a build and test system available
> to us by the time we release QEMU 2.10, we will remove support in the
> release that follows 2.10.

BTW, by "build & test system available", presumably you mean a system
that someone has committed to actively maintaining, not merely donation
of (or access to) hardware on which to install & run VMs ?

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
