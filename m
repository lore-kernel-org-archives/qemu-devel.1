Received: from eggs.gnu.org ([2001:4830:134:3::10]:38348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgXnp-00047i-Tf
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgXnk-0004IL-VF
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:21:57 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgXnk-0004IF-RG
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:21:52 -0500
Received: by mail-qk0-x244.google.com with SMTP id x71so605459qkb.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:21:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
	<20170220095734.7890-2-cornelia.huck@de.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4c4e4544-f425-6c74-f2d4-8b12311c3c1c@amsat.org>
Date: Wed, 22 Feb 2017 11:21:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170220095734.7890-2-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/12] s390x/s390-virtio: get rid of DPRINTF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, agraf@suse.de

On 02/20/2017 06:57 AM, Cornelia Huck wrote:
> The DPRINTF approach is likely to introduce bitrot, and the preferred
> way for debugging is tracing anyway. Fortunately, there are no users
> (left), so nuke it.
>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/s390x/s390-virtio.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
> index 7a3a7fe5fd..9cfb09057e 100644
> --- a/hw/s390x/s390-virtio.c
> +++ b/hw/s390x/s390-virtio.c
> @@ -44,16 +44,6 @@
>  #include "hw/s390x/ipl.h"
>  #include "cpu.h"
>
> -//#define DEBUG_S390
> -
> -#ifdef DEBUG_S390
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
>  #define MAX_BLK_DEVS                    10
>
>  #define S390_TOD_CLOCK_VALUE_MISSING    0x00
>
