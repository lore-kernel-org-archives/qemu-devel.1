Received: from eggs.gnu.org ([2001:4830:134:3::10]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faArh-0004nc-Lp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faArg-0005vf-S1
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:16:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faArg-0005vZ-M2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:16:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54F8587A87
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:16:24 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-22-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d4fb6f8-c871-ef4f-f87d-3358bd60f075@redhat.com>
Date: Mon, 2 Jul 2018 21:16:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-22-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/32] qobject: New
 qdict_from_jsonf_nofail()
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
> Many uses of qobject_from_jsonf() convert JSON objects.  Create new
> convenience function qdict_from_jsonf_nofail() that includes the
> conversion to QDict.  The next few commits will put it to use.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/qjson.h |  2 ++
>   qobject/qjson.c          | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
