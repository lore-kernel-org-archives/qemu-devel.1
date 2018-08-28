Received: from eggs.gnu.org ([2001:4830:134:3::10]:34131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujXu-0006uO-Ke
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujIq-0001hc-5X
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:05:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fujIn-0001bh-Hn
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:05:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A338807A13D
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:05:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
Date: Tue, 28 Aug 2018 21:05:15 +0200
In-Reply-To: <20180815133747.25032-1-peterx@redhat.com> (Peter Xu's message of
	"Wed, 15 Aug 2018 21:37:34 +0800")
Message-ID: <87a7p6l3bo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 00/13] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Hi, Markus, Marc-Andre,
>
> I didn't follow up the latest discussions on the response queue or
> monitor changes.  For now this series still makes sense to me, so I'm
> just rebasing the series to master and repost (with some additional
> changes/patches to address Markus's concerns). Please let me know if
> you have made any conclusion that I'm not aware of, or if this work
> needs any further rebasing.
>
> v6 (previous version of the series might be incorrect; from this
> version, I continued to use the old version counts):
> - collect r-bs
> - use Markus's version of build_params() [Markus]
> - use \' instead of \" in Python codes [Markus]
> - in qapi_event_send_*() still pass in &error_abort instead of NULL
>   [Markus]
> - remove COMMAND_DROPPED from document too
> - add missing pieces for test-qmp-cmds [Markus]
> - add one patch to remove as much different code path for oob as
>   possible [Markus]
>
> TODO:
> - flow control test is still missing; I still didn't consider it much,
>   also we possibly need to touch up monitor_puts() to use limited
>   sized buffer to complete the flow control of QMP channel
>
> Please review.  Thanks,

PATCH 01-03 queued.  Thanks!
