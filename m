Received: from eggs.gnu.org ([2001:4830:134:3::10]:58053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccD4g-0004eP-4T
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccD4f-0000G5-3b
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:25:26 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccD4e-0000Fy-SF
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:25:25 -0500
Received: by mail-wr0-x22f.google.com with SMTP id i10so110462683wrb.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 07:25:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170207183356.17840-1-laurent@vivier.eu>
References: <20170207183356.17840-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 15:25:03 +0000
Message-ID: <CAFEAcA_XuEA01Cnsdd7Wq-ueH0zqjcinNasW-wkJ-Us3M_MkRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/5] risu: add m68k target support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2017 at 18:33, Laurent Vivier <laurent@vivier.eu> wrote:
> This series add the files needed to test the m68k target.
>
> For the moment, it doesn't support FPU instructions.
>
> Laurent Vivier (5):
>   m68k: implement risugen module
>   m68k: implement server and client side
>   m68k: add risufile with m68k instructions.
>   m68k: add instruction needing an extended word
>   m68k: manage memory block

Thanks for this; I think patches 1-3 are good, and have
applied them to risu master. For 4 I wonder if we can
find a better way of handling variable-length instruction
sets than !post, and I haven't yet looked at 5.

thanks
-- PMM
