Received: from eggs.gnu.org ([2001:4830:134:3::10]:44762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfsD-000784-02
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1edfsC-0004jZ-4A
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:27:08 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:39492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1edfsB-0004jL-W6
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:27:08 -0500
Received: by mail-ot0-x22c.google.com with SMTP id d9so8150959oth.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 09:27:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-EJarPnYbOzUc2V0YkD_T9UtSPR6DL313Z2NbbGvzv9A@mail.gmail.com>
References: <20180119182248.10821-1-ard.biesheuvel@linaro.org>
	<CAFEAcA-EJarPnYbOzUc2V0YkD_T9UtSPR6DL313Z2NbbGvzv9A@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 22 Jan 2018 17:27:06 +0000
Message-ID: <CAKv+Gu8ZnVzfkBiEjPzM7GmpP96a_694-sgNL7zUE3mWHkoBBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/4] target-arm: add SHA-3,
 SM3 and SHA512 instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 22 January 2018 at 17:11, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 January 2018 at 18:22, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Changes since v3:
>> - don't bother with helpers for the SHA3 instructions: they are simple enough
>>   to be emitted as TCG ops directly
>> - rebase onto Richard's pending SVE work
>
> I've made a few comments about structural nits but otherwise I think
> this looks good. I'm trying to scare up a test setup so I can write
> some risu tests for the instruction patterns...hopefully will be able
> to do that later this week.
>

That would be excellent - thanks.
