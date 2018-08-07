Received: from eggs.gnu.org ([2001:4830:134:3::10]:58119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn28q-000609-3F
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn27W-0005ii-Jh
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:35:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fn27W-0005iZ-BE
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:33:54 -0400
References: <cover.1533638952.git.tgolembi@redhat.com>
	<951d1c8265e9ef6b36d61358fd01f267a9b83ca7.1533638952.git.tgolembi@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e459264-00cf-cb7e-1d23-8eea8720f73a@redhat.com>
Date: Tue, 7 Aug 2018 08:33:50 -0500
MIME-Version: 1.0
In-Reply-To: <951d1c8265e9ef6b36d61358fd01f267a9b83ca7.1533638952.git.tgolembi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] qga: win32: fix crashes when PCI info
 cannot be retrived
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 08/07/2018 05:49 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> The guest-get-fsinfo command collects also information about PCI
> controller where the disk is attached. When this fails for some reasons
> it tries to return just the partial information. However in certain
> cases the pointer to the structure was not initialized and was set to
> NULL. This breaks the serializer and lead to crasehs of the guest agent=
.

s/lead to crasehs/leads to a crash/

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
