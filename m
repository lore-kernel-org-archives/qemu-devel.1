Received: from eggs.gnu.org ([2001:4830:134:3::10]:34202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXSL3-0001A8-7T
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXSL0-0001zR-2d
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:51:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gXSKz-0001y8-Pn
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:51:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EA3D3082E46
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:51:40 +0000 (UTC)
Date: Thu, 13 Dec 2018 15:51:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181213155137.326718b7@redhat.com>
In-Reply-To: <20181213124224.31585-3-kchamart@redhat.com>
References: <20181213124224.31585-1-kchamart@redhat.com>
	<20181213124224.31585-3-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] Update that HMP 'cpu_add' is
 deprecated in 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, thuth@redhat.com

On Thu, 13 Dec 2018 13:42:23 +0100
Kashyap Chamarthy <kchamart@redhat.com> wrote:

> Also fix the wrong spelling of it: s/cpu-add/cpu_add/
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qemu-deprecated.texi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 46bec688db..79743ab8bd 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -121,9 +121,9 @@ replaced by the ``target'' output member.
>  The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
>  'hostfwd_remove' HMP commands has been replaced by @option{netdev_id}.
>  
> -@subsection cpu-add (since 3.1)
> +@subsection cpu_add (since 4.0)
>  
> -Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
> +Use ``device_add'' for hotplugging vCPUs instead of ``cpu_add''.  See
>  documentation of ``query-hotpluggable-cpus'' for additional details.
>  
>  @section System emulator devices
