Received: from eggs.gnu.org ([2001:4830:134:3::10]:47429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv2jm-0003O6-3o
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv2jg-0007Sl-EO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:13:42 -0400
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:35652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv2jg-0007Sc-64
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:13:36 -0400
Received: by mail-lf0-x22f.google.com with SMTP id j90so74947922lfk.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 07:13:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403105238.23262-1-kraxel@redhat.com>
References: <20170403105238.23262-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 15:13:14 +0100
Message-ID: <CAFEAcA_qL4HNRcF=qqZuJMpfkuJfkMDyC-7bVd5PL-uvh=ryhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] usb-host: switch to LIBUSB_API_VERSION
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

On 3 April 2017 at 11:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
> libusbx doesn't exist any more, the fork got merged back to libusb.  So
> stop using LIBUSBX_API_VERSION and use LIBUSB_API_VERSION instead.  For
> backward compatibility alias LIBUSB_API_VERSION to LIBUSBX_API_VERSION
> in case we figure LIBUSB_API_VERSION isn't defined.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>


Applying to master at Gerd's suggestion since it's got review
and it just missed the boat for his -rc3 pull request.

thanks
-- PMM
