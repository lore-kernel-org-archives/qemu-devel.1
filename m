Received: from eggs.gnu.org ([2001:4830:134:3::10]:48801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1comDq-0003an-7a
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 03:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1comDn-0006EM-Jr
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 03:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1comDn-0006EA-E6
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 03:22:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83A4D8051A
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 07:22:47 +0000 (UTC)
Message-ID: <1489735363.854.0.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Mar 2017 08:22:43 +0100
In-Reply-To: <1489734595-14749-1-git-send-email-kraxel@redhat.com>
References: <1489734595-14749-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] ich9: add tco reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Fr, 2017-03-17 at 08:09 +0100, Gerd Hoffmann wrote:
> Without that the nmi watchdog fires after reboot and the
> linux kernel is confused where the nmi comes from:
>=20
>    Uhhuh. NMI received for unknown reason 20 on CPU 0.
>    Do you have a strange power saving mode enabled?
>    Dazed and confused, but trying to continue

Oops scratch that.  Patch not working, must be something else, didn't
manage to root-cause this one yet ...

cheers,
  Gerd
