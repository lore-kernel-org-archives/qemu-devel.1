Received: from eggs.gnu.org ([2001:4830:134:3::10]:51348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZJPy-00033N-4k
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZJPx-0008Fi-EH
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:35:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cZJPx-0008Fd-8q
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:35:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 377FC3B722
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 15:35:25 +0000 (UTC)
Message-ID: <1486049722.3484.25.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 02 Feb 2017 16:35:22 +0100
In-Reply-To: <1486047322.20628.42.camel@redhat.com>
References: <1486046738-26059-1-git-send-email-abologna@redhat.com>
	<1486047322.20628.42.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, drjones@redhat.com

On Thu, 2017-02-02 at 15:55 +0100, Gerd Hoffmann wrote:
> > +++ b/docs/q35-emulated.cfg
> >=C2=A0
> > +#=C2=A0=C2=A0=C2=A000:01.0 VGA compatible controller
> >=C2=A0
> > +[device "video"]
> > +=C2=A0=C2=A0driver =3D "VGA"
> > +=C2=A0=C2=A0bus =3D "pcie.0"
> > +=C2=A0=C2=A0addr =3D "02.0"
>=C2=A0
> Here is a address mismatch ;)

Oh, wait, I realize where the mismatch comes from now:
on real hardware (my laptop) the video card is plugged
into 00:02.0, but the default one you get when you don't
pass -nodefault to QEMU is plugged into 00:01.0!

I think we should use 00:02.0, do you agree? I would
also use the same slot in q35-virtio-graphical.cfg.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
