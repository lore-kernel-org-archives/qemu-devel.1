Received: from eggs.gnu.org ([2001:4830:134:3::10]:45771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTESy-00072J-03
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 17:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTESx-0006mO-98
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 17:37:40 -0400
References: <20170607063555.7374-1-marcandre.lureau@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5c87e2bf-898e-221d-2b96-31147dd85c8a@redhat.com>
Date: Thu, 6 Jul 2017 17:37:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170607063555.7374-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iscsi: use scsi_create_task()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


On 06/07/2017 02:35 AM, Marc-Andr=C3=A9 Lureau wrote:
> The function does the same initialization, and matches with
> scsi_free_scsi_task() usage, and qemu doesn't need to know the
> allocator details.
>=20

Happy month-iversary for this patch!

Yeah, uh, we should probably not be reaching into this structure
ourselves, huh? I had to look up the iscsi source just to confirm that
we /were/ doing the right thing, but now we won't have to worry about it.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

This should be care of... Ronnie, Paolo, and Peter Lieven?
