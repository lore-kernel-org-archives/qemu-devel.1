Received: from eggs.gnu.org ([2001:4830:134:3::10]:38951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCrMv-0006tt-Nz
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCrMv-0005uB-3D
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:20:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCrMu-0005t3-La
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:20:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id x4so25947683otg.3
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 12:20:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a53d1784-f947-501b-5589-07b611800959@redhat.com>
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<20181017162944.GF31060@habkost.net>
	<d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
	<CAFEAcA_gyQvmq48QquNiFhGef-FWPeDKRUSk3wf7hS=_=xm_XQ@mail.gmail.com>
	<a53d1784-f947-501b-5589-07b611800959@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Oct 2018 20:20:11 +0100
Message-ID: <CAFEAcA9Ck+aUMTXY_rDLkim+wtMNObq1A=uEa+UzuHN8E_BccQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On 17 October 2018 at 20:05, Cleber Rosa <crosa@redhat.com> wrote:
>
>
> On 10/17/18 2:40 PM, Peter Maydell wrote:
>> At that level, I think the right answer is "tell the user
>> they need to specify the qemu executable they are trying to test".
>> In particular, there is no guarantee that the user has actually
>> built the executable for the target that corresponds to the
>> host, so it doesn't work to try to default to that anyway.
>>
>
> I think your "right answer" is the ideal, but I'm afraid it's not
> practical.  For instance, look at how a qemu-iotest is run:
>
> $ ./check 001
> QEMU          --
> "/tmp/qemu-build/tests/qemu-iotests/../../ppc64-softmmu/qemu-system-ppc64"
> -nodefaults -machine accel=qtest
> ...

I don't know how the iotests stuff works (they're odd
and not part of the stock "make check"), but the main
tests/Makefile.include handles tests which run for any
QEMU binary, tests which run only on certain target
architectures, and tests which don't use a QEMU binary
and just run once.

> The rules that "check" uses for finding a "default" QEMU binary are a
> lot harder to describe (are "smarter") than the ones we currently have
> on the acceptance tests.  IMO some compromises like these are necessary,
> or else, tests may be run much much less than they could and should.

I'm not sure what that check script is trying to do,
but my first impression is that it's probably not a
good model to follow.

thanks
-- PMM
