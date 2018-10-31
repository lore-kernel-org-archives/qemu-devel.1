Received: from eggs.gnu.org ([2001:4830:134:3::10]:34610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHx0O-00040p-8P
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHx0K-000861-QT
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:22:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHx0G-00082l-E0
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:22:15 -0400
Date: Wed, 31 Oct 2018 17:22:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181031202200.GC30771@habkost.net>
References: <20181030150453.9344-1-marcandre.lureau@redhat.com>
	<20181030150453.9344-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181030150453.9344-4-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/10] qdev: move
 qdev_prop_register_global_list() to tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 30, 2018 at 07:04:46PM +0400, Marc-Andr=E9 Lureau wrote:
> The function is only used by a test, move it there.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I would still like to reduce duplication between
machine_register_compat_props() and accel_register_compat_props(),
but that doesn't mean we should keep qdev_prop_register_global_list()
just because we plan to refactor/reuse it some day.

--=20
Eduardo
