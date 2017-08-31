Received: from eggs.gnu.org ([2001:4830:134:3::10]:46817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnOuk-0007tJ-4j
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnOuf-0005al-6B
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:49:42 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnOue-0005aS-UW
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:49:37 -0400
Received: by mail-wm0-x231.google.com with SMTP id u26so3839372wma.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 05:49:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831122925.GJ17315@redhat.com>
References: <20170831122925.GJ17315@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 13:49:14 +0100
Message-ID: <CAFEAcA_pZn5evv_Z00EKevr1PrV+vNrs4bzEv9FaYLU_cisqyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] RFC: changing ROM bundling in tar dists for
 releases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 August 2017 at 13:29, Daniel P. Berrange <berrange@redhat.com> wrote:
> A while back now I posted an RFC patch that changes qemu-X.Y.Z.tar.bz2
> archive to *not* have any ROMs or 3rd party libs bundled, and create a
> new dist qemu-bundled-X.Y.Z.tar.bz2 for the fully bundled dist:
>
>   http://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03335.html
>
> With 2.10 out of the way, and KVM Forum approaching, I figure now is
> a reasonable time to revive the idea to see if it has support
>
> The core issues I'm aiming to solve are:
>
>  - Distro vendors don't want the bundled ROMs / libs. They want to
>    fully build everything from source to ensure they are distributing
>    clean soure & builds in compliance with the licenses. Currently they
>    strip bundled bits from the build tree, but would prefer if the source
>    dist did not have them either.
>
>  - The qemu release dists get ever larger as we add more ROMS. Adding
>    EFI ROM builds for i386, x86_64, and aarch64 will make the dists
>    larger still.

I think these make sense. Should we tie this into the
recent suggestion (by Gerd?) that we should put all the
rom blobs into git submodules, and otherwise generally
try to regularise our handling of blobs?

> There are the following options I see
>
>   1. Keep existing dist, and add a new minimal one
>
>        qemu-X.Y.Z.tar.bz2 - qemu source + bundled ROMS + libs
>        qemu-minimal-X.Y.Z.tar.bz2 - qemu source only
>
>      Least impact for current non-distro users, distros just switch.
>
>   2. Change existing dist, and add a new one with everything
>
>        qemu-X.Y.Z.tar.bz2 - qemu source only
>        qemu-full-X.Y.Z.tar.bz2 - qemu source + bundled ROMS + libs
>
>      Non-distro users need to download a different dist from what they
>      have known previously, but otherwise unchanged build process.
>
>   3. Change existing dist, and add a new one with bundled bits
>
>        qemu-X.Y.Z.tar.bz2 - qemu source only
>        qemu-addons-X.Y.Z.tar.bz2 - bundled ROMS + libs
>
>      Non-distro users need to manually download & install an
>      extra piece compared to now.

I don't use the tarballs, so I don't really have
a strong preference.

thanks
-- PMM
