Received: from eggs.gnu.org ([2001:4830:134:3::10]:40236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1fzKe9-0004YU-FW
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1fzKca-0002j9-1p
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:44:51 -0400
References: <1536566979-6868-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <738a767d-1f9e-57ea-0cdc-d98d71f4df2a@suse.de>
Date: Mon, 10 Sep 2018 13:44:44 +0200
MIME-Version: 1.0
In-Reply-To: <1536566979-6868-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/qdev-core: Fix description of
 instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Am 10.09.18 um 10:09 schrieb Thomas Huth:
> The part of the documentation of DeviceClass that talks about instance_=
init
> is partly wrong: instance_init() functions must not abort or exit, sinc=
e
> the function is also called during introspection of the device already.
> So if a device calls exit() during its instance_init() function, QEMU
> terminates unexpectedly if somebody tries to just have a look at the
> interfaces from the device with "device_add xyz,help" or with the
> "device-list-properties" QOM command. This should never happen.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Andreas F=C3=A4rber <afaerber@suse.de>

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
