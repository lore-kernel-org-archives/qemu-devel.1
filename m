Received: from eggs.gnu.org ([2001:4830:134:3::10]:34088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZuwh-0007XU-MD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZuwe-0007e3-Gr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:44:15 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZuwe-0007dW-9w
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:44:12 -0500
Received: by mail-wr0-f194.google.com with SMTP id d9so4632119wre.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 00:44:12 -0800 (PST)
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
	<151299849551.4808.6986816612829228878.stgit@Misha-PC.lan02.inno>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a7fe7d1-291f-66cc-cd94-e8962829b7aa@redhat.com>
Date: Fri, 12 Jan 2018 09:44:08 +0100
MIME-Version: 1.0
In-Reply-To: <151299849551.4808.6986816612829228878.stgit@Misha-PC.lan02.inno>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/46] windbg: modified windbgkd.h
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

On 11/12/2017 14:21, Mihail Abakumov wrote:
> Added useful name arrays of some defines. Not used yet. Needs for the future.
> 
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgkd.h |   83 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/include/exec/windbgkd.h b/include/exec/windbgkd.h
> index b8f98925e7..5008cbb729 100755
> --- a/include/exec/windbgkd.h
> +++ b/include/exec/windbgkd.h
> @@ -870,4 +870,87 @@ typedef struct _DBGKD_TRACE_IO {
>     } u;
>  } DBGKD_TRACE_IO, *PDBGKD_TRACE_IO;
>  
> +__attribute__ ((unused)) /* maybe unused */
> +static const char *kd_api_names[] = {

Please put this in windbgstub-utils.c...

> +    "DbgKdReadVirtualMemoryApi",
> +    "DbgKdWriteVirtualMemoryApi",
> +    "DbgKdGetContextApi",
> +    "DbgKdSetContextApi",
> +    "DbgKdWriteBreakPointApi",
> +    "DbgKdRestoreBreakPointApi",
> +    "DbgKdContinueApi",
> +    "DbgKdReadControlSpaceApi",
> +    "DbgKdWriteControlSpaceApi",
> +    "DbgKdReadIoSpaceApi",
> +    "DbgKdWriteIoSpaceApi",
> +    "DbgKdRebootApi",
> +    "DbgKdContinueApi2",
> +    "DbgKdReadPhysicalMemoryApi",
> +    "DbgKdWritePhysicalMemoryApi",
> +    "DbgKdQuerySpecialCallsApi",
> +    "DbgKdSetSpecialCallApi",
> +    "DbgKdClearSpecialCallsApi",
> +    "DbgKdSetInternalBreakPointApi",
> +    "DbgKdGetInternalBreakPointApi",
> +    "DbgKdReadIoSpaceExtendedApi",
> +    "DbgKdWriteIoSpaceExtendedApi",
> +    "DbgKdGetVersionApi",
> +    "DbgKdWriteBreakPointExApi",
> +    "DbgKdRestoreBreakPointExApi",
> +    "DbgKdCauseBugCheckApi",
> +    "",
> +    "",
> +    "",
> +    "",
> +    "",
> +    "",
> +    "DbgKdSwitchProcessor",
> +    "DbgKdPageInApi",
> +    "DbgKdReadMachineSpecificRegister",
> +    "DbgKdWriteMachineSpecificRegister",
> +    "OldVlm1",
> +    "OldVlm2",
> +    "DbgKdSearchMemoryApi",
> +    "DbgKdGetBusDataApi",
> +    "DbgKdSetBusDataApi",
> +    "DbgKdCheckLowMemoryApi",
> +    "DbgKdClearAllInternalBreakpointsApi",
> +    "DbgKdFillMemoryApi",
> +    "DbgKdQueryMemoryApi",
> +    "DbgKdSwitchPartition",
> +    "DbgKdUnknownApi"
> +};
> +
> +__attribute__ ((unused)) /* maybe unused */
> +static const char *kd_packet_type_names[] = {

... same here...

> +    "PACKET_TYPE_UNUSED",
> +    "PACKET_TYPE_KD_STATE_CHANGE32",
> +    "PACKET_TYPE_KD_STATE_MANIPULATE",
> +    "PACKET_TYPE_KD_DEBUG_IO",
> +    "PACKET_TYPE_KD_ACKNOWLEDGE",
> +    "PACKET_TYPE_KD_RESEND",
> +    "PACKET_TYPE_KD_RESET",
> +    "PACKET_TYPE_KD_STATE_CHANGE64",
> +    "PACKET_TYPE_KD_POLL_BREAKIN",
> +    "PACKET_TYPE_KD_TRACE_IO",
> +    "PACKET_TYPE_KD_CONTROL_REQUEST",
> +    "PACKET_TYPE_KD_FILE_IO",
> +    "PACKET_TYPE_MAX"
> +};
> +
> +#define KD_API_NAME(id) ({                                                  \

... and make this a function instead of a macro.

Paolo

> +    QEMU_BUILD_BUG_ON(ARRAY_SIZE(kd_api_names) ==                           \
> +                      DbgKdMaximumManipulate - DbgKdMinimumManipulate + 2); \
> +    (id >= DbgKdMinimumManipulate && id < DbgKdMaximumManipulate) ?         \
> +        kd_api_names[id - DbgKdMinimumManipulate] :                         \
> +        kd_api_names[DbgKdMaximumManipulate - DbgKdMinimumManipulate];      \
> +})
> +
> +#define KD_PKT_TYPE_NAME(id) ({                                             \
> +    QEMU_BUILD_BUG_ON(ARRAY_SIZE(kd_packet_type_names) == PACKET_TYPE_MAX); \
> +    (id >= 0 && id < PACKET_TYPE_MAX) ?                                     \
> +        kd_packet_type_names[id] :                                          \
> +        kd_packet_type_names[PACKET_TYPE_MAX - 1];                          \
> +})
> +
>  #endif
> 
> 
