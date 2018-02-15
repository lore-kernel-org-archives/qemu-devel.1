Received: from eggs.gnu.org ([2001:4830:134:3::10]:33572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1emOCt-0005lE-Ar
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1emOCq-0007tv-5m
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:24:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1emOCq-0007tX-0x
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:24:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8697540744C6
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 18:24:22 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
References: <20180215102602.10864-1-berrange@redhat.com>
Date: Thu, 15 Feb 2018 13:24:14 -0500
In-Reply-To: <20180215102602.10864-1-berrange@redhat.com> ("Daniel
	P. \=\?utf-8\?Q\?Berrang\=C3\=A9\=22's\?\= message of "Thu,
	15 Feb 2018 10:26:02 +0000")
Message-ID: <jpglgfucdrl.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: remove bogus object_unref on client
 socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> vnc_listen_io() does not own the reference on the 'cioc' parameter is it
> passed, so should not be unref'ing it.
>
> Reported-by: Bandan Das <bsd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Daniel, wouldn't a Fixes: 13e1d0e71e78a925848258391a6e616b6b5ae219
be helpful here ?

> ---
>  ui/vnc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index c715bae1cf..b97769aa9e 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3152,7 +3152,6 @@ static void vnc_listen_io(QIONetListener *listener,
>                           isWebsock ? "vnc-ws-server" : "vnc-server");
>      qio_channel_set_delay(QIO_CHANNEL(cioc), false);
>      vnc_connect(vd, cioc, false, isWebsock);
> -    object_unref(OBJECT(cioc));
>  }
>=20=20
>  static const DisplayChangeListenerOps dcl_ops =3D {
