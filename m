Received: from eggs.gnu.org ([2001:4830:134:3::10]:48418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftKHV-0002vk-JS
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 18:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftKHU-0002Md-QK
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 18:10:13 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:38573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftKHU-0002LU-9z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 18:10:12 -0400
Received: by mail-oi0-x236.google.com with SMTP id x197-v6so173768oix.5
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 15:10:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180823095653.14556-1-kraxel@redhat.com>
References: <20180823095653.14556-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 23:09:50 +0100
Message-ID: <CAFEAcA-QhN14Sbo8r9OO-8G_pV6+2mACih+ECFM+TOwgky+Htw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] Ui 20180823 v3 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>

On 23 August 2018 at 10:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit d0092d90eb546a8bbe9e9120426c189474123797:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180820' into staging (2018-08-20 17:41:18 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180823-v3-pull-request
>
> for you to fetch changes up to 63cde1d13d0767f778a130e2c93c15ad709e1276:
>
>   util: promote qemu_egl_rendernode_open() to libqemuutil (2018-08-23 11:53:26 +0200)
>
> ----------------------------------------------------------------
> ui: misc fixes which piled up during 3.0 release freeze
>
> ----------------------------------------------------------------

Hi; this failed to build on openbsd (the VM setup in tests/vm).
Linking of all the qemu-system-foo binaries failed with:

../ui/egl-helpers.o: In function `egl_rendernode_init':
ui/egl-helpers.c:153: undefined reference to `qemu_drm_rendernode_open'


thanks
-- PMM
