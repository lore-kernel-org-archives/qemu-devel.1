Received: from eggs.gnu.org ([2001:4830:134:3::10]:56242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dXq24-0003B9-95
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dXq22-0007QZ-Ki
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:32:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dXq22-0007Gq-Ep
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:32:54 -0400
Message-ID: <1500474339.29197.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Jul 2017 16:25:39 +0200
In-Reply-To: <CAJ+F1C+tNiGEkzC3aBf=_92oxb7NvG+UeYaUPLy9vKY8ym936g@mail.gmail.com>
References: <1500448182-21376-1-git-send-email-armbru@redhat.com>
	<CAJ+F1C+tNiGEkzC3aBf=_92oxb7NvG+UeYaUPLy9vKY8ym936g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vnc: Clarify documentation of QMP command
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

  Hi,

> The password would have to be NULL to disallow further login, is that
> what your other series will allow to do?

Disallow logins can be done using "expire-password vnc now".

I think having multiple ways to archive the same thing is a bad idea
from a security point of view, so I'd suggest to not touch the behavior
of the various set-password command variants.

cheers,
  Gerd
