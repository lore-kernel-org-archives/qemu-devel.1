Received: from eggs.gnu.org ([2001:4830:134:3::10]:56122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2IQb-0002MP-G4
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2IQX-0007A2-FK
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:56:09 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:56238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2IQX-00079K-9A
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:56:05 -0400
Received: by mail-wm0-x22b.google.com with SMTP id u138so5620072wmu.4
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 07:56:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507710805-221721-1-git-send-email-imammedo@redhat.com>
References: <1507710805-221721-1-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 15:55:43 +0100
Message-ID: <CAFEAcA9gO1XZOsmKXi0fLwKUDorTgvLgkHZuMtZPyhzhBzC98w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] arm: fix armv7m_init() declaration to
 match definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11 October 2017 at 09:33, Igor Mammedov <imammedo@redhat.com> wrote:
> s/cpu_model/cpu_type/ that has been forgotten during
> conversion (ba1ba5cc), while touching the line also
> fixup alignment.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/arm/arm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
> index a3f79d3..ce769bd 100644
> --- a/include/hw/arm/arm.h
> +++ b/include/hw/arm/arm.h
> @@ -25,7 +25,7 @@ typedef enum {
>
>  /* armv7m.c */
>  DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
> -                      const char *kernel_filename, const char *cpu_model);
> +                         const char *kernel_filename, const char *cpu_type);
>  /**
>   * armv7m_load_kernel:
>   * @cpu: CPU
> --
> 2.7.4



Applied to target-arm.next, thanks.

-- PMM
