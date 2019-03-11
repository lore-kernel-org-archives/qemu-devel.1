Received: from eggs.gnu.org ([209.51.188.92]:60193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GNW-00028G-6z
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GNV-0008G2-I2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3GNV-0008Et-8p
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:45 -0400
Date: Mon, 11 Mar 2019 09:33:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190311083340.toucg3xfdoqaybgn@sirius.home.kraxel.org>
References: <20190307151141.6483-1-kraxel@redhat.com>
	<CAFEAcA-t7kkq8pMK-Nh2mopZiEsTuO+kGzGNTz3Aj2kjngPmtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-t7kkq8pMK-Nh2mopZiEsTuO+kGzGNTz3Aj2kjngPmtg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/7] Ui 20190307 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

> > curses: better wide char support.
> > vnc: acl update, stall fix.

> Hi; this fails to build on FreeBSD; linking the qemu-system-*
> binaries fails with:
> 
> /usr/bin/ld: undefined reference to symbol `libiconv_open' (try adding -liconv)
> //usr/local/lib/libiconv.so.2: could not read symbols: Bad value
> c++: error: linker command failed with exit code 1 (use -v to see invocation)

> (This is with the FreeBSD test setup from tests/vm/freebsd).

Hmm, not obvious why configure finds iconv but the build doesn't.
Samuel, can you check please?

Dropped the two iconv patches, sent a v2 pull.

cheers,
  Gerd
