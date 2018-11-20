Received: from eggs.gnu.org ([2001:4830:134:3::10]:44916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPAkC-0007l6-GY
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPAjA-0000D3-Gt
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:26:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPAj9-00009d-Vb
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:26:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48E7C308A941
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 18:26:22 +0000 (UTC)
References: <20181120175646.25763-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5815cf64-e0b4-c895-8fa8-2b6debe87306@redhat.com>
Date: Tue, 20 Nov 2018 12:26:20 -0600
MIME-Version: 1.0
In-Reply-To: <20181120175646.25763-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: fix nbd test to work correctly with
 raw images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 11/20/18 11:56 AM, Daniel P. Berrang=C3=A9 wrote:
> The first qemu-io command must honour the $IMGFMT that is set rather
> than hardcoding qcow2. The qemu-nbd commands should also set $IMGFMT
> to avoid the insecure format probe warning.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/qemu-iotests/233 | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

I'm fine if this goes through Kevin's tree (if he beats me to a next=20
pull request) since he has been looking at other iotests issues;=20
otherwise I'll plan on an NBD pull request for -rc3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
