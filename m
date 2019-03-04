Received: from eggs.gnu.org ([209.51.188.92]:55378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0icG-0004HU-0V
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0icF-0002Pq-2m
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:06:27 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:41774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h0icE-0002Mo-Fk
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:06:26 -0500
Date: Mon, 4 Mar 2019 09:06:22 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190304080622.fvrsvkkq4h4k2z37@function>
References: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
	<20190303104430.7692-3-samuel.thibault@ens-lyon.org>
	<20190304080338.jalgvluxwqiygqi2@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304080338.jalgvluxwqiygqi2@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] curses: add option to specify VGA font
 encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, Eddie Kohler <ekohler@gmail.com>

Gerd Hoffmann, le lun. 04 mars 2019 09:03:38 +0100, a ecrit:
> On Sun, Mar 03, 2019 at 11:44:30AM +0100, Samuel Thibault wrote:
> > This uses iconv to convert glyphs from the specified VGA font encoding to
> > unicode, and makes use of cchar_t instead of chtype when using ncursesw,
> > which allows to store all wide char as well as the WACS values.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > Cc: Eddie Kohler <ekohler@gmail.com>
> 
> So the difference to the patch from Eddie is that charset
> is configurable instead of being hard-coded to CP437?

Yes.

Samuel
