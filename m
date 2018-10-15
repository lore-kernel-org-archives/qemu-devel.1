Received: from eggs.gnu.org ([2001:4830:134:3::10]:52822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gC3qS-0007XY-Hg
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gC3qN-0001vz-Ae
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:27:44 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com
	([104.47.34.98]:6944
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gC3qM-0001tU-U9
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:27:39 -0400
References: <1539600633-17726-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539600633-17726-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Stefan Markovic <smarkovic@wavecomp.com>
Message-ID: <fef526dc-5928-bb14-41d9-a637eccd82ff@wavecomp.com>
Date: Mon, 15 Oct 2018 16:27:43 +0200
MIME-Version: 1.0
In-Reply-To: <1539600633-17726-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/3] target/mips: Add a comment with an
 overview of CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, pjovanovic@wavecomp.com



On 15.10.2018. 12:50, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add a comment with an overview of CP0 registers close to the
> definition of their corresponding fields in CPUMIPSState.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/cpu.h | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 109 insertions(+)

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>

>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 28af4d1..cd54073 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -195,6 +195,115 @@ struct CPUMIPSState {
>   #define MSAIR_ProcID    8
>   #define MSAIR_Rev       0
>   
> +/*
> + *     Summary of CP0 registers
> + *     ========================
> + *
> + *
> + *     Register 0        Register 1        Register 2        Register 3
> + *     ----------        ----------        ----------        ----------
> + *
> + * 0   Index             Random            EntryLo0          EntryLo1
> + * 1   MVPControl        VPEControl        TCStatus          GlobalNumber
> + * 2   MVPConf0          VPEConf0          TCBind
> + * 3   MVPConf1          VPEConf1          TCRestart
> + * 4   VPControl         YQMask            TCHalt
> + * 5                     VPESchedule       TCContext
> + * 6                     VPEScheFBack      TCSchedule
> + * 7                     VPEOpt            TCScheFBack       TCOpt
> + *
> + *
> + *     Register 4        Register 5        Register 6        Register 7
> + *     ----------        ----------        ----------        ----------
> + *
> + * 0   Context           PageMask          Wired             HWREna
> + * 1   ContextConfig     PageGrain         SRSConf0
> + * 2   UserLocal         SegCtl0           SRSConf1
> + * 3   XContextConfig    SegCtl1           SRSConf2
> + * 4   DebugContextID    SegCtl2           SRSConf3
> + * 5   MemoryMapID       PWBase            SRSConf4
> + * 6                     PWField           PWCtl
> + * 7                     PWSize
> + *
> + *
> + *     Register 8        Register 9        Register 10       Register 11
> + *     ----------        ----------        -----------       -----------
> + *
> + * 0   BadVAddr          Count             EntryHi           Compare
> + * 1   BadInstr
> + * 2   BadInstrP
> + * 3   BadInstrX
> + * 4                                       GuestCtl1         GuestCtl0Ext
> + * 5                                       GuestCtl2
> + * 6                                       GuestCtl3
> + * 7
> + *
> + *
> + *     Register 12       Register 13       Register 14       Register 15
> + *     -----------       -----------       -----------       -----------
> + *
> + * 0   Status            Cause             EPC               PRId
> + * 1   IntCtl                                                EBase
> + * 2   SRSCtl                              NestedEPC         CDMMBase
> + * 3   SRSMap                                                CMGCRBase
> + * 4   View_IPL          View_RIPL                           BEVVA
> + * 5   SRSMap2           NestedExc
> + * 6   GuestCtl0
> + * 7   GTOffset
> + *
> + *
> + *     Register 16       Register 17       Register 18       Register 19
> + *     -----------       -----------       -----------       -----------
> + *
> + * 0   Config            LLAddr            WatchLo           WatchHi
> + * 1   Config1           MAAR              WatchLo           WatchHi
> + * 2   Config2           MAARI             WatchLo           WatchHi
> + * 3   Config3                             WatchLo           WatchHi
> + * 4   Config4                             WatchLo           WatchHi
> + * 5   Config5                             WatchLo           WatchHi
> + * 6                                       WatchLo           WatchHi
> + * 7                                       WatchLo           WatchHi
> + *
> + *
> + *     Register 20       Register 21       Register 22       Register 23
> + *     -----------       -----------       -----------       -----------
> + *
> + * 0   XContext                                              Debug
> + * 1                                                         TraceControl
> + * 2                                                         TraceControl2
> + * 3                                                         UserTraceData1
> + * 4                                                         TraceIBPC
> + * 5                                                         TraceDBPC
> + * 6                                                         Debug2
> + * 7
> + *
> + *
> + *     Register 24       Register 25       Register 26       Register 27
> + *     -----------       -----------       -----------       -----------
> + *
> + * 0   DEPC              PerfCnt            ErrCtl          CacheErr
> + * 1                     PerfCnt
> + * 2   TraceControl3     PerfCnt
> + * 3   UserTraceData2    PerfCnt
> + * 4                     PerfCnt
> + * 5                     PerfCnt
> + * 6                     PerfCnt
> + * 7                     PerfCnt
> + *
> + *
> + *     Register 28       Register 29       Register 30       Register 31
> + *     -----------       -----------       -----------       -----------
> + *
> + * 0   DataLo            DataHi            ErrorEPC          DESAVE
> + * 1   TagLo             TagHi
> + * 2   DataLo            DataHi                              KScratch<n>
> + * 3   TagLo             TagHi                               KScratch<n>
> + * 4   DataLo            DataHi                              KScratch<n>
> + * 5   TagLo             TagHi                               KScratch<n>
> + * 6   DataLo            DataHi                              KScratch<n>
> + * 7   TagLo             TagHi                               KScratch<n>
> + *
> + */
>       int32_t CP0_Index;
>       /* CP0_MVP* are per MVP registers. */
>       int32_t CP0_VPControl;
