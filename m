Received: from eggs.gnu.org ([2001:4830:134:3::10]:48348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkR8a-0000R6-7B
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkR8Z-0000Tj-Ew
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:40:16 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkR8Z-0000TQ-8C
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:40:15 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so26731693oih.11
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 02:40:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180731093043.GC29167@redhat.com>
References: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
	<9d7f6a73-a00f-ebc1-efb3-18367e3c0f32@amsat.org>
	<CAFEAcA_nr=hS4Qe=n-=HU389S5cvZArt97QJ83jLQ-x2xRKFWQ@mail.gmail.com>
	<20180731093043.GC29167@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jul 2018 10:39:54 +0100
Message-ID: <CAFEAcA8wkhqH0ioUfT1NBNHc-O8Z7TsDbmXEh22TUa_An7fiKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] configure: Add RISC-V host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 31 July 2018 at 10:30, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> On Mon, Jul 30, 2018 at 07:37:55PM +0100, Peter Maydell wrote:
>> We should fix this somewhat nonsensical error message by
>> completing the deprecate-and-drop cycle for this bit of
>> configure, ie by outright rejecting attempts to build on
>> host CPU types we don't recognize and support, the same
>> way we do with unrecognized host OS types.
>
> Do you mean to imply that we should drop  the TCG intepreter too, or do
> you consider that something that makes it a supported host CPU ?  TCG
> intepretor essentially makes any host supportable, if we keep it.

I would happily drop the TCG host interpreter, but I don't
object in the short term to keeping it around (as an experimental
thing for people who really want it for some reason). I do want to
stop claiming we "support" host CPUs which we in practice
don't, because the interpreter's performance is not good and
it only works with a subset of host OS calling convention ABIs
anyway. Either a host CPU architecture matters enough that we
can put in the not-all-that-huge effort to support it properly,
or it doesn't. I don't think it serves the (probably nearly
zero) users trying to run QEMU on weird CPUs to produce a
sort-of-but-not-really-working setup which we'll then disclaim
any interest in if they do try to report problems to us.

thanks
-- PMM
