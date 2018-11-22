Received: from eggs.gnu.org ([2001:4830:134:3::10]:51823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPtfr-0002nB-Tz
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPtfp-00015h-TK
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:25:59 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:40406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPtfk-0000z8-28
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:25:54 -0500
Received: by mail-ot1-x336.google.com with SMTP id s5so8749586oth.7
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 10:25:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181122182335.9038-1-pbonzini@redhat.com>
References: <20181122182335.9038-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 18:25:28 +0000
Message-ID: <CAFEAcA8B6o57ZD8VktwLqTkE_BKidjMv0LyVoRjc+rJzuCVjqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] nvme: fix CMB endianness confusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On 22 November 2018 at 18:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The CMB is marked as DEVICE_LITTLE_ENDIAN, so the data must be
> read/written as if it was little-endian output (in the case of
> big endian, we get two swaps, one in the memory core and one
> in nvme.c).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/block/nvme.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Tested-by: Peter Maydell <peter.maydell@linaro.org>

This is sufficient to get the nvme-test to pass on sparc
(big-endian host).

thanks
-- PMM
