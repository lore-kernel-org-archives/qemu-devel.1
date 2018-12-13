Received: from eggs.gnu.org ([2001:4830:134:3::10]:49870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXXCn-0006uU-R2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXXCi-0008QL-R1
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:03:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXXCi-0008Pc-CY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:03:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3827E307D91A
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 20:03:27 +0000 (UTC)
References: <20181213124224.31585-1-kchamart@redhat.com>
	<20181213124224.31585-3-kchamart@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2ce67a1c-caaf-cac1-1374-c09da3c4e472@redhat.com>
Date: Thu, 13 Dec 2018 21:03:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181213124224.31585-3-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com

On 2018-12-13 13:42, Kashyap Chamarthy wrote:
> Also fix the wrong spelling of it: s/cpu-add/cpu_add/
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
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

AFAIK the spelling was right. It's "cpu-add" ... only device_add is
using the underscore. Welcome to the wonderful world of QEMU
inconsistencies...

 Thomas
