Received: from eggs.gnu.org ([2001:4830:134:3::10]:47113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSeJv-0005Z6-Vg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSeJu-0002z9-Pr
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:06:27 -0400
Date: Tue, 12 Jun 2018 09:06:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180612080611.GD23739@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
	<20180611205203.2624-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611205203.2624-5-mreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/10] qapi: Formalize qcow2 encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, Jun 11, 2018 at 10:51:57PM +0200, Max Reitz wrote:
> Currently, you can give no encryption format for a qcow2 file while
> still passing a key-secret.  That does not conform to the schema, so
> this patch changes the schema to allow it.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 44 ++++++++++++++++++++++++++++++++++++++++----
>  block/qcow2.c        |  3 +++
>  2 files changed, 43 insertions(+), 4 deletions(-)

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
