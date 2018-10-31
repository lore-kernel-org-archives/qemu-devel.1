Received: from eggs.gnu.org ([2001:4830:134:3::10]:50752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtWs-0004Ew-Ll
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtWo-0007gD-6O
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtWn-0007fi-U3
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id y16so17237235wrw.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:39:33 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-50-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-50-cota@braap.org>
Date: Wed, 31 Oct 2018 16:39:31 +0000
Message-ID: <87a7mu6pfg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 50/71] s390x: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  hw/intc/s390_flic.c | 2 +-
>  target/s390x/cpu.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index bfb5cf1d07..d944824e67 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -189,7 +189,7 @@ static void qemu_s390_flic_notify(uint32_t type)
>      CPU_FOREACH(cs) {
>          S390CPU *cpu =3D S390_CPU(cs);
>
> -        cs->interrupt_request |=3D CPU_INTERRUPT_HARD;
> +        cpu_interrupt_request_or(cs, CPU_INTERRUPT_HARD);
>
>          /* ignore CPUs that are not sleeping */
>          if (s390_cpu_get_state(cpu) !=3D S390_CPU_STATE_OPERATING &&
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 956d4e1d18..1f91df57bc 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -65,7 +65,7 @@ static bool s390_cpu_has_work(CPUState *cs)
>          return false;
>      }
>
> -    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
> +    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
>          return false;
>      }


--
Alex Benn=C3=A9e
