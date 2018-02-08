Received: from eggs.gnu.org ([2001:4830:134:3::10]:42758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejlpp-0006il-8c
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejlpj-0006bU-Ms
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:01:53 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:45063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejlpj-0006bE-IR
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:01:47 -0500
Received: by mail-oi0-x22c.google.com with SMTP id c189so3392020oib.12
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 05:01:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
References: <20180208105754.19924-1-danielhb@linux.vnet.ibm.com>
	<caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 13:01:26 +0000
Message-ID: <CAFEAcA90+5RL+WPVDS00NH8WuLmG4C0Ou74v-m20+RB6zYz8WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/audio/sb16.c: missing break
 statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

On 8 February 2018 at 12:15, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Hi Daniel,
>
> On 02/08/2018 07:57 AM, Daniel Henrique Barboza wrote:
>> This patch adds a break in the switch() statement of complete(),
>> value 0x42:
>>
>>     case 0x42:              /* FT2 sets output freq with this, go figure=
 */
>>         qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it=
"
>>                       " should\n");
>>         break; <-------
>>     case 0x41:
>
> It seems this is an intentional fallthrough, I understand cmd 0x42 is
> expected to do the same of 0x41 and _a bit more_ (see commit 85571bc7415)=
.

Yes, I agree; I wrote a bit about this in this thread:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02081.html

(though my guess is that actually 0x42 is supposed to do exactly
what 0x41 does, and that the LOG_UNIMP should maybe just be removed).

thanks
-- PMM
