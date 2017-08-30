Received: from eggs.gnu.org ([2001:4830:134:3::10]:48995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn4En-0005hm-MB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn4El-0006s0-3Y
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:45:01 -0400
References: <1504099475-241036-9-git-send-email-imammedo@redhat.com>
	<1504103170-259479-1-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e877e8ca-8e4f-f102-9b51-a29df8c1db7d@redhat.com>
Date: Wed, 30 Aug 2017 16:44:53 +0200
MIME-Version: 1.0
In-Reply-To: <1504103170-259479-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 9/8] fixup! ppc: remove non
 implemented cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 30.08.2017 16:26, Igor Mammedov wrote:
> only TODO escaped defines were meant to be removed,
> but not TODO_USER_ONLY which are compiled in case of
> *-user targets.
> 
> So retirn back "440" model removed by mistake
> 
> Spotted-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/ppc/cpu-models.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 611fc1b..08fb34b 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -150,6 +150,10 @@
>      POWERPC_DEF("x2vp20",        CPU_POWERPC_X2VP20,                 405,
>                  NULL)
>      /* PowerPC 440 family                                                    */
> +#if defined(TODO_USER_ONLY)
> +    POWERPC_DEF("440",           CPU_POWERPC_440,                    440GP,
> +                "Generic PowerPC 440")
> +#endif
>      /* PowerPC 440 cores                                                     */
>      POWERPC_DEF("440-xilinx",    CPU_POWERPC_440_XILINX,             440x5,
>                  "PowerPC 440 Xilinx 5")
> 

With this fixup patch added:

Reviewed-by: Thomas Huth <thuth@redhat.com>
