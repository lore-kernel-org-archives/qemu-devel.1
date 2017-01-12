Received: from eggs.gnu.org ([2001:4830:134:3::10]:56334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdTm-0008OT-99
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdTi-0005Ja-B9
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:23:38 -0500
References: <1483980309-30821-1-git-send-email-peter.maydell@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <5f112063-7143-48be-461d-7ecd069fa103@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 14:23:33 +0300
MIME-Version: 1.0
In-Reply-To: <1483980309-30821-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/display/framebuffer.c: Avoid overflow
 for framebuffers > 4GB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

09.01.2017 19:45, Peter Maydell wrote:
> Coverity points out that calculating src_len by multiplying
> src_width by rows could overflow. This can only happen in
> the implausible case of a framebuffer larger than 4GB, but
> we may as well fix it, placating Coverity. (CID1005515)

Applied to -trivial, thanks!

/mjt
