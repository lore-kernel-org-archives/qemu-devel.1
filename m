Received: from eggs.gnu.org ([2001:4830:134:3::10]:33601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEaCj-0001TZ-3A
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEaCg-0002Td-12
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:52:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEaCf-0002S1-S6
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:52:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CCC781A88C3
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 12:52:46 +0000 (UTC)
References: <20180504054241.6833-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0616c04-9db3-58a9-997d-da1055718e51@redhat.com>
Date: Fri, 4 May 2018 07:52:43 -0500
MIME-Version: 1.0
In-Reply-To: <20180504054241.6833-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Revert "Makefile: add target to print
 generated files"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>

On 05/04/2018 12:42 AM, Markus Armbruster wrote:
> This reverts commit 9578f8cc3e8bd71de8e3f543dc7b95644d64824e.
> 
> The patch snuck in by accident without having been posted to
> qemu-devel.  It's entirely redundant: existing target print-% already
> serves the purpose.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   Makefile | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/Makefile b/Makefile
> index d71dd5bea4..f36110d4aa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1047,9 +1047,6 @@ endif
>   include $(SRC_PATH)/tests/docker/Makefile.include
>   include $(SRC_PATH)/tests/vm/Makefile.include
>   
> -printgen:
> -	@echo $(GENERATED_FILES)
> -
>   .PHONY: help
>   help:
>   	@echo  'Generic targets:'
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
