Received: from eggs.gnu.org ([2001:4830:134:3::10]:53208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1eBjFY-0004vb-Nf
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1eBjFT-0006Nf-Qh
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:23:44 -0500
Received: from mifritscher.de ([188.40.170.105]:40194
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1eBjFT-0006M9-K1
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:23:39 -0500
Message-ID: <5bc62a3a54dd9c1eb19c41bc5f710e3e.squirrel@mifritscher.de>
In-Reply-To: <d86b8115-9512-d487-a508-906c5f259764@redhat.com>
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-16-michael@fritscher.net>
	<d86b8115-9512-d487-a508-906c5f259764@redhat.com>
Date: Mon, 6 Nov 2017 16:23:37 +0100
From: "Michael Fritscher" <michael@fritscher.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/18] Fix unavailable fields in stbuf
 under Windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

Hi,

> Likewise, I think it should be struct FileOperations's lstat member tha=
t
> uses struct V9fsStatDotl instead of struct stat.  Then
> stat_to_v9stat_dotl would be hidden inside 9p-local.c (and 9p-local.c
> isn't going to be used by Windows at all, so this patch disappears).
>
> Paolo
>
At first: thanks for reviewing!

Yes, the main question for me at this stage is:
  * use the 9p-local.c and try workaround the limitations (e.g. lack of
the *at functions) by creating stubs)
  * make a own 9p-local-windows.c and use ntdlls functions, which is a bi=
t
more ugly.

I decribed these options a moment ago in the other mail in more detail.
For me both way are fine.

Best regards,
Michael Fritscher
