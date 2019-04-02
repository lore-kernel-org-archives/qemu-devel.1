Received: from eggs.gnu.org ([209.51.188.92]:59330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hBDtx-0004t2-EW
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hBDnX-0003aj-GN
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:25:33 -0400
References: <1554184537-35011-1-git-send-email-like.xu@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <63b183f2-9876-7c2c-d4b4-1e27aecd4869@redhat.com>
Date: Tue, 2 Apr 2019 09:16:06 +0200
MIME-Version: 1.0
In-Reply-To: <1554184537-35011-1-git-send-email-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl.c: make current_machine as non-global
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 02/04/2019 07.55, Like Xu wrote:
> This patch makes the remaining dozen or so uses of the global
> current_machine outside vl.c use qdev_get_machine() instead,
> and then make current_machine local to vl.c instead of global.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
[...]
> --- a/vl.c
> +++ b/vl.c
> @@ -1265,6 +1265,8 @@ static QemuOptsList qemu_smp_opts = {
>      },
>  };
>  
> +MachineState *current_machine;

To be sure that it is only used here, could you please also make the
variable "static"?

 Thanks,
  Thomas


> +
>  static void smp_parse(QemuOpts *opts)
>  {
>      if (opts) {
> @@ -1462,8 +1464,6 @@ static int usb_parse(const char *cmdline)
>  /***********************************************************/
>  /* machine registration */
>  
> -MachineState *current_machine;
> -
>  static MachineClass *find_machine(const char *name)
>  {
>      GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
> 
