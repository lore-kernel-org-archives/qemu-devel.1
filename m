Received: from eggs.gnu.org ([2001:4830:134:3::10]:45275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2xW0-0007BR-KR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2xVz-0005yE-K6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:16:12 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2xVz-0005xN-Cb
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:16:11 -0400
Received: by mail-wm0-x22e.google.com with SMTP id u65so18343938wmu.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 03:16:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424192002.18622-1-jcody@redhat.com>
References: <20170424192002.18622-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 11:15:49 +0100
Message-ID: <CAFEAcA_m8jWwdUWJb9pHZ_TaPUw5tLD8gjavWwRu+UrHkpJ6ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/12] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24 April 2017 at 20:19, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit 4c55b1d0bad8a703f0499fe62e3761a0cd288da3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2017-04-24' into staging (2017-04-24 14:49:48 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to ecfa185400ade2abc9915efa924cbad1e15a21a4:
>
>   qemu-iotests: _cleanup_qemu must be called on exit (2017-04-24 15:09:33 -0400)
>
> ----------------------------------------------------------------
> Pull v2, with 32-bit errors fixed.  I don't have OS X to test compile on,
> but I think it is safe to assume the cause of the compile error was the same.
> ----------------------------------------------------------------
>
> Ashish Mittal (2):
>   block/vxhs.c: Add support for a new block device type called "vxhs"
>   block/vxhs.c: Add qemu-iotests for new block device type "vxhs"
>
> Jeff Cody (10):
>   qemu-iotests: exclude vxhs from image creation via protocol
>   block: add bdrv_set_read_only() helper function
>   block: do not set BDS read_only if copy_on_read enabled
>   block: honor BDRV_O_ALLOW_RDWR when clearing bs->read_only
>   block: code movement
>   block: introduce bdrv_can_set_read_only()
>   block: use bdrv_can_set_read_only() during reopen
>   block/rbd - update variable names to more apt names
>   block/rbd: Add support for reopen()
>   qemu-iotests: _cleanup_qemu must be called on exit
>

Applied, thanks.

-- PMM
