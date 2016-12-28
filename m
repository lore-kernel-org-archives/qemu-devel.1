Received: from eggs.gnu.org ([2001:4830:134:3::10]:42222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cME3t-0000mZ-QW
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 08:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cME3s-00054a-Ru
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 08:14:33 -0500
Date: Wed, 28 Dec 2016 14:14:23 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161228131423.jeyywk3uh6snkiqu@kamzik.brq.redhat.com>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<1481625384-15077-23-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481625384-15077-23-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 22/23] target-arm: Enable EL2 feature bit
 on A53 and A57
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Christoffer Dall <christoffer.dall@linaro.org>, patches@linaro.org

On Tue, Dec 13, 2016 at 10:36:23AM +0000, Peter Maydell wrote:
> Enable the ARM_FEATURE_EL2 bit on Cortex-A52 and
> Cortex-A57, since this is all now sufficiently implemented
> to work with the GICv3. We provide the usual CPU property
> to disable it for backwards compatibility with the older
> virt boards.
> 
> In this commit, we disable the EL2 feature on the
> virt and ZynpMP boards, so there is no overall effect.
> Another commit will expose a board-level property to
> allow the user to enable EL2.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target-arm/cpu.h     |  2 ++
>  hw/arm/virt.c        |  4 ++++
>  hw/arm/xlnx-zynqmp.c |  2 ++
>  target-arm/cpu.c     | 12 ++++++++++++
>  target-arm/cpu64.c   |  2 ++
>  5 files changed, 22 insertions(+)
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
