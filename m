Received: from eggs.gnu.org ([2001:4830:134:3::10]:58342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d6WfP-0005gI-Oy
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d6WfM-0002oS-HC
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:24:39 -0400
References: <20170503104441.1349-1-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <3a1419bd-710a-61f5-bfee-0eb5895a022c@msgid.tls.msk.ru>
Date: Fri, 5 May 2017 09:24:33 +0300
MIME-Version: 1.0
In-Reply-To: <20170503104441.1349-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] jazz_led: fix bad snprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, leon.alrae@imgtec.com

03.05.2017 13:44, Paolo Bonzini wrote:
> Detected by GCC 7's -Wformat-truncation.  snprintf writes at most
> 2 bytes here including the terminating NUL, so the result is
> truncated.  In addition, the newline at the end is pointless.
> Fix the buffer size and the format string.

Polo, that's quite a bit too bureaucratic,
but where's your s-o-b for this patch? :)

Thanks,

/mjt
