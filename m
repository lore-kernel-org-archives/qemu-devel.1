Received: from eggs.gnu.org ([2001:4830:134:3::10]:42888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWlh-0007Js-Va
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWld-000194-SW
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:36:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dkWld-00018w-Lu
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:36:25 -0400
Message-ID: <1503498982.16071.25.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Aug 2017 16:36:22 +0200
In-Reply-To: <20170818143707.GE2222@work-vm>
References: <85cdeb9f-a6ea-5530-edcd-10ed3853026f@exactcode.com>
	<20170818143707.GE2222@work-vm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] QXL: always show default cursor,
 even for unsupported chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>
Cc: qemu-devel@nongnu.org

On Fri, 2017-08-18 at 15:37 +0100, Dr. David Alan Gilbert wrote:
> cc'ing in Gerd
>=20
> * Ren=C3=A9 Rebe (rene@exactcode.com) wrote:
> > Hi,
> >=20
> > I was testing a Windows 10 guest with HiDPI scaling which
> >=20
> > actually made the cursor disappear and only multiple chunks
> >=20
> > warnings being printed.
> >=20
> > When the cursor is using currently unsupported multiple chunks, the
> > builtin-left cursor is better than none.

Better: add support for chunks.  Can you try

https://www.kraxel.org/cgit/qemu/log/?h=3Dwork/qxl-chunked-cursor

?

cheers,
  Gerd
