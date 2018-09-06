Received: from eggs.gnu.org ([2001:4830:134:3::10]:54577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxwF1-0003S5-7O
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxwEw-0006Y1-19
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:30:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxwEv-0006PM-PP
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:30:37 -0400
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
	<20180906151227.25514-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <43452188-354e-5fe8-a758-28e32675faae@redhat.com>
Date: Thu, 6 Sep 2018 10:30:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180906151227.25514-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-option: improve
 qemu_opts_print_help() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 09/06/2018 10:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> Modify qemu_opts_print_help():
> - to print expected argument type
> - skip description if not available
> - sort lines
> - prefix with the list name (like qdev, to avoid confusion)
> - drop 16-chars alignment, use a '-' as seperator for option name and
>    description
>=20
> For ex, "-spice ?" output is changed from:

s/?/help/

>=20
> port             No description available
> tls-port         No description available
> addr             No description available
> [...]
> gl               No description available
> rendernode       No description available
>=20
> to:
>=20
> spice.addr=3Dstr
> spice.agent-mouse=3Dbool (on/off)
> spice.disable-agent-file-xfer=3Dbool (on/off)
> [...]
> spice.x509-key-password=3Dstr
> spice.zlib-glz-wan-compression=3Dstr
>=20
> "qemu-img create -f qcow2 -o ?", changed from:

and again

>=20
> size             Virtual disk size
> compat           Compatibility level (0.10 or 1.1)
> backing_file     File name of a base image
> [...]
> lazy_refcounts   Postpone refcount updates
> refcount_bits    Width of a reference count entry in bits
>=20
> to:
>=20
> backing_file=3Dstr - File name of a base image
> backing_fmt=3Dstr - Image format of the base image
> cluster_size=3Dsize - qcow2 cluster size
> [...]
> refcount_bits=3Dnum - Width of a reference count entry in bits
> size=3Dsize - Virtual disk size
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   util/qemu-option.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
