Received: from eggs.gnu.org ([2001:4830:134:3::10]:36931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fziM6-000847-AV
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fziAQ-00011s-KH
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:53:21 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fziAP-00011L-Se
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:53:18 -0400
Received: by mail-pg1-x543.google.com with SMTP id y4-v6so12214581pgp.9
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 05:53:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-9-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9ef6906f-7fbc-1b41-b5f3-3fd5c9a87e5b@twiddle.net>
Date: Tue, 11 Sep 2018 05:53:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180910232752.31565-9-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/12] cpus: always call seqlock_write
 in cpu_update_icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 09/10/2018 04:27 PM, Emilio G. Cota wrote:
>  
> -#ifndef CONFIG_ATOMIC64
>      seqlock_write_lock(&timers_state.vm_clock_seqlock,
>                         &timers_state.vm_clock_lock);
> -#endif
>      atomic_set__nocheck(&timers_state.qemu_icount,
>                          timers_state.qemu_icount + executed);
> -#ifndef CONFIG_ATOMIC64
>      seqlock_write_unlock(&timers_state.vm_clock_seqlock,
>                           &timers_state.vm_clock_lock);
> -#endif

I don't understand this.  Surely you either want atomic64_set,
or an actual atomic64_add, but no extra lock when CONFIG_ATOMIC64.


r~
