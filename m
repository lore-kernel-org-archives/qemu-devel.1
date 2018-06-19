Received: from eggs.gnu.org ([2001:4830:134:3::10]:36266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fV9yx-0002Wk-3C
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fV9yr-0006Bn-EQ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:19:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fV9yr-0006BG-9n
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:19:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4C67401EF00
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 06:19:04 +0000 (UTC)
Date: Tue, 19 Jun 2018 08:19:03 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180619061903.pmiy36kznlkpmanq@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180618161729.334-10-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/26] HACK: vhost-user-backend: allow
 to specify binary to execute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

On Mon, Jun 18, 2018 at 06:17:12PM +0200, Marc-Andr=E9 Lureau wrote:
> An executable with its arguments may be given as 'cmd' property, ex:
> -object vhost-user-backend,id=3Dvui,cmd=3D"./vhost-user-input
> /dev/input..". The executable is then spawn and, by convention, the
> vhost-user socket is passed as fd=3D3. It may be considered a security
> breach to allow creating processes that may execute arbitrary
> executables, so this may be restricted to some known executables (via
> signature etc) or directory.

Hmm, maybe let the device which uses vhost-user-backend handle this?

So you use "-device vhost-user-input-pci,device=3D/dev/input/$dev" and
vhost-user-input-pci translates that into ...
=20
  argv =3D { "$dir/vhost-user-input", "-device", "/dev/input/$dev", NULL =
}

... for vhost-user-backend ?

cheers,
  Gerd
