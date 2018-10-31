Received: from eggs.gnu.org ([2001:4830:134:3::10]:49299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtSR-0000lY-RZ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtSN-000517-Hd
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:35:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtSN-0004vn-6R
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:34:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id w5-v6so17225504wrt.2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:34:50 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-34-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-34-cota@braap.org>
Date: Wed, 31 Oct 2018 16:34:47 +0000
Message-ID: <87muqu6pnc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 34/71] s390x: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/s390x/excp_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index d22c5b3ce5..7ca50b3df6 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -454,7 +454,7 @@ try_deliver:
>
>      /* we might still have pending interrupts, but not deliverable */
>      if (!env->pending_int && !qemu_s390_flic_has_any(flic)) {
> -        cs->interrupt_request &=3D ~CPU_INTERRUPT_HARD;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>      }
>
>      /* WAIT PSW during interrupt injection or STOP interrupt */


--
Alex Benn=C3=A9e
