Received: from eggs.gnu.org ([2001:4830:134:3::10]:60825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNgj5-0000Dh-1a
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNgj4-0002vk-B5
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:12:11 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a244b46-25da-8407-13b9-a0b11d5cba84@redhat.com>
Date: Fri, 16 Nov 2018 10:11:44 -0600
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

In fact, I already have a proposed patch 228 that I'm trying to clean up=20
for potential inclusion in 3.1 that could use this!  [I'm still=20
hammering on those patches, so I don't know if they will make 3.1 or be=20
delayed to 4.0 - this patch is not needed in 3.1 unless either your=20
later patches are 3.1 material or my patch ends up ready in time]

https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00308.html

>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/qemu-iotests/058        | 47 +++++------------------------
>   tests/qemu-iotests/common.nbd | 56 ++++++++++++++++++++++++++++++++++=
+
>   2 files changed, 64 insertions(+), 39 deletions(-)
>   create mode 100644 tests/qemu-iotests/common.nbd
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
