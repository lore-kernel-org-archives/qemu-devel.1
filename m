Received: from eggs.gnu.org ([2001:4830:134:3::10]:38819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f76t7-0006g2-0R
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f76t6-0000TA-7q
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 18:09:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180413164545.18409-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <87db1aab-1bcb-7ba8-f871-017b7a9c0f6c@amsat.org>
Date: Fri, 13 Apr 2018 19:09:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180413164545.18409-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] acpi: fix a comment about aml_call0()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 04/13/2018 01:45 PM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/acpi/aml-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 3fa557cea1..1e43cd736d 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -627,7 +627,7 @@ Aml *aml_notify(Aml *arg1, Aml *arg2)
>      return var;
>  }
>  
> -/* helper to call method with 1 argument */
> +/* helper to call method without argument */
>  Aml *aml_call0(const char *method)
>  {
>      Aml *var = aml_alloc();
> 
