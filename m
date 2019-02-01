Received: from eggs.gnu.org ([209.51.188.92]:58835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpVee-0007Fv-8E
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpVec-0000j0-Ss
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:02:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpVec-0000iM-NP
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:02:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-2-lifei1214@126.com>
Date: Fri, 01 Feb 2019 11:02:30 +0100
In-Reply-To: <20190201051806.53183-2-lifei1214@126.com> (Fei Li's message of
	"Fri, 1 Feb 2019 13:17:56 +0800")
Message-ID: <87a7jf9689.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 01/11] qemu_thread: make
 qemu_thread_create() take Error ** argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Fei Li <fli@suse.com>, Paolo Bonzini <pbonzini@redhat.com>

Fei Li <lifei1214@126.com> writes:

> From: Fei Li <fli@suse.com>
>
> qemu_thread_create() abort()s on error. Not nice. Give it a return
> value and an Error ** argument, so it can return success/failure.
>
> Considering qemu_thread_create() is quite widely used in qemu, split
> this into two steps: this patch passes the &error_abort to
> qemu_thread_create() everywhere, and the next 10 patches will improve
> on &error_abort for callers who need.  To differentiate callers who
> need the improvement, temporarily add the "TODO:" comment for them.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
