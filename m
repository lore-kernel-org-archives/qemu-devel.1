Received: from eggs.gnu.org ([2001:4830:134:3::10]:43640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMf2v-0004UV-KL
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMf2u-0007Wq-LI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:07:53 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:37287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMf2u-0007W1-G5
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:07:52 -0500
Received: by mail-oi0-x232.google.com with SMTP id y75so3277500oie.4
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 11:07:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171206170019.24842.47488.stgit@gimli.home>
References: <20171206170019.24842.47488.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Dec 2017 19:07:31 +0000
Message-ID: <CAFEAcA8kBT8Kxg_c5zSv1N8rW3gLY46_cXOJotaptLpCe4f5Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.11 0/1] VFIO: Fix vfio-kvm device
 group registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 December 2017 at 17:02, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 2babfe0c9241c239272a03fec785165a50e8288c:
>
>   Update version for v2.11.0-rc4 release (2017-12-05 16:36:46 +0000)
>
> are available in the git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20171206.0
>
> for you to fetch changes up to 13e6ae741cc0848a1819f435e2251d6d0bfae3e1:
>
>   vfio: Fix vfio-kvm group registration (2017-12-05 13:22:45 -0700)
>
> ----------------------------------------------------------------
> VFIO fix for v2.11-final
>
>  - Fix bug failing to register all but the first group attached to
>    a container with kvm-vfio device (Alex Williamson)
>
> ----------------------------------------------------------------

I'm afraid this has missed the boat for 2.11, since we've
already cut what we think should be the final rc. It would
have to be a really critical regression since 2.10...

thanks
-- PMM
