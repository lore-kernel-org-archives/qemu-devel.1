Received: from eggs.gnu.org ([209.51.188.92]:44987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gytLj-0001Uy-ED
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 02:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gytLf-0002tS-N1
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 02:09:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gytLf-0002se-1c
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 02:09:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190220154253.26982-1-marcandre.lureau@redhat.com>
Date: Wed, 27 Feb 2019 08:09:41 +0100
In-Reply-To: <20190220154253.26982-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 20 Feb 2019 16:42:51 +0100")
Message-ID: <877edlogga.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] Misc QGA/monitor QMP improvements
 (resend)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> I have those 2 simplification patches left which were part of previous
> series. They are still worthwhile imho.

They are.

> Thanks
>
> Marc-Andr=C3=A9 Lureau (2):
>   qga: process_event() simplification
>   qmp: common 'id' handling & make QGA conform to QMP spec

PATCH 1 is qga only.  PATCH 2 simplifies the common monitor core, but
observable change is again qga only.  Mike, care to take these patches
through your tree?
