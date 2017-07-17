Received: from eggs.gnu.org ([2001:4830:134:3::10]:33609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX9UQ-0004Jl-1c
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX9UL-0002g4-W4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:07:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX9UL-0002fc-Pq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:07:17 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1500279971-13875-9-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 17 Jul 2017 16:26:08 +0800")
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-9-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 19:07:06 +0200
Message-ID: <87zic3youd.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 08/11] migration: remove check against
 colo support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hailiang Zhang <zhang.zhanghailiang@huawei.com>

Peter Xu <peterx@redhat.com> wrote:
> Since commit a15215f3 ("build: remove --enable-colo/--disable-colo"),
> colo is always supported. We don't need any colo_supported() now since
> it is always true. Removing any extra code that depends on it.
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
