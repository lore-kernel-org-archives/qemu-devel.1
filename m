Received: from eggs.gnu.org ([2001:4830:134:3::10]:36895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drTOT-00012B-VP
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drTOT-00069y-5t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:25:13 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:45947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drTOS-00069L-Vo
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:25:13 -0400
Received: by mail-wm0-x235.google.com with SMTP id f199so46286349wme.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:25:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 19:24:51 +0100
Message-ID: <CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>

On 11 September 2017 at 19:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 09/10/2017 07:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> changed in 659ef5cbb893, this fixes building with --enable-tcg-interpret=
er:
>>
>> /home/travis/build/qemu/qemu/tcg/tcg.c:116:14: error: =E2=80=98tcg_out_l=
dst_finalize=E2=80=99 used but never defined [-Werror]
>>  static bool tcg_out_ldst_finalize(TCGContext *s);
>>               ^
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Oops.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied to master as a buildfix, thanks.

I've also turned on a tci compile check on my pre-merge tests.
(It doesn't pass "make check" for me, though...)

thanks
-- PMM
