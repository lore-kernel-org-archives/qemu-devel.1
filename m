Received: from eggs.gnu.org ([2001:4830:134:3::10]:53824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZz5v-0006Kx-5A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZz5r-0006EO-TG
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:10:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZz5r-0006DY-NZ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:09:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F18A083F44
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:09:58 +0000 (UTC)
Date: Fri, 12 Jan 2018 14:09:34 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112130934.pyofdpke76ttupcm@sirius.home.kraxel.org>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-39-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180111213250.16511-39-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 38/51] qapi: add conditions to SPICE
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 11, 2018 at 10:32:37PM +0100, Marc-Andr=E9 Lureau wrote:
> Add #if defined(CONFIG_SPICE) in generated code, and adjust the
> qmp/hmp code accordingly.
>=20
> query-qmp-schema no longer reports the command/events etc as
> available when disabled at compile time.
>=20
> Commands made conditional:
>=20
> * query-spice
>=20
>   Before the patch, the command for !CONFIG_SPICE is unregistered. It
>   will fail with the same error.
>=20
> Events made conditional:
>=20
> * SPICE_CONNECTED, SPICE_INITIALIZED, SPICE_DISCONNECTED,
>   SPICE_MIGRATE_COMPLETED
>=20
> Chardev made conditional:
>=20
> * spiceport, spicevmc
>=20
>   Before and after the patch for !CONFIG_SPICE, the error is the
>   same ('spiceport' is not a valid char driver name).
>=20
> No HMP change, the code was already conditional.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Looks good to me.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
