Received: from eggs.gnu.org ([2001:4830:134:3::10]:49192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXXBP-0005SD-Ey
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXXBJ-0007YX-Ry
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:02:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXXBH-0007UV-LC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 15:02:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6492308213C
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 20:01:56 +0000 (UTC)
References: <20181213124224.31585-1-kchamart@redhat.com>
	<20181213124224.31585-2-kchamart@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e363547d-8717-91cc-89da-9c51412b5914@redhat.com>
Date: Thu, 13 Dec 2018 21:01:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181213124224.31585-2-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-deprecated.texi: Rename the HMP
 section
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
> So that it is consistent with the naming of QMP's
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  qemu-deprecated.texi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 72b8191d60..46bec688db 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -114,7 +114,7 @@ The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
>  The ``arch'' output member of the ``query-cpus-fast'' command is
>  replaced by the ``target'' output member.
>  
> -@section System emulator human monitor commands
> +@section Human Monitor Protocol (HMP) commands

Reviewed-by: Thomas Huth <thuth@redhat.com>
