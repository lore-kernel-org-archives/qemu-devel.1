Received: from eggs.gnu.org ([2001:4830:134:3::10]:49863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxSqY-0002Wy-TC
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxSqX-0006Qi-VE
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:30:42 -0400
Received: from mail-yb0-x229.google.com ([2607:f8b0:4002:c09::229]:36286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1cxSqX-0006Qd-RN
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:30:41 -0400
Received: by mail-yb0-x229.google.com with SMTP id i124so30803420ybc.3
	for <qemu-devel@nongnu.org>; Sun, 09 Apr 2017 23:30:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170410050759.12359.94192.malone@gac.canonical.com>
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
	<20170410050759.12359.94192.malone@gac.canonical.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 10 Apr 2017 14:30:40 +0800
Message-ID: <CAOGPPbc9Bw+fLSVFxTLh8XwfJM7tymsWT7b7vPHL_9CxTv5k1Q@mail.gmail.com>
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

On Mon, Apr 10, 2017 at 1:07 PM, wayen <1662050@bugs.launchpad.net> wrote:
> Hi Lidong Chen:
>     I used QEMU 2.0.0 on Ubuntu 14.04.
>     Do you mean your patch can make qemu-img convert qcow2 overlay into a new overlay?

yes. but i find it already fixed in 2.0.0.
do you add the -o backing_file= option in the command?

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
