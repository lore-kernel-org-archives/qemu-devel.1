Received: from eggs.gnu.org ([2001:4830:134:3::10]:34324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLVZr-0000A4-DY
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLVZm-0003Nn-FC
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:16:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLVZm-0003Nb-90
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:16:46 -0400
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-4-rth@twiddle.net> <87tw3hmxvq.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ff6272f-7dac-7501-8304-a410b9f8cb3c@redhat.com>
Date: Thu, 15 Jun 2017 16:16:40 +0200
MIME-Version: 1.0
In-Reply-To: <87tw3hmxvq.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/mips: Exit after enabling
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, cota@braap.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 15/06/2017 10:57, Alex Benn=C3=A9e wrote:
>> +                /* BS_STOP isn't good enough here;
>> +                   reevaluate cpu_mips_hw_interrupts_enabled.  */
> nit: technically we want to ensure mips_cpu_exec_interrupt is run (whic=
h
> calls cpu_mips_hw_interrupts_enabled)

Right, that's why it's "reevaluate" not "reexecute". :)  Just a nit of
course.

Paolo
