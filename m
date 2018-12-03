Received: from eggs.gnu.org ([2001:4830:134:3::10]:45240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTnXF-0007R1-86
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTnIg-0007wF-1x
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:26:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTnIf-0007vf-TD
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:26:10 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-3-d.csapak@proxmox.com>
Date: Mon, 03 Dec 2018 13:26:07 +0100
In-Reply-To: <20181203092617.24090-3-d.csapak@proxmox.com> (Dominik Csapak's
	message of "Mon, 3 Dec 2018 10:26:16 +0100")
Message-ID: <87bm624x0g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qapi: Add reason to SHUTDOWN and
 RESET events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

Dominik Csapak <d.csapak@proxmox.com> writes:

> This makes it possible to determine what the exact reason was for
> a RESET or a SHUTDOWN. A management layer might need the specific reason
> of those events to determine which cleanups or other actions it needs to do.
>
> This patch also fixes the iotests to include the reason in the output.

This sounds as if iotests were broken somehow before this patch.  I'd
simply drop the sentence.  Not worth a respin, but if you have to respin
for some other reason...

> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
