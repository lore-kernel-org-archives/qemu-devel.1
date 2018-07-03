Received: from eggs.gnu.org ([2001:4830:134:3::10]:60979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB5C-0002Kl-Il
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB5B-0003bX-GF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:30:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faB5B-0003aq-0O
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:30:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93E2EBD9E
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:30:20 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-30-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8fd5c32-f3eb-2f16-2d0f-dce43655b817@redhat.com>
Date: Mon, 2 Jul 2018 21:30:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-30-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 29/32] qobject: Let qobject_from_jsonf()
 fail instead of abort
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
> qobject_from_jsonf() aborts on error, unlike qobject_from_jsonv(),
> which returns null.  Since all remaining users of qobject_from_jsonf()
> cope fine with null, change it to return null.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/qjson.c | 5 -----
>   1 file changed, 5 deletions(-)
> 

Nice that we're finally gaining some symmetry between the ... and 
va_list forms.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
