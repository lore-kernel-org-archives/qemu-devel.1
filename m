Received: from eggs.gnu.org ([209.51.188.92]:55921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h0iet-000576-Ca
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h0ies-0004T0-PI
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:09:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h0ier-0004Pj-JJ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:09:10 -0500
Date: Mon, 4 Mar 2019 09:03:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190304080338.jalgvluxwqiygqi2@sirius.home.kraxel.org>
References: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
	<20190303104430.7692-3-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303104430.7692-3-samuel.thibault@ens-lyon.org>
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
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, Eddie Kohler <ekohler@gmail.com>

On Sun, Mar 03, 2019 at 11:44:30AM +0100, Samuel Thibault wrote:
> This uses iconv to convert glyphs from the specified VGA font encoding to
> unicode, and makes use of cchar_t instead of chtype when using ncursesw,
> which allows to store all wide char as well as the WACS values.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: Eddie Kohler <ekohler@gmail.com>

So the difference to the patch from Eddie is that charset
is configurable instead of being hard-coded to CP437?

> +# @charset:       Font charset used by guest (default: CP437).

> @@ -1139,7 +1140,8 @@
>    'base'    : { 'type'           : 'DisplayType',
>                  '*full-screen'   : 'bool',
>                  '*window-close'  : 'bool',
> -                '*gl'            : 'DisplayGLMode' },
> +                '*gl'            : 'DisplayGLMode',
> +                '*charset'       : 'str' },

No.  Please add a new DisplayCurses struct for the charset option.  It
will only be used by the curses UI and it is highly unlikely that this
will ever change as only curses needs this (the graphical UIs will just
use whatever font the guest loaded into the vga).

cheers,
  Gerd
