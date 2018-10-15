Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gC69l-0003uw-Dq
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gC69k-0001GR-Kt
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:55:49 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:39468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gC69k-0001Fs-ES
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:55:48 -0400
Received: by mail-ot1-x331.google.com with SMTP id l58so19584975otd.6
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:55:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87woqjw4o3.fsf@dusky.pond.sub.org>
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
	<CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
	<20181015101309.GD10459@localhost.localdomain>
	<87woqjw4o3.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Oct 2018 17:55:27 +0100
Message-ID: <CAFEAcA_H78rpT-9-M-NhTNXtMy8dpmC8_Yvb_4MyJ+GD8ZEptg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 15 October 2018 at 17:33, Markus Armbruster <armbru@redhat.com> wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
>
>> Am 15.10.2018 um 12:02 hat Peter Maydell geschrieben:
>> It's easier to port stuff to Python 3 though than making them work with
>> both. I think Eduardo's RFC is in part motivated by a patch from
>> Philippe that converted something in iotests to work with Python 3,
>> passed review and then turned out to break Python 2.
>
> Seconded.  This is not about the cost of maintaining existing
> compatibility gunk, it's about the extra effort to first get the
> remainder to work with 2 and 3, only to throw away 2 a few months later.
>
> I propose we permit ourselves to port stuff that isn't essential to
> building QEMU straight to 3 instead.  This includes iotests.

No particular objection, as long as nothing run via 'make'
or 'make check' needs Python 3.

I also suspect "a few months" is an underestimate. My guess
would be we're going to want to keep Python 2 support for
at least the next year, maybe two.

thanks
-- PMM
