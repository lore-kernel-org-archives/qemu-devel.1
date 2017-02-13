Received: from eggs.gnu.org ([2001:4830:134:3::10]:42905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdGXh-0003VP-K9
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdGXg-0004sz-Lq
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:19:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cdGXg-0004sn-FY
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:19:44 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7417480F8E
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:19:44 +0000 (UTC)
Message-ID: <1486991981.19677.16.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Feb 2017 14:19:41 +0100
In-Reply-To: <d039b4d9-4c9a-ed49-dd36-304b290a013b@redhat.com>
References: <1486722439-12033-1-git-send-email-abologna@redhat.com>
	<1486723086-12247-1-git-send-email-abologna@redhat.com>
	<1486723086-12247-2-git-send-email-abologna@redhat.com>
	<d039b4d9-4c9a-ed49-dd36-304b290a013b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, marcel@redhat.com, drjones@redhat.com

  Hi,

> Clearly, for reviewing both files, I applied your patches, and then
> diffed the two files created by this patch. :)
>=20
> So, what speaks against adding "-serial mon:stdio" here too? Even with a
> graphical guest, the monitor is useful. And, if you care about firmware
> logs (who doesn't? ;)), seeing serial output is good. (Same applies to
> the guest kernel -- sooner or later everyone enables serial output for
> grub2 and kernel, for reporting bugs.)

Depends on the target audience.  I'd expect users don't care much,
developers probably do.

Yes, most of my virtual machines have a serial console too, even if they
boot into graphic mode.  If I screwed up graphics with a bad virtio-gpu
patch it is very useful to have serial console to figure what exactly
broke ...

> * I'm a *huge* fan of saving disk space on the host. So, thin
> provisioning FTW! Virtio-scsi is definitely a step in the right
> direction, but for the disk drive, please add these wo properties:
>=20
>   discard =3D "unmap"
>   werror =3D "enospc"

Good idea!

cheers,
  Gerd
