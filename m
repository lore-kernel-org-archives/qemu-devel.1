Received: from eggs.gnu.org ([209.51.188.92]:34260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glsf3-0006DO-4c
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glsf0-0000YL-3c
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:47:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1glsez-0000WN-EJ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:47:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BC45C01A693
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:47:56 +0000 (UTC)
Date: Tue, 22 Jan 2019 09:47:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122094748.GD13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190122092814.14919-1-kraxel@redhat.com>
	<20190122092814.14919-7-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122092814.14919-7-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 6/8] kbd-state: use state tracker
 for vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Jan 22, 2019 at 10:28:12AM +0100, Gerd Hoffmann wrote:
> Use the new keyboard state tracked for vnc.  Allows to drop the
> vnc-specific modifier state tracking code.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/vnc.h |   5 ++-
>  ui/vnc.c | 120 ++++++++++++++++++-------------------------------------=
--------
>  2 files changed, 35 insertions(+), 90 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
