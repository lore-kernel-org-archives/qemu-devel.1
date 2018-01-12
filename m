Received: from eggs.gnu.org ([2001:4830:134:3::10]:39422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZv5a-0005j1-A9
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZv5V-0007A7-Cu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:53:26 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZv5V-00079Z-61
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:53:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id 143so10418633wma.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 00:53:21 -0800 (PST)
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
	<151299872436.4808.2880956635467564369.stgit@Misha-PC.lan02.inno>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95da61d9-ca01-c938-1ebb-a8e0a291556f@redhat.com>
Date: Fri, 12 Jan 2018 09:53:17 +0100
MIME-Version: 1.0
In-Reply-To: <151299872436.4808.2880956635467564369.stgit@Misha-PC.lan02.inno>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 43/46] windbg: added new api functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>, qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, den@openvz.org

On 11/12/2017 14:25, Mihail Abakumov wrote:
> Added some definitions for new windbg.
> 
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgkd.h |   21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/windbgkd.h b/include/exec/windbgkd.h
> index 5008cbb729..aa2b4fdbd9 100755
> --- a/include/exec/windbgkd.h
> +++ b/include/exec/windbgkd.h
> @@ -112,7 +112,10 @@
>  #define DbgKdFillMemoryApi                  0x0000315b
>  #define DbgKdQueryMemoryApi                 0x0000315c
>  #define DbgKdSwitchPartition                0x0000315d
> -#define DbgKdMaximumManipulate              0x0000315e
> +#define DbgKdWriteCustomBreakpointApi       0x0000315e
> +#define DbgKdGetContextExApi                0x0000315f
> +#define DbgKdSetContextExApi                0x00003160
> +#define DbgKdMaximumManipulate              0x00003161
>  
>  /*
>   * Debug I/O Types
> @@ -723,6 +726,20 @@ typedef struct _DBGKD_SWITCH_PARTITION {
>      uint32_t Partition;
>  } DBGKD_SWITCH_PARTITION;
>  
> +typedef struct _DBGKD_CONTEXT_EX {
> +   uint32_t Offset;
> +   uint32_t ByteCount;
> +   uint32_t BytesCopied;
> +} DBGKD_CONTEXT_EX, *PDBGKD_CONTEXT_EX;
> +
> +typedef struct _DBGKD_WRITE_CUSTOM_BREAKPOINT {
> +   uint64_t BreakPointAddress;
> +   uint64_t BreakPointInstruction;
> +   uint32_t BreakPointHandle;
> +   uint16_t BreakPointInstructionSize;
> +   uint16_t BreakPointInstructionAlignment;
> +} DBGKD_WRITE_CUSTOM_BREAKPOINT, *PDBGKD_WRITE_CUSTOM_BREAKPOINT;
> +
>  /*
>   * DBGKD Structure for Manipulate
>   */
> @@ -787,6 +804,8 @@ typedef struct _DBGKD_MANIPULATE_STATE64 {
>          DBGKD_FILL_MEMORY FillMemory;
>          DBGKD_QUERY_MEMORY QueryMemory;
>          DBGKD_SWITCH_PARTITION SwitchPartition;
> +        DBGKD_WRITE_CUSTOM_BREAKPOINT WriteCustomBreakpoint;
> +        DBGKD_CONTEXT_EX ContextEx;
>      } u;
>  } DBGKD_MANIPULATE_STATE64, *PDBGKD_MANIPULATE_STATE64;
>  
> 
> 

Please squash in patch 2 ("windbg: added windbg's KD header file")

Paolo
