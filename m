Received: from eggs.gnu.org ([2001:4830:134:3::10]:45744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuNWs-0003Be-RN
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 15:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuNDP-0005FD-An
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 15:30:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fuNDP-0005Ew-5V
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 15:30:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E70AE26360
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 19:30:17 +0000 (UTC)
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-7-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b125dfa-2097-8dda-0de0-e72136391947@redhat.com>
Date: Mon, 27 Aug 2018 14:30:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180815133747.25032-7-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 06/13] qapi: remove COMMAND_DROPPED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 08/15/2018 08:37 AM, Peter Xu wrote:
> Now it was not used any more.  Drop it, especially if we can do that
> before we release QEMU 3.0.

Stale commit message, now that 3.0 has been released. But still doable, 
since the event could not be emitted without use of the experimental 
x-oob option.

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   docs/interop/qmp-spec.txt |  5 +++--
>   qapi/misc.json            | 40 ---------------------------------------
>   2 files changed, 3 insertions(+), 42 deletions(-)
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
