Received: from eggs.gnu.org ([2001:4830:134:3::10]:54418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN5yg-0001Ej-BW
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN5yd-0002Wa-7o
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:21:02 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN5yc-0002WK-Tb
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:20:59 -0400
Received: by mail-pf0-x241.google.com with SMTP id y7so19741099pfd.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 16:20:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924253.28532.2681638904562623104.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ca41d7c2-b009-46b9-1f76-3e45c0f91ecf@twiddle.net>
Date: Mon, 19 Jun 2017 16:20:55 -0700
MIME-Version: 1.0
In-Reply-To: <149727924253.28532.2681638904562623104.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 2/6] queue: Add macro for incremental
 traversal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/12/2017 07:54 AM, Lluís Vilanova wrote:
> Adds macro QTAILQ_FOREACH_CONTINUE to support incremental list
> traversal.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>   include/qemu/queue.h |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index 35292c3155..eb2bf9cb1c 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -415,6 +415,18 @@ struct {                                                                \
>                   (var);                                                  \
>                   (var) = ((var)->field.tqe_next))
>   
> +/**
> + * QTAILQ_FOREACH_CONTINUE:
> + * @var: Variable to resume iteration from.
> + * @field: Field in @var holding a QTAILQ_ENTRY for this queue.
> + *
> + * Resumes iteration on a queue from the element in @var.
> + */
> +#define QTAILQ_FOREACH_CONTINUE(var, field)                             \
> +        for ((var) = ((var)->field.tqe_next);                           \
> +                (var);                                                  \
> +                (var) = ((var)->field.tqe_next))
> +
>   #define QTAILQ_FOREACH_SAFE(var, head, field, next_var)                 \
>           for ((var) = ((head)->tqh_first);                               \
>                   (var) && ((next_var) = ((var)->field.tqe_next), 1);     \
> 
> 

I still say this isn't required if the breakpoint loop is better structured.


r~
