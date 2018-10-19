Received: from eggs.gnu.org ([2001:4830:134:3::10]:46783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDY3e-0007sW-Em
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDY3b-0005hJ-K6
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:55:28 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDY3Y-000589-TN
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:55:25 -0400
Received: by mail-ot1-x342.google.com with SMTP id k9so33837874otl.10
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:55:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b43a36a4-bb35-77e4-42e3-d15aebd618f9@redhat.com>
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-5-git-send-email-thuth@redhat.com>
	<CAFEAcA-ahq3Y4sgs=Vijq_fsDPgX4JuG0gGdMwE5oOLOrsvxjQ@mail.gmail.com>
	<a6b421a6-439e-ac87-0f96-b28ca349bc70@redhat.com>
	<CAAdtpL4M9zD3LPOMgQNtN50pKzZAsoKn0c_uBe5vajPFwUMJvQ@mail.gmail.com>
	<b43a36a4-bb35-77e4-42e3-d15aebd618f9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:54:57 +0100
Message-ID: <CAFEAcA9QtLnFhPfgRgeduB+avJcC9X8Tea1Hi-2q3p9GtU_j8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] configs: Add a CONFIG_UNIMP switch for
 the "unimplemented-device"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>

On 19 October 2018 at 17:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 19/10/2018 18:25, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> First because I'm using it heavily on MIPS and PPC boards, when no
>> datashits are available.
>> I'll submit that during the next merge window, although the MIPS tree
>> seems now reluctant to that kind of hobbyist work.
>>
>> Second, because it is very clean when you implement a SoC to first
>> start with an empty UNIMP region and a cpu core,
>> then declare the mmio regions for each device (still UNIMP), then you
>> can slowly add devices one at a time.
>> This let you (me, so far) push at most a dozen of tiny patches in a
>> working series, instead of a small series of a dozen of huge patches,
>> or a series of 100 tiny patches.
>
> I don't see however why it's a problem to add/remove CONFIG_UNIMP to
> default-configs though (in the Kconfig world the board would "select
> UNIMP").

Well, it's extra friction for people writing new board models,
and the benefit of having CONFIG_UNIMP is all to downstream
redistributors, not to upstream...

I'm not vetoing this patchset, but I do think that if RedHat
wants to distribute significantly-cut-down binaries then
it would be worth working on a mechanism for making that
more conveniently doable, rather than just hacking up
the very creaky default-configs/ stuff.

thanks
-- PMM
