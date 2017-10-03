Received: from eggs.gnu.org ([2001:4830:134:3::10]:42894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzM7x-0003hu-Gi
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dzM7t-0001Ho-5t
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:16:45 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:55125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dzM7t-0001Gu-23
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:16:41 -0400
Received: by mail-vk0-f43.google.com with SMTP id c19so4423873vke.11
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 05:16:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642393032.3900.4598141276692628379.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642393032.3900.4598141276692628379.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 3 Oct 2017 14:16:39 +0200
Message-ID: <CABdb734ijMQ_2-k669-rGErYnq3zJGN=MyyuR_=jwAwnoGC-Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 15/43] windbg: sized data buffer
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

On Tue, Sep 26, 2017 at 1:05 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Defined useful sized data buffer. It contains pointer to data and size of this data. Also, defined some macroses for init and free.

"macros" instead of "macroses", same in patch 31.

> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index cf2996d8cb..791721d472 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -86,6 +86,21 @@ typedef struct PacketData {
>      uint16_t extra_size;
>  } PacketData;
>
> +typedef struct SizedBuf {
> +    uint8_t *data;
> +    size_t size;
> +} SizedBuf;
> +
> +#define SBUF_INIT(buf, mem_ptr, len) do { \
> +    buf.data = mem_ptr;                   \
> +    buf.size = len;                       \
> +} while (false)
> +#define SBUF_MALLOC(buf, size) SBUF_INIT(buf, g_malloc0(size), size)
> +#define SBUF_FREE(buf) do { \
> +    g_free(buf.data);       \
> +    buf.data = NULL;        \
> +    buf.size = 0;           \
> +} while (false)
>  bool windbg_on_load(void);
>  void windbg_on_exit(void);
>
>
