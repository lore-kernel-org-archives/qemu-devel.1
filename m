Received: from eggs.gnu.org ([2001:4830:134:3::10]:54987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cotPb-00012w-4m
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cotPX-00072W-Am
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:03:27 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cotPX-00071e-56
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:03:23 -0400
Received: by mail-wr0-x232.google.com with SMTP id u48so53799042wrc.0
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 08:03:22 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 15:03:01 +0000
Message-ID: <CAFEAcA_mYnZyQXrMQCqvwiHWiyoyyHzd86A70z=rMHA7F1DugQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] make fails with confusing message if sdl audio enabled
 but sdl graphics not
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

If you configure like this:
 configure --disable-sdl --audio-drv-list=sdl
then configure will succeed but attempting to make fails with
a confusing message:

$ make
Makefile:259: *** ui/sdl.mo added in common-obj-y but ui/sdl.mo-objs
is not set. Stop.

(I actually encountered this on an OpenBSD system where
'sdl' is the default audio driver and the system happened
not to have sdl installed, so it doesn't need any configure
arguments to run into it. The above repro works on Linux,
though.)

thanks
-- PMM
