Received: from eggs.gnu.org ([2001:4830:134:3::10]:42549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ccfwX-00027T-7d
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 17:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ccfwU-0003BI-30
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 17:14:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ccfwT-0003BB-TM
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 17:14:54 -0500
Date: Sat, 11 Feb 2017 23:14:49 +0100
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170211221449.GA18702@thinpad.lan.raisama.net>
References: <1485916178-17838-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485916178-17838-1-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v3] vl: Move the
 cpu_synchronize_all_post_init() after generic devices initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org

On Wed, Feb 01, 2017 at 10:29:38AM +0800, Dou Liyang wrote:
> At the Qemu initialization, we call the cpu_synchronize_all_post_init()
> to synchronize All CPU states to KVM in the ./vl.c::main().
> 
> Currently, it is called before we initialize the CPUs, which is created
> by "-device" command and parsed by generic devices initialization, So,
> these CPUs may be ignored to synchronize.
> 
> The patch moves the cpu_synchronize_all_post_init func after generic
> devices initialization to make sure that all the CPUs can be included.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I will be away from work during the next 10 days, so anybody
willing to merge this gets my:

Acked-by: Eduardo Habkost <ehabkost@redhat.com>


> ---
> Change log:
> v2-> v3:
> 1. Rebase the patch.
> 2. Rewrite the log
> v1-> v2:
> 1. Split it from
> https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03354.html
> 2. Rewrite the log.
> 
>  vl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 0b72b12..bceb835 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4490,8 +4490,6 @@ int main(int argc, char **argv, char **envp)
>  
>      audio_init();
>  
> -    cpu_synchronize_all_post_init();
> -
>      if (hax_enabled()) {
>          hax_sync_vcpus();
>      }
> @@ -4517,6 +4515,8 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      }
>  
> +    cpu_synchronize_all_post_init();
> +
>      numa_post_machine_init();
>  
>      rom_reset_order_override();
> -- 
> 2.5.5
> 
> 
> 
> 

-- 
Eduardo
