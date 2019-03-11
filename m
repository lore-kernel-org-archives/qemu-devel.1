Received: from eggs.gnu.org ([209.51.188.92]:48959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h3LN7-0003bP-Gu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h3LMI-0005WL-Pd
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:52:51 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h3LMI-0005Tn-Ia
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:52:50 -0400
Date: Mon, 11 Mar 2019 14:52:46 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190311135246.igm3m6yhpp6fus3w@function>
References: <20190307151141.6483-1-kraxel@redhat.com>
	<CAFEAcA-t7kkq8pMK-Nh2mopZiEsTuO+kGzGNTz3Aj2kjngPmtg@mail.gmail.com>
	<20190311083340.toucg3xfdoqaybgn@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311083340.toucg3xfdoqaybgn@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PULL 0/7] Ui 20190307 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Gerd Hoffmann, le lun. 11 mars 2019 09:33:40 +0100, a ecrit:
> > > curses: better wide char support.
> > > vnc: acl update, stall fix.
> 
> > Hi; this fails to build on FreeBSD; linking the qemu-system-*
> > binaries fails with:
> > 
> > /usr/bin/ld: undefined reference to symbol `libiconv_open' (try adding -liconv)
> > //usr/local/lib/libiconv.so.2: could not read symbols: Bad value
> > c++: error: linker command failed with exit code 1 (use -v to see invocation)
> 
> > (This is with the FreeBSD test setup from tests/vm/freebsd).
> 
> Hmm, not obvious why configure finds iconv but the build doesn't.
> Samuel, can you check please?

Mmm, that's because on the freebsd vm there is a libiconv installed
in /usr/local, and that path gets pulled in include flags after the
system's iconv is detected not to need -liconv.

In PATCHv3 I have added detection in /usr/local before /usr

Samuel
