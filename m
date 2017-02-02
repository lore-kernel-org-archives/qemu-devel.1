Received: from eggs.gnu.org ([2001:4830:134:3::10]:44118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZC95-0000x6-MN
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 02:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZC92-0007pk-NI
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 02:49:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZC92-0007p0-HC
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 02:49:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AED4C04B935
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 07:49:28 +0000 (UTC)
Message-ID: <1486021764.20628.29.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 02 Feb 2017 08:49:24 +0100
In-Reply-To: <1485969640-8149-1-git-send-email-abologna@redhat.com>
References: <1485969640-8149-1-git-send-email-abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, drjones@redhat.com

  Hi,

>   * Document more devices:
>     - the video card is added by default;
>     - so is the Ethernet adapter, apparently.
>=20
> The last part seems to clash with some of Gerd's comments,
> so I'm kinda puzzled.

Oh yes, the wonderful confusing world of default devices ;)

So, if you run qemu with "-nodefaults" it will not add those two
devices.

If you add a video card manually (via -device or config file entry) qemu
will not add the default video card.

Likewise, if you add a NIC manually, qemu will not add the default
ethernet device (and IIRC creating the default netdev will be skipped
too).

cheers,
  Gerd
