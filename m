Received: from eggs.gnu.org ([2001:4830:134:3::10]:34734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZZRB-0004xx-Lj
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZZRA-0003sK-I8
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cZZRA-0003rx-Bn
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 03:41:44 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 678D5883A6
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 08:41:44 +0000 (UTC)
Message-ID: <1486111301.3484.29.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 03 Feb 2017 09:41:41 +0100
In-Reply-To: <1486073234.20628.51.camel@redhat.com>
References: <1486046738-26059-1-git-send-email-abologna@redhat.com>
	<1486047322.20628.42.camel@redhat.com>
	<1486049722.3484.25.camel@redhat.com>
	<1486073234.20628.51.camel@redhat.com>
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

On Thu, 2017-02-02 at 23:07 +0100, Gerd Hoffmann wrote:
> > Oh, wait, I realize where the mismatch comes from now:
> > on real hardware (my laptop) the video card is plugged
> > into 00:02.0, but the default one you get when you don't
> > pass -nodefault to QEMU is plugged into 00:01.0!
>=C2=A0
> And that depends on the chipset.=C2=A0=C2=A0On q35 it is 01.0, whereas =
on pc it is
> 02.0 because 01.0 is occupied by the piix southbridge.
>=C2=A0
> > I think we should use 00:02.0, do you agree? I would
> > also use the same slot in q35-virtio-graphical.cfg.
>=C2=A0
> Matter of taste really.=C2=A0=C2=A0I have some guests where the vga is =
at 04.0,
> works fine too.=C2=A0=C2=A0But being consistent across all configuratio=
ns makes
> sense.

Cool, I will stick to 00:01.0 across the board then.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
