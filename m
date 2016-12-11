Received: from eggs.gnu.org ([2001:4830:134:3::10]:50809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cG9tG-0007il-Iw
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 14:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cG9tD-0000b8-HY
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 14:34:30 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cG9tD-0000at-Ca
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 14:34:27 -0500
Received: by mail-oi0-f44.google.com with SMTP id y198so69020203oia.1
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 11:34:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lgvm1dvz.fsf@gmail.com>
References: <87lgvm1dvz.fsf@gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sun, 11 Dec 2016 14:32:55 -0500
Message-ID: <CAJhHMCDYONA6S_FF6aMy-A_WM=N4cKzQqaiG+4D2HFWFNKL3dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] aarch64-linux-user compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Sun, Dec 11, 2016 at 2:09 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Hi,
>
> I am getting a strange compilation error lately for aarch64-linux-user. I
> think it is somehow related to TYPE_PTRVOID handling but my investigation has
> not led to anything concrete. I think this is a compiler error since the build
> passes on an other system with gcc-6.
>
> Info: ubuntu 16.04 x86_64 system
>
> $ gcc --version
> gcc (Ubuntu 5.4.1-2ubuntu1~16.04) 5.4.1 20160904
>

The issue occurs even with a newer gcc.

$ gcc --version
gcc (Ubuntu 6.2.0-3ubuntu11~16.04) 6.2.0 20160901

-- 
Pranith
