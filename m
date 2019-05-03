Received: from eggs.gnu.org ([209.51.188.92]:47548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMQRq-0001PB-JK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMQRp-00057V-LZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:09:26 -0400
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003650.10137-1-driver1998@foxmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3d707ff-0fa6-7f2a-014b-97946c00fd9d@redhat.com>
Date: Fri, 3 May 2019 07:09:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190503003650.10137-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qga: Fix mingw compilation warnings
 on enum conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>

On 03/05/2019 02.36, Cao Jiaxi wrote:
> The win2qemu[] is supposed to be the conversion table to convert between
> STORAGE_BUS_TYPE in Windows SDK and GuestDiskBusType in qga.
> 
> But it was incorrectly written that it forces to set a GuestDiskBusType
> value to STORAGE_BUS_TYPE, which generates an enum conversion warning in clang.
> 
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  qga/commands-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index d40d61f605..6b67f16faf 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -457,7 +457,7 @@ void qmp_guest_file_flush(int64_t handle, Error **errp)
>  
>  #ifdef CONFIG_QGA_NTDDSCSI
>  
> -static STORAGE_BUS_TYPE win2qemu[] = {
> +static GuestDiskBusType win2qemu[] = {
>      [BusTypeUnknown] = GUEST_DISK_BUS_TYPE_UNKNOWN,
>      [BusTypeScsi] = GUEST_DISK_BUS_TYPE_SCSI,
>      [BusTypeAtapi] = GUEST_DISK_BUS_TYPE_IDE,

Reviewed-by: Thomas Huth <thuth@redhat.com>
