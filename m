Received: from eggs.gnu.org ([2001:4830:134:3::10]:40465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuUqA-0004Bg-Ra
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuUq6-0003NM-SD
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:38:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fuUq6-0003NA-NG
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:38:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A4C420E19
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 03:38:46 +0000 (UTC)
Date: Tue, 28 Aug 2018 11:38:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180828033838.GC4446@xz-x1>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-7-peterx@redhat.com>
	<6b125dfa-2097-8dda-0de0-e72136391947@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b125dfa-2097-8dda-0de0-e72136391947@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 06/13] qapi: remove COMMAND_DROPPED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Aug 27, 2018 at 02:30:12PM -0500, Eric Blake wrote:
> On 08/15/2018 08:37 AM, Peter Xu wrote:
> > Now it was not used any more.  Drop it, especially if we can do that
> > before we release QEMU 3.0.
> 
> Stale commit message, now that 3.0 has been released. But still doable,
> since the event could not be emitted without use of the experimental x-oob
> option.

Fixed:

    Now it was not used any more, drop it.  We can still do that since
    out-of-band is still experimental, and this event is only used when
    out-of-band is enabled.

Thanks,

-- 
Peter Xu
