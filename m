Received: from eggs.gnu.org ([2001:4830:134:3::10]:50206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxPdK-0003VK-99
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 23:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxPdJ-0006eP-7W
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 23:04:50 -0400
Received: from mail-yb0-x230.google.com ([2607:f8b0:4002:c09::230]:34645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1cxPdJ-0006e4-2f
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 23:04:49 -0400
Received: by mail-yb0-x230.google.com with SMTP id m133so28932842ybb.1
	for <qemu-devel@nongnu.org>; Sun, 09 Apr 2017 20:04:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170410021453.1711.64526.malone@chaenomeles.canonical.com>
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
	<20170410021453.1711.64526.malone@chaenomeles.canonical.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 10 Apr 2017 11:04:47 +0800
Message-ID: <CAOGPPbf88=LK7cEMKa5ZeK7O=BaH_n0GWg-4y8Ph1p6FPMoyBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1662050] Re: qemu-img convert a overlay qcow2
 image into a entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1662050 <1662050@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

Hi wayen:
    Which version are you used?
    I also find this problem on old version qemu, and i write a patch
for it. It works.
    I'm not sure the mainline version have solve this problem.
    what command are you used?

On Mon, Apr 10, 2017 at 10:14 AM, wayen <1662050@bugs.launchpad.net> wrote:
> Is there any way to remove holes from qcow2 overlay images? It's very
> important to me. I am looking forward to your reply.
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1662050
>
> Title:
>   qemu-img convert a overlay qcow2 image into a entire image
>
> Status in QEMU:
>   Incomplete
>
> Bug description:
>   I have a base image file "base.qcow2" and a delta qcow2 image file
>   "delta.qcow2" whose backing file is "base.qcow2".
>
>   Now I use qemu-img to convert "delta.qcow2" and will get a new image
>   file "new.qcow2" which is entire and equivalent to combination of
>   "base.qcow2" and "delta.qcow2".
>
>   In fact,I don't want to get a complete image.I just want to convert
>   delta qcow2 image file "A" to a New delta overlay qcow2 image "B"
>   which is equivalent to "A". So the "new.qcow2" is not what i want. I
>   have to admit that this is not bug. Could you please take this as a
>   new feature and enable qemu-img to convert qcow2 overlay itself?
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1662050/+subscriptions
>
