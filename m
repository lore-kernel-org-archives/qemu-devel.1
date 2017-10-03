Received: from eggs.gnu.org ([2001:4830:134:3::10]:48372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzNs4-00084e-2x
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzNry-0006Qd-4a
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:08:28 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:51748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dzNrx-0006PF-Ts
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:08:22 -0400
Received: by mail-wr0-x22e.google.com with SMTP id j14so6453199wre.8
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 07:08:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170929110052.6111-1-kraxel@redhat.com>
References: <20170929110052.6111-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Oct 2017 15:08:00 +0100
Message-ID: <CAFEAcA-8gaOhkuNX9hBt0Ofg-CKkJ-v8puHJ4K3QOq0ZGMgB5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20170929 patches
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

On 29 September 2017 at 12:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit ab161529261928ae7f3556e3220829c34b2686ec:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170927a' into staging (2017-09-27 22:44:51 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20170929-pull-request
>
> for you to fetch changes up to 13787d59cf86bac230c4d3eec3580110f53ac113:
>
>   usb: Use angle brackets for cacard include directive (2017-09-29 12:28:26 +0200)
>
> ----------------------------------------------------------------
> usb fixes.
>
> ----------------------------------------------------------------

This fails to build from clean (x86-64 Linux host):

make[1]: *** No rule to make target '../hw/usb/host-stub.o', needed by
'qemu-system-microblaze'. Stop.

(and similar for other targets).

thanks
-- PMM
