Received: from eggs.gnu.org ([2001:4830:134:3::10]:40743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJbLi-0008Ub-NH
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJbLh-0006oq-Vz
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:34:38 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJbLh-0006og-Qj
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:34:37 -0500
Received: by mail-ot0-x241.google.com with SMTP id g104so26758768otg.7
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 00:34:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CABdb7372q-LntFhkDuurfWi2JakzZCM9xVxkEA=cqYMbKv_jGw@mail.gmail.com>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127326409.6888.9209413226035587910.stgit@Misha-PC.lan02.inno>
	<CABdb7372q-LntFhkDuurfWi2JakzZCM9xVxkEA=cqYMbKv_jGw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 08:34:16 +0000
Message-ID: <CAFEAcA9Db5hB95KqZEjWgEhkX_gWZ+Za40B1hhbKQ5mop-WgbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 05/45] windbg: added helper features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: Mihail Abakumov <mikhail.abakumov@ispras.ru>, Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On 28 November 2017 at 08:18, Ladi Prosek <lprosek@redhat.com> wrote:
> On Tue, Nov 21, 2017 at 3:07 PM, Mihail Abakumov
> <mikhail.abakumov@ispras.ru> wrote:
>> Added some helper features for windbgstub.

> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -32,7 +32,7 @@
>  #define FMT_ERR  "Error:%d"
>
>  #define UINT8_P(ptr) ((uint8_t *) (ptr))
> -#define UINT32_P(ptr) ((uint32_t *) (ptr))
> +#define UINT32_P(ptr) ((uint32_t *) (size_t) (ptr))
>  #define PTR(var) UINT8_P(&var)

Hiding casts behind macros like this doesn't seem worthwhile
to me anyway -- all it's doing is obscuring what's going on.
And casting an arbitrary pointer to a uint32_t* is somewhat
alarming -- the alignment requirements may not be met.
Chances are high that code using that macro is not correct.

thanks
-- PMM
