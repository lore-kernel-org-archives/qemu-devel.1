Received: from eggs.gnu.org ([2001:4830:134:3::10]:52208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGOHz-0001U7-Qd
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGOHz-0005wu-4P
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:56:59 -0500
Date: Mon, 12 Dec 2016 11:56:50 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161212105650.3nguwm6yswqwlzqc@kamzik.brq.redhat.com>
References: <1481301020-21777-1-git-send-email-peter.maydell@linaro.org>
	<1481301020-21777-4-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481301020-21777-4-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/arm/virt: Rename 'vbi' variables to
 'vms'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Christoffer Dall <christoffer.dall@linaro.org>

On Fri, Dec 09, 2016 at 04:30:19PM +0000, Peter Maydell wrote:
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

We obviously need this patch, it's just a shame that git history
digging will become a bit harder after it's committed. While we
may be pretty confident we won't need another patch like it
(vms forever!), we could add another patch or two to help prepare.
I see that nearly half the uses of 'vbi' are for 'vbi->fdt'. We could
add local 'fdt = vbi->fdt' aliases in all functions that need
it. We can do the same with 'vbi->memmap/irqmap', which would
eliminate another 57. Finally machvirt_init could easly replace 9
'vbi->bootinfo's with a bootinfo alias. That would only leave
about 60 lines (currently, and not including the new local variable
definitions) that would need to be changed on another renaming.
Of those 60, 45 can't be changed, as they're referencing just 'vbi'.
So we'd only leave 15 lines exposed to risk of additional renaming
churn.

Thanks,
drew
