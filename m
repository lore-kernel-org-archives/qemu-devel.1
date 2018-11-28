Received: from eggs.gnu.org ([2001:4830:134:3::10]:38056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS63F-0007gH-HL
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS63E-0001d1-MQ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:03:13 -0500
References: <20181128195802.B6A6C7456B9@zero.eik.bme.hu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2bdbd7b4-c1de-4ab4-7057-f87a535838e0@redhat.com>
Date: Wed, 28 Nov 2018 14:03:10 -0600
MIME-Version: 1.0
In-Reply-To: <20181128195802.B6A6C7456B9@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i2c: Move typedef of bitbang_i2c_interface
 to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 11/28/18 1:27 PM, BALATON Zoltan wrote:
> Clang 3.4 considers duplicate typedef in ppc4xx_i2c.h and
> bitbang_i2c.h an error even if they are identical. Move it to a common
> place to allow building with this clang version.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/i2c/bitbang_i2c.h        | 2 --
>   include/hw/i2c/i2c.h        | 2 ++
>   include/hw/i2c/ppc4xx_i2c.h | 3 ---
>   3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i2c/bitbang_i2c.h b/hw/i2c/bitbang_i2c.h
> index 3a7126d5de..9443021710 100644
> --- a/hw/i2c/bitbang_i2c.h
> +++ b/hw/i2c/bitbang_i2c.h
> @@ -3,8 +3,6 @@
>   
>   #include "hw/i2c/i2c.h"
>   
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;

Would this also be an opportunity to rename the struct to something 
CamelCase to match our coding conventions?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
