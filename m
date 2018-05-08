Received: from eggs.gnu.org ([2001:4830:134:3::10]:54786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG2aD-0005tO-3Z
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG2aB-0006GB-Vw
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:23:09 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG2aB-0006G1-Qz
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:23:07 -0400
Received: by mail-ot0-x244.google.com with SMTP id l13-v6so36029671otk.9
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 06:23:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180507094448.32386-1-kraxel@redhat.com>
References: <20180507094448.32386-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 14:22:46 +0100
Message-ID: <CAFEAcA-=o2M3y8YN5-YZs0yxgoovyxc+GMWVA+R6KYhc_hcGpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20180507 patches
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

On 7 May 2018 at 10:44, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180507-pull-request
>
> for you to fetch changes up to 3280ea8edede3814553aa19fa27a58daedd48ad9:
>
>   usb-host: skip open on pending postload bh (2018-05-07 11:10:42 +0200)
>
> ----------------------------------------------------------------
> usb: fixes for mtp and host.
>
> ----------------------------------------------------------------
>
> Bandan Das (2):
>   usb-mtp: Add some NULL checks for issues pointed out by coverity
>   usb-mtp: Unconditionally check for the readonly bit
>
> Gerd Hoffmann (1):
>   usb-host: skip open on pending postload bh
>
>  hw/usb/dev-mtp.c     | 15 ++++++++-------
>  hw/usb/host-libusb.c |  7 +++++++
>  2 files changed, 15 insertions(+), 7 deletions(-)

Applied, thanks.

-- PMM
