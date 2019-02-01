Received: from eggs.gnu.org ([209.51.188.92]:33039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpY26-00054a-2U
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpY25-00063j-Es
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:34:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpY25-00063B-95
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:34:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-4-lifei1214@126.com>
Date: Fri, 01 Feb 2019 13:34:52 +0100
In-Reply-To: <20190201051806.53183-4-lifei1214@126.com> (Fei Li's message of
	"Fri, 1 Feb 2019 13:17:58 +0800")
Message-ID: <87o97v7klv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 03/11] qemu_thread: supplement
 error handling for qmp_dump_guest_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Fei Li <fli@suse.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Fei Li <lifei1214@126.com> writes:

> From: Fei Li <fli@suse.com>
>
> Utilize the existed errp to propagate the error instead of the
> temporary &error_abort.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
