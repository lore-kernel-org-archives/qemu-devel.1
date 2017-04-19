Received: from eggs.gnu.org ([2001:4830:134:3::10]:39312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0pl3-0008M0-QV
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0pl0-0001wE-Ny
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d0pl0-0001vs-E7
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:34:54 -0400
References: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9ca8e6d-6f82-a856-3c76-edbbbc57188a@redhat.com>
Date: Wed, 19 Apr 2017 08:34:50 -0500
MIME-Version: 1.0
In-Reply-To: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P17TtPN8vTvhaQnkuppWCchKowPOMuKWg"
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: add
 guest-network-get-interface-stat command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P17TtPN8vTvhaQnkuppWCchKowPOMuKWg
From: Eric Blake <eblake@redhat.com>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org
Message-ID: <e9ca8e6d-6f82-a856-3c76-edbbbc57188a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: add
 guest-network-get-interface-stat command
References: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
In-Reply-To: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 11:57 AM, ZhiPeng Lu wrote:
> we can get the  network card statistics inside  a virtual machine by gu=
est-network-get-interface-stat command.
> it is very userful for us to monitor and analyze network traff.
>=20
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---

> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,37 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +##
> +# @GuestNetworkInterfaceStat:
> +#
> +# @rx_bytes: received bytes of interface
> +#
> +# @rx_packets: received packets of interface
> +#
> +# @rx_errs: received error packets of interface
> +# @rx_drop: received drop packets of interface

New interfaces should favor the use of '-' rather than '_', as in
'rx-bytes', 'rx-packets'...

> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestNetworkInterfaceStat',
> +  'data': {'rx_bytes': 'uint64',
> +            'rx_packets': 'uint64',
> +            'rx_errs': 'uint64',
> +            'rx_drop': 'uint64',
> +            'tx_bytes': 'uint64',
> +            'tx_packets': 'uint64',
> +            'tx_errs': 'uint64',
> +            'tx_drop': 'uint64'

You only documented four fields, but have a lot more in the structure.

> +           } }
> +##
> +# @guest-network-get-interface-stat:
> +#
> +# Get list of interface stat
> +#
> +# Returns: List of GuestNetworkInterfaceStat on success.
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-network-get-interface-stat',
> +  'data':    {'bus': 'int64', 'slot': 'int64', 'function': 'int64','ne=
tname':'str'},

Are all of these parameters requires on every invocation, or are they
optional for filtering the results but with an intent to allow them to
be omitted to get a full list at once?

Missing documentation.

> +  'returns': ['GuestNetworkInterfaceStat'] }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--P17TtPN8vTvhaQnkuppWCchKowPOMuKWg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY92d6AAoJEKeha0olJ0NqDGEIAKgc3TV1yHbMs0kwERXxKhpG
gEehg7HnpMbh/qwohjwos5OXosupJPBbWQlmQ2zHmdLvswvZS0gcB+v7MpFSGOYF
3mGqF8HHTkTv9jSGMTbCc7R53IwZZl0UQjO65QVvLQWwW6Aa+I238wLZkpHSjuwV
c4pXSkkZ7M2DKUie7HlMdvt2FVCWX9Ae365yizORv/Bx+xm5Igc4+DcvpMJifVMY
eOXaqPEQJESkf8un+20aHklKWx7mBrw2Ghjga2jraYVDZjqt6gLEJl5TWzzsmKmF
F885uWJwOn1C2xDZGs7VaZylKmqWDM1V32wbS0QAedO58BiW2VcwfzZU5QpTYy8=
=OSrC
-----END PGP SIGNATURE-----

--P17TtPN8vTvhaQnkuppWCchKowPOMuKWg--
