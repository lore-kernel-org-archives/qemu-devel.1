Received: from eggs.gnu.org ([2001:4830:134:3::10]:39849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flKLf-0008Bo-PW
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 16:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flKLe-00052N-MC
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 16:37:27 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:44843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1flKLe-00052D-Fz
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 16:37:26 -0400
Received: by mail-oi0-x22f.google.com with SMTP id s198-v6so5888595oih.11
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 13:37:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <af0a868b-20d8-a02f-f6c3-eb0d9a56b5ab@amsat.org>
References: <CAFEAcA8yrNzEaL5_D79OjHCUUwPQnS4MnQhU9gumR7fpTThyuQ@mail.gmail.com>
	<af0a868b-20d8-a02f-f6c3-eb0d9a56b5ab@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Aug 2018 21:37:05 +0100
Message-ID: <CAFEAcA-T=kByrL13i3ujemaJKeKo-6g=Dc0e=Vg4=5dCJXtaBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] 'make vm-build-freebsd' &c don't work if KVM isn't
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

On 2 August 2018 at 20:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> Hi Peter,
>
> On 07/30/2018 10:23 AM, Peter Maydell wrote:
>> The tests in tests/vm/ seem to make some attempt to cope with the
>> host system not allowing the user to use KVM, but it doesn't quite
>> work. The problem is that tests/vm/basevm.py always uses "-cpu host"
>> in the QEMU options it uses to run the VM, and that only works if
>> KVM is enabled. If the user can't run KVM then we correctly avoid
>> passing it "-enable-kvm" but then QEMU doesn't run because "-cpu host"
>> isn't supported...
>>
>> I guess the right fix here is to use "-cpu max" ?
>
> I think this is the issue I intended to address in this series:
>
> http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03411.html
> "tests/vm: Improvements when KVM is not available"
> ->
> "tests/vm: Use 'host' cpu when KVM is available, else default to 'max'"

Just using "max" seems more straightforward, since the point
is that it works everywhere.

I thought I'd sent my tests/vm series out earlier this week,
but I must have managed to only do the dry-run or something --
I'll send them tomorrow.

thanks
-- PMM
