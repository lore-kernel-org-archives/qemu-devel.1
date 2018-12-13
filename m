Received: from eggs.gnu.org ([2001:4830:134:3::10]:34625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXSM6-0001s3-LX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXSM4-0003ae-SN
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:52:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gXSM4-0003ZL-KH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:52:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BC5B356EC
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:52:47 +0000 (UTC)
Date: Thu, 13 Dec 2018 15:52:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181213155245.58747e85@redhat.com>
In-Reply-To: <20181213124224.31585-4-kchamart@redhat.com>
References: <20181213124224.31585-1-kchamart@redhat.com>
	<20181213124224.31585-4-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] Mention that QMP 'cpu-add' will be
 deprecated
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

On Thu, 13 Dec 2018 13:42:24 +0100
Kashyap Chamarthy <kchamart@redhat.com> wrote:

> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qemu-deprecated.texi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 79743ab8bd..2505e1f47f 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -114,6 +114,12 @@ The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
>  The ``arch'' output member of the ``query-cpus-fast'' command is
>  replaced by the ``target'' output member.
>  
> +@subsection cpu-add (since 4.0)
> +
> +Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
> +documentation of ``query-hotpluggable-cpus'' for additional
> +details.
> +
>  @section Human Monitor Protocol (HMP) commands
>  
>  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
