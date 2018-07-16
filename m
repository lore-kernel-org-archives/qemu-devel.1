Received: from eggs.gnu.org ([2001:4830:134:3::10]:54437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffB2l-00017N-5E
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffB2g-00075Y-9C
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ffB2g-00074y-2S
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:28:26 -0400
Date: Mon, 16 Jul 2018 18:28:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180716212821.GT914@localhost.localdomain>
References: <20180514171913.17664-1-berrange@redhat.com>
	<20180514171913.17664-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180514171913.17664-4-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] opts: remove redundant check for NULL
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, May 14, 2018 at 06:19:13PM +0100, Daniel P. Berrang=E9 wrote:
> No callers of get_opt_value() pass in a NULL for the "value" parameter,
> so the check is redundant.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queueing on x86-next.

--=20
Eduardo
