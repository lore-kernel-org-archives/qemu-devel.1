Received: from eggs.gnu.org ([2001:4830:134:3::10]:37880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wonsange@gmail.com>) id 1fGhMT-0000gr-GO
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wonsange@gmail.com>) id 1fGhMS-0001bp-H0
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:55:41 -0400
Received: from mail-it0-x236.google.com ([2607:f8b0:4001:c0b::236]:53803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wonsange@gmail.com>) id 1fGhMS-0001bQ-BI
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:55:40 -0400
Received: by mail-it0-x236.google.com with SMTP id n64-v6so2228193itb.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 01:55:39 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?7Jyg7JuQ7IOB?= <wonsange@gmail.com>
Date: Thu, 10 May 2018 17:55:38 +0900
Message-ID: <CA+EEy5tEYtEXPH-vXcdcb1XsAD_5MEaz_JQ+_rwK3RfZn4b+nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Question about QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,
This is Wonsang Ryu.
I'm developer working in South Korea.

Do you have forum or community for any developer?
I want share my issues with other developers.
I have some question about QEMU.

I am porting an embedded OS for emulator to QEMU.
My environment is
Host OS : Ubuntu 14.04 64bit
Guest OS : x86 Embedded Linux OS (like as open embedded)
Guest UI Options : using SDL2, virglrenderer
Basic running is ok.

I have a problem about screen resolution.
Recommended resolution of my guest OS is 1920x1080.
If a QEMU window size is 1920x1080, it is clear.
But, if I change smaller of a QEMU window size, it does not display
clearly.(ex: 1280x720)
In this case, QEMU windows size in host is 1280x720, and guest screen
resolution is 1920x1080.
For example, it is similar with same resolution support of different
monitor size.

I think, it need to enable the MultiSampling(or anti-aliasing) of OpenGL.
Does not support MultiSampleing in QEMU yet?
Or, is it related with virglrenderer?

I found, QEMU does not use MULTISAMPLING option in "sdl2-gl.c".
And, "nr_samples" is always zero in "virtio-gpu-3d.c".
I think, it need to apply multisampling to texture received from
virglrenderer.
How can I enable a multisampling option in QEMU?

I want to hold the resolution of the guest OS and scale the QEMU windows in
the host OS.
When scale QEMU windows, I want display is more clear even though small.
Is it possible?

Please help me.
Thanks.
