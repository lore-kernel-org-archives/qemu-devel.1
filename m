Received: from eggs.gnu.org ([2001:4830:134:3::10]:49117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cSb-0006Xk-Al
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cSV-0003VR-Qp
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9cSS-0003UT-0N
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:48:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFCF53084022
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 20:48:50 +0000 (UTC)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-30-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9fd573a-8ab9-26b7-1c6e-a558f24daeff@redhat.com>
Date: Mon, 8 Oct 2018 15:48:49 -0500
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-30-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 29/31] vl: Assert drive_new() does not fail
 in default_drive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 10/8/18 12:31 PM, Markus Armbruster wrote:
> If creating (empty) default drives fails, it's a bug.  Therefore,
> assert() is more appropriate than exit(1).
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   vl.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

The assert disappears in the next patch (replaced by an &error_fatal), 
but the separation of patches makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
