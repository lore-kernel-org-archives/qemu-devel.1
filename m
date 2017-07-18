Received: from eggs.gnu.org ([2001:4830:134:3::10]:42441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXV1v-00008f-IE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXV1s-0006fr-B9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:07:23 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:36373)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXV1r-0006f8-VJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:07:20 -0400
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<4bed43f5ba034c4413aaa2ad37180d3a450f3995.1500378931.git-series.james.hogan@imgtec.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <eaf41d42-03d2-cd99-603c-378d7381f7f9@imgtec.com>
Date: Tue, 18 Jul 2017 17:07:18 +0100
MIME-Version: 1.0
In-Reply-To: <4bed43f5ba034c4413aaa2ad37180d3a450f3995.1500378931.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/14] target/mips: Decode microMIPS EVA
 load & store instructions
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
> Implement decoding of microMIPS EVA load and store instruction groups in
> the POOL31C pool. These use the same gen_ld(), gen_st(), gen_st_cond()
> helpers as the MIPS32 decoding, passing the equivalent MIPS32 opcodes as
> opc.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> Changes in v2:
> - New patch (Yongbok).
> ---
>  target/mips/translate.c | 119 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 115 insertions(+), 4 deletions(-)
> 

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
