Received: from eggs.gnu.org ([2001:4830:134:3::10]:35437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAPPB-0000tx-Gt
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 21:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gAPP7-0007uh-HX
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 21:04:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gAPP7-0007ra-C0
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 21:04:41 -0400
References: <cover.1538652143.git.tgolembi@redhat.com>
	<0ad2a56e767a04f8fd2c8cb32ed6c1bc0f1c2497.1538652143.git.tgolembi@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9bb2056e-04b5-f887-5b83-1daf24def527@redhat.com>
Date: Wed, 10 Oct 2018 20:04:35 -0500
MIME-Version: 1.0
In-Reply-To: <0ad2a56e767a04f8fd2c8cb32ed6c1bc0f1c2497.1538652143.git.tgolembi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/11] qga-win: fix crashes when PCI
 info cannot be retrived
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org
Cc: Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 10/4/18 6:22 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:

In the subject: s/retrived/retrieved/

> The guest-get-fsinfo command collects also information about PCI
> controller where the disk is attached. When this fails for some reasons
> it tries to return just the partial information. However in certain
> cases the pointer to the structure was not initialized and was set to
> NULL. This breaks the serializer and leads to a crash of the guest agen=
t.
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>   qga/commands-win32.c | 27 ++++++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
