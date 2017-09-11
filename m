Received: from eggs.gnu.org ([2001:4830:134:3::10]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drTEW-0007dr-5Z
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drTEV-0002jQ-8z
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:14:56 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:46779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drTEV-0002ih-2V
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:14:55 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i189so46083788wmf.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:14:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <da50f354-35ad-5ddc-2890-58fc6d9fbe64@amsat.org>
References: <20170911022839.23231-1-f4bug@amsat.org>
	<da50f354-35ad-5ddc-2890-58fc6d9fbe64@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 19:14:33 +0100
Message-ID: <CAFEAcA_E8-9-iYUq7F9z7WL02_4wuo0m1pd9S3LycPYVspXe8g@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>

On 11 September 2017 at 19:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> On 09/10/2017 11:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> changed in 659ef5cbb893, this fixes building with
>> --enable-tcg-interpreter:
>>
>> /home/travis/build/qemu/qemu/tcg/tcg.c:116:14: error:
>> =E2=80=98tcg_out_ldst_finalize=E2=80=99 used but never defined [-Werror]
>>   static bool tcg_out_ldst_finalize(TCGContext *s);
>>                ^
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>
> I'm not sure I can sign for Jincheng, but since his patch has the same
> content you could add:
>
> Signed-off-by: Jincheng Miao <jincheng.miao@gmail.com>

In that sort of case we generally just say "first person's
patch won". Extra signed-off-by tags are for where there's
really multiple peoples' work in the patch.

thanks
-- PMM
