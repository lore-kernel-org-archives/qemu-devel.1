Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqcD1-0008Nq-GB
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqcCx-00042j-Jp
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:10:07 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqcCx-00042I-Dz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:10:03 -0500
Received: by mail-ot0-x244.google.com with SMTP id 108so3279478otv.3
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 02:10:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACRpkdZLwbVr2O5__GpHt+y0pqpk3-j_AXD_qv5JQc3JZNRm7A@mail.gmail.com>
References: <20180217140051.22731-1-linus.walleij@linaro.org>
	<20180217140051.22731-2-linus.walleij@linaro.org>
	<eff4f015-38ad-60e1-e1de-886bb4f93328@amsat.org>
	<CACRpkdZLwbVr2O5__GpHt+y0pqpk3-j_AXD_qv5JQc3JZNRm7A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 10:09:42 +0000
Message-ID: <CAFEAcA-jqgBxoEprjTPed0k_vZFGrAVd87Gj5nAfFysau4WrSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/3] hw/sii9022: Add support for
 Silicon Image SII9022
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2018 at 07:41, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Sat, Feb 17, 2018 at 7:32 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
>
>> [Me]
>>> +#define DEBUG_SII9022 0
>>> +
>>> +#define DPRINTF(fmt, ...) \
>>> +    do { \
>>> +        if (DEBUG_SII9022) { \
>>> +            printf("sii9022: " fmt, ## __VA_ARGS__); \
>>> +        } \
>>> +    } while (0)
>>
>> Can you replace DPRINTF() by trace events?
>
> Absolutely but which ones?
>
> I do not feel senior enough to also invent new trace events
> for displays or I2C devices...

Just put a trace event where you've put DPRINTF debug statements.

thanks
-- PMM
