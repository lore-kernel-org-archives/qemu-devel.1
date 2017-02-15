Received: from eggs.gnu.org ([2001:4830:134:3::10]:33504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwxo-0004Y1-In
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwxl-0006Lw-F1
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:37:32 -0500
References: <1484309555-1935-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <879e9f0f-9f95-e018-7b42-794f42c1dda4@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:37:27 +0300
MIME-Version: 1.0
In-Reply-To: <1484309555-1935-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] monitor: Fix crashes when using HMP
 commands without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

13.01.2017 15:12, Thomas Huth wrote:
> When running certain HMP commands ("info registers", "info cpustats",
> "info tlb", "nmi", "memsave" or dumping virtual memory) with the "none"
> machine, QEMU crashes with a segmentation fault. This happens because the
> "none" machine does not have any CPUs by default, but these HMP commands
> did not check for a valid CPU pointer yet. Add such checks now, so we get
> an error message about the missing CPU instead.

(finally) applied to -trivial, thank you!

/mjt
