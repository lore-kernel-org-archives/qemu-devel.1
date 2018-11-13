Received: from eggs.gnu.org ([2001:4830:134:3::10]:36578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMVKS-0000eD-F1
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMVKR-0005QN-FK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:49:52 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMVKR-0005PO-0Y
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:49:51 -0500
Received: by mail-ot1-x341.google.com with SMTP id 40so10754240oth.4
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 01:49:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1542073341-2843-1-git-send-email-liq3ea@gmail.com>
References: <1542073341-2843-1-git-send-email-liq3ea@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 09:49:28 +0000
Message-ID: <CAFEAcA-GU85D_7kopc2s7GmTExsqSda0j73v2ecafr_FGKYBLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] memory: check write/read_with_attrs in
 memory dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13 November 2018 at 01:42, Li Qiang <liq3ea@gmail.com> wrote:
> This can avoid the NULL-deref if the rm doesn't has a
> read/write nor write/read_with_attrs callback.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  memory.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Alternative approach -- assert that every MemoryRegionOps has
pointers to callbacks in it, when it is registered in memory_region_init_io()
and memory_region_init_rom_device_nomigrate().

I don't have a strong opinion on which is better, but I guess
I slightly favour requiring devices to be specific about what
their read/write behaviour is.

Do we have many devices that legitimately only want to implement
one of read and write, not both ?

thanks
-- PMM
