Received: from eggs.gnu.org ([2001:4830:134:3::10]:52926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eejSW-0000tZ-HO
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eejSV-0001rm-It
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:29:00 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eejSV-0001qj-DL
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:28:59 -0500
Received: by mail-oi0-x241.google.com with SMTP id w135so5490930oie.3
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 07:28:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180125091643.26195-1-kraxel@redhat.com>
References: <20180125091643.26195-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 15:28:38 +0000
Message-ID: <CAFEAcA_U7Dw4m+wLeqHRij5YUO9eFkkpwwRjTWKr099Ux12+cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20180125 patches
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

On 25 January 2018 at 09:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 834a336eb911db8a8ca00e760ee6a85faca19414:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-01-24 19:24:26 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180125-pull-request
>
> for you to fetch changes up to 2aef004483e34a42021dc98a3646971dc152cb1b:
>
>   usb-storage: Fix share-rw option parsing (2018-01-25 09:50:30 +0100)
>
> ----------------------------------------------------------------
> usb: -usbdevice cleanups, storage fix, ccid cleanup.
>
> ----------------------------------------------------------------
>
> Fam Zheng (1):
>   usb-storage: Fix share-rw option parsing
>
> Mao Zhongyi (1):
>   hw/usb/ccid: Make ccid_card_init() take an error parameter
>
> Thomas Huth (1):
>   usb: Remove legacy -usbdevice options (host, serial, disk and net)

Hi. This fails to build on FreeBSD:

  LINK    arm-softmmu/qemu-system-arm
../vl.o: In function `usb_device_add':
/root/qemu/vl.c:1471: undefined reference to `usb_host_device_open'

There's still a call to that function in vl.c inside an
ifndef CONFIG_LINUX...

If we can really remove the function we should get rid of the
stub in hw/usb/host-stub.c and the prototype in usb.h too.

thanks
-- PMM
