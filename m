Received: from eggs.gnu.org ([208.118.235.92]:60038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdNQ3-0002iM-DA
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdNFO-0000TJ-Rk
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:38:27 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gdN5s-0008Ao-KL
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:28:32 -0500
Received: by mail-pf1-x441.google.com with SMTP id b7so11870047pfi.8
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 14:28:32 -0800 (PST)
References: <20181228173356.15359-1-philmd@redhat.com>
	<20181228173356.15359-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f71b1bf-f6f2-dddf-3e4a-ad007edccaa1@linaro.org>
Date: Sun, 30 Dec 2018 09:28:23 +1100
MIME-Version: 1.0
In-Reply-To: <20181228173356.15359-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/5] qemu/compiler: Define QEMU_NONSTRING
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 12/29/18 4:33 AM, Philippe Mathieu-Daudé wrote:
> GCC 8 introduced the -Wstringop-truncation checker to detect truncation by
> the strncat and strncpy functions (closely related to -Wstringop-overflow,
> which detect buffer overflow by string-modifying functions declared in
> <string.h>).
> 
> In tandem of -Wstringop-truncation, the "nonstring" attribute was added:
> 
>   The nonstring variable attribute specifies that an object or member
>   declaration with type array of char, signed char, or unsigned char,
>   or pointer to such a type is intended to store character arrays that
>   do not necessarily contain a terminating NUL. This is useful in detecting
>   uses of such arrays or pointers with functions that expect NUL-terminated
>   strings, and to avoid warnings when such an array or pointer is used as
>   an argument to a bounded string manipulation function such as strncpy.
> 
>   From the GCC manual: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-nonstring-variable-attribute
> 
> Add the QEMU_NONSTRING macro which checks if the compiler supports this
> attribute.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
