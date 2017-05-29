Received: from eggs.gnu.org ([2001:4830:134:3::10]:42431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFGsb-0003O3-8q
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFGsY-0003m4-2q
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:22:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dFGsX-0003lY-Sp
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:22:22 -0400
References: <1c8f4f4e-65f7-2d12-a391-08781fea651c@landley.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e55a133d-2ce7-4889-e214-044f0026d096@redhat.com>
Date: Mon, 29 May 2017 11:22:14 +0200
MIME-Version: 1.0
In-Reply-To: <1c8f4f4e-65f7-2d12-a391-08781fea651c@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Commit b2a575a1c652 broke i486 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc_Mar=c3=ad?= <markmb@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 28.05.2017 07:18, Rob Landley wrote:
> You can't boot a kernel under -cpu 486 since that commit (hangs
> producing no output) because it added a bios image that won't run on
> anything short of pentium II.
>=20
> You can try the run-emulator.sh script in
> http://landley.net/aboriginal/downloads/binaries/system-image-i486.tar.=
gz
> before and after that commit to check for yourself.

 Hi Rob,

thanks for the bug report ... but to make sure that your mail does not
get lost in the high traffic of the qemu-devel mailing list, it might be
a good idea to CC: the people from that commit b2a575a1c652 in this case
(which I've done now).

 Thomas
