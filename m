Received: from eggs.gnu.org ([2001:4830:134:3::10]:50584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY4qF-0005fa-3y
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY4qB-000704-CE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:26:15 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY4qB-0006xW-6G
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:26:11 -0400
Received: by mail-pl0-x243.google.com with SMTP id w17-v6so630444pll.9
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 00:26:11 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-38-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e45c5f02-bb42-2dc2-a898-32fef7fabee6@linaro.org>
Date: Wed, 27 Jun 2018 00:26:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-38-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 37/46] hw/vfio: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-trivial@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

On 06/25/2018 05:42 AM, Philippe Mathieu-Daudé wrote:
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
> 
> and modified manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/vfio/pci-quirks.c | 9 +++++----
>  hw/vfio/pci.c        | 3 ++-
>  2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
