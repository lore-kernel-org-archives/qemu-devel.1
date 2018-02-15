Received: from eggs.gnu.org ([2001:4830:134:3::10]:33288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKS9-0000lV-Gx
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKS6-0001IR-A9
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:24:01 -0500
References: <1518690027-31318-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518690027-31318-5-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b835989a-26d2-cb8d-d4a9-b8578f629387@redhat.com>
Date: Thu, 15 Feb 2018 08:23:51 -0600
MIME-Version: 1.0
In-Reply-To: <1518690027-31318-5-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 4/4] qemu-doc: deprecate query-cpus and
 info cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 02/15/2018 04:20 AM, Viktor Mihajlovski wrote:
> Start the deprecation period for QAPI query-cpus (replaced by
> query-cpus-fast) and HMP 'info cpus' (replaced by 'info cpus_fast')
> beginning with 2.12.0.

See my comments on 2/4 - if we want, we could just make HMP 'info cpus' 
be the fast version, with no slow version counterpart, right away 
without a deprecation period.  If we do that, then...

> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>   hmp-commands-info.hx |  4 ++--
>   qapi-schema.json     |  4 ++++
>   qemu-doc.texi        | 10 ++++++++++
>   3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 16ac602..2ccb9c7 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -149,14 +149,14 @@ ETEXI
>           .name       = "cpus",
>           .args_type  = "",
>           .params     = "",
> -        .help       = "show infos for each CPU",
> +        .help       = "show infos for each CPU (deprecated, use info cpus_fast instead)",

changes to this file no longer need to happen in this patch, and


> +++ b/qemu-doc.texi
> @@ -2757,6 +2757,12 @@ used and it will be removed with no replacement.
>   The ``convert -s snapshot_id_or_name'' argument is obsoleted
>   by the ``convert -l snapshot_param'' argument instead.
>   
> +@section System emulator monitor commands
> +
> +@subsection query-cpus (since 2.12.0)
> +
> +The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
> +
>   @section System emulator human monitor commands
>   
>   @subsection host_net_add (since 2.10.0)
> @@ -2767,6 +2773,10 @@ The ``host_net_add'' command is replaced by the ``netdev_add'' command.
>   
>   The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
>   
> +@subsection info cpus (since 2.12.0)
> +
> +The ``info cpus'' command is replaced by the ``info cpus_fast'' command.
> +

this hunk could be dropped.

But if we really want a deprecation period on the HMP side as well, then 
this patch is fine.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
