Received: from eggs.gnu.org ([2001:4830:134:3::10]:32975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqkvt-0001W4-2l
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqkvs-0002F6-3G
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:29:01 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqkvr-0002Ej-Tk
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:29:00 -0500
Received: by mail-oi0-x241.google.com with SMTP id j79so13730679oib.12
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 11:28:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227083919.12339-1-kraxel@redhat.com>
References: <20180227083919.12339-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 19:28:38 +0000
Message-ID: <CAFEAcA8_dhX2ULBv+14Rs=3bU8Z56jgd=_U_Xg9368D0c2Fp8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Usb 20180227 patches
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

On 27 February 2018 at 08:39, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:
>
>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180227-pull-request
>
> for you to fetch changes up to 53735bef108c5ccddf0f8a65cde4da53a48dbd47:
>
>   usb-mtp: Advertise SendObjectInfo for write support (2018-02-26 12:18:36 +0100)
>
> ----------------------------------------------------------------
> usb: add mtp write support.
>
> ----------------------------------------------------------------
>
> Bandan Das (5):
>   usb-mtp: Add one more argument when building results
>   usb-mtp: print parent path in IN_IGNORED trace fn
>   usb-mtp: Support delete of mtp objects
>   usb-mtp: Introduce write support for MTP objects
>   usb-mtp: Advertise SendObjectInfo for write support
>
>  hw/usb/dev-mtp.c | 471 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 441 insertions(+), 30 deletions(-)

Applied, thanks.

-- PMM
