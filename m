Received: from eggs.gnu.org ([2001:4830:134:3::10]:49155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4oUc-0002dx-Gv
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4oUY-0000MO-J8
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:34:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4oUY-0000Kz-D3
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:34:38 -0400
Date: Wed, 18 Oct 2017 14:34:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171018133428.GI9719@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171017153742.10026-1-richard.henderson@linaro.org>
	<20171017153742.10026-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171017153742.10026-10-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v5 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Oct 17, 2017 at 08:37:42AM -0700, Richard Henderson wrote:
> Do not require the submodule, but use it if present (in preference
> even to a system copy).  This will allow us to easily use capstone
> in older systems for which a package is not available, and also
> easily track bug fixes from upstream.

I don't like the idea that we should blindly use the submodule
even if the host OS has it installed. This means developers working
on git will never be testing against the capstone that will actually
be used when they deploy a release build on their distro.

It also gives inconsistent behaviour wrt the way the dtc module
is handled, where we always try to use the system version and
only try the submodule if the system version is missing.

Thus I think we really ought to deal with capstone in the same
way as dtc. We could make the check a little more advanced so that
it checks for the particular capstone feature QEMU wants. That way
if someone does have an outdated capstone we'd still use the submodule.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
