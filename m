Received: from eggs.gnu.org ([2001:4830:134:3::10]:47206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJfPN-0005j5-RF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJfPK-0007O4-Nr
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:54:41 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eJfPK-0007Nz-Jj
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:54:38 -0500
Received: by mail-vk0-f65.google.com with SMTP id s197so141474vkh.11
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 04:54:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151127325284.6888.645379954526299685.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127325284.6888.645379954526299685.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 28 Nov 2017 13:54:37 +0100
Message-ID: <CABdb734qWO=gNGv=pt=C42-e7toF0VG0TGdPyVOZ9U6PvTsHHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 03/45] windbg: modified windbgkd.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Tue, Nov 21, 2017 at 3:07 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Added useful name arrays of some defines. Not used yet. Needs for the future.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgkd.h |   75 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/include/exec/windbgkd.h b/include/exec/windbgkd.h
> index b8f98925e7..40a23f8cd0 100755
> --- a/include/exec/windbgkd.h
> +++ b/include/exec/windbgkd.h
> @@ -870,4 +870,79 @@ typedef struct _DBGKD_TRACE_IO {
>     } u;
>  } DBGKD_TRACE_IO, *PDBGKD_TRACE_IO;
>
> +__attribute__ ((unused)) /* maybe unused */
> +static const char *kd_api_names[] = {
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
> +#define KD_API_NAME(id) \
> +    (id >= DbgKdMinimumManipulate && id < DbgKdMaximumManipulate) ? \
> +        kd_api_names[id - DbgKdMinimumManipulate] : \
> +        kd_api_names[DbgKdMaximumManipulate - DbgKdMinimumManipulate] \

nice-to-have: Build-time assert that kd_api_names has
(DbgKdMaximumManipulate - DbgKdMinimumManipulate + 1) elements.

> +#define KD_PKT_TYPE_NAME(id) kd_packet_type_names[id]

nice-to-have: A ternary similar to what KD_API_NAME has for extra safety.

>  #endif
>
