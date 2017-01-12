Received: from eggs.gnu.org ([2001:4830:134:3::10]:50568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd2M-0000T4-W1
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd2K-0003H7-0g
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:55:19 -0500
References: <20170104145914.3361-1-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <ef00f454-4049-6b88-cbca-d59b21fdb259@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 13:55:14 +0300
MIME-Version: 1.0
In-Reply-To: <20170104145914.3361-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: remove dead check
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

04.01.2017 17:59, Paolo Bonzini wrote:
> options must be non-NULL here, because a NULL value is replaced with
> qdict_new earlier in the function.  Reported by Coverity.

Applied to -trivial, thank you!

/mjt
