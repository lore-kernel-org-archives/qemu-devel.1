Received: from eggs.gnu.org ([2001:4830:134:3::10]:46334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFJey-0005cP-5H
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFJev-0004Vs-1Q
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:20:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFJeu-0004VZ-Rt
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:20:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D596761B80
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 12:20:27 +0000 (UTC)
Message-ID: <1496060426.5201.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 May 2017 14:20:26 +0200
In-Reply-To: <20170522123325.2199-1-lprosek@redhat.com>
References: <20170522123325.2199-1-lprosek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] usb-hub: set PORT_STAT_C_SUSPEND on
 host-initiated wake-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org

On Mon, 2017-05-22 at 14:33 +0200, Ladi Prosek wrote:
> PORT_STAT_C_SUSPEND should be set even on host-initiated wake-up,
> i.e. on ClearPortFeature(PORT_SUSPEND). Windows is known to not
> work properly otherwise.
>=20
> Side note, since PORT_ENABLE looks similar and might appear to
> have the same issue: According to 11.24.2.7.2.2 C_PORT_ENABLE:
>=20
> =C2=A0 "This bit is set when the PORT_ENABLE bit changes from one to
> =C2=A0 zero as a result of a Port Error condition (see Section 11.8.1).
> =C2=A0 This bit is not set on any other changes to PORT_ENABLE."
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>

Added to usb queue.

thanks,
  Gerd
