Received: from eggs.gnu.org ([209.51.188.92]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMOwZ-0007aL-D8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMOwX-0004cB-NG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:33:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMOwX-0004bv-HQ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:33:01 -0400
Received: by mail-pf1-x443.google.com with SMTP id g3so2181977pfi.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 20:33:01 -0700 (PDT)
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003650.10137-1-driver1998@foxmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45252654-7451-69ed-326e-9807f529de16@linaro.org>
Date: Thu, 2 May 2019 20:32:57 -0700
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

On 5/2/19 5:36 PM, Cao Jiaxi wrote:
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
> 


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
