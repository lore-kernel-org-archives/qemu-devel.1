Received: from eggs.gnu.org ([209.51.188.92]:54193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hCVaB-0005bN-2j
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hCVa4-0008Qt-0h
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:36:58 -0400
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <ce68c2dc-857a-aff0-0fb7-a8e48e921c54@redhat.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
	<ce68c2dc-857a-aff0-0fb7-a8e48e921c54@redhat.com>
Message-ID: <155449613359.3739.8673708328232350625@sif>
Date: Fri, 05 Apr 2019 15:28:53 -0500
Subject: Re: [Qemu-devel] [PATCH 00/97] Patch Round-up for stable 3.0.1,
 freeze on 2019-04-08
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>, Hannes Reinecke <hare@suse.com>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Quoting Philippe Mathieu-Daud=C3=A9 (2019-04-04 17:31:31)
> On 4/1/19 10:58 PM, Michael Roth wrote:
> > Hi everyone,                                                           =
                                   =

> > =

> > The following new patches are queued for QEMU stable v3.0.1:
> > =

> >   https://github.com/mdroth/qemu/commits/stable-3.0-staging
> > =

> > The release is planned for 2019-04-11:
> > =

> >   https://wiki.qemu.org/Planning/3.0
...
> =

> I'm not sure about 4c257911dcc7c4189768e9651755c849ce9db4e8
> "i386: remove the 'INTEL_PT' CPUID bit from named CPU models"

AFAICT this was only enabled by default via Icelake-*, Cascadelake-Server
models, which are only in 3.1+. I have it queued for 3.1.1 though.

> =

> What about 334c43e2c342e878311c66b4e62343f0a7c2c6be?
> "qemu-img: fix error reporting for -object"

Looks like this fixes a regression introduced in 3.1 with 7e1e0c11, I'll
make sure to queue it for 3.1.1 though.

> =

> Also ade0075523478fa015afd5c6f6cc70681687818d:
> "contrib/rdmacm-mux: Fix out-of-bounds risk"

Fixes regression introduced in 4.0 with a5d2f6f8773

> =

> And 3fd2092fd11b9e4220a08eca0663cc59178a6c3f:
> "hw/usb: fix mistaken de-initialization of CCID state"


Fixes regression introduced in 4.0 with 7dea29e4

> =

> Eventually:
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00843.html
> "megasas: fix mapped frame size"

Hopefully it makes it in by rc3 next week, otherwise we'd need to delay
3.0.1 to pick it up. Will keep it eye on it.

Thanks for the suggestions!

> =

> Regards,
> =

> Phil.
>=20
