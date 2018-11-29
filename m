Received: from eggs.gnu.org ([2001:4830:134:3::10]:49055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSHOC-0008Gj-6o
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSHO7-0006MJ-42
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:09:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gSHO6-0006JM-RJ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:09:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 261DD37EE0
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 08:09:30 +0000 (UTC)
Date: Thu, 29 Nov 2018 09:09:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181129080926.qyji6olhjqzkkcuz@sirius.home.kraxel.org>
References: <20181128155932.16171-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181128155932.16171-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3] configure: bump spice-server
 required version to 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, fziglio@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Nov 28, 2018 at 07:59:32PM +0400, Marc-Andr=E9 Lureau wrote:
> Looking at chardev/spice.c code, I realize compilation was broken for
> a while with spice-server < 0.12.3. Let's bump required version
> to 0.12.5, released May 19 2014, instead of adding more #ifdef.

Oh, you did the 0.12.5 patch already.  Scratch my other reply then.

> -  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
> +  if $pkg_config --atleast-version=3D0.12.5 spice-server && \
>       $pkg_config --atleast-version=3D0.12.3 spice-protocol && \

I think we should adjust spice-protocol too to whatever 0.12.5 requires
to build.

cheers,
  Gerd
