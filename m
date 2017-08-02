Received: from eggs.gnu.org ([2001:4830:134:3::10]:41712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dcozb-0001nj-2r
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dcozW-0004OZ-1x
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:26:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dcozV-0004Mj-Ro
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:26:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFB6D1CD0AC
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 08:26:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1501644321-17721-3-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 2 Aug 2017 11:25:21 +0800")
References: <1501644321-17721-1-git-send-email-peterx@redhat.com>
	<1501644321-17721-3-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 02 Aug 2017 10:26:49 +0200
Message-ID: <87379agyt2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] io: fix qio_channel_socket_accept err
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> When accept failed, we should setup errp with the reason. More
> importantly, the caller may assume errp be non-NULL when error happens,
> and not setting the errp may crash QEMU.
>
> At the same time, move the trace_qio_channel_socket_accept_fail() after
> the if check on EINTR. Two reasons:
>
> 1. when EINTR happened, it's not really a fault (we should just try
>    again), so we should not log with an "accept failure".
>
> 2. trace_*() functions may overwrite errno, then the old errno will be
>    missing. We need to either check errno before trace_*() calls, or
>    reserve the errno.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
