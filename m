Received: from eggs.gnu.org ([2001:4830:134:3::10]:41561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqZtY-00039X-5f
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqZtX-00028a-CO
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:41:52 -0500
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:45447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1eqZtX-00028I-7G
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:41:51 -0500
Received: by mail-io0-x22d.google.com with SMTP id m22so20166570iob.12
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 23:41:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <eff4f015-38ad-60e1-e1de-886bb4f93328@amsat.org>
References: <20180217140051.22731-1-linus.walleij@linaro.org>
	<20180217140051.22731-2-linus.walleij@linaro.org>
	<eff4f015-38ad-60e1-e1de-886bb4f93328@amsat.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Feb 2018 08:41:49 +0100
Message-ID: <CACRpkdZLwbVr2O5__GpHt+y0pqpk3-j_AXD_qv5JQc3JZNRm7A@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Sat, Feb 17, 2018 at 7:32 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:

> [Me]
>> +#define DEBUG_SII9022 0
>> +
>> +#define DPRINTF(fmt, ...) \
>> +    do { \
>> +        if (DEBUG_SII9022) { \
>> +            printf("sii9022: " fmt, ## __VA_ARGS__); \
>> +        } \
>> +    } while (0)
>
> Can you replace DPRINTF() by trace events?

Absolutely but which ones?

I do not feel senior enough to also invent new trace events
for displays or I2C devices...

Yours,
Linus Walleij
