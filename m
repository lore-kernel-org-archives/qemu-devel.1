Received: from eggs.gnu.org ([2001:4830:134:3::10]:35956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaRY-0000UY-Je
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaRU-0007pF-Jg
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:27:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecaRU-0007oy-DE
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:27:04 -0500
Date: Fri, 19 Jan 2018 15:26:55 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119172655.GC15832@localhost.localdomain>
References: <20171114102246.22221-1-apahim@redhat.com>
	<20171114102246.22221-2-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114102246.22221-2-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/8] qemu.py: remove unused import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, crosa@redhat.com, muriloo@linux.vnet.ibm.com

On Tue, Nov 14, 2017 at 11:22:39AM +0100, Amador Pahim wrote:
> Removing 'import sys' as it's not used anywhere.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Queued on python-next.  Thanks, and sorry for taking 2 months to
do it.

> ---
>  scripts/qemu.py | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 9bfdf6d37d..65d9ad688c 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -15,7 +15,6 @@
>  import errno
>  import logging
>  import os
> -import sys
>  import subprocess
>  import qmp.qmp
>  
> -- 
> 2.13.6
> 
> 

-- 
Eduardo
