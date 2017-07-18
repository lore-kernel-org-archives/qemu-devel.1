Received: from eggs.gnu.org ([2001:4830:134:3::10]:60346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXUeU-00016n-5y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXUeQ-0007Dj-AD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:43:10 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:49752)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXUeQ-0007DE-4R
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:43:06 -0400
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<c69cbc8b31fbb723b12beeb59545762c12bd11f6.1500378931.git-series.james.hogan@imgtec.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <e3b492ac-2326-b652-d45f-a013f3ca4c9e@imgtec.com>
Date: Tue, 18 Jul 2017 16:43:03 +0100
MIME-Version: 1.0
In-Reply-To: <c69cbc8b31fbb723b12beeb59545762c12bd11f6.1500378931.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/14] target/mips: Decode MIPS32 EVA load &
 store instructions
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
> Implement decoding of MIPS32 EVA loads and stores. These access the user
> address space from kernel mode when implemented, so for each instruction
> we need to check that EVA is available from Config5.EVA & check for
> sufficient COP0 privilege (with the new check_eva()), and then override
> the mem_idx used for the operation.
> 
> Unfortunately some Loongson 2E instructions use overlapping encodings,
> so we must be careful not to prevent those from being decoded when EVA
> is absent.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> Changes in v2:
> - Fix typo in commit message (Yongbok).
> - Use sextract32 (Yongbok).
> ---
>  target/mips/translate.c | 106 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 0 deletions(-)
> 

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
