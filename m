Received: from eggs.gnu.org ([2001:4830:134:3::10]:45805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyH1u-0000Ci-1V
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyH1p-0001ww-9G
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:42:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fyH1n-0001qE-9B
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:42:29 -0400
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7fbe967-6339-88eb-d4e9-41365e432bc7@redhat.com>
Date: Fri, 7 Sep 2018 08:42:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/12] qemu-option: add help fallback to
 print the list of options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 09/07/2018 02:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> QDev options accept 'help' (or '?', but that's problematic with shell
> globing) in the list of parameters, which is handy to list the

s/globing/globbing/

> available options.
>=20
> Unfortunately, this isn't built in QemuOpts. qemu_opts_parse_noisily()
> seems to be the common path for command line options, so place a
> fallback to print help, listing the available options.
>=20
> This is quite handy, for example with qemu "-spice help".
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   util/qemu-option.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
>=20

R-b still stands.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
