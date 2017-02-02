Received: from eggs.gnu.org ([2001:4830:134:3::10]:54042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZP8N-0007Y7-5K
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 16:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZP8M-0005XO-H5
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 16:41:39 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1485876994-14555-1-git-send-email-pl@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea032a8a-1429-bd95-5b68-4634a0fb0a57@redhat.com>
Date: Thu, 2 Feb 2017 13:41:30 -0800
MIME-Version: 1.0
In-Reply-To: <1485876994-14555-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: ignore EBUSY when freezing a
 filesystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, mdroth@linux.vnet.ibm.com, ct@flyingcircus.io



On 31/01/2017 07:36, Peter Lieven wrote:
> the current implementation fails if we try to freeze an
> already frozen filesystem. This can happen if a filesystem
> is mounted more than once (e.g. with a bind mount).
> 
> Suggested-by: Christian Theune <ct@flyingcircus.io>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>

What happens when you thaw?

Paolo
