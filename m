Received: from eggs.gnu.org ([2001:4830:134:3::10]:34022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gODOW-000850-4o
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 22:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gODLX-0002sE-6B
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 22:02:04 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0bbf4d8b-8a1d-d208-5fa1-278d39e1ea5a@redhat.com>
Date: Sat, 17 Nov 2018 21:01:57 -0600
MIME-Version: 1.0
In-Reply-To: <20181116155325.22428-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: pull qemu-nbd iotest helpers
 into common.nbd file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> The helpers for starting/stopping qemu-nbd in 058 will be useful in
> other test cases, so move them into a common.nbd file.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

> +function nbd_server_start_unix_socket()
> +{
> +    nbd_server_stop
> +    $QEMU_NBD -v -t -k "$nbd_unix_socket" $@ &

Needs to be "$@" to properly preserve whitespace and/or empty arguments=20
(the latter if someone passes -x '' for a default-named export).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
