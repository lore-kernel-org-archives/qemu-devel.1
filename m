Received: from eggs.gnu.org ([2001:4830:134:3::10]:59286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB1B-00089K-T3
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB18-0001V1-Lh
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:26:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faB18-0001Uf-FY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:26:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C8A6805A530
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:26:10 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-26-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1e4862f-4fca-fa99-883a-e54ff32d0024@redhat.com>
Date: Mon, 2 Jul 2018 21:26:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-26-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 25/32] qmp: Replace get_qmp_greeting() by
 qmp_greeting()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> get_qmp_greeting() returns a QDict * as QObject *.  It's caller
> converts it right back.
> 
> Return QDict * instead.  While there, rename to qmp_greeting().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
