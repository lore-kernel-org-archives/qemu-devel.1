Received: from eggs.gnu.org ([2001:4830:134:3::10]:41611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffroE-0002Zs-46
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffroD-0002HX-55
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:08:22 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffroC-0002HK-UX
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:08:21 -0400
Received: by mail-oi0-x244.google.com with SMTP id r16-v6so10860369oie.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 12:08:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180718170428.GT9812@redhat.com>
References: <20180712192603.11599-1-sw@weilnetz.de>
	<20180718162111.GR9812@redhat.com>
	<255cc07f-8eb7-0839-2001-e6ead4f3d969@weilnetz.de>
	<20180718170428.GT9812@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Jul 2018 20:07:59 +0100
Message-ID: <CAFEAcA-qaDKwG1Use+WG-ocBMd7h3irDQNBYsq_jyE1u8fRA2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Support pkg-config for zlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developer <qemu-devel@nongnu.org>

On 18 July 2018 at 18:04, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> On Wed, Jul 18, 2018 at 06:59:25PM +0200, Stefan Weil wrote:
>> Am 18.07.2018 um 18:21 schrieb Daniel P. Berrang=C3=A9:
>> > .... this fallback support for non-pkgconfig scenarios can be entirely
>> > deleted, just leaving the error_exit message.
>>
>> I have no objection. Thank you for the investigation of the zlib
>> history. Removing old unneeded code is always good, but maybe that's
>> something which could be done after release 3.0.
>>
>> Or would you suggest to do it now? Then I can either send an updated
>> patch (v2), or whoever pulls that patch can make that trivial modificati=
on.
>
> If we're ok with adding support for pkg-config in 3.0, I think it is
> reasonable to drop the fallback check at the same time.  I think it
> this stills qualify as a bug fix patch in terms of our freeze rules,
> since we're specificially aiming to fix build problems on one of our
> supported platforms.
>
> So personally I'd suggest sending a v2 with the fallback dropped.
> for 3.0

I would favour doing that part in 3.1. This feels like the
kind of change that we're all pretty certain is safe that
then turns out not to be for some case or other, and it's
easier not to have to fix it up later.

thanks
-- PMM
