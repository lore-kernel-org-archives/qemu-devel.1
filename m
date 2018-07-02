Received: from eggs.gnu.org ([2001:4830:134:3::10]:49896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa6cC-0005OG-A7
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa6c9-0002fD-7p
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:44:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa6c9-0002es-2e
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:44:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BC57406E1D6
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 21:44:04 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-10-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0c0c1df-b783-9f1e-a868-411c67cb002c@redhat.com>
Date: Mon, 2 Jul 2018 16:44:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/32] qmp qemu-ga: Revert change that
 accidentally made qemu-ga accept "id"
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

On 07/02/2018 11:21 AM, Markus Armbruster wrote:
> Commit cf869d53172 "qmp: support out-of-band (oob) execution" changed
> how we check "id":
> 
>      Note that in the patch I exported qmp_dispatch_check_obj() to be
>      used to check the request earlier, and at the same time allowed
>      "id" field to be there since actually we always allow that.
> 
> The part after "and" is ill-advised: it makes qemu-ga accept and
> ignore "id".  Revert.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c           | 14 ++++++++------
>   qapi/qmp-dispatch.c |  2 --
>   tests/test-qga.c    | 10 +++++-----
>   3 files changed, 13 insertions(+), 13 deletions(-)
> 

It might be nicer to teach qga to reply with id. But for the purposes of 
fixing regressions, this is reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
