Received: from eggs.gnu.org ([209.51.188.92]:56544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gx78w-0007DG-FL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gx78v-0005Vg-52
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:29:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gx78u-0005TZ-IL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:29:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C67693082E07
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 09:29:15 +0000 (UTC)
References: <20190222031413.20250-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c74698e-3d3b-be12-1f60-cacf0c3421ef@redhat.com>
Date: Fri, 22 Feb 2019 10:28:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190222031413.20250-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] iothread: create gcontext
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>

On 22/02/19 04:14, Peter Xu wrote:
> And if this patchset can survive... how about running gcontext
> directly in iothread_run()?  I believe there could be a bit more
> things to clean but I'll see.

Do you mean instead of aio_poll?  The problem is that GMainContext is
quite a bit slower than aio_poll.

Frediano and I tried to bring some of the optimizations of aio_poll to
GMainContext
(https://github.com/GNOME/glib/commit/e91c11841808ccca408da96136f433a82b2e2145),
but they broke webkit. :(

Paolo
