Received: from eggs.gnu.org ([2001:4830:134:3::10]:46325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elYfE-0007NM-Fn
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elYfD-000462-N2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:22:20 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:39125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elYfD-00045n-IL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:22:19 -0500
Received: by mail-ot0-x229.google.com with SMTP id f18so16993575otf.6
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 03:22:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8ad4b5f9-eced-3a3f-64b3-494624e3c369@redhat.com>
References: <20180125135129.9305-1-klim.kireev@virtuozzo.com>
	<bb1b8270-e924-3d41-a172-38ba79db9bf7@redhat.com>
	<fd22674c-059e-8d37-338c-5d2d4d96eb20@redhat.com>
	<CAFEAcA9eKZNznjgnRy_vuKvcQZ2e=0XD0b9reGBFBBFoBTREQg@mail.gmail.com>
	<CAKmqyKNN_ysFP0pwDaccc1T+znoMfNtTXPzhLE-nsB7pCqmctg@mail.gmail.com>
	<4b726592-1078-1ac8-37b1-9227122d2429@redhat.com>
	<ac7cca9f-24f7-6b04-acbd-e63c99df9136@virtuozzo.com>
	<8ad4b5f9-eced-3a3f-64b3-494624e3c369@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 11:21:58 +0000
Message-ID: <CAFEAcA_Ri_OFj_ZTR1Bt8zfM-VdjKmSL1r2UaAWX5yz0W9XTrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] "make check -j4" hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: klim <klim.kireev@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Alistair Francis <alistair23@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Denis V. Lunev" <den@virtuozzo.com>

On 12 February 2018 at 19:30, Thomas Huth <thuth@redhat.com> wrote:
> On 12.02.2018 15:42, klim wrote:
> [...]
>> I just have reverted my 2 commits and
>>
>> after that make check -j32 hangs
>>
>> with
>>
>> GTester: last random seed: R02Sb95a3bf6ab4c05540cec188081a7cc2a
>>
>> in vhost-user-test
>>
>> so it is not my fault
>
> You're right. I've bisected the issue again, and this time I've applied
> 8f6d701044b ("tests/test-filter-redirector: move close()") on top of
> each step if necessary, and indeed, the "vhost-user-test" problem has
> nothing to do with your patches, Klim, but with the one from Marc-Andr=C3=
=A9.
> According to git bisect, this is the commit that introduced the problem:
>
>         commit 7e49f5e8e508ed020c96798b3f7083e24e0e425b
>         tests: use memfd in vhost-user-test
>
> Peter, since this is quite annoying if "make check" is not working
> reliably, could you please revert that commit until a proper solution is
> found?

Reverted in master -- thanks for the bisect.

-- PMM
