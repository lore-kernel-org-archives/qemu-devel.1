Received: from eggs.gnu.org ([2001:4830:134:3::10]:52241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdFEZ-0002d5-NG
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdFEY-0008Uc-Ro
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:32:43 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdFEY-0008Tm-LS
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:32:42 -0400
Received: by mail-oi0-x242.google.com with SMTP id i12-v6so49258899oik.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:32:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180711125112.GF31228@stefanha-x1.localdomain>
References: <20180630091343.14391-1-stefanha@redhat.com>
	<20180630091343.14391-2-stefanha@redhat.com>
	<CAFEAcA-boywojdasSCZ5EnnGMtETMH7JZw30fOR7fepMQaqctQ@mail.gmail.com>
	<CAFEAcA8AzjD3f44U+He1Y10p8iNR8EaWODdv3XRUQtQiDdCotg@mail.gmail.com>
	<20180711125112.GF31228@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Jul 2018 14:32:21 +0100
Message-ID: <CAFEAcA_JBFS+e_vu35kAwfQUsyjhvYRV9YZ6vmyVkYPzdSLuBQ@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

On 11 July 2018 at 13:51, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Jul 05, 2018 at 04:49:22PM +0100, Peter Maydell wrote:
>> On 5 July 2018 at 16:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>> > On 30 June 2018 at 10:13, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> >> The ARMv7-M code is largely similar to what other M Profile CPUs need.
>> >> Extract the common M Profile aspects into the ARMMProfileState base
>> >> class.  ARMv6-M will inherit from this class in the following patch.
>> >>
>> >> It might be possible to make ARMv6-M the base class of ARMv7-M, but it
>> >> seems cleaner to have an M Profile base class instead of saying an
>> >> "ARMv7-M is an ARMv6-M".
>> >>
>> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> >
>> > This makes sense, I guess (though it currently leaves us in the
>> > odd position that we have separate a object for v6m, but the v7m
>> > object handles both v7m and v8m...)
>>
>> ...though I guess the counter-argument is that the only thing that
>> the v7m object is doing that v6m doesn't want is creating
>> the bitbanding device, and in fact bitbanding is optional in v7m
>> (you can configure a Cortex-M3 without it). So maybe we should
>> instead just have a QOM property to let you turn off the
>> bitbanding ?
>
> Okay, we can do that.  So how about a single ARMMProfileState class for
> v6, v7, and v8?

Yes, I think that makes sense. (A lot of our code says 'v7m' when
it really means 'm profile in general' for historical reasons. I'm
not too worried about trying to tidy that up.)

thanks
-- PMM
