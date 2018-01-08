Received: from eggs.gnu.org ([2001:4830:134:3::10]:46258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYady-00051S-7u
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYadx-0006iL-7v
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:51:26 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:38290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYadx-0006hm-3R
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:51:25 -0500
Received: by mail-ot0-x231.google.com with SMTP id h2so9751185oti.5
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 08:51:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8bc869d6-73cd-d085-99ca-aab8832ee1fc@msgid.tls.msk.ru>
References: <20171005143553.23784-1-malbarbo@gmail.com>
	<8bc869d6-73cd-d085-99ca-aab8832ee1fc@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 16:51:03 +0000
Message-ID: <CAFEAcA9nLWP=hdOtYQSzBjgsmVbbqOyZDmVPArUky+7wV4N0gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add AT_SECURE auxval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Marco A L Barbosa <malbarbo@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16 October 2017 at 19:04, Michael Tokarev <mjt@tls.msk.ru> wrote:
> 05.10.2017 17:35, Marco A L Barbosa wrote:
>> This is necessary to run android ndk applications. Without this patch, the
>> following error is generated:
>>
>> FATAL: kernel did not supply AT_SECURE
>>
>> Should AT_SECURE from host be considered or is the ids comparisons enough?

If we just pass through the host AT_SECURE value that would
mean we don't need to do the ID comparisons, right? (the host
kernel will have done them for us). I think that would be better.

We can do that with qemu_getauxval(AT_SECURE).

thanks
-- PMM
