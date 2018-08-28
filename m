Received: from eggs.gnu.org ([2001:4830:134:3::10]:39064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuUje-0007LP-Ds
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuUjZ-0005Qv-Eq
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:32:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fuUjZ-0005Qk-99
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:32:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D948E87A82
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 03:32:00 +0000 (UTC)
Date: Tue, 28 Aug 2018 11:31:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180828033154.GB4446@xz-x1>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-4-peterx@redhat.com>
	<87tvngt3a6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvngt3a6.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v6 03/13] qapi: remove error checks for
 event emission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Aug 27, 2018 at 02:14:25PM +0200, Markus Armbruster wrote:

[...]

> Let's improve the commit message a bit.  Here's my try:
> 
>     qapi: Drop qapi_event_send_FOO()'s Error ** argument
> 
>     The generated qapi_event_send_FOO() take an Error ** argument.  They
>     can't actually fail, because all they do with the argument is passing it
>     to functions that can't fail: the QObject output visitor, and the
>     @qmp_emit callback, which is either monitor_qapi_event_queue() or
>     event_test_emit().
> 
>     Drop the argument, and pass &error_abort to the QObject output visitor
>     and @qmp_emit instead.

I'm stealing this into my local tree.

> 
> With something like that:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks for the analysis and r-b; stealing the r-b too.

-- 
Peter Xu
