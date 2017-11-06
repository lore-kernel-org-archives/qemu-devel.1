Received: from eggs.gnu.org ([2001:4830:134:3::10]:51164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1eBj9c-0002rd-N9
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1eBj9X-0003Hv-V1
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:17:36 -0500
Received: from mifritscher.de ([188.40.170.105]:40034
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1eBj9X-0003HP-NW
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:17:31 -0500
Message-ID: <5d67c7311aa19c9830cf4927a4e22159.squirrel@mifritscher.de>
In-Reply-To: <20171106144422.4bda119f@bahia>
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-4-michael@fritscher.net>
	<20171106144422.4bda119f@bahia>
Date: Mon, 6 Nov 2017 16:17:29 +0100
From: "Michael Fritscher" <michael@fritscher.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/18] Disable the proxy fsdev under
 Windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Michael Fritscher <michael@fritscher.net>, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, Greg Kurz <gkurz@linux.vnet.ibm.com>

> On Fri, 29 Sep 2017 13:13:08 +0200
> Michael Fritscher <michael@fritscher.net> wrote:
>> Signed-off-by: Michael Fritscher <michael@fritscher.net>
>
> What's the justification for this patch ?
It had too much linuxisms in it to fix compiling - so I disabled the prox=
y
variant altogether. Reactivating it could be done in a version 2.0 ;-)

Best regards,
Michael Fritscher
