Received: from eggs.gnu.org ([2001:4830:134:3::10]:40152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlnT-0004hI-6J
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlnO-00082V-AC
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:29:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fPlnO-00081a-4S
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:28:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48D6E68819
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 09:28:57 +0000 (UTC)
Date: Mon, 4 Jun 2018 11:28:56 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180604092856.zdjepzaylmqcxrmv@sirius.home.kraxel.org>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180601162749.27406-11-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 10/12] vhost-user: add
 vhost_user_gpu_set_socket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Jun 01, 2018 at 06:27:47PM +0200, Marc-Andr=E9 Lureau wrote:
> Add a new vhost-user message to give a unix socket for gpu updates to
> a vhost-user backend.
>=20
> Back when I started that work, I added a new GPU channel because the
> vhost-user protocol wasn't bidirectional. Since then, there is a
> vhost-user-slave channel for the slave to send requests to the master.
> We could extend it with GPU messages. However, the GPU protocol is
> quite orthogonal to vhost-user=20

Yes.

> and may not need the same kind of
> stability guarantees,

Why?

> thus I recommend to have a new dedicated
> channel.
>=20
> FIXME: document the GPU protocol.

Yes, please.

cheers,
  Gerd
