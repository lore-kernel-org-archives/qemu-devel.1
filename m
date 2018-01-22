Received: from eggs.gnu.org ([2001:4830:134:3::10]:36285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edgUa-0008WS-7Q
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edgUZ-0001HQ-9t
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:06:48 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edgUZ-0001GP-4l
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:06:47 -0500
Received: by mail-oi0-x243.google.com with SMTP id m83so4115885oik.8
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 10:06:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171209010811.GJ3037@localhost.localdomain>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
	<20171209010811.GJ3037@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 18:06:26 +0000
Message-ID: <CAFEAcA9oG=+mJ+jSGTM_z54S09gjHoFowDkOvofdkhJd+g3=Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 9 December 2017 at 01:08, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Thu, Dec 07, 2017 at 07:37:31PM +0000, Peter Maydell wrote:
>> On 7 December 2017 at 18:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>> > This patchset adds support for '-cpu max' to Arm, along the lines
>> > of the existing support we have for x86 targets:
>> >
>> >  * under KVM, -cpu max is the same as -cpu host
>> >  * under TCG, -cpu max means "emulate with as many features as
>> >    possible"
>>
>> Forgot to mention: -cpu max for qemu-system-aarch64 will
>> be a 64-bit cpu, and for qemu-system-arm it will be a 32-bit
>> cpu. (This differs from all the other TCG CPU types, which
>> behave the same for the 32-bit and 64-bit binaries. I think
>> it is the same way that x86 -cpu max works, though.)
>
> Are they going to be represented by two different QOM type names?
>
> (In the case of x86, all the CPU classes have different names on
> qemu-system-x86_64 and qemu-system-i386).

(Just pulling this thread up from before Christmas...)

I guess a better way to approach this would be to ask: how is
x86 implementing -cpu max, ie what is the required view of things
that I need to provide for target/arm in order to have QEMU
behave the same way x86 does? Did we write any user-facing
documentation for this feature?

(The code in this patchset makes '-cpu max' give the same
QOM type name for both qemu-system-arm and qemu-system-aarch64,
with different behaviour depending on the binary. If that means
we don't provide the same behaviour as x86 then I can change that,
but I'm not sure where the difference is exposed to the user?)

thanks
-- PMM
