Received: from eggs.gnu.org ([2001:4830:134:3::10]:58636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evT4B-000349-Rs
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evT4A-0000L8-T3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:25:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evT4A-0000Kp-OC
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:25:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B43D8182D2A
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 19:25:02 +0000 (UTC)
Date: Mon, 12 Mar 2018 19:24:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312192458.GD15677@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180312185503.5746-1-ehabkost@redhat.com>
	<20180312185503.5746-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312185503.5746-4-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] device-crash-test: Use 'python' binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Mon, Mar 12, 2018 at 03:55:03PM -0300, Eduardo Habkost wrote:
> Now the script works with Python 3, so we can use the 'python'
> binary provided by the system.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/device-crash-test | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index 36194e4347..7e79a8d885 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python2.7
> +#!/usr/bin/env python
>  #
>  #  Copyright (c) 2017 Red Hat Inc
>  #

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
