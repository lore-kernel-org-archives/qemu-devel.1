Received: from eggs.gnu.org ([2001:4830:134:3::10]:44451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cakGh-0004Cq-FJ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cakGe-0006Hr-FD
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:27:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cakGe-0006He-9B
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:27:44 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79AB16AAF2
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 14:27:44 +0000 (UTC)
Message-ID: <1486391261.32329.25.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 06 Feb 2017 15:27:41 +0100
In-Reply-To: <20170203120649.15637-1-berrange@redhat.com>
References: <20170203120649.15637-1-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Support multiple listening sockets
 per VNC server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Fr, 2017-02-03 at 12:06 +0000, Daniel P. Berrange wrote:
> Followup to
>=20
>  v2:
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg04951.html
>=20
> There are two core feature changes in this series
>=20
>  - If a DNS name resolves to multiple distinct IP addresses,
>    the VNC server is now able to listen on all of them
>=20
>  - The -vnc argument syntax is extended to allow the 'vnc'
>    and 'websocket' arguments to be listed multiple times.
>    This allows a single VNC server to listen on multiple
>    different names / addresses.
>=20
> The io/ patch series that this previously depended on is now merged
> in git master.

Added to ui patch queue.

thanks,
  Gerd
