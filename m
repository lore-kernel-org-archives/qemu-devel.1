Received: from eggs.gnu.org ([2001:4830:134:3::10]:42304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cME4M-00013K-2I
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 08:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cME4L-0005aB-7p
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 08:15:02 -0500
Date: Wed, 28 Dec 2016 14:14:52 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161228131452.jt37cfqteqkhb6hn@kamzik.brq.redhat.com>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<1481625384-15077-24-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481625384-15077-24-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 23/23] hw/arm/virt: Add board property to
 enable EL2
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

On Tue, Dec 13, 2016 at 10:36:24AM +0000, Peter Maydell wrote:
> Add a board level property to the virt board which will
> enable EL2 on the CPU if the user asks for it. The
> default is not to provide EL2. If EL2 is enabled then
> we will use SMC as our PSCI conduit, and report the
> virtualization support in the GICv3 device tree node.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/virt.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
