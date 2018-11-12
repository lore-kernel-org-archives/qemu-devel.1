Received: from eggs.gnu.org ([2001:4830:134:3::10]:38093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMBls-0001Wi-R8
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMBlq-0002lu-SG
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:56:52 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMBlq-0002de-Jd
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:56:50 -0500
Received: by mail-ot1-x342.google.com with SMTP id 81so7870303otj.2
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 04:56:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181109152119.9242-1-alex.bennee@linaro.org>
References: <20181109152119.9242-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 12:56:06 +0000
Message-ID: <CAFEAcA9AEzCseAt8gxx_3jKpi1R=UPS+YGzik_KbcusvhRBXTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/7] KVM Guest Debug fixes (plus TCG EL2
 debug tweaks)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 9 November 2018 at 15:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Hi,
>
> I missed a fix I'd applied locally from v2 so this is a resend with
> some additional tags, some changes suggested by rth and one more fix
> for the test case.
>
> So these are fixes for guest debug when running under KVM. While
> re-spinning these I came across an anomaly which pointed to a kernel bug
> that caused the 1st single-step to fail. This is being discussed at on
> the kvm-arm list:
>
>   Subject: [RFC PATCH] KVM: arm64: don't single-step for non-emulated fau=
lts
>   Date: Wed, 7 Nov 2018 17:10:31 +0000
>   Message-Id: <20181107171031.22573-1-alex.bennee@linaro.org>
>
> It looks like there will be another patch series on its way to address
> this.
>
> As debugging HYP mode code is next to impossible on real hardware I
> tried re-creating the single-step bug under TCG. As a result I ran into
> some debug and EL2 cases that failed. The final two patches are some
> fixes but I'm still seeing some weird behaviour although it is currently
> obscured by timer interrupts constantly firing as I enter the to be
> single-stepped guest EL1 instruction so they can probably be skipped for
> 3.1.
>
> The following patches still need review:
>  0001/target arm64 properly handle DBGVR RESS bits.patch
>  0005/tests guest debug don t use symbol resolution for.patch
>  0007/arm fix aa64_generate_debug_exceptions to work wi.patch

Richard had a review comment on 5, so I'm applying 1-4 and 6-7 to
target-arm.next and will let you respin 5.

thanks
-- PMM
