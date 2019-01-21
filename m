Received: from eggs.gnu.org ([209.51.188.92]:41275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1glUp2-0001Ak-3R
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 03:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1glUp1-0002Ng-8I
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 03:20:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1glUp0-0001YF-Vx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 03:20:43 -0500
References: <154803791641.5550.15254007790773130906@2d3111e9616b>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <7979bbc2-2713-4043-291b-79b7132634c0@oracle.com>
Date: Mon, 21 Jan 2019 08:19:03 +0000
MIME-Version: 1.0
In-Reply-To: <154803791641.5550.15254007790773130906@2d3111e9616b>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] QEMU changes to do PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, ehabkost@redhat.com, mst@redhat.com, maran.wilson@oracle.com, george.kennedy@oracle.com, stefanha@redhat.com, xen-devel@lists.xenproject.org, pbonzini@redhat.com, boris.ostrovsky@oracle.com, rth@twiddle.net, sgarzare@redhat.com

On 21/01/2019 02:31, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1547554687-12687-1-git-send-email=
-liam.merwick@oracle.com/
...>
>    CC      dma-helpers.o
>    CC      vl.o
> /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
> /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified =
bound 256 equals destination size [-Werror=3Dstringop-truncation]
>       strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20


Given the PVH patch series was posted 5 days ago and the following=20
change was committed 3 days ago, I'm assuming this is not related to the=20
PVH changes (which do not touch this file).

commit 97b583f46c435aaa40942ca73739d79190776b7f
Author: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Date:   Thu Jan 3 09:56:35 2019 +0100

     block/sheepdog: Use QEMU_NONSTRING for non NUL-terminated arrays

Regards,
Liam


>=20
> The full log is available at
> http://patchew.org/logs/1547554687-12687-1-git-send-email-liam.merwick@=
oracle.com/testing.docker-mingw@fedora/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
>=20
