Received: from eggs.gnu.org ([209.51.188.92]:57956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpZby-00085E-Ok
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpZbx-0005ZI-Ri
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:16:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpZbx-0005YI-J8
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:16:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-11-lifei1214@126.com>
Date: Fri, 01 Feb 2019 15:16:00 +0100
In-Reply-To: <20190201051806.53183-11-lifei1214@126.com> (Fei Li's message of
	"Fri, 1 Feb 2019 13:18:05 +0800")
Message-ID: <87ef8r61cv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 10/11] qemu_thread: supplement
 error handling for vnc_start_worker_thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Fei Li <fli@suse.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Fei Li <lifei1214@126.com> writes:

> From: Fei Li <fli@suse.com>
>
> Supplement the error handling for vnc_thread_worker_thread: add
> an Error parameter for it to propagate the error to its caller to
> handle in case it fails, and make it return a Boolean to indicate
> whether it succeeds.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
