Received: from eggs.gnu.org ([2001:4830:134:3::10]:51769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYBBa-00057T-80
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYBBX-0001yp-Ji
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:08:10 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:5329)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYBBX-0001ya-D1
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:08:07 -0400
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<dfa531e1144393813a515e73748321a08e06356c.1500378931.git-series.james.hogan@imgtec.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <e87cb44d-7f8b-9eb7-f73f-a112e9ee24ef@imgtec.com>
Date: Thu, 20 Jul 2017 14:08:05 +0100
MIME-Version: 1.0
In-Reply-To: <dfa531e1144393813a515e73748321a08e06356c.1500378931.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/14] target/mips: Implement segmentation
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>



On 18/07/2017 12:55, James Hogan wrote:
> Implement the optional segmentation control feature in the virtual to
> physical address translation code.
> 
> The fixed legacy segment and xkphys handling is replaced with a dynamic
> layout based on the segmentation control registers (which should be set
> up even when the feature is not exposed to the guest).
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> Changes in v2:
> - Use hwaddr instead of target_ulong for physical addresses in
>   get_seg[ctl]_physical_address() (Yongbok).
> - Fix xkphys privilege control based on access mode (am) (Yongbok).
> - Fix xkphys TLB faults to use XTLB.
> ---
>  target/mips/helper.c | 177 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 142 insertions(+), 35 deletions(-)
> 

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>

Regards,
Yongbok
