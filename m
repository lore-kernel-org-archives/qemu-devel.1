Received: from eggs.gnu.org ([2001:4830:134:3::10]:50228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f0ntm-0001VU-Qb
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f0ntj-0001yX-JH
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:40:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f0ntU-0001nl-8l
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:40:19 -0400
Date: Tue, 27 Mar 2018 13:40:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180327124000.GJ4005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hmp.c: Revert hmp_info_cpus output format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sathnaga@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Tue, Mar 27, 2018 at 06:08:00PM +0530, sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> 
> This commit 137b5cb6ab565cb3781d5337591e155932b4230e
> refactors info cpus output and changes output format from
> 'thread_id' to 'thread-id', this would break parsing
> of output in above layers like libvirt, test framework etc.

Libvirt doesn't use HMP, only QMP, so this shouldn't have broken libvirt
afaik.  HMP is not intended to be a stable API so these kind of changes
should be expected.

> 
> This patch just reverts back output format to 'thread_id'.
> 
> CC: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> ---
>  hmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 679467d85a..a25c7bd9a8 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -381,7 +381,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>  
>          monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
>                         cpu->value->cpu_index);
> -        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
> +        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
>      }
>  
>      qapi_free_CpuInfoFastList(cpu_list);
> -- 
> 2.14.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
