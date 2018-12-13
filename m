Received: from eggs.gnu.org ([2001:4830:134:3::10]:50224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXXDz-0007lX-VQ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXXDx-0000e7-1N
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:04:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXXDu-0000Zv-KI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:04:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE6263097023
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 20:04:33 +0000 (UTC)
References: <20181213124224.31585-1-kchamart@redhat.com>
	<20181213124224.31585-4-kchamart@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4652b1a-cb7d-6dd3-a624-8455369b8323@redhat.com>
Date: Thu, 13 Dec 2018 21:04:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181213124224.31585-4-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com

On 2018-12-13 13:42, Kashyap Chamarthy wrote:
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
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
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
