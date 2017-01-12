Received: from eggs.gnu.org ([2001:4830:134:3::10]:51473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd6Q-0004Cw-PW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd6N-0004a4-NV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:59:30 -0500
References: <1483981521-6789-1-git-send-email-peter.maydell@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <c88596ec-71c3-ce54-b956-785d5f7fc03f@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 13:59:26 +0300
MIME-Version: 1.0
In-Reply-To: <1483981521-6789-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386/kvmvapic: Remove dead code in
 patch_hypercalls()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

09.01.2017 20:05, Peter Maydell wrote:
> The patch_hypercalls() function sets up a 'patches'
> variable and checks it at the end of the function, but
> never modifies it in the middle. Remove this dead code,
> which seems to have been present since the function was
> added in commit e5ad936b0fd7 in 2012.

Applied to -trivial, thank you!

/mjt
