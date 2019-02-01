Received: from eggs.gnu.org ([209.51.188.92]:38224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpe8j-0006sn-61
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpe8f-0003Iq-GW
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:06:11 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:41819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpe8d-0003Ff-5Q
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:06:07 -0500
Received: by mail-oi1-x232.google.com with SMTP id j21so6667574oii.8
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 11:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20190201163518.31157-1-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 19:05:51 +0000
Message-ID: <CAFEAcA9yESdxJYXXrSkoBWVJh+bSaSJKQvgjH-iOAjJ2Dz204A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 1 Feb 2019 at 16:35, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit cfe6c547690b06fbce54a6d0f7b05dd7f18e36ea:
>
>   Merge remote-tracking branch 'remotes/xanclic/tags/pull-block-2019-01-31' into staging (2019-01-31 19:26:09 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 7471a649fc3a391dd497297013fb2525ca9821ba:
>
>   scsi-disk: Add device_id property (2019-02-01 13:48:11 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - vmdk: Support for blockdev-create
> - block: Apply auto-read-only for ro-whitelist drivers
> - virtio-scsi: Fixes related to attaching/detaching iothreads
> - scsi-disk: Fixed erroneously detected multipath setup with multiple
>   disks created with node-names. Added device_id property.
> - block: Fix hangs in synchronous APIs with iothreads
> - block: Fix invalidate_cache error path for parent activation
> - block-backend, mirror, qcow2, vpc, vdi, qemu-iotests:
>   Minor fixes and code improvements


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
