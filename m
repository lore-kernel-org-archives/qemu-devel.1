Received: from eggs.gnu.org ([2001:4830:134:3::10]:54523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRfVy-0006dw-Fk
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRfVx-0001ZE-Mg
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:43:06 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <afa0af9d-1c0f-3dee-85e1-b10fef7b6bdf@redhat.com>
Date: Tue, 27 Nov 2018 09:42:59 -0600
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

Although this series is now in 3.1, I can think of further enhancements=20
we should add for 4.0 (summarizing an IRC conversation with Dan).=20
Capturing it here to remember things...

- we need iotests coverage of Pre-Shared Keys (PSK) as an alternative to=20
certificates (either add on to 233, or a new test)
- add an optional QMP parameter for specifying the hostname to validate=20
a certificate against when using a Unix socket with TLS (compare=20
tls-hostname added to 'migrate'), rather than the current restriction=20
that using TLS with an NBD client requires TCP

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
