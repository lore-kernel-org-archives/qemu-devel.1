Received: from eggs.gnu.org ([2001:4830:134:3::10]:57257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDUaT-0007Jg-7z
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gDUaN-0004gr-I9
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:13:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gDUaN-0004gP-8V
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:13:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAD59461D0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 13:13:01 +0000 (UTC)
References: <20181019123923.26649-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd958bd4-5f04-b65e-6c9d-e66e6680f7d9@redhat.com>
Date: Fri, 19 Oct 2018 08:13:00 -0500
MIME-Version: 1.0
In-Reply-To: <20181019123923.26649-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] error: Drop bogus "use error_setg()
 instead" admonitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 10/19/18 7:39 AM, Markus Armbruster wrote:
> Commit 97f40301f1d "error: Functions to report warnings and
> informational messages" copied the "use error_setg() instead"
> admonition from the error reporting functions to new functions even
> though it doesn't actually apply there.  Drop it.  Also drop it from
> vreport(), where it doesn't apply anymore.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/qemu-error.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
