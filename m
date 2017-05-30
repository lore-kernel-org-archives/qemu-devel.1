Received: from eggs.gnu.org ([2001:4830:134:3::10]:43936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFfZs-0005cp-M9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFfZr-0002gn-NF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:44:44 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFfZr-0002gd-Ft
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:44:43 -0400
Received: by mail-wm0-x231.google.com with SMTP id 7so88553697wmo.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 04:44:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <tencent_025CFFC03619731459E0872A@qq.com>
References: <tencent_025CFFC03619731459E0872A@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 12:44:21 +0100
Message-ID: <CAFEAcA_jd+bJ6TF2_Ep2hA388PSiHCTXTAekVRB+pGPecXTZQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] timer configure for QEMU versatilepb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: heavybird <4345099@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 9 May 2017 at 05:32, heavybird <4345099@qq.com> wrote:
> Hi Peter and qemu-devel,
>
> I am trying to port one simple RTOS to QEMU versatilepb,  however, i found
> the SIC address(actually PIC) is different from the PIC in the
> integratorcp.c even though they are same arm926, besides, the PIC register
> bit definition is some different between versatilepb and integratorcp
> compared by the icp_pic_read/icp_pic_read interface.

These devices are not part of the CPU, so it is expected
that they will differ from board to board.

> Could you confirm for me PIC register bit definition and the PIC
> address/timer0 address in the versatilepb QEMU or where i can find some
> information exactly.

The documentation for the hardware board that we model as the
'versatilepb' is this one:
http://infocenter.arm.com/help/topic/com.arm.doc.dui0224i/index.html

thanks
-- PMM
