Received: from eggs.gnu.org ([2001:4830:134:3::10]:55479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD5a1-000159-Gp
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD5Zw-0003Co-BG
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:31:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gD5Zw-00038h-4P
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:30:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so4870937wmf.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 03:30:55 -0700 (PDT)
References: <1539828637-2907-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e9bbeddd-1fb5-daa5-635d-7ca1b0104dfa@redhat.com>
Date: Thu, 18 Oct 2018 12:30:50 +0200
MIME-Version: 1.0
In-Reply-To: <1539828637-2907-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qga: fix an off-by-one issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org

Missed in a3ef3b2272d.

On 18/10/2018 04:10, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Nice catch btw.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  qga/commands-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 98d9735..e3842d1 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -465,7 +465,7 @@ static STORAGE_BUS_TYPE win2qemu[] = {
>  
>  static GuestDiskBusType find_bus_type(STORAGE_BUS_TYPE bus)
>  {
> -    if (bus > ARRAY_SIZE(win2qemu) || (int)bus < 0) {
> +    if (bus >= ARRAY_SIZE(win2qemu) || (int)bus < 0) {
>          return GUEST_DISK_BUS_TYPE_UNKNOWN;
>      }
>      return win2qemu[(int)bus];
> 
