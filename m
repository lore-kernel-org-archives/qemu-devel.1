Received: from eggs.gnu.org ([2001:4830:134:3::10]:34995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f64jp-0006uG-Ao
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f64jm-00018U-7d
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:39:53 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:39267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f64jl-000180-V4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:39:50 -0400
Received: by mail-wm0-x22b.google.com with SMTP id b21so769687wme.4
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 18:39:49 -0700 (PDT)
References: <1522883475-27858-1-git-send-email-cota@braap.org>
	<1522883475-27858-2-git-send-email-cota@braap.org>
	<874lki5yj2.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <874lki5yj2.fsf@linaro.org>
Date: Wed, 11 Apr 2018 02:39:47 +0100
Message-ID: <8737025xng.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/15] tests: add fp-test,
 a floating point test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Emilio G. Cota <cota@braap.org> writes:
>
>> This will allow us to run correctness tests against our
>> FP implementation. The test can be run in two modes (called
>> "testers"): host and soft. With the former we check the results
>> and FP flags on the host machine against the model.
>> With the latter we check QEMU's fpu primitives against the
>> model. Note that in soft mode we are not instantiating any
>> particular CPU (hence the HW_POISON_H hack to avoid macro poisoning);
>> for that we need to run the test in host mode under QEMU.
> <snip>
>
> So with the attached patch and my proposed cross build we can now get:
>
<snip>
> --- a/tests/tcg/Makefile
> +++ b/tests/tcg/Makefile
> @@ -24,6 +24,9 @@
>  VPATH =3D $(SRC_PATH)/tests/tcg/multiarch
>  TEST_SRCS =3D $(wildcard $(SRC_PATH)/tests/tcg/multiarch/*.c)
>
> +VPATH     +=3D $(SRC_PATH)/tests/fp
> +TEST_SRCS +=3D $(wildcard $(SRC_PATH)/tests/fp/*.c)
> +
>  VPATH     +=3D $(SRC_PATH)/tests/tcg/$(ARCH)
>  TEST_SRCS +=3D $(wildcard $(SRC_PATH)/tests/tcg/$(ARCH)/*.c)

It also needs:

fp-test: LDFLAGS+=3D-lm

--
Alex Benn=C3=A9e
