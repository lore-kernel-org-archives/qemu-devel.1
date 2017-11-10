Received: from eggs.gnu.org ([2001:4830:134:3::10]:43891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eD49R-0007Ai-JQ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 02:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eD49Q-0003Kt-Sv
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 02:54:57 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:55966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1eD49Q-0003Kd-NU
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 02:54:56 -0500
Received: by mail-ot0-x244.google.com with SMTP id u10so167101otc.12
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 23:54:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510299947-11287-1-git-send-email-wanpeng.li@hotmail.com>
References: <1510299947-11287-1-git-send-email-wanpeng.li@hotmail.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 10 Nov 2017 15:54:55 +0800
Message-ID: <CANRm+Cw_Sg04WV0J4tMXy6CSPa+GqfH31hch8p0XCZKmxT=VLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_TLB_FLUSH CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Wanpeng Li <wanpeng.li@hotmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

2017-11-10 15:45 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> From: Wanpeng Li <wanpeng.li@hotmail.com>
>
> Adds PV_TLB_FLUSH CPUID feature bit.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6f21a5e..ecebc5a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -347,7 +347,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORD=
S] =3D {
>          .feat_names =3D {
>              "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
>              "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhal=
t",
> -            NULL, NULL, NULL, NULL,
> +            NULL, "kvm-pv-tlb-flush", NULL, NULL,

Note: bit 8 is reserved for the PV_DEDICATED which is posted by
another guy in kvm community.

>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
> --
> 2.7.4
>
