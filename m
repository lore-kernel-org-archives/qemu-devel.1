Received: from eggs.gnu.org ([2001:4830:134:3::10]:41617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFgJx-0000zv-6M
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFgJw-0004jJ-DT
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:36:53 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:44641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fFgJw-0004iv-7A
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:36:52 -0400
Received: by mail-oi0-x22a.google.com with SMTP id e80-v6so25087480oig.11
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 06:36:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180507121126.gjeufzppsc7qspgm@sirius.home.kraxel.org>
References: <20180507101013.32736-1-kraxel@redhat.com>
	<CAFEAcA-a74RLKXi=v7w-8v9h6A_QFSKeNxK64AvCYKxc_VN+uA@mail.gmail.com>
	<20180507121126.gjeufzppsc7qspgm@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 May 2018 14:36:30 +0100
Message-ID: <CAFEAcA_hgd7P5fjgqpc00_PzoAdMzBuABombyAnk4ej6a2itoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vga: print friendly error message in case
 multiple vga devices are added
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

On 7 May 2018 at 13:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> This seems like a bit of an irritating reason to refuse to
>> allow multiple VGA devices though, since we could make
>> them work by having the vmstate be not-global.
>
> Multiple vga devices will also try to use the same isa vga
> ports.  Seems that doesn't make qemu abort any more, which
> used to happen in older versions.

Oh, good point. Shouldn't we be checking for that on
some other thing than whether global_vmstate is set here,
though? Otherwise it won't work consistently for the
vga devices which pass 'false'.

thanks
-- PMM
