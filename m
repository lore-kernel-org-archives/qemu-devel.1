Received: from eggs.gnu.org ([209.51.188.92]:38578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpYS9-0007TI-1A
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpYS6-0002xh-IC
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpYS6-0002wG-8d
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-6-lifei1214@126.com>
Date: Fri, 01 Feb 2019 14:01:42 +0100
In-Reply-To: <20190201051806.53183-6-lifei1214@126.com> (Fei Li's message of
	"Fri, 1 Feb 2019 13:18:00 +0800")
Message-ID: <87ftt77jd5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 05/11] qemu_thread: supplement
 error handling for h_resize_hpt_prepare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, David Gibson <david@gibson.dropbear.id.au>

Fei Li <lifei1214@126.com> writes:

> From: Fei Li <fli@suse.com>
>
> Add a local_err to hold the error, and return the corresponding
> error code to replace the temporary &error_abort.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Fei Li <fli@suse.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
