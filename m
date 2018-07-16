Received: from eggs.gnu.org ([2001:4830:134:3::10]:52467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffAxr-0007mD-0l
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffAxm-0004JL-5M
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ffAxl-0004J7-UD
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:23:22 -0400
Date: Mon, 16 Jul 2018 18:23:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180716212319.GR914@localhost.localdomain>
References: <20180514171913.17664-1-berrange@redhat.com>
	<20180514171913.17664-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180514171913.17664-2-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] i386: fix regression parsing multiboot
 initrd modules
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

On Mon, May 14, 2018 at 06:19:11PM +0100, Daniel P. Berrang=E9 wrote:
> The logic for parsing the multiboot initrd modules was messed up in
>=20
>   commit 950c4e6c94b15cd0d8b63891dddd7a8dbf458e6a
>   Author: Daniel P. Berrang=E9 <berrange@redhat.com>
>   Date:   Mon Apr 16 12:17:43 2018 +0100
>=20
>     opts: don't silently truncate long option values
>=20
> Causing the length to be undercounter, and the number of modules over
> counted. It also passes NULL to get_opt_value() which was not robust
> at accepting a NULL value.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queueing on x86-next.  Thanks.

--=20
Eduardo
