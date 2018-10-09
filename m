Received: from eggs.gnu.org ([2001:4830:134:3::10]:59242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9uoN-0003w1-Jg
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9uoM-0005dG-Nx
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:24:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9uoM-0005cf-AT
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:24:42 -0400
Received: by mail-ot1-x343.google.com with SMTP id i12-v6so2275040otl.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 09:24:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0d11ef31-ab0f-4372-86f6-d22e4879f0ac@vivier.eu>
References: <20181009161814.21257-1-peter.maydell@linaro.org>
	<0d11ef31-ab0f-4372-86f6-d22e4879f0ac@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 17:24:21 +0100
Message-ID: <CAFEAcA_86YqgtxRDc0hfW4Z6zJXqOpguV9yGmgQMhGFCUtjCNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Suppress
 address-of-packed-member warnings in __get/put_user_e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

On 9 October 2018 at 17:22, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 09/10/2018 =C3=A0 18:18, Peter Maydell a =C3=A9crit :
>> +#ifdef __clang__
>> +#define PRAGMA_DISABLE_PACKED_WARNING                                  =
 \
>> +    _Pragma("GCC diagnostic push");                                    =
 \
>> +    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                   =
 \
>
> Do we really need this pragma now we don't build this for gcc?
> I understood it was for older gcc, not older llvm.

Yes, it's necessary. Older versions of clang don't recognize
-Waddress-of-packed-member.

thanks
-- PMM
