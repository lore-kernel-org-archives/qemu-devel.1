Received: from eggs.gnu.org ([2001:4830:134:3::10]:42096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cME3d-0000dM-QP
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 08:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cME3c-0004zG-UP
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 08:14:17 -0500
Date: Wed, 28 Dec 2016 14:14:07 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161228131407.mytiexge3cbwrth4@kamzik.brq.redhat.com>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<1481625384-15077-22-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481625384-15077-22-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 21/23] hw/arm/virt: Support using SMC for
 PSCI
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

On Tue, Dec 13, 2016 at 10:36:22AM +0000, Peter Maydell wrote:
> If we are giving the guest a CPU with EL2, it is likely to
> want to use the HVC instruction itself, for instance for
> providing PSCI to inner guest VMs. This makes using HVC
> as the PSCI conduit for the outer QEMU a bad idea. We will
> want to use SMC instead is this case: this makes sense
> because QEMU's PSCI implementation is effectively an
> emulation of functionality provided by EL3 firmware.
> 
> Add code to support selecting the PSCI conduit to use,
> rather than hardcoding use of HVC.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/virt.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
