Received: from eggs.gnu.org ([2001:4830:134:3::10]:54542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fSUhF-0006yH-49
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fSUhB-0006cR-73
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:49:53 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fSUhB-0006bu-12
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:49:49 -0400
Received: by mail-pf0-x244.google.com with SMTP id r11-v6so10941893pfl.6
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 14:49:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180611203712.12086-1-ehabkost@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7cc43c06-e48d-8678-b259-06e3187ee99a@twiddle.net>
Date: Mon, 11 Jun 2018 11:49:44 -1000
MIME-Version: 1.0
In-Reply-To: <20180611203712.12086-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] i386: Remove ospke CPUID flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 06/11/2018 10:37 AM, Eduardo Habkost wrote:
> RFC NOTE: Paolo, Richard, as far as I can see, there's no point
> in enabling OSPKE in user-mode QEMU.  Do you confirm that?
> 
> OSPKE is not a static feature flag: it changes dynamically at
> runtime depending on CR4, and it was never configurable: KVM
> never returned OSPKE on GET_SUPPORTED_CPUID, and on TCG enables
> it automatically if CR4_PKE_MASK is set.
> 
> Remove OSPKE from the feature name array so users don't try to
> configure it manually.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
