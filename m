Received: from eggs.gnu.org ([2001:4830:134:3::10]:41474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cyMDN-0002G8-6w
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cyMDM-0002nP-EF
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:37:57 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cyMDM-0002mw-7H
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:37:56 -0400
Received: by mail-wm0-x229.google.com with SMTP id w64so93768041wma.0
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 10:37:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2fc1a67b-5608-2736-c629-b8a1c8730223@kaod.org>
References: <1491051477-10455-1-git-send-email-clg@kaod.org>
	<1491051477-10455-2-git-send-email-clg@kaod.org>
	<CAFEAcA8jfj1p45qdPr9AWALb4dURQvDAiigok6pH7ao_nNT6-w@mail.gmail.com>
	<2fc1a67b-5608-2736-c629-b8a1c8730223@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Apr 2017 18:37:34 +0100
Message-ID: <CAFEAcA9L7b4E3Q4KmrNEbPrJu_V0LPpW3AO_pSzQhCvaGo9crg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] net: add FTGMAC100 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 12 April 2017 at 18:29, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 04/10/2017 03:43 PM, Peter Maydell wrote:
>> On 1 April 2017 at 13:57, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>> +    case FTGMAC100_MAC_LADR:
>>> +        return (s->conf.macaddr.a[2] << 24) | (s->conf.macaddr.a[3] <<=
 16) |
>>> +               (s->conf.macaddr.a[4] << 8)  |  s->conf.macaddr.a[5];
>>
>> This will sign extend the high bit of macaddr.a[2] into bits 63..32 of
>> the return value, which probably isn't what you intended and will
>> make Coverity unhapppy.
>
> indeed. What would you recommand ? simply :
>
>         ((uint64_t) s->conf.macaddr.a[2] << 24) | ...

Cast to uint32_t is sufficient. We just need to avoid ending
up with a signed 32 bit value...

thanks
-- PMM
