Received: from eggs.gnu.org ([2001:4830:134:3::10]:59734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gNXTR-00071h-Ar
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 01:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gNXTQ-0003iu-1u
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 01:19:25 -0500
References: <20181115143535.5885-1-peter.maydell@linaro.org>
	<20181115143535.5885-3-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fe946842-bd54-2db9-c064-44d551c52a2f@redhat.com>
Date: Fri, 16 Nov 2018 07:19:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181115143535.5885-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] hw/block/onenand: use
 qemu_log_mask() for reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <richard.henderson@linaro.org>

On 2018-11-15 15:35, Peter Maydell wrote:
> Update the onenand device to use qemu_log_mask() for reporting
> guest errors and unimplemented features, rather than plain
> fprintf() and hw_error().
> 
> (We leave the hw_error() in onenand_reset(), as that is
> triggered by a failure to read the underlying block device
> for the bootRAM, not by guest action.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/block/onenand.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>
