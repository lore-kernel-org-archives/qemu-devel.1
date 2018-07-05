Received: from eggs.gnu.org ([2001:4830:134:3::10]:51239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb6Vs-0001AV-Mv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb6Vr-0006tj-To
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:49:44 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb6Vr-0006tO-P2
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:49:43 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so17758108oiw.8
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 08:49:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-boywojdasSCZ5EnnGMtETMH7JZw30fOR7fepMQaqctQ@mail.gmail.com>
References: <20180630091343.14391-1-stefanha@redhat.com>
	<20180630091343.14391-2-stefanha@redhat.com>
	<CAFEAcA-boywojdasSCZ5EnnGMtETMH7JZw30fOR7fepMQaqctQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 16:49:22 +0100
Message-ID: <CAFEAcA8AzjD3f44U+He1Y10p8iNR8EaWODdv3XRUQtQiDdCotg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/arm: extract ARM M Profile base
 class from ARMv7-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Liviu Ionescu <ilg@livius.net>

On 5 July 2018 at 16:45, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 June 2018 at 10:13, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> The ARMv7-M code is largely similar to what other M Profile CPUs need.
>> Extract the common M Profile aspects into the ARMMProfileState base
>> class.  ARMv6-M will inherit from this class in the following patch.
>>
>> It might be possible to make ARMv6-M the base class of ARMv7-M, but it
>> seems cleaner to have an M Profile base class instead of saying an
>> "ARMv7-M is an ARMv6-M".
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> This makes sense, I guess (though it currently leaves us in the
> odd position that we have separate a object for v6m, but the v7m
> object handles both v7m and v8m...)

...though I guess the counter-argument is that the only thing that
the v7m object is doing that v6m doesn't want is creating
the bitbanding device, and in fact bitbanding is optional in v7m
(you can configure a Cortex-M3 without it). So maybe we should
instead just have a QOM property to let you turn off the
bitbanding ?

thanks
-- PMM
