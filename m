Received: from eggs.gnu.org ([2001:4830:134:3::10]:50731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd3I-0001CZ-Jc
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd3F-0003SB-Ii
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:56:16 -0500
References: <20170104145210.31608-1-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <8ea8a55f-aab6-2ba0-c111-69cfb8fc0193@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 13:56:12 +0300
MIME-Version: 1.0
In-Reply-To: <20170104145210.31608-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: fix erroneous argument to strerror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

04.01.2017 17:52, Paolo Bonzini wrote:
> process_command returns a negative value in case of error.  Make this
> clear in the "if" statement and fix the strerror argument to flip it
> to positive.

Applied to -trivial, thank you!

/mjt
