Received: from eggs.gnu.org ([2001:4830:134:3::10]:44274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1TK0-0006WK-O9
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1TJv-00060Q-Mi
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:21:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1e1TJv-000602-Gq
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:21:51 -0400
Date: Mon, 9 Oct 2017 10:21:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171009082147.GC5711@localhost.localdomain>
References: <CAMSFjdhUGDQd9sGTFGeP31BCBqoN-tZyO7bmyj63wBfV5d1tBg@mail.gmail.com>
	<CAMSFjdi01EzUmy=JYeOkvqK8JUHQ2wM99GSr2Jx1Nf-AbkUgnw@mail.gmail.com>
	<20171006162838.GD4325@localhost.localdomain>
	<CAMSFjdgsAUNknNRvBWWt1HBSmWiKOY+iz7+o4dc5gwS3FCs9wg@mail.gmail.com>
	<CAMSFjdhQJ8X_sk-R8rvYN9_DOx8Egw9k0ZY5dW3KyiqxfZg2FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMSFjdhQJ8X_sk-R8rvYN9_DOx8Egw9k0ZY5dW3KyiqxfZg2FA@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu Documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Swetheendra Tallamraju <swetheendra.t@gmail.com>
Cc: qemu-devel@nongnu.org

Am 06.10.2017 um 19:39 hat Swetheendra Tallamraju geschrieben:
> Infact emulation of virtual USB already exists. I want to add functionality
> of booting from USB. Can you refer which source files to llok on and
> modify.

Booting is the job of the BIOS that is running inside the guest, so you
won't find this code in QEMU, but in SeaBIOS. As it happens, SeaBIOS
also already supports booting from USB and it works just fine for me.

Kevin
