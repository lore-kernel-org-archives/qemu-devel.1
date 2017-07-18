Received: from eggs.gnu.org ([2001:4830:134:3::10]:51625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXaZ9-0007Iy-45
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXaZ4-0001nj-NV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:02:03 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:58458)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXaZ4-0001nR-I1
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:01:58 -0400
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<b551b2d487039c2e1165e9c732a9fa36bf6497f0.1500378931.git-series.james.hogan@imgtec.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <bf6367d0-0553-7a34-9fc9-50c47d207443@imgtec.com>
Date: Tue, 18 Jul 2017 23:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <b551b2d487039c2e1165e9c732a9fa36bf6497f0.1500378931.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/14] target/mips: Add segmentation
 control registers
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
> The optional segmentation control registers CP0_SegCtl0, CP0_SegCtl1 &
> CP0_SegCtl2 control the behaviour and required privilege of the legacy
> virtual memory segments.
> 
> Add them to the CP0 interface so they can be read and written when
> CP0_Config3.SC=1, and initialise them to describe the standard legacy
> layout so they can be used in future patches regardless of whether they
> are exposed to the guest.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> Changes in v2:
> - Use ld_tl and ext32s_tl rather than ld32s_tl to avoid big endian host,
>   MIPS64 target issues (Yongbok).
> - Add missing break in DMFC0 CP0_SegCtl2 case.
> ---
>  target/mips/cpu.h       | 30 ++++++++++++++-
>  target/mips/helper.h    |  3 +-
>  target/mips/machine.c   |  7 ++-
>  target/mips/op_helper.c | 24 +++++++++++-
>  target/mips/translate.c | 88 ++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 150 insertions(+), 2 deletions(-)
> 


Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>

Regards,
Yongbok
