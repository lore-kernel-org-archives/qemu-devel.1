Received: from eggs.gnu.org ([2001:4830:134:3::10]:40600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNCWF-0002jq-5M
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 02:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNCWA-0005K1-VH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 02:56:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNCWA-0005DK-Ov
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 02:56:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4BFFC05D3F4
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 07:56:40 +0000 (UTC)
Date: Thu, 15 Nov 2018 08:56:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181115075637.3lentc3rdn5jlnhd@sirius.home.kraxel.org>
References: <20180420104743.7396-1-kraxel@redhat.com>
	<3f72757a-4b4c-9241-dd8f-561886cf3295@redhat.com>
	<a17f8629-e628-3b3d-f964-98bcb9b218f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17f8629-e628-3b3d-f964-98bcb9b218f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] simple firmware.json test tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

  Hi,

> > Perhaps print a few shell commands first? Such as:
> > 
> >    (
> >      VARSTORE=$(mktemp)
> >      trap 'rm -f -- "$VARSTORE"' EXIT
> >      cat -- '[VARSTORE_TEMPLATE]' >> "$VARSTORE"
> >      qemu ...
> >    )
> > 
> > It really does take separate actions, just like when you create a new
> > disk image with "qemu-img".

> Any plan to respin this patch?

-ENOTIME[1].  Also no really good idea how to handle varstore.

I'd like to have something simple, so it is easy run qemu with the
correct arguments.  Just ...

  qemu-system-$arch $(qemu-firmware /path/to/firmware.json)

... would be cool, but varstore handling isn't going to fly that way.

Maybe we really have to print some shell commands and set some specific
variables, so one can do something like this:

  eval $(qemu-firmware /path/to/firmware.json)
  qemu-system-${QEMU_FIRMWARE_ARCH} ${QEMU_FIRMWARE_ARGS}

cheers,
  Gerd

[1] feel free to pick it up.
