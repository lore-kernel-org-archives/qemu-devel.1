Received: from eggs.gnu.org ([2001:4830:134:3::10]:58052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIbcI-0003Qr-8m
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIbcE-0000e3-2F
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:11:54 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIbcD-0000dv-Qq
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:11:49 -0400
Received: by mail-wr0-x241.google.com with SMTP id a12-v6so509337wrn.13
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:11:49 -0700 (PDT)
References: <20180515134835.3409-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180515134835.3409-1-peter.maydell@linaro.org>
Date: Tue, 15 May 2018 16:11:47 +0100
Message-ID: <8736yteyx8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory.h: Fix typo in documentation comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/memory.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 525619a5f4..4fa1227f13 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -679,7 +679,7 @@ void memory_region_init_rom_device_nomigrate(MemoryRe=
gion *mr,
>   * memory_region_init_reservation: Initialize a memory region that reser=
ves
>   *                                 I/O space.
>   *
> - * A reservation region primariy serves debugging purposes.  It claims I=
/O
> + * A reservation region primarily serves debugging purposes.  It claims =
I/O
>   * space that is not supposed to be handled by QEMU itself.  Any access =
via
>   * the memory API will cause an abort().
>   * This function is deprecated. Use memory_region_init_io() with NULL

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
