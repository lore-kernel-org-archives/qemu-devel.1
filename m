Received: from eggs.gnu.org ([209.51.188.92]:57632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr2Wl-0005IM-QQ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr2Wg-0000SB-47
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:20:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gr2We-0000IP-1v
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:20:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so4121606wmt.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 07:20:28 -0800 (PST)
References: <1549371525-29899-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <91c92519-2eb4-a769-7bff-9cd7b8b5c919@redhat.com>
Date: Tue, 5 Feb 2019 16:20:25 +0100
MIME-Version: 1.0
In-Reply-To: <1549371525-29899-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/cpu/cluster: Mark the cpu-cluster
 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc.michel@greensocs.com>

On 2/5/19 1:58 PM, Thomas Huth wrote:
> The device can not be instantiated by the user and QEMU currently
> aborts when you try to use it:
> 
> $ x86_64-softmmu/qemu-system-x86_64 -device cpu-cluster
> qemu-system-x86_64: hw/cpu/cluster.c:73: cpu_cluster_realize:
>  Assertion `cbdata.cpu_count > 0' failed.
> Aborted (core dumped)
> 
> Since this is an internal device only, mark it with user_creatable = false.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/cpu/cluster.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
> index 25f9070..6f5f037 100644
> --- a/hw/cpu/cluster.c
> +++ b/hw/cpu/cluster.c
> @@ -79,6 +79,9 @@ static void cpu_cluster_class_init(ObjectClass *klass, void *data)
>  
>      dc->props = cpu_cluster_properties;
>      dc->realize = cpu_cluster_realize;
> +
> +    /* This is not directly for users, CPU children must be attached by code */
> +    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo cpu_cluster_type_info = {
> 
