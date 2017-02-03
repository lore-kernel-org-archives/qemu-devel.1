Received: from eggs.gnu.org ([2001:4830:134:3::10]:49468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZabK-00015q-Uq
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZabG-0006s1-Up
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:56:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZabG-0006qz-OP
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:56:14 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D03513B713
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 09:56:14 +0000 (UTC)
Message-ID: <1486115771.16444.18.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Feb 2017 10:56:11 +0100
In-Reply-To: <1486115213-24250-1-git-send-email-abologna@redhat.com>
References: <1486115213-24250-1-git-send-email-abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4] q35: Improve sample configuration files
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

On Fr, 2017-02-03 at 10:46 +0100, Andrea Bolognani wrote:
> Instead of having a single sample configuration file,
> we now have several:
>=20
>   * q35-emulated.cfg documents the default devices QEMU
>     adds to a q35 guest and the additional devices that
>     are pretty much guaranteed to be present in a
>     physical q35-based machine;
>=20
>   * q35-virtio-graphical.cfg can be used to start a
>     fully-featured (USB, graphical console, audio, etc.)
>     guest that uses VirtIO instead of emulated devices;
>=20
>   * q35-virtio-serial.cfg is similar but has a minimal
>     set of devices and uses the serial console.
>=20
> All configuration files are fully commented and neatly
> organized.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
