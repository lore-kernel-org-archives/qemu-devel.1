Received: from eggs.gnu.org ([2001:4830:134:3::10]:52907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJI0-0005BC-Lr
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJHz-0001gZ-SW
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:47:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gVJHz-0001ep-Ky
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:47:43 -0500
References: <20181207131732.21073-1-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e6f1c89-90d3-8582-a6fa-550a2691c35e@redhat.com>
Date: Fri, 7 Dec 2018 10:47:40 -0600
MIME-Version: 1.0
In-Reply-To: <20181207131732.21073-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] scsi-disk: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 12/7/18 7:17 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/scsi/scsi-disk.c  | 105 +++++++++++++++++++++----------------------
>   hw/scsi/trace-events |  29 ++++++++++++
>   2 files changed, 81 insertions(+), 53 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 0e9027c8f3..29e541efdb 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -19,15 +19,6 @@
>    * the host adapter emulator.
>    */
>   
> -//#define DEBUG_SCSI
> -
> -#ifdef DEBUG_SCSI
> -#define DPRINTF(fmt, ...) \
> -do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
> -

Yay for getting rid of yet another bit-rottable debug statement.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
