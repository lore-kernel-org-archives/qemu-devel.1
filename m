Received: from eggs.gnu.org ([2001:4830:134:3::10]:46063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bVX-0000mb-3a
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bVW-0001vf-3h
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:06:23 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:45379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1bVV-0001v4-Tk
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:06:22 -0400
Received: by mail-wm0-x235.google.com with SMTP id q124so24436535wmb.0
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:06:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqFdjYgj9s2yz_LUv=uheK5Yy0YQ9o-3McLopAFqeVx43Q@mail.gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-9-andrew.smirnov@gmail.com>
	<CAFEAcA_5Yt4a3gE8pHAdE9RnY-SZoucMkt8CParasA1YQxKUfg@mail.gmail.com>
	<CAHQ1cqFdjYgj9s2yz_LUv=uheK5Yy0YQ9o-3McLopAFqeVx43Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:06:00 +0100
Message-ID: <CAFEAcA-DbWn2JcDuWOW-o5ov2uV1Kr_bHGpt5Q6Vi7PhEXn1tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/17] imx_fec: Add support for multiple Tx
 DMA rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 9 October 2017 at 16:38, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Fri, Oct 6, 2017 at 7:10 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>>> More recent version of the IP block support more than one Tx DMA ring,
>>> so add the code implementing that feature.
>>>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Cc: qemu-devel@nongnu.org
>>> Cc: qemu-arm@nongnu.org
>>> Cc: yurovsky@gmail.com
>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>
>> I'm surprised this doesn't mean "we have a property on the device
>> to indicate what IP version it is, which the boards set". Or are
>> all our current boards mismodelling their ethernet devices with the
>> wrong number of TX rings ?
>>
>
> As far as I know the only already emulated SoC that this affects is
> i.MX6, and, no, it doesn't mismodel its Ethernet device since it has
> version of the IP block with only one Tx ring. I didn't add any notion
> of versioning because it didn't seem necessary, since 3-ring IP block
> should be backwards compatible with 1-ring version and host drivers
> written for the latter will end up using only ring #1 of the 3-ring
> block.

It is guest visible if the guest looks for it, though, so I think
we should have a device property to set the number of Tx rings
(or to set the version number of the IP if that's in a guest
visible register and a more useful way to model it) so we can
get it right for both boards.

thanks
-- PMM
