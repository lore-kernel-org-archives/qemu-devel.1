Received: from eggs.gnu.org ([2001:4830:134:3::10]:60171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f48Mt-0005JJ-4I
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f48Mp-0002Px-6E
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:08:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f48Mp-0002Pl-17
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:08:07 -0400
References: <CAFEAcA9PbAr+0U1dJ22fr3+B0-KO3Oy73-mk755rJQtmY_rSKA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfb5230b-ec8e-ccb7-788d-0b389a93e128@redhat.com>
Date: Thu, 5 Apr 2018 19:07:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PbAr+0U1dJ22fr3+B0-KO3Oy73-mk755rJQtmY_rSKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] TCG icount interaction with timer deadlines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>

On 05/04/2018 18:01, Peter Maydell wrote:
>  * however, if the guest reprograms the clock during the tcg_cpu_exec()
>    run, we don't do anything to cause us to stop earlier

Anything that does this from the vCPU thread should be between
gen_icount_start and gen_icount_end.  (In fact, it's the entire reason
why cpu_io_recompile exists).

For completeness, if the I/O thread does it, it should (in icount mode
only) kick the running VCPU.

Am I missing something?

Paolo
