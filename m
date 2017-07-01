Received: from eggs.gnu.org ([2001:4830:134:3::10]:47802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRRxW-00024v-Us
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 19:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRRxT-0000kY-SF
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 19:37:50 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:34519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRRxT-0000kD-Nw
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 19:37:47 -0400
Received: by mail-qt0-x22e.google.com with SMTP id 32so122373427qtv.1
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 16:37:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865316837.17063.1608754834009945976.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <528c921e-d04c-f064-08f8-2c6a0b3f23f1@twiddle.net>
Date: Sat, 1 Jul 2017 16:37:43 -0700
MIME-Version: 1.0
In-Reply-To: <149865316837.17063.1608754834009945976.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 04/29] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 05:32 AM, Lluís Vilanova wrote:
> +    void (*init_disas_context)(DisasContextBase *db, CPUState *cpu);
> +    void (*init_globals)(DisasContextBase *db, CPUState *cpu);
> +    void (*tb_start)(DisasContextBase *db, CPUState *cpu);
> +    void (*insn_start)(DisasContextBase *db, CPUState *cpu);
> +    BreakpointCheckType (*breakpoint_check)(DisasContextBase *db, CPUState *cpu,
> +                                            const CPUBreakpoint *bp);
> +    target_ulong (*translate_insn)(DisasContextBase *db, CPUState *cpu);
> +    void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
> +    void (*disas_log)(const DisasContextBase *db, CPUState *cpu);

Any reason not to stuff the cpu pointer into the DisasContextBase instead of 
passing it around separately?

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
