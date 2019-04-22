Received: from eggs.gnu.org ([209.51.188.92]:59812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhIk-0005eV-MC
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhIj-0000Fa-QB
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIhIj-0000F1-KR
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so8605481wrs.11
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 15:20:37 -0700 (PDT)
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-4-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c1aa85de-849d-fe69-2059-244c2bb3e197@redhat.com>
Date: Tue, 23 Apr 2019 00:20:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190422210448.2488-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] accel: Remove unused
 AccelClass::available field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 4/22/19 11:04 PM, Eduardo Habkost wrote:
> The field is not used anymore, we can remove it.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
mingw64:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/sysemu/accel.h | 1 -
>  accel/accel.c          | 5 -----
>  2 files changed, 6 deletions(-)
> 
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 5565e00a96..70e9e2f2a1 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -38,7 +38,6 @@ typedef struct AccelClass {
>  
>      const char *opt_name;
>      const char *name;
> -    int (*available)(void);
>      int (*init_machine)(MachineState *ms);
>      void (*setup_post)(MachineState *ms, AccelState *accel);
>      bool *allowed;
> diff --git a/accel/accel.c b/accel/accel.c
> index 454fef9d92..5fa31717b4 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -107,11 +107,6 @@ void configure_accelerator(MachineState *ms, const char *progname)
>          if (!acc) {
>              continue;
>          }
> -        if (acc->available && !acc->available()) {
> -            printf("%s not supported for this target\n",
> -                   acc->name);
> -            continue;
> -        }
>          ret = accel_init_machine(acc, ms);
>          if (ret < 0) {
>              init_failed = true;
> 
