Received: from eggs.gnu.org ([2001:4830:134:3::10]:44345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqds7-0008T9-PE
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqds4-0008J5-OS
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:56:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eqds4-0008Hs-JW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:56:36 -0500
Date: Tue, 27 Feb 2018 11:56:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180227115612.GE18258@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
Subject: Re: [Qemu-devel] Proposal: deprecate and remove QEMU's unicore32
 target code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Richard Henderson <rth@twiddle.net>

On Tue, Feb 27, 2018 at 11:51:13AM +0000, Peter Maydell wrote:
> I propose that we deprecate and plan to remove the unicore32 code:
> 
>  * It has had no changes since 2012 that were not tree-wide
>    maintenance/API changes/other global updates
>  * We dropped the linux-user unicore32 support in 2016 because of
>    a clash between the 'old ABI' that it was implementing and the
>    ABI that's actually in the upstream Linux kernel, and there have
>    been no moves to get this fixed so we could re-enable it, nor
>    any complaints when it went away
>  * Linux is now planning to drop unicore support
>    (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1619640.html)
>  * there is apparently no upstream gcc support for the architecture
>  * nobody has ever reported a bug or problem to us about it
> 
> Essentially, it seems to be a largely-inactive university R&D project,
> it's costing us in maintenance effort every time we have to touch it,
> and I don't think it has any real users.
> 
> Does anybody disagree?
> 
> If we go ahead with deprecating then we should:
>  * add a note to Changelog that we're deprecating the target
>  * ditto qemu-doc.texi's deprecation section
>  * patch hw/unicore32/puv3.c to warn on startup that it's deprecated
>  * remove it entirely for the 2.14 release

Sounds like a good plan to me.

> We could also remove linux-user/unicore32 immediately, since
> the linux-user target has been disabled for some time.

Agreed.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
