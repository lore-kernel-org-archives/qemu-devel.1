Received: from eggs.gnu.org ([2001:4830:134:3::10]:35576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJdaU-0001Zz-Lm
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJdaQ-0000Mj-Iv
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:30:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJdaQ-0000M9-DU
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:30:14 -0400
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-22-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46d4512f-585e-073f-fbc1-857c4063df12@redhat.com>
Date: Fri, 18 May 2018 13:30:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 21/49] tests/tcg/i386: add runner for
 test-i386-fprem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 17/05/2018 19:46, Alex Benn=C3=A9e wrote:
> The runner needs to compare against a reference run. We also only run
> this test when SPEED=3Dslow as it takes a while.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/i386/Makefile.target   | 11 +++++++++++
>  tests/tcg/i386/test-i386-fprem.c | 12 +++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.t=
arget
> index 39a1627650..94fa50abbc 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -37,3 +37,14 @@ pi_10.com:
>  run-runcom: runcom pi_10.com
>  	$(call quiet-command, $(QEMU) ./runcom ./pi_10.com > runcom.out, "TES=
T", "$< on $(TARGET_NAME)")
> =20
> +ifeq ($(SPEED), slow)
> +run-test-i386-fprem: test-i386-fprem
> +	$(call quiet-command, \
> +		$(QEMU) $< > $<.out && \
> +		diff -u $(I386_SRC)/$<.ref $<.out, \
> +		"TEST", "$< (default) on $(TARGET_NAME)")

Where is the .ref file created?

Thanks,

Paolo
