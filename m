Received: from eggs.gnu.org ([2001:4830:134:3::10]:57672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cJMcR-0005TJ-FR
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 10:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cJMcQ-0007FP-Qu
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 10:46:23 -0500
Date: Tue, 20 Dec 2016 16:46:09 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161220154609.iw6jwwcttkhi67zm@kamzik.brq.redhat.com>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<1481625384-15077-7-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481625384-15077-7-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 06/23] hw/arm/virt: Rename 'vbi' variables
 to 'vms'
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

On Tue, Dec 13, 2016 at 10:36:07AM +0000, Peter Maydell wrote:
> Rename all the variables which used to be VirtBoardInfo*
> and are now VirtMachineState* so their names are in line
> with the type being used.
> 
> Apart from the removal of the line 'VirtMachineState *vbi = vms;'
> this commit is purely a search-and-replace of 'vbi' with 'vms'.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/virt.c | 489 +++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 244 insertions(+), 245 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
