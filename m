Received: from eggs.gnu.org ([2001:4830:134:3::10]:58066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fslmu-00077q-Sj
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fslmu-00012s-1l
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:20:20 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fslmt-00012D-6m
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:20:19 -0400
Received: by mail-oi0-x241.google.com with SMTP id k12-v6so8094317oiw.8
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 02:20:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180821091148.32220-1-kraxel@redhat.com>
References: <20180821091148.32220-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 10:19:57 +0100
Message-ID: <CAFEAcA-qBC+aJJYw=KzgEU++yPPcOkDHEHbhEfAds=zbFKK4_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Usb 20180821 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 August 2018 at 10:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit d0092d90eb546a8bbe9e9120426c189474123797:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180820' into staging (2018-08-20 17:41:18 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180821-pull-request
>
> for you to fetch changes up to 15aa757d0523b9d6fb26ea1e5c967ba0619dce0a:
>
>   dev-mtp: rename x-root to rootdir (2018-08-21 10:27:59 +0200)
>
> ----------------------------------------------------------------
> usb: mtp write support, bugfixes.
>
> ----------------------------------------------------------------
>
> Bandan Das (5):
>   dev-mtp: add support for canceling transaction
>   dev-mtp: fix buffer allocation for writing file contents
>   dev-mtp: retry write for incomplete transfers
>   dev-mtp: Add support for > 4GB file transfers
>   dev-mtp: rename x-root to rootdir
>
> Sebastian Bauer (1):
>   ohci: Clear the interrupt counter for erroneous transfers
>
> npes87184 (1):
>   docs/usb2.txt: ehci has six ports
>
>  docs/usb2.txt     |  4 +--
>  hw/usb/dev-mtp.c  | 93 ++++++++++++++++++++++++++++++++++++++++++++++---------
>  hw/usb/hcd-ohci.c |  3 ++
>  3 files changed, 84 insertions(+), 16 deletions(-)

Applied, thanks.

-- PMM
