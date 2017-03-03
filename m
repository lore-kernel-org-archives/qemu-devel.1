Received: from eggs.gnu.org ([2001:4830:134:3::10]:49577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpc5-0001ze-OK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpc5-00074A-6V
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:59:25 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjpc5-00073u-0a
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:59:25 -0500
Received: by mail-wm0-x234.google.com with SMTP id n11so18787944wma.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:59:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAG48ez2eaXFk50puw_bc27tNdfOHDsL08A9jY8=7DnA-mtEXWA@mail.gmail.com>
References: <20170303112503.32277-1-ppandit@redhat.com>
	<CAFEAcA_V8azXLLptxqNWBwkY7wJZzK+YkZHd6RfHEVS-NoXXBg@mail.gmail.com>
	<CAG48ez2eaXFk50puw_bc27tNdfOHDsL08A9jY8=7DnA-mtEXWA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 15:59:03 +0000
Message-ID: <CAFEAcA8cchuY8_=kLqSeV6_kixn5OJ0_UmQyxmgkeARmhNcQng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] linux-user: limit number of arguments to
 execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jann Horn <jannh@google.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Prasad J Pandit <pjp@fedoraproject.org>

On 3 March 2017 at 15:57, Jann Horn <jannh@google.com> wrote:
> On Fri, Mar 3, 2017 at 4:55 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> This code is already supposed to handle "argument string too big",
>> see commit a6f79cc9a5e.
>>
>> What's the actual bug case we're trying to handle here?
>
> commit a6f79cc9a5e doesn't help here, it only bails out after the two
> alloca() calls

That's why I asked "what's the actual bug case we're trying to handle?"...

thanks
-- PMM
