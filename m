Received: from eggs.gnu.org ([2001:4830:134:3::10]:58045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOD05-0003Kn-4r
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 21:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOD04-0004lE-9O
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 21:39:53 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <883a1eec-0609-7fc3-3cf3-ab49145010f2@redhat.com>
Date: Sat, 17 Nov 2018 20:39:43 -0600
MIME-Version: 1.0
In-Reply-To: <20181116155325.22428-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] Misc fixes to NBD
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
> This does two minor fixes to the NBD code and adds significant coverage
> of the NBD TLS support to detect future problems.
>=20
> The first two patches should be for 3.1.
>=20
> The tests can wait till 4.0 if desired.
>=20
> Daniel P. Berrang=C3=A9 (6):
>    nbd: fix whitespace in server error message
>    nbd: stop waiting for a NBD response with NBD_CMD_DISC
>    tests: pull qemu-nbd iotest helpers into common.nbd file
>    tests: check if qemu-nbd is still alive before waiting
>    tests: add iotests helpers for dealing with TLS certificates
>    tests: exercise NBD server in TLS mode
>=20

I'm still missing your S-o-b on 6. I've posted a preliminary version of=20
your series with my touchups incorporated, if you'd like to double check=20
it, at:

https://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/nbd


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
