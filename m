Received: from eggs.gnu.org ([2001:4830:134:3::10]:33860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9nHP-00013y-TZ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 04:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9nHM-0000DO-Q9
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 04:22:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9nHM-0000Bq-J2
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 04:22:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id n11-v6so672099wru.13
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 01:22:08 -0700 (PDT)
References: <1539068913-3796-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ac397e6c-6302-0aad-c0da-a878be8e5463@redhat.com>
Date: Tue, 9 Oct 2018 10:22:05 +0200
MIME-Version: 1.0
In-Reply-To: <1539068913-3796-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Rom: change Rom's 'isrom' to bool type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

On 09/10/2018 09:08, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/core/loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index aa0b3fc867..910f9a97a9 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -837,7 +837,7 @@ struct Rom {
>      uint8_t *data;
>      MemoryRegion *mr;
>      AddressSpace *as;
> -    int isrom;
> +    bool isrom;
>      char *fw_dir;
>      char *fw_file;
>  
> 
