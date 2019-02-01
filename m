Received: from eggs.gnu.org ([209.51.188.92]:56968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpZZ7-0006MD-Uo
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpZZ7-0003im-6C
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:13:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpZZ6-0003gy-MB
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:13:08 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-9-lifei1214@126.com>
Date: Fri, 01 Feb 2019 15:13:06 +0100
In-Reply-To: <20190201051806.53183-9-lifei1214@126.com> (Fei Li's message of
	"Fri, 1 Feb 2019 13:18:03 +0800")
Message-ID: <87imy361hp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 08/11] qemu_thread: supplement
 error handling for qemu_signalfd_compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com

Fei Li <lifei1214@126.com> writes:

> From: Fei Li <shirley17fei@gmail.com>
>
> For qemu_signalfd_compat: set errno, do some cleanup, and return

"For iothread_complete" is redundant, isn't it?

> -1 to replace the temporary &error_abort when failing to create
> sigwait_compat.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Fei Li <shirley17fei@gmail.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
