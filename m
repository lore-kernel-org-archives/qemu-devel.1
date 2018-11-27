Received: from eggs.gnu.org ([2001:4830:134:3::10]:47618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRdgL-0006LY-8x
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRdgH-0001wy-AN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:45:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRdgH-0001v2-4W
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:45:37 -0500
Date: Tue, 27 Nov 2018 11:45:14 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181127134514.GN18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181127092801.21777-12-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 11/28] qom: make
 user_creatable_complete() specific to UserCreatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Amit Shah <amit@kernel.org>

On Tue, Nov 27, 2018 at 01:27:44PM +0400, Marc-Andr=E9 Lureau wrote:
> Instead of accepting any Object*, change user_creatable_complete() to
> require a UserCreatable*. Modify the callers to pass the appropriate
> argument, removing redundant dynamic cast checks in object creation.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
