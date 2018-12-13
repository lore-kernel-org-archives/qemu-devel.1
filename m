Received: from eggs.gnu.org ([2001:4830:134:3::10]:55373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXS0b-0005Ot-Q2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXS0X-0002CM-I4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:30:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gXS0X-0002Bh-Aw
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:30:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CF6730043FA
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:30:32 +0000 (UTC)
Date: Thu, 13 Dec 2018 14:30:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181213143027.GK5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181213142719.592-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213142719.592-1-cfergeau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Dec 13, 2018 at 03:27:19PM +0100, Christophe Fergeau wrote:
> This commit adds a qemu_init_logging() helper which calls
> g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
> are handled similarly to other QEMU logs. This means they will get a
> timestamp if timestamps are enabled, and they will go through the
> monitor if one is configured.
> This commit also adds a call to qemu_init_logging() to the binaries
> installed by QEMU.
> glib debug messages are enabled through G_MESSAGES_DEBUG similarly to
> glib default log handler.
>=20
> At the moment, this change will mostly impact SPICE logging if your
> spice version is >=3D 0.14.1. With older spice versions, this is not go=
ing
> to work as expected, but will not have any ill effect, so this call is
> not conditional on the SPICE version.
>=20
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>

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
