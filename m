Received: from eggs.gnu.org ([2001:4830:134:3::10]:57611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxKjG-0000KR-Ge
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxKjF-0006nR-Gy
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:22:54 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:44188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dxKjF-0006k5-9R
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:22:53 -0400
Received: by mail-wm0-x229.google.com with SMTP id m127so22372354wmm.1
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 15:22:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2ED47AD3BCA5A94A950F676FB45058DE5420E75A@SHSMSX101.ccr.corp.intel.com>
References: <2ED47AD3BCA5A94A950F676FB45058DE5420E75A@SHSMSX101.ccr.corp.intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 27 Sep 2017 15:22:20 -0700
Message-ID: <CAKmqyKNG4qXw92Vczxd_LD11ypzSU-3_Mazd6gbE_=DWPb20Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] HDMI Question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Ni, Xingrong" <xingrong.ni@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, Sep 27, 2017 at 5:31 AM, Ni, Xingrong <xingrong.ni@intel.com> wrote:
> Hello,
>
> I am using qemu and hit a question and would like to ask here, can we simulate a HDMI device in Qemu, if so, how to do it?

Hello,

I don't see any reason why you can't. We (Xilinx) have a display port
device in QEMU that we use.

Basically how it works is you model the devices registers and use
QEMUs display backend (usually over SDL or VNC) to display the image.

Here is a pretty recent example of a display port device in QEMU:
https://github.com/qemu/qemu/blob/master/hw/display/xlnx_dp.c

In saying that display devices are pretty intense and this will not be
a trivial task.

Thanks,
Alistair

>
>
> Thanks & Best Wishes!
> Rocky
>
>
