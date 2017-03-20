Received: from eggs.gnu.org ([2001:4830:134:3::10]:45447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpvLc-0005Lr-C3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpvLX-0000xx-EW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:19:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cpvLX-0000xt-97
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:19:31 -0400
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<20170224112109.3147-12-alex.bennee@linaro.org>
	<f7a4cba9-12da-fbb3-684f-68b4a11fbe97@vivier.eu>
	<87y3wr8zs2.fsf@linaro.org>
	<e3f645d0-ea92-b28d-bb2b-9c831dd8b264@vivier.eu>
	<87var7ocr9.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a41adf2-0771-86ee-2805-77997c46207a@redhat.com>
Date: Mon, 20 Mar 2017 12:19:27 +0100
MIME-Version: 1.0
In-Reply-To: <87var7ocr9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 11/24] tcg: enable thread-per-vCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: peter.maydell@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, KONRAD Frederic <fred.konrad@greensocs.com>, Richard Henderson <rth@twiddle.net>



On 17/03/2017 21:43, Alex Benn=C3=A9e wrote:
> There is currently cpu->running which is set/cleared by
> cpu_exec_start/end. Although if we crash between cpu_exec_start and
> sigsetjmp the same sort of brokenness might happen.

I think cpu_exec_start/end should be moved into cpu_exec itself (but
probably just in 2.10).

Paolo

> Anyway understood now. If anyone has any suggestions for neater stuff
> over the weekend please shout, otherwise I'll probably just hack
> handle_cpu_signal to do:
>=20
>    cpu =3D current_cpu;
>    if (!cpu->running) {
>       /* we weren't running or translating JIT code when the signal cam=
e */
>       return 1;
>    }
