Received: from eggs.gnu.org ([2001:4830:134:3::10]:48899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZJFj-0001Yu-2x
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZJFd-00046Y-Rk
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:24:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cZJFd-00046I-M2
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:24:45 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B60B881231
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 15:24:45 +0000 (UTC)
Message-ID: <1486049083.3484.23.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 02 Feb 2017 16:24:43 +0100
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
>=C2=A0
> Otherwise looks all fine to me.

Good catch! I'll fix it and wait for input on the questions
raised by Marcel before sending out a v4 :)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
