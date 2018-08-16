Received: from eggs.gnu.org ([2001:4830:134:3::10]:41788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqNXW-0000ld-33
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqNXV-00020G-6z
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:02:33 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2e8b4754-2f83-d263-f562-b753aea90d42@virtuozzo.com>
Date: Thu, 16 Aug 2018 22:02:16 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Qemu-devel] nbd oldstyle negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, nbd list <nbd@other.debian.org>

Hi Eric!

There is a small problem with our qemu-nbd cmdline interface: people=20
forget to use option -x or don't know about it and face into problems=20
with old protocol version. One of may colleagues after such situation=20
(because of this option, he could not use utility nbd-client, which=20
doesn't support old version) asked me to add comments about version=20
selection by -x option into --help of qemu-nbd. And really, it's not an=20
obvious interface solution...

Now I think, should not we use new version by default? Or, even drop old=20
version support at all? Anybody uses it?

from nbd spec:
 =C2=A0... the old style negotiation is now no longer developed; starting=20
with version 3.10 of the reference implementation, it is also no longer=20
supported.

it's unsupported, I think it's ok to drop it. I can create patches, if=20
you agree.

--=20
Best regards,
Vladimir
