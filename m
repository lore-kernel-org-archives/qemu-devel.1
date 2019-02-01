Received: from eggs.gnu.org ([209.51.188.92]:53645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpZQI-0002PJ-60
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpZQC-0006A2-SI
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:04:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpZQC-0005d4-JP
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:03:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-8-lifei1214@126.com>
Date: Fri, 01 Feb 2019 15:03:07 +0100
In-Reply-To: <20190201051806.53183-8-lifei1214@126.com> (Fei Li's message of
	"Fri, 1 Feb 2019 13:18:02 +0800")
Message-ID: <877eej7gis.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 07/11] qemu_thread: supplement
 error handling for iothread_complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>

Fei Li <lifei1214@126.com> writes:

> From: Fei Li <fli@suse.com>
>
> For iothread_complete: utilize the existed errp to propagate the

"For iothread_complete" is redundant, isn't it?

> error and do the corresponding cleanup to replace the temporary
> &error_abort.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
