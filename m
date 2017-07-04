Received: from eggs.gnu.org ([2001:4830:134:3::10]:35104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSP5f-0006uL-6x
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSP5b-00009G-DD
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:46:11 -0400
Date: Tue, 4 Jul 2017 16:46:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704144600.GH4253@noname.str.redhat.com>
References: <1497863771-24929-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497863771-24929-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Add missing "@c man end"
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>

Am 19.06.2017 um 11:16 hat Thomas Huth geschrieben:
> Since commit 3f2ce724f1f1 ("Move the qemu-ga description into a
> separate chapter"), the qemu.1 man page looks pretty much screwed
> up, e.g. the title was "qemu-ga - QEMU Guest Agent" instead of
> "qemu-doc - QEMU Emulator User Documentation". However, that movement
> of the gemu-ga chapter is not the real problem, it just triggered
> another bug in the qemu-doc.texi: There are some parts in the file
> which introduce a "@c man begin OPTIONS" section, but never close
> it again with "@c man end". After adding the proper end tags here,
> the title of the man page is right again and the previously wrongly
> tagged sections now also show up correctly in the man page, too.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Michael, do you want to take this through qemu-trivial?

Kevin
